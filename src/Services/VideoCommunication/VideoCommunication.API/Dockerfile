#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["src/Services/VideoCommunication/VideoCommunication.API/VideoCommunication.API.csproj", "src/Services/VideoCommunication/VideoCommunication.API/"]
COPY ["src/Services/BuildingBlocks/EventBus.Messages/EventBus.Messages.csproj", "src/Services/BuildingBlocks/EventBus.Messages/"]
RUN dotnet restore "src/Services/VideoCommunication/VideoCommunication.API/VideoCommunication.API.csproj"
COPY . .
WORKDIR "/src/src/Services/VideoCommunication/VideoCommunication.API"
RUN dotnet build "VideoCommunication.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "VideoCommunication.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "VideoCommunication.API.dll"]
