# Use an official Node.js runtime as the base image
FROM node:latest


# Set the working directory in the container
WORKDIR /var/www

# Copy package.json and package-lock.json to the container

# Copy the rest of the app source code to the container
COPY . /var/www

# Install the app dependencies
RUN npm install

# Expose the desired port (replace 3000 with the appropriate port)
EXPOSE 3000

# Specify the command to run your app
CMD ["node","index.js"]
