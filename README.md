# 🚀 Getting Started with Strapi + Docker

This project uses [Strapi](https://strapi.io) as the CMS and supports both local development and production deployment using Docker.

---

## 📦 Development (Docker)

You can run Strapi in development mode using the provided `docker-compose.development.yml`. This enables **autoReload** for a smoother dev experience.

### Start Development Server

```bash
docker compose -f docker-compose.development.yml up --build
```

### Stop Development Server

```bash
docker compose -f docker-compose.development.yml down
```

### Access

Strapi Admin Panel: http://localhost:1337/admin

## ⚙️ Production Deployment (Docker)

To run Strapi in production, use the included Dockerfile.production.

### Build Production Image

```bash
docker build -t my-strapi-app -f Dockerfile.production .
```

### Run Production Image

```bash
docker run -d \
  --name strapi \
  -p 1337:1337 \
  -e DATABASE_CLIENT=postgres \
  -e DATABASE_HOST=<your-db-host> \
  -e DATABASE_PORT=5432 \
  -e DATABASE_NAME=<your-db-name> \
  -e DATABASE_USERNAME=<your-db-username> \
  -e DATABASE_PASSWORD=<your-db-password> \
  -e NODE_ENV=production \
  my-strapi-app
```

### Access

Strapi Admin Panel: http://localhost:1337/admin

## 🛠 Strapi CLI Commands

Strapi also comes with a full featured Command Line Interface.

```bash
npm run develop
# or
yarn develop
```

Start your Strapi application when autoReload is disabled.

```bash
npm run start
# or
yarn start
```

Build the strapi admin panel.

```bash
npm run build
# or
yarn build
```
