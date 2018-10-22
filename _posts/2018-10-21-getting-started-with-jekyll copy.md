---
layout: post
title: "Comments for Your Blog with Disqus"
categories: junk
author: "Pubudu Welagedara"
meta: "Jekyll"
comments: true
---

Enabling others to comment on your posts is a nice to have feature for a blog. [Disqus][disqus] is an online tool which can be used to do this. It is pretty easy to integrate with your Jekyll Site. 

## Create an Account on Disqus

This is pretty easy so I am not going to explain this. 

## Create a new Site

When you have logged into your account you will be able to create a site.

## Embed the code

First you need to add a variable to the `YAML Formatter`. I added this to all my posts.

```yaml
---
# Other Stuff
comments: true
---
```

Then emded the `JavaScript` to the template.

```js
<div id="disqus_thread"></div>
<script>
    /**
     *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
     *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
     */
    /*
    var disqus_config = function () {
        this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
        this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
    };
    */
    (function() {  // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        
        s.src = 'https://pubuduonline.disqus.com/embed.js';
        
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
```

My Disqus Configuration looks like this

```js
var disqus_config = function () {
    this.page.url = "{{ site.url }}{{ page.url }}";
    this.page.identifier = "{{ page.id }}";
};
```
Now you should be able to see a comments section for each post.

[disqus]: https://disqus.com/
