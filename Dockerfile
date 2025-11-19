# Build stage
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the React app
RUN npm run build

# Runtime stage
FROM node:18-alpine

WORKDIR /app

# Install express for serving
RUN npm install express

# Copy built app from builder
COPY --from=builder /app/dist ./dist

# Copy server file
COPY server.js .
COPY package.json .

# Expose port
EXPOSE 8080

# Start the server
CMD ["node", "server.js"]
