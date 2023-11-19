FROM    mcr.microsoft.com/azure-sql-edge:latest

ENV SA_PASSWORD=P@ssword1
ENV ACCEPT_EULA=Y

EXPOSE  1433

CMD /opt/mssql/bin/sqlservr
