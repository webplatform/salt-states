FROM webplatform/etherpad

MAINTAINER Renoir Boulanger, renoir@w3.org

ADD build/settings.json /opt/etherpad/settings.json
ADD build/package.json /opt/etherpad/package.json

WORKDIR /opt/etherpad

ENV NODE_ENV production

# Get Etherpad-lite's other dependencies
RUN mkdir -p /var/log/etherpad && \
    apt-get autoremove -yqq --purge && \
    npm install

# Plugins in use:
#  - ep_user_pad_frontend
#  - ep_user_pad
#  - ep_offline_edit
#  - ep_markdown
#  - ep_markdownify
#  - ep_linkify

VOLUME "/var/log/etherpad"

CMD ["supervisord", "-c", "/etc/supervisor/supervisor.conf", "-n"]
