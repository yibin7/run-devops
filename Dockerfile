#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
#test1001001

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY ["Shopping.Client2/Shopping.Client2.csproj", "Shopping.Client2/"]
RUN dotnet restore "Shopping.Client2/Shopping.Client2.csproj"
COPY . .
WORKDIR "/src/Shopping.Client2"
RUN dotnet build "Shopping.Client2.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Shopping.Client2.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Shopping.Client2.dll"]