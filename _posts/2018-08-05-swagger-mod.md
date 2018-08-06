---
layout: post
title: "Swagger-mod; A Filter for your Swagger Documents"
categories: junk
author: "Pubudu Welagedara"
meta: "Node.js"
---

I am positive that I am not the only one who wanted to modify an existing Swagger Document to get rid of the APIs that you do not want others to see. 

[`swagger-mod`][source] is there for the rescue. Filter your Swagger Documents using HTTP methods, tags, urls, summaries and descriptions by using a single Node.js package with ease. You can download that [here][source].

To use this package, first install it.

```bash
npm install swagger-mod --save
```

Then use the Promise Syntax to filter the swagger document. The filters can be chained like in the example below. You might want to have a look at the [regular expressions][regex] since all filters except for the HTTP method filter accept regular expressions. 

```js
const swaggerMod= require("swagger-mod");

const opts = {
    filters: {

        // Filter by HTTP methods
        http: {
            include: ['get', 'delete']
        },

        // Filter by paths using regular expressions
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
        paths: {
             exclude: [
                '//pet/findByStatus/'
             ]
        },

        // Filter by tags using regular expressions
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
        tags: {
            exclude: [
                '/^default$/i',
                '/Store/i'
            ]
        },

        // Filter by summary using regular expressions
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
        summary: {
            include: [
                '/Find pet by ID/',
                '/Deletes a pet/'
            ]
        },

        // Filter by description using regular expressions
        // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions
        description: {
            include: [
                '/Returns a single pet/'
            ]
        }
    }
};

swaggerMod('https://petstore.swagger.io/v2/swagger.json', opts)
  .then(function(modifiedSchema) {
    console.log(modifiedSchema);      
  }).catch(function(err) {
    console.error(err);
  });
```

[source]: https://www.npmjs.com/package/swagger-mod
[regex]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions

