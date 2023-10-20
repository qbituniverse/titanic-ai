#############################################################################
# titanic-ai R Webapp
#############################################################################
# variables
dockerfile="Dockerfile-titanic-ai-webapp"
image="qbituniverse/titanic-ai-webapp:local"
container="titanic-ai-webapp"
network="titanic-ai-bridge"

#############################################################################
# Create, configure and work with Webapp
#############################################################################
# build image
docker build -t $image -f .cicd/docker/$dockerfile .

# create network & container
docker network create $network
docker run --name $container -d -p 8010:80 --network=$network \
-e ASPNETCORE_ENVIRONMENT=Development \
-e WebApp__AiApi__BaseUri=http://titanic-ai-api:8000 \
$image

# launch Webapp
start http://localhost:8010

#############################################################################
# Container operations
#############################################################################
# start, stop, exec
docker start $container
docker stop $container
docker exec -it $container bash

#############################################################################
# Clean-up
#############################################################################
docker rm -fv $container
docker volume rm -f $container
docker rmi -f $image
docker network rm $network