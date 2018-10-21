---
layout: post
title: "Create your own Helm Repo"
categories: junk
author: "Pubudu Welagedara"
meta: "Helm Charts"
comments: true
---

[Helm][helm] is a Package Manager for Kubernetes. [Here][tutorial]'s a good getting started tutorial on Helm Charts. 

[My Helm Chart Repo][repo] is exposed on <https://welagedara.github.io/helm/>. 

{% assign image = "helm-repo.png" %}
{% assign alt = "My Helm Repo" %}
{% include srcset.html %}

## Add a new Repo
Add that to your repos using.
```bash
helm repo add welagedara https://welagedara.github.io/helm/
```

Check if the Repo got added succefully
```bash
helm repo list
```

Update the Repos by using this command
```bash
helm repo update
```

Finally install hello-world. The latest version will be installed if --version flag is not set.
```bash
helm install welagedara/hello-world 
```

## How to update the Repo

Check for errors using `lint` command
```bash
helm lint ./hello-world/
```

Package it
```bash
helm package ./hello-world/
```

Update index.yaml
```bash
helm repo index ./
```
Push the artifacts to Github
```bash
git push origin master
```

## Upgrade and Rollback 

Install the app from local
```
helm install ./hello-world
``` 
Upgrade the app
```
helm upgrade --set replicaCount=2,image.tag="1.13" <helm name> ./hello-world
```

To check revison number 
```bash
helm list -a
```
or 
```bash
helm history <helm name>
```

To rollback
```bash
helm rollback <helm name> <revision number>
```

Here is an example.
```bash
helm rollback needled-hog 1
```

## Upgrade and Rollback using an external yaml

Install the app
```bash
helm install -f ./hello-world-helm.yaml ./hello-world
``` 

Upgrade the app
```bash
helm upgrade -f ./hello-world-helm-upgraded.yaml <helm name> ./hello-world
```

To check revison number 
```bash
helm list -a
```
or bash
```
helm history <helm name>
```

To rollback
```bash
helm rollback <helm name> <revision number>
```
Here is an example
```bash
helm rollback early-ladybird 1
```

[helm]: https://github.com/kubernetes/charts
[repo]: https://github.com/welagedara/helm
[tutorial]: https://www.youtube.com/watch?v=vQX5nokoqrQ
