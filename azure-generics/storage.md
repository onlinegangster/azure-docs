# Storage in Azure

## Introduction

Storage in transient environments such as cloud needs to be fixed before we can do anything. Otherwise where is our data?

In Azure we can distinct 3 generic types of storage which can be subdivided based on their respective characteristics.

* Block storage (raw disk)
* Object storage (files)
* (un)structured data (SQL/noSQL/Graph/...)


## (Un)structured data
Various types of databases are offered on Azure:
https://azure.microsoft.com/en-us/product-categories/databases/

* Traditional MySQL/MariaDB/Postgres/MSSQL
* BI SQL Datawarehouse
* NoSQL ...

Microsoft also offers a large scale distributed (un)structured store **Cosmos DB**


## Distributed data (Cosmos DB)
Microsoft's generic offering for distributed (un)structured data is called "[Azure Cosmos DB](https://azure.microsoft.com/en-us/services/cosmos-db/)".

### Interfaces

* SQL
* Mongo API(document)
* Cassandra API(key/value,column)
* Gremlin API(graph)

### SLA's

The SLA's for Cosmos DB can be found here:
https://azure.microsoft.com/en-us/support/legal/sla/cosmos-db/v1_2/

Highlights:

| OPERATION                                     | MAXIMUM UPPER BOUND ON PROCESSING LATENCY |
|-----------------------------------------------|-------------------------------------------|
| All Database Account configuration operations | 2 Minutes                                 |
| Add a new Region                              | 60 Minutes                                |
| Manual Failover                               | 5 Minutes                                 |
| Resource Operations                           | 5 Sec                                     |
| Media Operations                              | 60 Sec                                    |

*
