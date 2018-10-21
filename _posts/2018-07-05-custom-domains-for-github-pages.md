---
layout: post
title: "Custom Domains for GitHub Pages"
categories: junk
author: "Pubudu Welagedara"
meta: "Jekyll"
comments: true
---

GitHub Documentation on [Setting up Custom Domains][custom-subdomain] will not that great if you do not know what you are supposed to do.

Here's what you need to do to setup your own Subdomain.

Create a `CNAME` file on your repo root. Then push your code to GitHub.

```bash
echo pubudu.kubefire.com > CNAME
```

Add a `CNAME` record in your DNS Provider pointing to your GitHub domain. I am using [GoDaddy][godaddy] for DNS.

{% assign image = "godaddy.png" %}
{% assign alt = "CNAME" %}
{% include srcset.html %}

I did not find a way to enable HTTPS from withing GitHub. There was an [article][cdn] on using a CDN to enforce HTTPS to your site.

If you have an NGINX in the Public Domain adding configuration like below to the conf files will route traffic from `https://pubudu.kubefire.com` to `https://welagedara.github.io` where your GitHub Pages are.

```
server {
    listen 443 ssl;
    server_name pubudu.kubefire.com;

    ssl_certificate /etc/nginx/ssl/kubefire.crt;
    ssl_certificate_key /etc/nginx/ssl/kubefire.key;

    location / {
        proxy_pass https://welagedara.github.io;       
    }
}
```

[custom-subdomain]: https://help.github.com/articles/setting-up-a-custom-subdomain/
[godaddy]: https://www.godaddy.com/
[cdn]: https://gist.github.com/cvan/8630f847f579f90e0c014dc5199c337b


