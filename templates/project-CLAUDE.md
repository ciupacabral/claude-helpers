# CLAUDE.md — <NUME PROIECT>

> Per-proiect. Ține-l scurt; completează doar ce e specific aici.

## Stack
- Frontend: <Next.js+Tailwind | React+Vite>
- Backend / date: <C#/.NET | Supabase | …>

## Comenzi
- dev: `<…>`
- build: `<…>`
- test: `<…>`
- lint/format: `<…>`

## Convenții
- <stil, foldere, naming, ce să NU atingă>

## Securitate
- Secrete: doar server-side (vezi skill `secure-web-defaults`). Fără `NEXT_PUBLIC_`/`VITE_` pe secrete.
- <Supabase: RLS pe toate tabelele; service_role doar server>

## MCP (per-proiect)
- Vezi `.mcp.json` (copiat din templates/mcp/). 
- .NET: activează `csharp-lsp@claude-plugins-official` + `dotnet tool install --global csharp-ls`.

## Status
- Statusul curent: `docs/worklog/STATE.md` (se încarcă automat la start de sesiune).
