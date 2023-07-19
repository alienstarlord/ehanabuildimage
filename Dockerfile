# Use the official Node.js base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Create the necessary directories with appropriate permissions
RUN chown -R node:node /app /usr/local/lib/node_modules /usr/local/bin

# Switch to a non-root user
USER node

# Disable strict SSL verification
RUN npm config set strict-ssl false

# Install the Cloud MBT tool with global tls verify off
RUN NODE_TLS_REJECT_UNAUTHORIZED=0 npm install --strict-ssl false mbt

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .$ 

# add MBT package to path

ENV PATH="${PATH}:/app/node_modules/mbt/bin"

# to keep the container running

CMD ["tail", "-f", "/dev/null"]

