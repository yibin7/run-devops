#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app/src
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
##WORKDIR /app/src/Shopping.Client
#COPY ["Shopping.Client/Shopping.Client.csproj", "Shopping.Client/"]
COPY ["./Shopping.Client.csproj", "/app/src/Shopping.Client/"]

WORKDIR /app/src/Shopping.Client
#RUN dotnet restore "Shopping.Client/Shopping.Client.csproj"
RUN dotnet restore "Shopping.Client.csproj"
COPY . .

WORKDIR /app/src/Shopping.Client/
#WORKDIR /src
RUN dotnet build "Shopping.Client.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Shopping.Client.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Shopping.Client.dll"]
