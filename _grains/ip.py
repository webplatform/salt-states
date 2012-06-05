import socket

def ipaddr():
	grains = {}
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
	s.connect(('example.org', 0))
	grains['ipaddr'] = s.getsockname()[0]
	return grains
