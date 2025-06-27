# 使用 .NET 8 的运行时镜像
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# 使用 SDK 镜像构建应用
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["GuessBoxHelper/GuessBoxHelper.csproj", "GuessBoxHelper/"]
RUN dotnet restore "GuessBoxHelper/GuessBoxHelper.csproj"

COPY . .
WORKDIR "/src/GuessBoxHelper"
RUN dotnet publish "GuessBoxHelper.csproj" -c Release -o /app/publish

# 最终运行阶段
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "GuessBoxHelper.dll"]
