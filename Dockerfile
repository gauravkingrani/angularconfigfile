# Stage 1
FROM node:14.16.0-alpine as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
RUN npm install
RUN npm audit fix
COPY . /app
RUN npm run build --prod
# Stage 2
FROM nginx:1.17.1-alpine
COPY --from=build-step /app/dist/e-care/ /usr/share/nginx/html

EXPOSE 4200
CMD npm start
