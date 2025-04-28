# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["PantryPalAPI.csproj", "./"]
RUN dotnet restore "./PantryPalAPI.csproj"
COPY . .
RUN dotnet publish "./PantryPalAPI.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "PantryPalAPI.dll"]
