#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Get some grains information that is only available in Amazon AWS

Author: Erik Günther, J C Lawrence <claw@kanga.nu>, Mark McGuire, Renoir Boulanger <renoir@w3.org>

Install:
  - Add this file in your salt sates, in a folder call _grains/


See also:
  - https://renoirboulanger.com/blog/2015/05/add-openstack-instance-meta-data-info-salt-grains/
  - https://gist.github.com/WebPlatformDocs/6b26b67321fe15870aa0

"""
import logging
import httplib
import socket
import json

# Set up logging
LOG = logging.getLogger(__name__)


def _call_aws(url):
    """
    Call AWS via httplib. Require correct path.
    Host: 169.254.169.254

    """
    conn = httplib.HTTPConnection("169.254.169.254", 80, timeout=1)
    conn.request('GET', url)
    return conn.getresponse()


def _get_dreamcompute_hostinfo(path=""):
    """
    Recursive function that walks the EC2 metadata available to each minion.
    :param path: URI fragment to append to /latest/meta-data/

    Returns a nested dictionary containing all the EC2 metadata. All keys
    are converted from dash case to snake case.

    On DreamCompute/OpenStack, the following is available at /latest/meta-data/

    | path                       | typical output
    ------------------------------------------------
    | ami-id                     |
    | ami-launch-index           |
    | ami-manifest-path          |
    | block-device-mapping/      |
    | hostname                   | salt.novalocal
    | instance-action            |
    | instance-id                | i-001151e3
    | instance-type              | lightspeed
    | kernel-id                  |
    | local-hostname             |
    | local-ipv4                 | 10.10.10.41
    | placement/                 |
    |   availability-zone        | iad-1
    | public-hostname            | salt.novalocal
    | public-ipv4                | 173.236.254.95
    | public-keys/               |
    |   0/                       | (each entry represent a a ssh key)
    |   0/openssh-key            | ssh-rsa.... (the public key)
    | ramdisk-id                 |
    | reservation-id             |

    EDIT: This function now truncates some keys that might just be not very helpful
          in the context of a salt master not managing an OpenStack cluster itself.
    """

    keys_to_mute = ['local-hostname','public-hostname','ami-id','ami-launch-index','ami-manifest-path','kernel-id','public-keys/']
    resp = _call_aws("/latest/meta-data/%s" % path)
    resp_data = resp.read().strip()
    d = {}
    for line in resp_data.split("\n"):
        if line[-1] != "/" and line not in keys_to_mute:
            call_response = _call_aws("/latest/meta-data/%s" % (path + line))
            call_response_data = call_response.read()
            # avoid setting empty grain
            if call_response_data == '':
                d[line] = None
            elif call_response_data is not None:
                line = _dash_to_snake_case(line)
                try:
                    data = json.loads(call_response_data)
                    if isinstance(data, dict):
                        data = _snake_caseify_dict(data)
                    d[line] = data
                except ValueError:
                    d[line] = call_response_data
            else:
                return line
        elif line in keys_to_mute:
            """
            This should catch public-keys/ to skip the formatting rules above and
            make the public-keys part of the grains data.
            """
        else:
            d[_dash_to_snake_case(line[:-1])] = _get_dreamcompute_hostinfo(path + line)
    return d


def _camel_to_snake_case(s):
    return s[0].lower() + "".join((("_" + x.lower()) if x.isupper() else x) for x in s[1:])


def _dash_to_snake_case(s):
    return s.replace("-", "_")


def _snake_caseify_dict(d):
    nd = {}
    for k, v in d.items():
        nd[_camel_to_snake_case(k)] = v
    return nd


def _get_dreamcompute_additional():
    """
    Recursive call in _get_dreamcompute_hostinfo() does not retrieve some of
    the hosts information like region, availability zone or
    architecture.

    """
    response = _call_aws("/openstack/2012-08-10/meta_data.json")
    # _call_aws returns None for all non '200' reponses,
    # catching that here would rule out AWS resource
    if response.status == 200:
        response_data = response.read()
        data = json.loads(response_data)
        return _snake_caseify_dict(data)
    else:
       raise httplib.BadStatusLine("Could not read EC2 metadata")


def dreamcompute_info():
    """
    Collect all dreamcompute grains into the 'dreamcompute' key.
    """
    try:
        grains = _get_dreamcompute_additional()
        grains.update(_get_dreamcompute_hostinfo())
        return {'dreamcompute' : grains}

    except httplib.BadStatusLine, error:
        LOG.debug(error)
        return {}

    except socket.timeout, serr:
        LOG.info("Could not read EC2 data (timeout): %s" % (serr))
        return {}

    except socket.error, serr:
        LOG.info("Could not read EC2 data (error): %s" % (serr))
        return {}

    except IOError, serr:
        LOG.info("Could not read EC2 data (IOError): %s" % (serr))
        return {}

if __name__ == "__main__":
    print dreamcompute_info()
