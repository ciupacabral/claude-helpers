# Multi-stage: frontend (React/Vite) + backend (.NET), runtime slim, NON-ROOT.
# Ajusteaza: caile (frontend/ backend/), versiunea .NET (8.0/9.0/10.0) si numele DLL-ului.

# 1) Build frontend (React/Vite) -> static
FROM node:22-alpine AS frontend
WORKDIR /fe
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build           # rezultat in /fe/dist

# 2) Build backend (.NET)
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS backend
WORKDIR /src
COPY backend/*.csproj ./backend/
RUN dotnet restore ./backend/*.csproj
COPY backend/ ./backend/
# include build-ul frontend in wwwroot (servit static de .NET); scoate daca FE e deploy-uit separat
COPY --from=frontend /fe/dist ./backend/wwwroot
RUN dotnet publish ./backend/*.csproj -c Release -o /app/publish /p:UseAppHost=false

# 3) Runtime (slim, non-root)
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
COPY --from=backend /app/publish ./
USER $APP_UID                                  # user non-root predefinit in imaginile .NET 8/9
ENTRYPOINT ["dotnet", "YourApp.dll"]           # <-- inlocuieste cu DLL-ul tau
# Secrete: NICIODATA in imagine. Le dai la runtime prin env:
#   docker run -e ConnectionStrings__Default="..." -e Supabase__ServiceKey="..." -p 8080:8080 your-image
