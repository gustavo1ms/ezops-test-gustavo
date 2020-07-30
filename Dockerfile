FROM node:12

WORKDIR /ezopsapp

COPY package*.json ./

RUN npm install --silent

COPY . .

EXPOSE 3000

ENTRYPOINT node ./server.js
