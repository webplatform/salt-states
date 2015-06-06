FROM dscho/node.js

RUN su -c "git clone -b wpd https://github.com/webplatform/parsoid.git" -l node

WORKDIR /home/node/parsoid/api

# generate localsettings.js
RUN su -c "sed \"s|'http://localhost/w|process.env.MW_URL + '|\" < localsettings.js.example > localsettings.js" node

# install node.js dependencies
RUN su -c "cd parsoid && npm install" -l node

# run parsoid as 'node' user by default
EXPOSE 8000

CMD su -c "MW_URL=$MW_URL node parsoid/api/server.js" -l node
