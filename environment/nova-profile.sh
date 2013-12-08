#
# Enable OpenStack Nova commands if user can read the file
#
# Ensure mod is 640 with ownership as root:ops
# and expected to be /etc/profile.d/NAME.sh
#
# @since 2013-08-20
#
echo "deployment.dho.webplatform.org: You have access to 'nova' commands!"
export OS_USERNAME=admin
export OS_TENANT_NAME=admin
export OS_AUTH_URL=https://horizon.dho.webplatform.org:35357/v2.0
export OS_PASSWORD=0000000000000000000000000000
