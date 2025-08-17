#!/bin/bash

# HOW TO RUN THIS BASH SCRIPT FOR EAISER CLI COMMANDS FOR STARTING DOCKER CONTAINER ON DEVELOPMENT ONLY
# /strapi-dev.sh → starts in detached mode
# /strapi-dev.sh --attach → runs attached (see console output)
# /strapi-dev.sh logs → tails logs
# /strapi-dev.sh stop → stops dev container

•/strapi-dev.sh down → stops & removes containers
cd "$(dirname "$0")"

case "$1" in
  logs)
    docker compose logs -f strapi-dev
    ;;
  stop)
    docker compose stop strapi-dev
    ;;
  down)
    docker compose down
    ;;
  --attach)
    docker compose up strapi-dev
    ;;
  *)
    docker compose up -d strapi-dev
    echo "✅ Strapi development container is running!"
    echo "   -> Visit: http://localhost:1337"
    echo "   -> Logs: ./strapi-dev.sh logs"
    ;;
esac
