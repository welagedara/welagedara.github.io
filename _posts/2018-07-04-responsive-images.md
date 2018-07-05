---
layout: post
title: "Responsive Images"
categories: junk
author: "Pubudu Welagedara"
meta: "Jekyll"
---

[Jekyll][jekyll] does not support responsive images out of the box. There are plugins that can do that. 

- [jekyll-responsive-image][plugin-one]
- [Jekyll Srcset][plugin-two]

But unfortunately GitHub has to support it.

{% assign image = "plugins.png" %}
{% assign alt = "Plugins Supported" %}
{% include srcset.html %}

## The Fix 

[Ben Seymour][ben] has written a [post][post] on making images responsive. I got his code to work with some slight modifications. 

I created a shell script  `resize_image.sh` to resize an image in my  `artifact` directory and store them in the width buckets  `600`,  `850` and  `1200`.

```bash
#!/bin/bash

# Prerequisite 
# 1. ImageMagick

# Pass image name as a param
IMAGE=$1

convert ./artifacts/$IMAGE -resize 600 ./artifacts/600/$IMAGE
convert ./artifacts/$IMAGE -resize 850 ./artifacts/850/$IMAGE
convert ./artifacts/$IMAGE -resize 1200 ./artifacts/1200/$IMAGE
```

After resizing the image I only had to add these lines to make my images responsive. Note that I am not using the `_config.yml` like Ben since I did not want to modify the code in two places to add an image( The downside to that is having to modify in many places if I ever need to modify an image I have already added :blush: Let's hope that never happens)

```md
{% raw %}
{% assign image = "plugins.png" %}
{% assign alt = "Plugins Supported" %}
{% include srcset.html %}
{% endraw %}
```

[jekyll]: http://jekyllrb.com
[documentation]: https://jekyllrb.com/docs/posts/
[plugins]: https://help.github.com/articles/adding-jekyll-plugins-to-a-github-pages-site/
[plugin-one]: https://github.com/wildlyinaccurate/jekyll-responsive-image
[plugin-two]: https://github.com/netlify/jekyll-srcset
[ben]: https://benseymour.com/
[post]: https://benseymour.com/2017/03/02/Responsive-Images-in-Jekyll-without-a-plugin