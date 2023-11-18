### Creating production image

Now it is time to ship it to production!

First let's make a change in the code, so we will know if we're hitting the devlopment or production environment.

```csharp
app.MapGet("/hello", () => $"Hello world from {app.Environment.EnvironmentName} instance!");
```

Now focus on the production dockerfile. Notice it is multi-stage, there are separate steps for restore, build, publish and creating a final image. There are at least two good resons for that.

First, notice that to build aspnet core project we need to have SDK, but for hosting we only need runtime, so different stages are based of diferent images and result image will be based on smaller runtime image.

Second, stages are cached in docker cache with some hash key, so only changing the code and no changes in nuget dependencies will enable docker to take cached restore stage and compile new code on top of that.

Build the production image with:

```
docker build -f prod.dockerfile -t dockerweb-prod .
```

And run it with:

```
docker run -p 8083:8080 dockerweb-prod
```

Accessing `https://localhost:8083/hello` should result with _Hello world from Production_ response.

Links:
* https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/docker/building-net-docker-images?view=aspnetcore-8.0
* https://kevsoft.net/2020/05/02/using-multi-stage-builds-to-create-class-library-nuget-packages.html