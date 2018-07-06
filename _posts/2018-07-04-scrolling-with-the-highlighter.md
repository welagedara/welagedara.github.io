---
layout: post
title: "Scrolling with the Highlighter"
categories: junk
author: "Pubudu Welagedara"
meta: "Jekyll"
---

You will notice that the highlighted text seems to overflow on smaller screens. 

{% assign image = "overflow.png" %}
{% assign alt = "Highlighter Overflow" %}
{% include srcset.html %}

There is a simple [fix][fix] for that. 

Add the below lines to your CSS. 
```css
pre { white-space: pre; overflow: auto; }

```
You will have a scroll bar enanbled now.

{% assign image = "overflow-fixed.png" %}
{% assign alt = "Highlighter Overflow Fixed" %}
{% include srcset.html %}

[fix]: https://stackoverflow.com/questions/11093233/how-to-support-scrolling-when-using-pygments-with-jekyll
