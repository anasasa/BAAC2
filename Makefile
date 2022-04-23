SERVICE_NAME=panda50-front

release: 
	docker build -t panda50-front .

run:
	docker run --rm --name panda50-front -p 8080:8080 -d panda50-front

stop:
	docket stop panda50-front

azure_create:
	AKS_RESOURCE_GROUP=panda50-group
	AKS_CLUSTER_NAME=panda50Cluster
	az group create --name $(AKS_RESOURCE_GROUP) --location eastus
	az aks create --resource-group $(AKS_RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME) --node-count 1 --generate-ssh-keys
	az aks get-credentials --resource-group $(AKS_RESOURCE_GROUP) --name $(AKS_CLUSTER_NAME)

azure_destroy:
	AKS_RESOURCE_GROUP=panda50-group
	AKS_CLUSTER_NAME=panda50Cluster
	az group delete --name $(AKS_RESOURCE_GROUPi)
