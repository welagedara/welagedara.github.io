---
layout: post
title: "Self Signed SSL Certificates"
categories: junk
author: "Pubudu Welagedara"
meta: "TLS"
comments: true
---

These are the steps to create a self signed SSL Certificate.

Generate the Key.

```bash
sudo openssl genrsa -des3 -out tls.key 2048
```

Next generate the Certificate Signing Request.

```bash
sudo openssl req -new -key tls.key -out tls.csr
```

You might want to remove the passphrase to prevent being prompted to enter it when you server restarts. 

To do that first make a copy of the Key.

```bash
sudo cp tls.key tls.key.orig
```

Run this to get the new Key.

```bash
sudo openssl rsa -in tls.key.orig -out tls.key
```

Now sign the Key. Remember you need to change the expiration.

```bash
sudo openssl x509 -req -days 365 -in tls.csr -signkey tls.key -out tls.crt
```

Now you have the `.crt` and the `.key` files.

