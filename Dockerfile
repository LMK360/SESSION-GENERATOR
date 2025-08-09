# Use official Node.js image with Corepack support
FROM node:18

# Enable Corepack (used for managing pnpm)
RUN corepack enable

# Set working directory inside the container
WORKDIR /app

# Copy package manager files first (for caching)
COPY package.json pnpm-lock.yaml ./

# Prepare and activate the desired version of pnpm
RUN corepack prepare pnpm@8.6.4 --activate

# Install dependencies using pnpm
RUN pnpm install --force --registry=https://registry.npmmirror.com

# Run approve-builds if it's available
RUN pnpm exec approve-builds || true

# Install dependencies using pnpm
RUN pnpm install --force --registry=https://registry.npmmirror.com

# Copy the rest of the application files
COPY . /app

# Expose the port your app will run on
EXPOSE 8000

# Start the app using pnpm
CMD ["pnpm", "start"]
