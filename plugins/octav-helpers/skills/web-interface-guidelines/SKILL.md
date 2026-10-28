---
name: web-interface-guidelines
description: "Use when reviewing or writing UI code (React/Next.js, plain HTML/CSS) — audits against Vercel's Web Interface Guidelines: accessibility, focus states, forms, keyboard, animation, typography, performance. Triggers on \"review my UI\", \"verifică interfața\", \"audit accesibilitate\", \"check a11y\", before shipping a screen, or when adding forms, dialogs, tables and lists."
---

# Web Interface Guidelines (audit de interfață)

Regulile sunt ale Vercel (`vercel-labs/web-interface-guidelines`, MIT) și **se descarcă la fiecare
rulare**, ca să fie cele curente:

```
https://raw.githubusercontent.com/vercel-labs/web-interface-guidelines/main/command.md
```

## Cum se folosește

1. **Descarcă regulile** de la adresa de mai sus (WebFetch). Sunt ~180 de linii, grupate pe
   Accessibility · Focus States · Forms · Animation · Typography · Layout · Content · Performance.
2. **Citește fișierele** de auditat. Dacă omul n-a spus care, întreabă-l — nu audita tot proiectul
   „ca să fie", că raportul devine nefolosibil.
3. **Verifică fiecare regulă** pe codul citit.
4. **Raportează în format `fișier:linie`**, scurt, cu ce e greșit și cum se repară.

Dacă descărcarea nu merge (fără internet), **spune-o** și continuă cu ce știi din
`accessibility-review` (plugin-ul `design`) — dar zi limpede că n-ai avut regulile complete, ca omul
să nu creadă că a trecut un audit pe care nu l-ai făcut.

## Ce contează mai mult, în practică

Ordinea de mai jos e a lucrurilor care chiar se strică des, nu a regulilor „de bifat":

| Cad des | De ce contează |
|---|---|
| butoane doar-iconiță fără `aria-label` | la screen reader e „button", fără nicio informație |
| `outline: none` fără înlocuitor | omul care navighează din tastatură nu mai vede unde e |
| formulare fără `autocomplete` / `type` / `inputmode` | pe telefon iese tastatura greșită, autofill nu merge |
| eroare de formular fără focus pe primul câmp greșit | la formulare lungi omul nu găsește ce e greșit |
| `transition: all` | animă și ce nu trebuie, sacadat |
| lipsa `prefers-reduced-motion` | pentru cine are nevoie de mișcare redusă e o problemă reală |
| `...` în loc de `…`, ghilimele drepte | se vede la tipar și în capturi |

## Reguli de aplicare (ale casei)

- **Nu rescrie estetica.** Skill-ul ăsta verifică *comportament* și *accesibilitate*, nu gust.
  Direcția vizuală vine din `frontend-design`; aici doar te asiguri că se poate folosi.
- **Nu strica limba.** Regulile Vercel sunt scrise pentru engleză. La texte românești păstrează
  ghilimelele „…" (nu „…" englezești) și diacriticele.
- **Verifică, nu presupune.** După ce repari, deschide ecranul în Browser pane și probează cu
  tastatura (Tab, Enter, Escape) — un `aria-label` adăugat greșit e mai rău decât lipsa lui.
- **Raportează și ce n-ai putut verifica** (ex. contrast de culoare fără randare, focus fără
  browser) în loc să treci peste.

## Legături

- Sursa regulilor: https://github.com/vercel-labs/web-interface-guidelines (MIT, Vercel Labs)
- Skill-ul original: `vercel-labs/agent-skills` → `web-design-guidelines`
- Complementare, deja instalate: `frontend-design` (direcție vizuală) ·
  `design:accessibility-review` (audit WCAG 2.1 AA) · `design:design-critique` (ierarhie, uzabilitate)
