---
layout: post
title: "Overriding Primary Key Generation Strategy in JPA + Liquibase"
categories: junk
author: "Pubudu Welagedara"
meta: "Spring JPA"
comments: true
---

How do you write a `Spring Boot` backend which supports all the SQL databases known to mankind. I'm just kidding. I have only tried this with `H2`, `MySQL`, `PostgreSQL` and `Oracle` in one single application. 

I am sure by now you are familiar with how `Version Control` works. A `Version Control` like `Git` will help you keep track of your source code. How do you keep track of your database changes the same way you track your source code?

## Liquibase

[Liquibase][liquibase] is an open- source solution to manage your database revisions. I am not going to go into minor details about liquibase as its documentation is quite exhaustive.

This is how you get Liquibase to work. 

First add your dependency.

```gradle
dependencies {
    //...

    // Liquibase
    implementation("org.liquibase:liquibase-core")

    //...
}
```

Create `db.changelog-master.yaml`  inside `src/main/resources/db/changelog`. This is the master file to which you need to keep adding the changes. To effectively track changes to the database keep adding the changelog files to this.

```yaml
databaseChangeLog:

    - include:
        file: db.changelog-1.0.0.yaml
        relativeToChangelogFile: true

    - include:
        file: db.changelog-1.1.0.yaml
        relativeToChangelogFile: true

    - include:
        file: db.changelog-1.2.0.yaml
        relativeToChangelogFile: true

    #...
```
Now create your Change Logs `db.changelog-1.0.0.yaml`, `db.changelog-1.1.0.yaml` and `db.changelog-1.2.0.yaml` inside the same directory.

```yaml
# db.changelog-1.0.0.yaml
# Create bank table
databaseChangeLog:
    - property:
        name: autoIncrement
        value: true
        dbms: mysql
    - changeSet:
        id: 1_0_0_0
        author: pubuduwelagedara
        changes:
            - createTable:
                tableName: bank
                columns:
                    - column:
                        name: id
                        type: int
                        constraints:
                            primaryKey: true
                            nullable: false
                        autoIncrement: ${autoIncrement}
                    - column:
                        name: name
                        type: varchar(255)
                        constraints:
                            nullable: false
    - changeSet:
        id: 1_0_0_1
        author: pubuduwelagedara
        dbms: h2,postgresql,oracle
        changes:
            - createSequence:
                sequenceName: seq_bank_id
                startValue: 1
                incrementBy: 5
```
Now let's see what's inside `db.changelog-1.0.0.yaml`. The DSL here creates a table with the name `bank` with two columns if the database is MySQL. The `id` column is auto-  incremented. 

If the database is H2, PostgreSQL or Oracle, the DSL creates a table with two columns and a sequence to generate the primary key. The `id` column here does not have auto- increments enabled as H2, PostgreSQL and Oracle can support database sequences. 

[Here][primary_keys_tutorial] is a good article on Primary Key Generation.


## Overriding the Primary Key Generation Strategy

Here is the `Bank` entity in my Spring Project. 

```java
package online.pubudu.openbankingapi.integration.database.entity;

import javax.persistence.*;

/**
 * {@link Bank} Entity.
 *
 * @author pubudu welagedara
 * @see <a href="http://pubudu.online">pubudu.online</a>
 */
@Entity
public class Bank {

    @Id
    @GeneratedValue( strategy = GenerationType.SEQUENCE,  generator = "seq_bank_id")
    @SequenceGenerator(name="seq_bank_id",sequenceName="seq_bank_id", allocationSize=5)
    private Long id;

    @Column(nullable = false)
    private String name;

    public Bank() {
    }

    public Bank(String name) {
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

`GenerationType.SEQUENCE` will only work for databases that support sequences. For MySQL I need to override this. 

Now I will create a `mysql-orm.xml` file inside `/src/main/resources/db/orm/`. 

```xml
<?xml version="1.0" encoding="UTF-8"?>

<entity-mappings xmlns="http://xmlns.jcp.org/xml/ns/persistence/orm"
                 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/persistence/orm_2_2.xsd"
                 version="2.2">
    <package>online.pubudu.openbankingapi.integration.database.entity</package>
    <entity class="Bank" access="FIELD">
        <attributes>
            <id name="id">
                <generated-value strategy="IDENTITY"/>
            </id>
        </attributes>
    </entity>
    <!--...-->
</entity-mappings>
```

`mysql-orm.xml` file activates `GenerationType.IDENTITY`. To override the Java configuration I will point `spring.jpa.mapping-resources` to `mysql-orm.xml`. With this configuration in `application-mysql.yaml`, I can activate `mysql` profile to get my application working with MySQL. 

```yaml
# application-mysql.yaml
spring:
  jpa:
    # Show SQL. DO NOT use this in production.
    show-sql: true
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQL57Dialect
        ddl-auto: none # None by Default
        # Beautify SQL
        format_sql: true
    # To override the Primary Key Generation Strategy for MySQL
    mapping-resources:
      - db/orm/mysql-orm.xml

  datasource:
    url: jdbc:mysql://localhost:3306/openbankingapi
    username: root
    password: root
```

## Source Code

Sadly I do not have any source code to demonstrate this in my [GitHub][github] right now. If I get a chance to create a demo project I will post an update with its link.   

[liquibase]: https://www.liquibase.org
[primary_keys_tutorial]: https://thoughts-on-java.org/jpa-generate-primary-keys/
[github]: https://github.com/pwelagedara/