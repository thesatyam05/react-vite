# Stage 1: Build the Vite app
FROM node:22-alpine AS build

WORKDIR /app

# Copy dependencies and install
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve with "serve"
FROM node:22-alpine

WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy build artifacts from Stage 1
COPY --from=build /app/dist ./dist

# Expose port 3000
EXPOSE 3000

# Run the app with serve
CMD ["serve", "-s", "dist", "-l", "3000"]
