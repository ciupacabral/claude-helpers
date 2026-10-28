---
name: session-state
description: Use at the START of work to restore exact prior status, at natural CHECKPOINTS, and when PAUSING/ENDING a session — also when the user says "salveaza status", "status", "unde am ramas", "reia", "resume", "continua de unde". Maintains a durable docs/worklog/STATE.md (current goal, done, next, blockers, decisions, how to run/verify) plus dated session logs, so any future session resumes at the exact prior status. Complements superpowers' plans; does NOT replace them.
---

# Session state & exact resume (Octav)

Scop: să poți reveni **oricând**, din orice sesiune, exact la statusul la care erai — fără să reconstruiești contextul. Acesta e contractul: planurile lungi le ține superpowers (`docs/superpowers/plans/`); **starea curentă „unde sunt acum" o ții aici**, în `docs/worklog/STATE.md`.

> Hook-ul `SessionStart` din acest plugin injectează automat `docs/worklog/STATE.md` la începutul fiecărei sesiuni, dacă există. Deci dacă-l ții la zi, contextul se restaurează singur.

## Fișiere

- `docs/worklog/STATE.md` — **sursa unică de adevăr** pentru „unde sunt acum". Se **suprascrie** la fiecare checkpoint.
- `docs/worklog/sessions/YYYY-MM-DD.md` — jurnal **append-only**: ce s-a întâmplat în sesiune (rezumat scurt, nu transcript).

## Când actualizez STATE.md (fără să întreb)

- după ce termin un pas semnificativ din plan;
- înainte de a încheia / pune pe pauză sesiunea;
- când user-ul zice „salvează status" / „pauză" / „gata pe azi";
- după o decizie de arhitectură sau un blocaj nou.

Ține-l **scurt și exact** (semnal, nu zgomot). Dacă nu s-a schimbat nimic material, nu rescrie.

## Protocol de RESUME (start de sesiune sau „reia")

1. Citește `docs/worklog/STATE.md` (hook-ul îl injectează deja), plus ultimul fișier din `docs/worklog/sessions/` și planul superpowers linkuit.
2. Rezumă user-ului în 3-5 rânduri: **obiectiv curent · ultimul pas făcut · următorul pas · blocaje**.
3. Confirmă „continui de aici?" înainte de a relua munca (user-ul rămâne în buclă).

## Șablon `STATE.md`

```markdown
# STATE — <nume-proiect>
_Actualizat: <YYYY-MM-DD HH:MM> · branch: <branch> · sesiune: <scurt>_

## 🎯 Obiectiv curent
<o frază: ce construim acum>

## 🔗 Plan activ
- docs/superpowers/plans/<fisier>.md   (dacă există)

## ✅ Făcut (recent)
- [x] <pas> — <rezultat / commit>

## ⏭️ Următorii pași
- [ ] <pasul imediat>   ← AICI AM RĂMAS
- [ ] <urmează>

## ⛔ Blocaje / decizii deschise
- <ce mă oprește / ce trebuie decis, cu opțiuni>

## 🧠 Decizii cheie (de ce)
- <decizie> — <motiv scurt>

## ▶️ Cum rulez & verific
- dev: `<cmd>` · build: `<cmd>` · test: `<cmd>`
- verificare vizuală: Playwright MCP (screenshot + flux)

## 📂 Fișiere atinse
- `path/to/file` — <ce face / de ce>
```

## Șablon intrare `sessions/YYYY-MM-DD.md`

```markdown
## <HH:MM> — <titlu scurt>
- Făcut: <…>
- Decis: <…>
- Rămas: <…>
```

## Reguli

- Nu duplica planul superpowers în STATE.md — **linkuiește-l**. STATE.md = „unde sunt", planul = „ce am de făcut în detaliu".
- Nu pune secrete în worklog.
- Worklog-ul **se comite** în git (e documentație utilă), spre deosebire de state-ul efemer.
