FROM node:18-alpine AS build

WORKDIR /web_app

COPY package*.json .
RUN npm ci

COPY . .

RUN npm run build

FROM nginx:alpine
COPY --from=build /web_app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# EXPOSE 3000

# CMD ["npm","start"]

