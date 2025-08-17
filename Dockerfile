# ---------- Build Stage ----------
FROM node:20-alpine AS build

# Install build deps for sharp/esbuild/etc.
RUN apk update && apk add --no-cache \
  build-base \
  gcc \
  autoconf \
  automake \
  zlib-dev \
  libpng-dev \
  nasm \
  vips-dev \
  git \
  libc6-compat \
  python3

# Set workdir
WORKDIR /srv/app

# Install dependencies (production only, no dev deps)
COPY package.json package-lock.json ./
RUN npm install --omit=dev

# Rebuild esbuild (covers Alpine + Strapi’s Vite deps)
RUN find node_modules -type d -name esbuild -exec npm rebuild esbuild --prefix {} --force \;

# Copy source and build
COPY . .
RUN npm run build

# ---------- Final Stage ----------
FROM node:20-alpine

# Runtime deps (sharp needs vips)
RUN apk add --no-cache vips-dev

# Set env
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /srv/app

# Copy built app + node_modules from build stage
COPY --from=build /srv/app ./

# Ensure correct permissions
RUN chown -R node:node /srv/app
USER node

# Expose port
EXPOSE 1337

# Start Strapi
CMD ["npm", "run", "start"]
