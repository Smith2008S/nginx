FROM node:latest as build-stage

ARG ENV=prod
ARG APP=frontend
ENV ENV ${ENV}
ENV APP ${APP}

WORKDIR /app
COPY package*.json /app/

# Instala y construye el React App
RUN npm install
COPY ./ /app/
RUN npm run build

# React app construida, la vamos a hostear un server production, este es Nginx

FROM nginx:1.15
COPY --from=build-stage /app/build/ /usr/share/nginx/html
#COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.conf
