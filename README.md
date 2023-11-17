From the main project directory run 

```
docker run -p 5001:8080 -v ${PWD}:/var/www -w "/var/www" mcr.microsoft.com/dotnet/sdk:8.0 bash -c "dotnet watch run"
```

1. Why `dotnet watch run --urls=http://*:5432` doesn't work?
1. Try overriding `HTTP_PORTS` enironment variable.
1. Make dockerfile.