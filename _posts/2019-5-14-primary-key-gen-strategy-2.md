---
layout: post
title: "Overriding Primary Key Generation Strategy in JPA + Liquibase Cont..."
categories: junk
author: "Pubudu Welagedara"
meta: "Spring JPA"
comments: true
---

My last post titled [Overriding Primary Key Generation Strategy in JPA + Liquibase]({{ site.baseurl }}{% post_url 2019-5-10-primary-key-gen-strategy %}) discusses how Spring Boot Application can work with multiple databases. 

The Source Code [here][repo] demonstrates what I explained in the aforementioned post.


## Getting Started

Before running the Java Application use the Shell Scripts in the project root to get a database running.

```bash
./run_mysql.sh
```

Change the Spring Profile to activate the configuration for the database of your choice. 

```yaml
spring:
  profiles:
    active: dev,mysql
```

## Working with Oracle

`run_oracle.sh` will need an Oracle XE Image. To create this image please refer to their [GitHub][oracle_github].

In addition you will need the Oracle Driver added as a dependency. For that you can do one of the following.

- Download the jar file from Oracle. Put that inside a `libs` directory and update `build.gradle` with the following.

```gradle

// ...

repositories {
	mavenCentral()
	flatDir {
		dirs 'libs'
	}
}

dependencies {
    
    // ...
	runtimeOnly name:'ojdbc6-11.2.0.3'

	// ...
}
```
- If you have an Enterprise Artifactory with the Driver get it from there.


Note that the first option is not recommended for production.

[repo]: https://github.com/pwelagedara/spring-data
[oracle_github]: https://github.com/oracle/docker-images/tree/master/OracleDatabase

