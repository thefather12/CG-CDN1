FROM debian:bookworm-slim

# 1. Instalar Nginx y certificados necesarios
RUN apt-get update && apt-get install -y \
    nginx \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Copiar tu configuración personalizada
COPY nginx.conf /etc/nginx/nginx.conf

# 3. Copiar el binario 'server' y dar permisos
COPY server /server
RUN chmod +x /server

# 4. Exponer el puerto de Cloud Run
EXPOSE 8080

# 5. Lanzar el binario y Nginx simultáneamente
# Usamos 'daemon off' para que Nginx no se cierre y mantenga el contenedor vivo
CMD ./server & nginx -g 'daemon off;'
