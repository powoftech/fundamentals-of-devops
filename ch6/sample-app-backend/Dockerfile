FROM node:lts

WORKDIR /home/node/app

COPY *.json .

RUN npm ci --only=production

COPY *.js .

EXPOSE 8080

USER node

CMD ["npm", "start"]
