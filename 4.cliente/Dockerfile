FROM node:14-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY ./cliente/package.json /app
RUN npm install
COPY ./cliente/ /app
RUN npm run build --prod
FROM nginx:1.21.4
COPY --from=build-step /app/dist/cliente /usr/share/nginx/html
EXPOSE 80