---
layout: post
title: "An Ingress with HTTPS Traffic in Upstream Servers, HTTPS Redirection and Sticky Sessions( IBM)"
categories: junk
author: "Pubudu Welagedara"
meta: "Kubernetes"
---

IBM has done a very good job on their [Ingress Documentation][documentation].

These are the annotations needed.

For HTTPS Redirection
```yaml
ingress.bluemix.net/redirect-to-https: "True"
```

To handle HTTPS Traffic in Upstream
```yaml
ingress.bluemix.net/ssl-services: "ssl-service=api-manager;ssl-service=is-as-km;ssl-service=am-analytics;"
```

To maintain a sticky session with the Upstream. A Cookie named `route` will be added to the request with an expiry of `43800h` only if more than one replica is in the Deployment.
```yaml
ingress.bluemix.net/sticky-cookie-services: "serviceName=api-manager name=route expires=43800h path=/ hash=sha1;"
```

Here is the entire Ingress.

```yaml
kind: Ingress
apiVersion: extensions/v1beta1
metadata:
    name: apifest-ingress
    annotations:
      ingress.bluemix.net/redirect-to-https: "True"
      ingress.bluemix.net/ssl-services: "ssl-service=api-manager;ssl-service=is-as-km;ssl-service=am-analytics;"
      ingress.bluemix.net/sticky-cookie-services: "serviceName=api-manager name=route expires=43800h path=/ hash=sha1;"
spec:
    tls:
    -   hosts:
        - apim-portal.yourdomain.com
        - apim-gateway.yourdomain.com
        - apim-key-manager.yourdomain.com
        - apim-analytics.yourdomain.com
        secretName: tls-secret
    rules:
    -   host: apim-portal.yourdomain.com
        http:
            paths:
            -   path: /
                backend:
                    serviceName: api-manager
                    servicePort: 9443
    -   host: apim-gateway.yourdomain.com
        http:
            paths:
            -   path: /
                backend:
                    serviceName: api-manager
                    servicePort: 8243 
    -   host: apim-key-manager.yourdomain.com
        http:
            paths:
            -   path: /
                backend:
                    serviceName: is-as-km
                    servicePort: 9443 
    -   host: apim-analytics.yourdomain.com
        http:
            paths:
            -   path: /
                backend:
                    serviceName: am-analytics
                    servicePort: 9444 
```

I am using this script to deploy it.
```bash
#!/bin/bash

# Deploys the Ingress

# Create a Secret to Store TLS Key and Cert
kubectl create secret tls tls-secret --key ./tls/tls.key --cert ./tls/tls.crt

# Add Ingresses 
kubectl create -f ./kubectl/tls-ingress.yaml

```


[documentation]: https://console.bluemix.net/docs/containers/cs_annotations.html



