FROM node

USER node

EXPOSE 65520
EXPOSE 8080

WORKDIR /home/node

COPY ./entrypoint.sh /usr/local/bin

RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

RUN npm install -g remixd && \
    npm install remix-ide -g && \
    sed -i s/127.0.0.1/0.0.0.0/g /home/node/.npm-global/lib/node_modules/remixd/lib/src/websocket.js && \
    sed -i s/", loopback"//g /home/node/.npm-global/lib/node_modules/remixd/lib/src/websocket.js && \
    sed -i s/127.0.0.1/0.0.0.0/g /home/node/.npm-global/lib/node_modules/remix-ide/bin/remix-ide

CMD ["/usr/local/bin/entrypoint.sh"]