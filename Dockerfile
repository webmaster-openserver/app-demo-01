# Etapa 1: Build de Angular
FROM node:18-alpine as builder
WORKDIR /app-demo-01
COPY . .
RUN npm install
RUN npm run build -- --configuration=production

# Etapa 2: Servidor NGINX
FROM nginx:alpine
COPY --from=builder /app-demo-01/dist/app-demo-01 /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto
EXPOSE 80