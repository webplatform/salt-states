#
# Enable OpenStack Nova commands if user can read the file
#
# Ensure mod is 640 with ownership as root:ops
# and expected to be /etc/profile.d/NAME.sh
#
# @since 2013-08-20
#
echo "deployment.webplatform.org: You have access to 'nova' commands!"
export NOVA_USERNAME="team-webplatform-admin@w3.org"
export NOVA_PASSWORD="000000000000"
#export NOVA_PROJECT_ID="team-webplatform-admin@w3.org-default-tenant"
export NOVA_PROJECT_ID="schepers@w3.org-default-tenant"
export NOVA_URL="https://region-a.geo-1.identity.hpcloudsvc.com:35357/v2.0/"
export NOVA_VERSION="1.1"
export NOVA_REGION_NAME="az-1.region-a.geo-1"
