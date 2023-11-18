### Run and develop using docker

First you need a dotnet core container image.

```
docker pull mcr.microsoft.com/dotnet/sdk:8.0
```

Having that on your machine, you can share a part of your filesystem with docker using a feature named *volume*.

Couple things to know about working with dotnet sdk container:

1. It hosts apps from */var/www/* directory
1. We will make a volume to map our current directory on host to */var/www* on the container
1. The container likes to expose its apps on port 8080, so we map that container port to 5001 on host.

From the main project directory run 

```
docker run -p 5001:8080 -v ${PWD}:/var/www -w "/var/www" mcr.microsoft.com/dotnet/sdk:8.0 bash -c "dotnet watch run"
```

This should start the container and you should be able to access app using `http://localhost:5001/hello`. Note that we're running the app in the watch mode, so go ahead and change the text being returned by the `/hello` enpoint. After saving the file and refreshing the page, you should see the modified text. That is how development with docker can be done.

* Configuring docker port by running `dotnet watch run --urls=http://*:5432` didn't work for me.
* One could try overriding `HTTP_PORTS` enironment variable.
* This should be possible using multilayer dockerfiles. Will experiment with that in the upcoming lessons.