# 使用 Microsoft 提供的官方 .NET 6 SDK 镜像
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# 复制项目文件（把 GuessBoxHelper.csproj 改成你的 .csproj 文件名）
COPY ["GuessBoxHelper.csproj", "./"]
RUN dotnet restore "./GuessBoxHelper.csproj"

COPY . .
RUN dotnet publish "GuessBoxHelper.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "GuessBoxHelper.dll"]
