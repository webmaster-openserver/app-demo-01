# build environment
FROM node:18-alpine as builder
# RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY . /usr/src/app
RUN npm install
RUN npm run build --configuration=production

# production environment
FROM nginx:alpine
RUN rm -rf /etc/nginx/conf.d
RUN mkdir -p /etc/nginx/conf.d
COPY ./default.conf /etc/nginx/conf.d/
COPY --from=builder /usr/src/app/dist/app-demo-01/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# Etapa 1: Build de Angular
# FROM node:18-alpine as builder
# RUN mkdir /usr/src/app
# WORKDIR /app
# COPY . .
# RUN npm install
# RUN npm run build -- --configuration=production

# Etapa 2: Servidor NGINX
# FROM nginx:alpine
# COPY --from=builder /app/dist/app-demo-01 /usr/share/nginx/html
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto
# EXPOSE 80