---
name: secure-web-defaults
description: Use when building, modifying, or reviewing web app features — enforces secrets hygiene (no NEXT_PUBLIC_/VITE_ secrets), BaaS access-control (Supabase RLS / Firebase rules), and verify-before-done. Applies to Octav's two stacks (Next.js+Tailwind public sites; React/Vite + C# internal apps).
---

# Secure web defaults (Octav)

Flexible reference skill. Apply the relevant checklist; don't recite it back.

## Octav's two stacks

| Caz | Stack | Note |
|---|---|---|
| Site public / web pentru firmă | **Next.js + Tailwind** (+ shadcn/ui, des Supabase) | server components / route handlers ca proxy pt. secrete |
| Aplicație internă / business | **React + Vite** front-end + **C# / .NET** backend | secretele stau în backend-ul C#, nu în client |

## Secrets hygiene — hard rules

- **NICIODATĂ nu prefixa un secret cu `NEXT_PUBLIC_` sau `VITE_`.** Orice variabilă cu acel prefix e inline-uită în bundle-ul client (vizibilă în DevTools). Dacă o variabilă „e undefined pe client", întreabă *de ce* trebuie pe client — nu adăuga prefixul.
- Secretele rămân `process.env.X` accesate **doar** în API routes / server components / route handlers (Next), sau în backend-ul C# (React/Vite). Frontend-ul apelează backend-ul, nu serviciul terț direct.
- Nu comite niciodată chei. Înainte de commit: scanare secrete (gitleaks local / TruffleHog în CI).

## BaaS access control (Supabase / Firebase)

- **RLS activat pe FIECARE tabel.** Cauza #1 de leak la app-uri generate de AI = RLS dezactivat → cheia `anon` (publică) citește/șterge tot. Tabelele create prin migrări/tooling extern pot veni fără RLS — verifică explicit.
- **`service_role` doar server-side.** Bypass-ează RLS complet (superuser). Niciodată în client, niciodată conectat la un agent/MCP. (Pattern „lethal trifecta": service_role + input ne-de-încredere + canal de exfiltrare.)
- Cheia `anon` e publică prin design — OK *doar dacă* RLS + politicile sunt corecte.
- Supabase MCP, dacă-l folosești: doar `read_only=true` + `project_ref` (scoped) + DB de **dev**, niciodată producție.
- Firebase: reguli locked-down, niciodată test mode în producție.

## Verify-before-done

- „Looks done" ≠ done. Dă-i o **verificare rulabilă** și rul-o: teste (`npm test` / `dotnet test`), build (`tsc` / `dotnet build`), lint.
- Pentru UI: screenshot prin Playwright MCP → compară cu intenția → fix.
- Arată **dovada** (output / screenshot), nu doar afirmația. Dacă nu poți verifica, nu declara „gata".
- Bug-uri: tratează cauza-rădăcină, nu suprima eroarea.

## Token hygiene (reminder)

- `/clear` între task-uri fără legătură; `/compact` cu instrucțiuni țintite.
- Default Sonnet pt. rutină; Opus doar pt. greu. Subagenți pt. research verbos.
- MCP per-proiect (`.mcp.json`), nu global.
