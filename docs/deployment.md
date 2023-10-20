# Deployment Process

## Docker Compose

Location: **.cicd/compose** and **.cicd/compose/cicd-compose.sh**

### Start up with Docker Compose

```bash
# using GitHub local source code
docker-compose -f .cicd/compose/docker-compose.GitHub.yaml up

# using DockerHub image repository
docker-compose -f .cicd/compose/docker-compose.DockerHub.yaml up
```

### Launch

```bash
start http://localhost:8010
```

### Take Down with Docker Compose

```bash
# using GitHub local source code
docker-compose -f .cicd/compose/docker-compose.GitHub.yaml down

# using DockerHub image repository
docker-compose -f .cicd/compose/docker-compose.DockerHub.yaml down
```

## Kubernetes

Location: **.cicd/kubernetes** and **.cicd/kubernetes/cicd-kubernetes.sh**

### Configure Kubernetes Context

```bash
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context
```

### Deploy to Kubernetes

```bash
# deploy
kubectl apply -f .cicd/kubernetes/deploy.yaml

# check deployment
kubectl get all -n titanic-ai
```

### Launch

```bash
start http://localhost:8010
```

### Take Down from Kubernetes

```bash
kubectl delete namespace titanic-ai
```

## Helm

Location: **.cicd/helm** and **.cicd/helm/cicd-helm.sh**

### Configure Kubernetes Context

```bash
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context
```

### Deploy to Kubernetes with Helm

```bash
# deploy webapp & api
helm upgrade titanic-ai-webapp -i --create-namespace --namespace titanic-ai .cicd/helm/titanic-ai-webapp
helm upgrade titanic-ai-api -i --create-namespace --namespace titanic-ai .cicd/helm/titanic-ai-api

# deploy ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx-ingress ingress-nginx/ingress-nginx \
--namespace titanic-ai \
--set controller.replicaCount=1 \
--set controller.admissionWebhooks.enabled=false \
--set controller.service.externalTrafficPolicy=Local

# check deployments
kubectl get all -n titanic-ai
kubectl get ingress -n titanic-ai
helm list --all -n titanic-ai
```

### Launch

```bash
start http://web.titanic-ai.localhost
start http://api.titanic-ai.localhost/__docs__/
```

### Take Down from Kubernetes

```bash
kubectl delete namespace titanic-ai
```