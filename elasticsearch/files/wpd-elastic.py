#!/usr/bin/env python
# -*- coding: utf-8 -*-

import argparse
import ipaddr
import os
import subprocess
import sys
import time

from elasticsearch import Elasticsearch, TransportError
from subprocess import CalledProcessError

# source: https://github.com/wikimedia/operations-puppet/blob/production/modules/elasticsearch/files/es-tool

# Helper functions go here
def cluster_health():
    es = Elasticsearch(args.server)
    return es.cluster.health()["status"]


def cluster_status(columns=None):
    es = Elasticsearch(args.server)
    cluster_health = es.cluster.health()
    if columns is None:
        columns = sorted(cluster_health)
    values = [cluster_health[x] for x in columns]

    column_fmt = ' '.join('{:>}' for x in columns)
    value_fmt = ' '.join('{:>%s}' % len(x) for x in columns)

    yield column_fmt.format(*columns)
    yield value_fmt.format(*values)


def set_setting(setting, value, settingtype="transient"):
        es = Elasticsearch(args.server)
        res = es.cluster.put_settings(
            body={
                settingtype: {
                    setting: value
                }
            }
        )
        if res["acknowledged"]:
            return True
        else:
            return False


def set_allocation_state(status):
    return set_setting("cluster.routing.allocation.enable", status)


def set_banned_nodes(nodelist, node_type):
    return set_setting("cluster.routing.allocation.exclude." + node_type,
                       ",".join(nodelist))


def get_banned_nodes(node_type):
    es = Elasticsearch(args.server)
    res = es.cluster.get_settings()
    try:
        bannedstr = res["transient"]["cluster"]["routing"]["allocation"][
            "exclude"][node_type]
        if bannedstr:
            return bannedstr.split(",")
    except KeyError:
        pass
    return []


def get_node_type(node):
    try:
        ipaddr.IPv4Address(node)
        return "_ip"
    except ipaddr.AddressValueError:
        try:
            ipaddr.IPv6Address(node)
            return "_ip"
        except ipaddr.AddressValueError:
            return "_host"


# Add new command functions here
def es_ban_node():
    if args.node == "":
        print "No node provided"
        return os.EX_UNAVAILABLE

    node_type = get_node_type(args.node)

    banned = get_banned_nodes(node_type)
    if args.node in banned:
        print args.node + " already banned from allocation, nothing to do"
        return os.EX_OK

    banned.append(args.node)
    if set_banned_nodes(banned, node_type):
        print "Banned " + args.node
        return os.EX_OK
    else:
        print "Failed to ban " + args.node
        return os.EX_UNAVAILABLE


def es_health():
    health = cluster_health()
    print health
    if health != "green":
        return os.EX_UNAVAILABLE
    else:
        return os.EX_OK


def printu(string):
    sys.stdout.write(string)
    sys.stdout.flush()


def es_restart_fast():
    # Sanity checks
    if os.getuid() != 0:
        print "Must be run as root"
        return os.EX_UNAVAILABLE
    if args.server != "localhost":
        print "Must be run against localhost only"
        return os.EX_UNAVAILABLE

    # Disable replication so we can make recovery easier
    printu("Disabling non-primary replication...")
    if not set_allocation_state("primaries"):
        print "failed!"
        return os.EX_UNAVAILABLE
    printu("ok\n")

    # Actually restart the service
    try:
        subprocess.check_call(["service", "elasticsearch", "restart"])
    except CalledProcessError:
        print "failed! -- You will still need to enable replication again",
        print "with `es-tool start-replication`"
        return os.EX_UNAVAILABLE

    # Wait for it to come back alive
    printu("Waiting for Elasticsearch...")
    while True:
        try:
            if cluster_health():
                printu("ok\n")
                break
        except:
            pass
        printu(".")
        time.sleep(1)

    # Wait a sec
    time.sleep(1)

    # Turn replication back on so things will recover fully
    printu("Enabling all replication...")
    if not set_allocation_state("all"):
        print "failed! -- You will still need to enable replication again",
        print "with `es-tool start-replication`"
        return os.EX_UNAVAILABLE
    printu("ok\n")

    # Wait a bit
    time.sleep(5)
    print "Waiting for green (you can ctrl+c here if you have to)...\n"
    while cluster_health() != "green":
        print '\n'.join(cluster_status(columns=('status',
                                                'initializing_shards',
                                                'relocating_shards',
                                                'unassigned_shards')))
        time.sleep(60)
    print "ok"

    return os.EX_OK


def es_start_replication():
    if set_allocation_state("all"):
        print "All replication enabled"
        return os.EX_OK
    else:
        print "Failed to set replication state"
        return os.EX_UNAVAILABLE


def es_stop_replication():
    if set_allocation_state("primaries"):
        print "Non-primary replication disabled"
        return os.EX_OK
    else:
        print "Failed to set replication state"
        return os.EX_UNAVAILABLE


def es_unban_node():
    if args.node == "":
        print "No node provided"
        return os.EX_UNAVAILABLE

    node_type = get_node_type(args.node)

    banned = get_banned_nodes(node_type)
    if args.node not in banned:
        print args.node + " not banned from allocation, nothing to do"
        return os.EX_OK

    banned.remove(args.node)
    if set_banned_nodes(banned, node_type):
        print "Unbanned " + args.node
        return os.EX_OK
    else:
        print "Failed to unban " + args.node
        return os.EX_UNAVAILABLE

# And register them here
commands = {
    "ban-node": es_ban_node,
    "health": es_health,
    "restart-fast": es_restart_fast,
    "start-replication": es_start_replication,
    "stop-replication": es_stop_replication,
    "unban-node": es_unban_node,
    "status": lambda: '\n'.join(cluster_status()),
}

# main()
parser = argparse.ArgumentParser(
    description="Tool for Elasticsearch cluster maintenance")
parser.add_argument("command", metavar='CMD', type=str,
                    choices=commands.keys(),
                    help="Subcommand, one of: " + ",".join(commands))
parser.add_argument("node", metavar='NODE', type=str, nargs="?", default="",
                    help="IP address or hostname, used by (un)ban-node")
parser.add_argument("--server", metavar='S', type=str, default="localhost",
                    help="Server to work on, default localhost")
args = parser.parse_args()

try:
    sys.exit(commands[args.command]())
except TransportError as te:
    print te
    sys.exit(os.EX_UNAVAILABLE)
