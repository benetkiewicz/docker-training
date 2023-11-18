FROM    mcr.microsoft.com/dotnet/sdk:8.0

LABEL   author="pbenetkiewicz@gmail.com"

ENV ASPNETCORE_URLS=http://*:5432
ENV ASPNETCORE_ENVIRONMENT=development
ENV DOTNET_USE_POLLING_FILE_WATCHER=1

WORKDIR /dockerweb

ENTRYPOINT  ["/bin/bash", "-c", "dotnet restore && dotnet watch run"]