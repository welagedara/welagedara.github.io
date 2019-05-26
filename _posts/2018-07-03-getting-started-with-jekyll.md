---
layout: post
title: "Getting Started with Jekyll"
categories: junk
author: "Pubudu Welagedara"
meta: "Jekyll"
comments: true
---

[GitHub Pages][gh-pages] are awesome! Who doesn't want to host a website directly from the repo. No Continuous
Integration Servers. No Apache Web Servers. You just need your HTML.

Oh wait...I don't want to write HTML. I don't want to spend time writing CSS to make my HTML pretty. Most of all, I don't want to spend days making my HTML pages responsive. Can't I eliminate the need to do all of this?

Two words.

1. [AsciiDoc][asciidoc]
2. [Jekyll][jekyll] 

## AsciiDoc

On the plus side, AsciiDoc pages look really good. They are responsive too. But I had to build the pages into HTML before pushing them to GitHub which was a bit annoying. I ended up writing a Shell Script to build the HTML.

```bash
#!/bin/bash

asciidoctor *.adoc
``` 

Check my [source code][my-source] to see how it was done. [This][my-pages] is now it looks like when hosted on GitHub.

## Jekyll

Seemed to be the best option to publish my articles. GitHub supports it. Thus I don't have to build the HTMLs before pushing the code. But, I was a bit annoyed when I saw that the images are not responsive. I'll write a post on the fix for that later.

For now [here][my-jekyll-source] is my source code. [This][my-jekyll-pages] is how it looks like. 

Ciao!

[gh-pages]: https://pages.github.com/
[asciidoc]: https://asciidoctor.org/docs/what-is-asciidoc/
[jekyll]: http://jekyllrb.com
[my-source]: https://github.com/pubudu-online/pubudu-online.github.io
[my-pages]: https://pubudu-online.github.io/
[my-jekyll-source]: https://github.com/welagedara/welagedara.github.io
[my-jekyll-pages]: https://welagedara.github.io/
