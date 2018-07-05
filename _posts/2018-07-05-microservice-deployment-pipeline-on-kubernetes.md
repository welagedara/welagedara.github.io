---
layout: post
title: "Microservice Deployment Pipeline on Kubernetes"
categories: junk
author: "Pubudu Welagedara"
meta: "Helm Charts"
---

"Microservices Deployment Pipelines" is a daunting topic for anyone. I am going to explain how I built a Microservices Deployment Pipeline on Kubernetes. This project is inspired by [Croc Hunter][crochunter] repo.

These are the things you must know in order to continue.

- [Docker][docker]( Dockerfiles etc.)
- [Jenkins][jenkins]( Jenkinsfiles, Pod Templates etc.)
- [Kubernetes][kubernetes]
- [Helm Charts][helm]( Basic Helm Commands)

## Associated Repositories

- [Microservice Repo][microservice] which contains the Application. 
- [Infrastructure Repo][infra] which can be used to deploy Jenkins and the Ingresses.
- [Pipeline Lib Repo][pipeline-lib] which has the Support Libraries for the Deployment.

## Environments( Kubernetes Clusters)

- `qa`
- `staging`
- `production`

## How the pipeline works

- Commits to `dev` branch goes into `qa` environment
- `release` branches go into `staging`
- Pull Requests go into `staging`
- When a Pull Request is merged with `master` it gets deployed in `production`


## Stages of a Deployment

You will be developing the application on `develop` branch. When you are ready to go into production a `release` branch is created. When you create a Pull Request from a `release` branch, it gets built in `staging` and the build result is submitted to GitHub. When the Pull Request is merged the app will be deployed in `productio`.

[Branch Restrictions][restrictions] can be enabled to prevent unauthorized users from pushing code to protected branches. Similarly Permissions for Branching, Creating Pull Requests, Merging Pull Request and be set based on an individual's Role in your Organization.

### 1. Prebuild

In this stage we check whether the image is already available using `gcloud` command( This is to make sure we are not building the same image twice). 

```bash
gcloud container images list-tags ${DOCKER_REPOSITORY}${DOCKER_IMAGE_NAME} --limit 9999 | grep ${GIT_COMMIT_HASH} | wc -l
```

In addition to that we find the current Helm Revision for Rollbacks.

### 2. Build

The application is built here. 

This stage is only executed in `qa` and `staging`.

### 3. Dockerize

We are Dockerizing the app here. Git hash is used to tag the image.

This stage is only executed in `qa` and `staging`.

### 4. Publish

Pushes the Docker Image to Google Container Registry( You can use any Docker Registry for this)

This stage is only executed in `qa` and `staging`.

### 5. Dry Run

Extecuted in all three environments.

### 6. Deploy

Extecuted in all three environments. If the deployment is unsuccessful changes are rolled back.

## Shell Scripts in the Microservice Repo

Many Shell Scripts are included in the Repo to prevent having to remember all the commands needed and to automate some of the repetitive tasks.

### Shell Scripts for Docker

- `1-docker-create-docker-machine.sh` to create a Docker Machine( You will not need this if you do not have Docker Machines).
- `2-docker_deploy-mysql.sh` to deploy MySQL on Docker with the schema and the data.
- `3-docker_deploy-microservice.sh` to deploy the Microservice on Docker. This script uses the `gradle` plugin for Docker to build the Docker Image.
- `3-docker_deploy-microservice-v2.sh` to deploy the Microservice on Docker. This Script does not use the `gradle` plugin for Docker to build the Docker Image.
- `4-docker_cleanup.sh` to tear down.
- `5-docker_remove-docker-machine.sh` to remove the Docker Machine( Optional)

### Shell Scripts for Kubectl
- `6-kubectl_deploy-mysql.sh` to deploy MySQL on your Kubernetes Cluster. In a Production Environment, you will be using an external Database. Therefore you will not need this.
- `7-kubectl_deploy-microservice.sh` to deploy your Microservice on Kubernetes. 
- `8-kubectl_cleanup.sh` to remove everything. You may need to remove the MySQL undeployment from this script if you are using an external Database.

### Shell Scripts for Helm

- `9-helm_deploy.sh` to deploy your Microservice on your Cluster using Helm Charts. Uses Config Maps to load data into MySQL( Config Map size is restricted to 1MB)
- `9-helm_deploy-v2.sh` to deploy your Microservice on your Cluster using Helm Charts. Does not use Config Maps to load data into MySQL.
- `9-helm_deploy_mysql.sh` to deploy MySQL on your Cluster using Helm Charts with Data. Uses the Database script `db.sql` to load the data directly.

## How a MySQL image is created

[Official MySQL Image][mysql-docker] on Docker Hub states that your `*.sql` files need to be copied to `/docker-entrypoint-initdb.d` to be executed when the container starts for the first time. 

This can be achieved in two ways.
1. Build a new image with your SQL Scripts copied. 
2. Use the Official Image. Mount your SQL Scripts into `/docker-entrypoint-initdb.d` directory. 

I have shown both ways to deploy MySQL in my Scripts. Do remember there is a limit to Config Map size( I think it is 1MB).

## Final Product

### Activity Page
{% assign image = "14.png" %}
{% assign alt = "Activity Page" %}
{% include srcset.html %}

### A Pull Request being Built in Staging Environment
{% assign image = "15.png" %}
{% assign alt = "PR being Built" %}
{% include srcset.html %}

### A Successful Pull Request Built in Staging Environment
{% assign image = "12.png" %}
{% assign alt = "PR Success" %}
{% include srcset.html %}

### Continuous Integration System notification to GitHub when a PR is being built
{% assign image = "16.png" %}
{% assign alt = "GitHub" %}
{% include srcset.html %}

### Continuous Integration System notification to GitHub upon a successful PR build
{% assign image = "11.png" %}
{% assign alt = "GitHub" %}
{% include srcset.html %}

{% assign image = "potato.png" %}
{% assign alt = "Potato" %}
{% include srcset.html %}

Icon made by [Freepik](http://www.freepik.com/) from [www.flaticon.com](http://www.flaticon.com/)

[docker]: https://www.docker.com/
[crochunter]: https://github.com/lachie83/croc-hunter
[jenkins]: https://jenkins.io/
[kubernetes]: https://kubernetes.io/
[helm]: https://github.com/kubernetes/charts
[restrictions]: https://help.github.com/articles/enabling-branch-restrictions/
[microservice]: https://github.com/welagedara/microservice
[infra]: https://github.com/welagedara/microservice-infrastructure
[pipeline-lib]: https://github.com/welagedara/pipeline-github-lib/
[mysql-docker]: https://hub.docker.com/_/mysql/

