FROM node:18-alpine

WORKDIR /web_app

COPY package*.json .
RUN npm ci

COPY . .

EXPOSE 3000

CMD ["npm","start"]