---
layout: post
title: "Production Kubernetes with DevOps Part 2 - The Ingress"
categories: junk
author: "Pubudu Welagedara"
meta: "DevOps"
---

I am going to deploy everything in one Cluster since Kubernetes Clusters are expensive. Then I am going to move the LDAP into that cluster since it is not required to have it outside now.

## Prerequisites

### Create a Static IP

```
gcloud auth login 

gcloud config set project <project id>
```

Then connect to the cluster using the connection string given.
```
gcloud container clusters get-credentials kube-main --zone us-central1-a --project kubefire-209619
```

Then create the Global IP
```
gcloud compute addresses create devops-tools-ip --global

gcloud compute addresses describe devops-tools-ip --global
```

### Add the DNS Entries

{% assign image = "do1.png" %}
{% assign alt = "DevOps" %}
{% include srcset.html %}

## Deploy the Ingress

Now go ahead and deploy the Ingress. I am not using SSL for now.

{% assign image = "do2.png" %}
{% assign alt = "DevOps" %}
{% include srcset.html %}

## Cleanup

```
gcloud compute addresses delete devops-tools-ip --global
```

## ToDos
 - Add the default backend

## References
 - [GCloud Ingress Reference](https://cloud.google.com/kubernetes-engine/docs/tutorials/configuring-domain-name-static-ip) 
 - [Name based Virtual Hosting](https://kubernetes.io/docs/concepts/services-networking/ingress/#name-based-virtual-hosting) 
 - [Default HTTP Backend](https://github.com/smpio/kube-default-http-backend) 


