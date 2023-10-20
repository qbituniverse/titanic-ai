#############################################################################
# titanic-ai App - Helm
#############################################################################
# set context
kubectl config get-contexts
kubectl config use-context docker-desktop
kubectl config current-context

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

# launch webapp & api
start http://web.titanic-ai.localhost
start http://api.titanic-ai.localhost/__docs__/

# clean-up
kubectl delete namespace titanic-ai