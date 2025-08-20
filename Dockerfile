# Use the official Node.js 18 Alpine image as the base image
FROM node:18-alpine
# Set the working directory inside the container
WORKDIR /app    
# Copy package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./
# Install the application dependencies
RUN npm install 
# Copy the rest of the application files to the working directory
COPY . .
# Expose port 3000 for the application
EXPOSE 3000
# Command to run the application
CMD ["npm", "start"]