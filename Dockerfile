# ʹ�� .NET 8 ������ʱ����
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# ʹ�� SDK ���񹹽�Ӧ��
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["GuessBoxHelper/GuessBoxHelper.csproj", "GuessBoxHelper/"]
RUN dotnet restore "GuessBoxHelper/GuessBoxHelper.csproj"

COPY . .
WORKDIR "/src/GuessBoxHelper"
RUN dotnet publish "GuessBoxHelper.csproj" -c Release -o /app/publish

# �������н׶�
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "GuessBoxHelper.dll"]
