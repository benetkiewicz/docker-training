FROM    mcr.microsoft.com/dotnet/aspnet:8.0 AS host
WORKDIR /dockerweb

FROM    mcr.microsoft.com/dotnet/sdk:8.0 AS restore
WORKDIR /src
COPY    dockerweb.csproj .
RUN     dotnet restore

FROM restore AS build
COPY . .
RUN dotnet build -c Release --no-restore

FROM build AS publish
RUN dotnet publish -c Release -o /src/publish --no-build --no-restore

FROM host as final
COPY --from=publish /src/publish .
ENTRYPOINT ["dotnet", "dockerweb.dll"]