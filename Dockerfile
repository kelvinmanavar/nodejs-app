# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Copy the rest of the app source code to the container
COPY . .

# Build the app

# Set the environment variable for production


# Expose the desired port (replace 3000 with the appropriate port)
EXPOSE 3000

# Specify the command to run your app
CMD ["node", "dist/index.js"]
