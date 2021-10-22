#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/Services/AboutUsers/AboutUser.API/AboutUsers.API/AboutUsers.API.csproj", "src/Services/AboutUsers/AboutUser.API/AboutUsers.API/"]
RUN dotnet restore "src/Services/AboutUsers/AboutUser.API/AboutUsers.API/AboutUsers.API.csproj"
COPY . .
WORKDIR "/src/src/Services/AboutUsers/AboutUser.API/AboutUsers.API"
RUN dotnet build "AboutUsers.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AboutUsers.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AboutUsers.API.dll"]