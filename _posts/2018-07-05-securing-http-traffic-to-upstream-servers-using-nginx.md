---
layout: post
title: "Securing HTTP Traffic to Upstream Servers using NGINX"
categories: junk
author: "Pubudu Welagedara"
meta: "NGINX"
---

How do you secure your backend using HTTPS? I will create a Swagger Node Project to show you how.

```bash
swagger project create upstream
cd upstream/
swagger project start
```
Swagger Module for Node will create an endpoint that looks like this( By default the Swagger Document is available on `http://localhost:10010/swagger`).

{% assign image = "swag.png" %}
{% assign alt = "Swagger UI" %}
{% include srcset.html %}

Now let's configure the NGINX to send the traffic to my upstream server.

Find your NGINX configuration file. On my Mac it was in `/usr/local/etc/nginx/` directory.

```bash
sudo nano /usr/local/etc/nginx/nginx.conf
```

Add this configuration to that.
```
# HTTPS server
#
server {
    listen       443 ssl;
    server_name  localhost;

    ssl_certificate      /usr/local/etc/nginx/ssl/tls.crt;
    ssl_certificate_key  /usr/local/etc/nginx/ssl/tls.key;

    location / {
        proxy_pass http://127.0.0.1:10010;
    }
}
```

Now stop NGINX and then start it.

```bash
sudo nginx -s stop
sudo nginx
```

Or simply restart it.
```bash
sudo nginx -s reload
```

You are all set. Hit the endpoint using the browser( I am using a Self Signed Certificate. Therefore the browser will show an invalid cert message.). 

{% assign image = "api-call.png" %}
{% assign alt = "API Call" %}
{% include srcset.html %}

Don't forget to disable HTTP or enforce HTTP redirection to HTTPS in your Production Environments.

{% assign image = "thank-you-potato.png" %}
{% assign alt = "Potato" %}
{% include srcset.html %}

Icon made by [Freepik](http://www.freepik.com/) from [www.flaticon.com](http://www.flaticon.com/)






