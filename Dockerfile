FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100-preview9 AS builder

WORKDIR /src
COPY src/DotNetConf2019.csproj .
RUN dotnet restore

COPY src/ .
RUN dotnet publish -c Release -o /out DotNetConf2019.csproj

# app image
FROM mcr.microsoft.com/dotnet/core/runtime:3.0.0-preview9

WORKDIR /app
ENTRYPOINT ["dotnet", "DotNetConf2019.dll"]
ENV DotNetBot:Message="docker4theEdge!"

COPY --from=builder /out/ .