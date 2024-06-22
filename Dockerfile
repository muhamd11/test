# Use the official .NET Core SDK image for building the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy the project files and restore dependencies
COPY . ./
RUN dotnet restore

# Build the project and publish the output
RUN dotnet publish -c Release -o out

# Use the official .NET Core runtime image for running the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expose the port the app runs on

EXPOSE 80

# Set the entry point for the container
ENTRYPOINT ["dotnet", "test.dll"]