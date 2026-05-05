# Build stage
FROM node:lts AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Runtime stage
FROM node:lts-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    imagemagick \
    webp \
    libvips \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .

RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 --gid 1001 botuser && \
    chown -R botuser:nodejs /app

USER botuser
EXPOSE 3000
ENV NODE_ENV=production
CMD ["npm", "run", "start"]
