#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 7189
EXPOSE 443
ENV ASPNETCORE_URLS=http://+:7189

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["ProdajaNekretnina/ProdajaNekretnina.csproj", "ProdajaNekretnina/"]
RUN dotnet restore "ProdajaNekretnina/ProdajaNekretnina.csproj"
COPY . .
WORKDIR "/src/ProdajaNekretnina"
RUN dotnet build "ProdajaNekretnina.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ProdajaNekretnina.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ProdajaNekretnina.dll"]