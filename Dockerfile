# Use the official Nginx image from Docker Hub
FROM nginx:stable-alpine

# Update curl to the fixed version
RUN apk update && apk add --no-cache curl=8.11.1-r0

# Copy the static HTML page into the container
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
