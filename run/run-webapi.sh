#############################################################################
# titanic-ai R Webapi
#############################################################################
# variables
dockerfile="Dockerfile-titanic-ai-webapi"
image="qbituniverse/titanic-ai-webapi:local"
container="titanic-ai-webapi"
network="titanic-ai-bridge"

#############################################################################
# Create, configure and work with Webapi
#############################################################################
# build image
docker build -t $image -f .cicd/docker/$dockerfile .

# create network & container
docker network create $network
docker run --name $container -d -p 8021:80 --network=$network \
-e ASPNETCORE_ENVIRONMENT=Development \
-e WebApi__RApiUrl=http://titanic-ai-api:8000 \
$image

# launch Webapi
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