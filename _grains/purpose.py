#!/usr/bin/env python

import socket
from string import digits

hostname = socket.gethostname().translate(None, digits)

def roles():
	'''
	Parse the host hostname and creates a list of roles

	Based on the hostname (without domain name), should return:

		salt		-> grain:roles: ["salt"]
		redis-jobs1	-> grain:roles: ["redis","jobs"]

	'''
	dataObject = {'roles': hostname.split('-')}
	return dataObject

def level():
	'''
	Returns environment level based on the host FQDN

		salt.staging.wpdn  		-> grains:level: "staging"
		redis-jobs1.staging.wpdn 	-> grains:level: "staging"
		memcache1.production.wpdn	-> grains:level: "production"

	This function fills the grain with key "level", default value is "production"
	'''
	dataObject = {}
	fqdn = socket.getfqdn()
	if 1 < len(fqdn.split('.')):
		dataObject['level'] = fqdn.split('.')[1]
	else:
		dataObject['level'] = "production"

	return dataObject
