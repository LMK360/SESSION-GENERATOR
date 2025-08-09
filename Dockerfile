Dockerfile
Use official Node.js image with corepack pre-installed
FROM node:18

Enable corepack (comes with recent Node versions)
RUN corepack enable

Set working directory
WORKDIR /app

Copy only package files first (for cache)
COPY package.json pnpm-lock.yaml ./

Set the pnpm version you want to use (you can change this)
RUN corepack prepare pnpm@8.6.4 --activate

Install dependencies
RUN pnpm install --frozen-lockfile

Copy the rest of your app
COPY . .

Expose the port your app uses (match your Koyeb config)
EXPOSE 8000

Start the app
CMD ["pnpm", "start"]
