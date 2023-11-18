using Microsoft.AspNetCore.Builder;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/hello", () => $"Hello world from {app.Environment.EnvironmentName} instance!");

app.Run();
