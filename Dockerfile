# Use a base image with Node.js and Nginx pre-installed
FROM node:14-alpine as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the index.html, styles.css, and the background image
COPY index.html styles.css pexels-andrea-piacquadio-5046423.jpg ./

# Build the production-ready code
RUN npm run build

# Use a lightweight Nginx image to serve the web application
FROM nginx:alpine

# Copy the built files from the builder stage to the Nginx server
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80 to allow incoming traffic
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
