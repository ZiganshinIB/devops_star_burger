# Project Star Burger 
This is a repository intended for build  [project](https://github.com/ZiganshinIB/star-burger-dvmn) в Docker и Kubernetes
## System requirements 
Software:
- Docker (preferably Docker version 27.2.1, build 9e34c9b)
- kubectl (preferably version 1.31.0)
- minikube (preferably version 1.34.0)
Hardware :
- operating system : Linux (preferably Ubuntu 20.04.1 LTS)
- CPU : 2 cores and more
- RAM : 8 GB adn more
- Disk space : 20 GB and more
## Quick start
### Clone the project to your local computer
```shell
git clone https://github.com/ZiganshinIB/devops_star_burger.git
cd devops_star_burger
```
### Create file `.env`  to the project root directory and write variables:
```bash
SECRET_KEY=django-insecure-0if40nf4nf93n4
YANDEX_API_KEY=610526f4-26ba-44c5-a498-a82f22d28d35
PG_USER=db_user
PG_PASSWORD=secret_password
PG_DB=db_name

```
- `SECRET_KEY` — project secret key. He is responsible for encryption on the site. For example, all passwords on your website are encrypted with it.
- `YANDEX_API_KEY` — The YANDEX_API_KEY token can be obtained from the following link https://developer.tech.yandex.ru/services/3
Following variables for database:
- `PG_USER` — database username (Optional)
- `PG_PASSWORD` — database user password (Optional)
- `PG_DB` — database name (Optional)
### Start dev version project
```bash
docker compose -f docker-compose.dev.yaml up 
```

### Start prod version project
It is advisable to add environment variables to `.env`
```
ALLOWED_HOSTS=127.0.0.1,localhost
ROLLBAR_ACCESS_TOKEN=YOUR_ROLLBAR_ACCESS_TOKEN
ROLLBAR_NAME=YOUR_ROLLBAR_NAME
ROLLBAR_ENVIRONMENT=YOUR_ROLLBAR_ENVIRONMENT
```
Next run project
```shell
docker compose -f docker-compose.prod.yaml up
```

# Docker
In docker hub has dev and prod versions of the project.
Example, `elzig1999/star-burger:<version>dev` - dev version.
`elzig1999/star-burger:<version> .prod` - prod version.

# Kubernetes 
To build a project using Kubernetes, created [docker images](https://hub.docker.com/r/elzig1999/star-burger/tags).
## Quick start
### Start minikube
```shell
minikube start --driver docker
```
### Create pod manually
Example:
```shell
kubectl run star-burger-pod --image=elzig1999/star-burger:1.0.2dev --env=YANDEX_API_KEY=YOUR_YANDEX_API_KEY \
--env=SECRET_KEY=YOUR_SECRET_KEY --port=8000 
```
For start with database you need add following variables --env=DB_URL=YOUR_DB_URL
#### Port forwarding
To read in docs https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#port-forward
Example:
```shell
kubectl port-forward pod/star-burger-pod 8000:8000
```
#### Create service
```shell
kubectl expose pod star-burger-pod --port=80 --target-port=8000 --type=NodePort
```
If you run in minikube (https://minikube.sigs.k8s.io/docs/handbook/accessing/):
```shell
minikube service star-burger-pod --url
```
### Create pod automatically (with YAML file)
1. Add Secret to the project (https://kubernetes.io/docs/concepts/configuration/secret/).:
   * Encode secret in base64 and copy result
   ```shell
    echo -n 'YOUR_SECRET' | base64 
    ```
   * Create Secret (manifest):
    ```yaml 
    apiVersion: v1
    kind: Secret
    metadata:
        name: star-burger-secret
    type: Opaque
    data:
        DEBUG: YOUR_SECRET_IN_BASE64 # Option
        DB_URL: YOUR_SECRET_IN_BASE64 # Option
        YANDEX_API_KEY: YOUR_SECRET_IN_BASE64
        SECRET_KEY: YOUR_SECRET_IN_BASE64
    ```
2. Start POD and Services (manifest):
```shell
kubectl apply -f k8s/k8s-star-burger-dev-pod.yaml
```
If you run in minikube (https://minikube.sigs.k8s.io/docs/handbook/accessing/):
```shell
minikube service star-burger-pod --url
```
3. Delete pod and service (manifest):
```shell
kubectl delete -f k8s/k8s-star-burger-dev-pod.yaml
```
### Create deployment automatically (with YAML file)
1. Add Secret to the project (https://kubernetes.io/docs/concepts/configuration/secret/).:
   * Encode secret in base64 and copy result
   ```shell
    echo -n 'YOUR_SECRET' | base64 
    ```
   * Create Secret (manifest):
    ```yaml 
    apiVersion: v1
    kind: Secret
    metadata:
        name: star-burger-secret
    type: Opaque
    data:
        DEBUG: YOUR_SECRET_IN_BASE64 # Option
        DB_URL: YOUR_SECRET_IN_BASE64 # Option
        YANDEX_API_KEY: YOUR_SECRET_IN_BASE64
        SECRET_KEY: YOUR_SECRET_IN_BASE64
    ```
2. Start deployment (manifest):
```shell
kubectl apply -f k8s/k8s-star-burger-dev-deploy.yaml
```
3. Delete deployment (manifest):
```shell
kubectl delete -f k8s/k8s-star-burger-dev-deploy.yaml
```

