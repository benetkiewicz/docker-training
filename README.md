### Orchestrating services with docker compose

Finally let's make it a bit more complex and try to connect docker-hosted API with a docker-hosted database. Working with multiple docker images would soon become hard to manage, so let's use docker compose to orchestrate everything for easy setup and teardown. 

In terms of the app, I used `Dapper` and `Microsoft.Data.SqlClient` to query version from the database, so I don't have to worry about seeding it with any data.

```csharp
using SqlConnection connection = new("..."); // removed for clarity
await connection.OpenAsync();
string sqlVersion = await connection.QueryFirstOrDefaultAsync<string>(
    "SELECT @@version",
    commandType: CommandType.Text);
```

To spin up the database, we need a new docker file `sql.dockerfile`, where we set things like port and password.

To build and test it on its own, the following command may get handy:

```
docker build -f sql.dockerfile -t sql-dev .
```

followed by 

```
docker run --name sql-dev -p 1433:1433 sql-dev
```

Finally time for some orchestration. Consifuration is contained in `docker-compose.yml` file. The are two services defined:
- sql - that points to newly created `sql.dockerfile`, instructed to expose default 1433 port
- api - pointing to `prod.dockerfile`, exposing 8083 port as in lesson 3

Please note that *localhost* on *sql* service is a different thing from *localhost* on *api* service, since containers are isolated by default. Docker manages communication between containers behind the scenes. They can refer to each other simply by container name, so the connection string in the api service will be ```Data Source=dev-sql,1433;Initial Catalog=...```

Time to build everything:

```
docker compose build
```

and start!

```
docker compose up
```

If all went well, the SQL version should be available at `http://localhost:8083/hello`

Note how simple this is to run everything at once, comparing to previous lessons. No need to worry about container names, ports, etc. 