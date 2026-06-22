FROM node:lts

# Install system dependencies for media, stickers, sharp, ffmpeg, etc.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    webp \
    libvips-dev \
    python3 \
    make \
    g++ \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files first
COPY package*.json ./

# Install Node.js dependencies
RUN npm install && npm cache clean --force

# Copy the rest of the application
COPY . .

# Expose port (matches CypherX)
EXPOSE 3000

# Set production environment
ENV NODE_ENV=production

# Start the bot
CMD ["npm", "run", "start"]
