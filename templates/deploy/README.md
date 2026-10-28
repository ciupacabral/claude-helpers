# Deploy & secret-scan — ghid

Toate rulează **fără Claude** (zero cost API). Claude te ajută doar să le scrii/ajustezi.

## Pre-commit (secrete) — în fiecare repo
Două opțiuni (alege una):

- **Framework (recomandat, auto-pinat):**
  ```bash
  brew install pre-commit gitleaks
  cp ~/claude-stack/templates/git/.pre-commit-config.yaml .
  pre-commit install && pre-commit autoupdate
  ```
- **Hook nativ (zero framework):**
  ```bash
  brew install gitleaks
  bash ~/claude-stack/templates/git/install-pre-commit.sh
  ```

## Site public (Next.js) → Vercel
- **Recomandat:** conectează repo-ul în Vercel → **deploy nativ pe push** (preview pe PR, prod pe `main`). Nu-ți trebuie GitHub Action.
- **Env vars:** în dashboard-ul Vercel (Production/Preview), **NU** în git. Secretele rămân server-side; doar `NEXT_PUBLIC_*` ajung în client (deci niciodată secrete acolo).
- `vercel.json` (opțional): adaugă headere de securitate (HSTS, X-Frame-Options etc.).

## App internă (React/Vite + C#) → container
1. `cp ~/claude-stack/templates/deploy/Dockerfile .` și `cp ~/claude-stack/templates/deploy/.dockerignore .`
2. Ajustează căile (`frontend/`, `backend/`), versiunea .NET și `YourApp.dll`.
3. Local: `docker build -t myapp . && docker run -p 8080:8080 -e ConnectionStrings__Default="..." myapp`
4. CI: `cp ~/claude-stack/templates/github/deploy-container.yml .github/workflows/` → build+push imagine în **GHCR** la fiecare push pe `main`.
5. Rulează **non-root** (deja în Dockerfile: `USER $APP_UID`). Secretele doar prin **env la runtime**, niciodată în imagine.

## Reguli de aur
- Secrete: niciodată în imagine / bundle / git. `.env` e în `.dockerignore`.
- Verifică build-ul real înainte de „gata" (vezi skill `secure-web-defaults` + `verify-before-done`).
- Deploy-ul pe VPS/Render/Fly/Railway îl configurăm separat, după unde rulezi.
