# claude-helpers

Plugin Claude Code cu skill-uri și hooks de web-dev.

## Ce conține

- **session-state**: ține `docs/worklog/STATE.md` la zi și îl încarcă automat la începutul fiecărei sesiuni, ca să reiei exact de unde ai rămas.
- **secure-web-defaults**: fără secrete în `NEXT_PUBLIC_`/`VITE_`, RLS pe Supabase, verificare înainte de „gata”.
- **web-interface-guidelines**: audit de UI după regulile Vercel (accesibilitate, focus, formulare, tastatură).
- **auto-format**: după fiecare editare rulează Prettier-ul proiectului, dacă există.
- `templates/`: Dockerfile, `vercel.json`, pre-commit, GitHub Actions (CI securitate, Dependabot), `.mcp.json`, `CLAUDE.md` de proiect.

## Instalare

```bash
claude plugin marketplace add ciupacabral/claude-helpers
claude plugin install octav-helpers@octav-public --scope user
```

Hook-ul de auto-format are nevoie de `jq`.
