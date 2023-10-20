# titanic-ai

**titanic-ai** is built entirely on container technology with [Docker](https://www.docker.com). To be able to run the code from the [titanic-ai GitHub](https://github.com/qbituniverse/titanic-ai) repository, all you need on your local workstation is [Docker Installation](https://docs.docker.com/get-docker/).

|Documentation|Packages|Showcase|
|-----|-----|-----|
|[Project Overview](/docs/overview)|[DockerHub Api Image](https://hub.docker.com/repository/docker/qbituniverse/titanic-ai-api)|
|[Project Description](/description)|[DockerHub Webapp Image](https://hub.docker.com/repository/docker/qbituniverse/titanic-ai-webapp)|[Gallery](/gallery)|
|[R Model Code Overview](/model)|||
|[C# Webapp Code Overview](/webapp)|||
|[Development Process](/development)|||
|[Deployment Process](/deployment)|||

### Try titanic-ai Now

#### Option 1: Docker Compose

Copy this YAML into a new **docker-compose.yaml** file on your file system.

```yaml
version: '3'
services:
  api:
    image: qbituniverse/titanic-ai-api:latest
    container_name: titanic-ai-api
    ports:
      - 8011:8000
    tty: true
    networks:
      - titanic-ai-bridge

  webapp:
    image: qbituniverse/titanic-ai-webapp:latest
    depends_on:
      - api
    container_name: titanic-ai-webapp
    environment:
      - ASPNETCORE_ENVIRONMENT=Development
      - WebApp__AiApi__BaseUri=http://titanic-ai-api:8000
    ports:
      - 8010:80
    tty: true
    networks:
      - titanic-ai-bridge

networks:
  titanic-ai-bridge:
    driver: bridge
```

Then use the commands below to start **titanic-ai** up and use it.

```bash
# start up titanic-ai
docker-compose up

# titanic-ai Webapp
start http://localhost:8010

# titanic-ai Api docs
start http://localhost:8011/__docs__/

# finish and clean up titanic-ai
docker-compose down
```

#### Option 2: Docker Run

Alternatively, you can run **titanic-ai** without compose, just simply use docker commands below.

```bash
# create network
docker network create titanic-ai-bridge

# start up titanic-ai containers
docker run --name titanic-ai-api -d -p 8011:8000 \
--network=titanic-ai-bridge qbituniverse/titanic-ai-api:latest

docker run --name titanic-ai-webapp -d -p 8010:80 \
-e ASPNETCORE_ENVIRONMENT=Development \
-e WebApp__AiApi__BaseUri=http://titanic-ai-api:8000 \
--network=titanic-ai-bridge qbituniverse/titanic-ai-webapp:latest

# titanic-ai Webapp
start http://localhost:8010

# titanic-ai Api docs
start http://localhost:8011/__docs__/

# finish and clean up titanic-ai
docker rm -fv titanic-ai-api
docker volume rm -f titanic-ai-api
docker rm -fv titanic-ai-webapp
docker volume rm -f titanic-ai-webapp
docker network rm titanic-ai-bridge
```
