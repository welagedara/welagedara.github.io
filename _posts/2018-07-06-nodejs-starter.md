---
layout: post
title: "Node.js Starter with Swagger Generation, Security, Database( CouchDB) and a CORS Filter"
categories: junk
author: "Pubudu Welagedara"
meta: "Node.js"
---

[This Project][source] has been created to facilitate Node.js API Development. I added all the bits and pieces that you need to get a solid Node.js project running.

## What's in the project

- Promises
- Database Integration for CouchDB using `nano`( Supports all major operations including insert, update, delete, find one, find all, Database Views etc.).
- REST calls made using `request`
- CORS Middleware for handling requests made from Browser based Clients in another Origin
- A Code Snippet showing how the API can be protected using an API Key.
- An example configuration fetched from the evvironment to support Production Deployments.

## Promises

A Commented Code Snippet from `hello_world.js`

```js
function hello(req, res) {

  ...
  // // Insert Document
  // couchdbDatabaseService.insert()
  //       .then(function (json){
  //         console.log('success');
  //   }).catch(function (err){
  //       console.log('error');
  //   }); 
  ...
}

```

## Database Integration

A few Lines of Code from `couchdb_database_service.js`

```js

...

function insert() {
    return new Promise(function (resolve, reject) {
        db.insert({collection : "message", message: "some message"}, function(err, body, header) {
            if (err) {
                return reject( {status: "error"});
            }else{
                return resolve(body);
            }
        });
    });
}

...

function getDocumentByCollection(collection) {
    return new Promise(function (resolve, reject) {
        db.view('viewByCollection', 'new-view', { keys:[collection]}, function(err, body) {
          if (err) {
            return reject( {status: "error"});
          } else{
            return resolve(body.rows);
          }
        });
    });
}

```

## REST Calls

A few Code Snippet from `w3school_api_service.js`

```js
...

function getCustomers() {

  return new Promise(function (resolve, reject) {

    var options = { 
            method: 'GET',
            url: mainApp.app.get('URL_W3SCHOOL_CUSTOMERS'),
            headers: { 'cache-control': 'no-cache' } 
        };
        
        request(options, function (error, response, body) {
            if (error) {
                return reject( {status: "error"});
            } else{
                return resolve(JSON.parse(body));
            }
        });
  }); 
}

```

## CORS Middleware

The CORS Filter in `./middleware`

```js
'use strict';

module.exports = function(app) {

	// Set CORS and header parameters
	var allowCrossDomain = function(req, res, next) {       
        res.header('Access-Control-Allow-Credentials', true);
        res.header('Access-Control-Allow-Origin', req.headers.origin);
        res.header('Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE, OPTIONS');
        res.header('Access-Control-Allow-Headers', 'Content-Type, Accept');        
        next();
	};
	app.use(allowCrossDomain);
};

```

## API Security

A Code Snippet from `app.js`.

```js
...
var config = {
  appRoot: __dirname, // required config

  // Security Handlers
  swaggerSecurityHandlers: {
    apiKeyAuth: function(req, authOrSecDef, scopesOrApiKey, cb) {
        var apiKey = req.headers['x-api-key']; // Values get simplified here.
        console.log(req.headers);
        console.log(apiKey);
        if (apiKey) {
            if(apiKey == app.get("API_KEY")) {
                cb();
            } else{
                cb(new Error('authentication failed'));
            }
        } else {
            cb(new Error('authentication failed'));
        }
    }
  }
};

...

```
## Environment Variables

A Commented Code Snippet from `application_config.js`.

```js
...
module.exports = function(app) {
	...
	// Example Configuration Parameter from Environment
	// app.set('ENDPOINT_RELAY', process.env.ENDPOINT_RELAY || 'https://b51730ef.ngrok.io/relay');
};
```

[source]: https://github.com/pwelagedara/nodejs-starter




