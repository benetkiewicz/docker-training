### Intro to Docker

This is the very simple aspnet core application that will be used to demonstrate some docker capabilities. Notice how small it is! Just two files and few lines of code.

The purpose of first lesson will be to host that aspnet core app without having dotnet runtime hosted on your machine. But if you have it, then as a step 0, you can try to run it and check if it works. 

Run

```dotnet restore```

followed by

```dotnet build --no-restore```

followed by

```dotnet run --no-build --no-restore --urls=http://localhost:5555```

All the above steps should work and after accessing `http://localhost:5555/hello` you should see

> Hello world!

Proceed to lesson 1 to see how to run and develop the app without dotnet runtime, using docker image of this runtime.
