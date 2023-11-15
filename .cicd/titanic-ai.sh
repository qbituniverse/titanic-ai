### Tests ###

## Manual ##
# r studio
sudo docker run --name titanic-ai-rstudio -d -p 8012:8787 -v titanic-ai-rstudio:/home/rstudio -e DISABLE_AUTH=true qbituniverse/titanic-ai-rstudio:latest
curl http://192.168.1.15:8012
curl http://192.168.1.20:8012

# network
sudo docker network create titanic-ai-bridge

# r api
#sudo docker run --name titanic-ai-api -it --rm -p 8011:8000 qbituniverse/titanic-ai-api:latest
sudo docker run --name titanic-ai-api -d -p 8011:8000 --network=titanic-ai-bridge qbituniverse/titanic-ai-api:latest
curl http://192.168.1.15:8011/api/ping
curl http://192.168.1.20:8011/api/ping
curl http://192.168.1.15:8011/api/stats
curl http://192.168.1.20:8011/api/stats
curl http://192.168.1.15:8011/api/predict?sex=male'&'age=34'&'pclass=1'&'fare=22.00'&'sibsp=1'&'parch=2
curl http://192.168.1.20:8011/api/predict?sex=male'&'age=34'&'pclass=1'&'fare=22.00'&'sibsp=1'&'parch=2

# webapi
sudo docker run --name titanic-ai-webapi -d -p 8021:80 --network=titanic-ai-bridge -e WebApi__RApiUrl=http://192.168.1.15:8011 qbituniverse/titanic-ai-webapi:latest
curl http://192.168.1.15:8021/api/status
curl http://192.168.1.15:8021/api/model
curl http://192.168.1.20:8021/api/status
curl http://192.168.1.20:8021/api/model

# webapp
sudo docker run --name titanic-ai-webapp -d -p 8010:80 --network=titanic-ai-bridge -e WebApp__AiApi__BaseUri=http://192.168.1.15:8011 qbituniverse/titanic-ai-webapp:latest
curl http://192.168.1.15:8010
curl http://192.168.1.20:8010


## Compose ##
sudo docker compose -f .cicd/compose/docker-compose.DockerHub.yaml up
sudo docker compose -f .cicd/compose/docker-compose.DockerHub.yaml down
