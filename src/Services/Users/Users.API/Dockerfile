#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/Services/Users/Users.API/Users.API.csproj", "src/Services/Users/Users.API/"]
COPY ["src/Services/Users/Users.Infrastructure/Users.Infrastructure.csproj", "src/Services/Users/Users.Infrastructure/"]
COPY ["src/Services/Users/Users.Application/Users.Application.csproj", "src/Services/Users/Users.Application/"]
COPY ["src/Services/Users/Users.Domain/Users.Domain.csproj", "src/Services/Users/Users.Domain/"]
RUN dotnet restore "src/Services/Users/Users.API/Users.API.csproj"
COPY . .
WORKDIR "/src/src/Services/Users/Users.API"
RUN dotnet build "Users.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Users.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Users.API.dll"]
