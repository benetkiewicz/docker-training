using Dapper;
using Microsoft.AspNetCore.Builder;
using Microsoft.Data.SqlClient;
using System.Data;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

using SqlConnection connection = new("Data Source=dev-sql,1433;Initial Catalog=master;User ID=sa;Password=P@ssword1;TrustServerCertificate=true");
await connection.OpenAsync();
string sqlVersion = await connection.QueryFirstOrDefaultAsync<string>("SELECT @@version", commandType: CommandType.Text);

app.MapGet("/hello", () => $"Hello world from sql version {sqlVersion} instance!");

app.Run();
