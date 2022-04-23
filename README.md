# Panda50 Fron-end
Aplikacja front-end do zbudowania i uruchomienia w dockerze

##Wymagane zainstalowane na stacji

- docker
- make
- azure-cli
- python3 z paczkami venv i flask

##Komendy

Żeby zbudować aplikację w dockerze
```bash
make release
```

Uruchomienie i zatrzymanie aplikacji w dockerze
```bash
make run
make stop
```

##Deployment na Azure
Zalogowanie się do Azure z poziomu CLI

```bash
az login
```

Utworzenie zasobów do uruchomienia klastra kubernetes w Azure

```bash
export AKS_RESOURCE_GROUP=panda50-group
export AKS_CLUSTER_NAME=panda50Cluster
az group create --name ${AKS_RESOURCE_GROUP} --location eastus
az aks create --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME} --node-count 1 --generate-ssh-keys
az aks get-credentials --resource-group ${AKS_RESOURCE_GROUP} --name ${AKS_CLUSTER_NAME}
az acr create --name=panda50registry --resource-group ${AKS_RESOURCE_GROUP} --sku Basic --location eastus
az acr updare --name=panda50registry --admin-enabled true
```

Deployment obrazu dockera utworzonego lokalnie do Azure (wymagana znajomość użytkownika i hasła do zasobu panda50register)
```bash
kubectl create secret docker-registry panda50-front-secret --namespace default --docker-server=panda50registry.azurecr.io --docker-username=<username> --docker-password=<password>
docker login panda50registry.azurecr.io
docker tag panda50-front:latest panda50registry.azurecr.io/panda50-front:latest
docker push panda50registry.azurecr.io/panda50-front
```

Deployment aplikacji w Azure
```bash
kubectl apply -f deployment/kube-deployment.yaml
```

Dodatkowo zautomatyzowany proces tworzenia zasobów i usuwania z Azure

```bash
make azure_create
make azure_destroy
```
