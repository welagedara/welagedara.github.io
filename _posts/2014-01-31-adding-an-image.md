---
layout: post
title: "Adding an image to a post"
categories: misc
---

Example image


You can [get the PDF]({{ "/artifacts/mydoc.pdf" | absolute_url }}) directly.
 

This is a responsive image.
{% assign image = "image.png" %}
{% assign alt = "Butterfly, fluttering by." %}
{% include srcset.html %}