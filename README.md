# node-hostname

A Node.js application that provides the hostname of the server where it is running. This project is containerized with Docker and can be deployed to a Kubernetes cluster. The application is available at [http://alensiilivask.ddns.net](http://alensiilivask.ddns.net).

## Deployment

### The application can be deployed to a Kubernetes cluster in various ways.

### 1. Deployment using Kubernetes
```kubectl apply -f kubernetes```

It will deploy the application to a Kubernetes cluster and make it available

### 2. Deployment using Terraform
- Initialize Terraform
```terraform init```

- Apply the configuration
```terraform apply```

It will deploy the application to Google Cloud and then deploy the kubernetes cluster with the application

### 3. Deployment using GitHub Action Pipeline
On every commit or pull request to master branch, the pipeline will be exectude which will run the deployment to Google Clound with creation of kubernetes cluster
