FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 5000

ENV ASPNETCORE_URLS=http://+:5000

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["DnTelemetry.csproj", "./"]
RUN dotnet restore "DnTelemetry.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DnTelemetry.csproj" -c Release -o /app/build

FROM node AS node-builder
WORKDIR /node
COPY ./ClientApp /node
RUN npm install
RUN npm run build

FROM build AS publish
RUN dotnet publish "DnTelemetry.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
RUN mkdir /app/wwwroot
COPY --from=publish /app/publish .
COPY --from=node-builder /node/build /app/wwwroot
ENTRYPOINT ["dotnet", "DnTelemetry.dll"]
