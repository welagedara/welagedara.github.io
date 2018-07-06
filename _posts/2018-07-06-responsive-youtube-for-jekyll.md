---
layout: post
title: "Responsive YouTube for Jekyll"
categories: junk
author: "Pubudu Welagedara"
meta: "Jekyll"
---

A huge shout-out goes to [eduardoboucas][eduardoboucas] for figuring this out. He has written a long [blog post][post] on this.

He fixes the responsiveness issues by adding a few classes to the Style Sheets and by creating a partial that gets rendered by Jekyll's Templating Engine.

His algorithm dynamically adjusts the height for any given screen width.

```html
<iframe width="560" height="315" src="https://www.youtube.com/embed/c-GAQezjg8A" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
```

Now I just have to add the line below to embed a YouTube Video into my Blog.

```
{% raw %}
{% include video.html url="https://www.youtube.com/embed/c-GAQezjg8A" width="560" height="315" %}
{% endraw %}
```

I had to spend a few minutes to figure out whether it is illegal to embed a YouTube Video. Looks like embedding a video does not result in a Copyright Infringement. This [post][copyright] explains why.

So here's an awesome Kubernetes Demo done by [Kelsey Hightower][kelsey].

{% include video.html url="https://www.youtube.com/embed/kOa_llowQ1c" width="560" height="315" %}

[eduardoboucas]: https://eduardoboucas.com/
[post]: https://eduardoboucas.com/blog/2016/12/21/responsive-video-embeds-jekyll.html
[copyright]: https://turbofuture.com/internet/Embed-YouTube-Videos---Copyright-Infringement
[kelsey]: https://github.com/kelseyhightower



