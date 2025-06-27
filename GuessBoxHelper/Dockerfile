# 使用官方 ASP.NET Core 运行时作为基础镜像
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# 使用官方 .NET SDK 作为构建环境
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# 复制项目文件
COPY ["GuessBoxHelper/GuessBoxHelper.csproj", "GuessBoxHelper/"]
RUN dotnet restore "GuessBoxHelper/GuessBoxHelper.csproj"

# 复制全部内容并构建
COPY . .
WORKDIR "/src/GuessBoxHelper"
RUN dotnet publish "GuessBoxHelper.csproj" -c Release -o /app/publish

# 发布阶段
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "GuessBoxHelper.dll"]
