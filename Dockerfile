# Use the official Nginx image from Docker Hub
FROM nginx:stable-alpine

# Copy the static HTML page into the container
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
