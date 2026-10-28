#!/usr/bin/env bash
# SessionStart hook: if the project has a saved status file, inject it into
# context so the session resumes at the exact prior status.
#
# Safe by design: silent and exit 0 when there's nothing to restore.
set -u

f="docs/worklog/STATE.md"
[ -f "$f" ] || exit 0

echo "## 🗂️ Status salvat al proiectului (docs/worklog/STATE.md) — reia de aici:"
echo ""
# Cap the inject to keep context lean (skill session-state keeps STATE.md short anyway).
head -n 160 "$f"
echo ""
echo "_(Sursă: octav-helpers/session-state. Confirmă cu user-ul înainte de a relua munca.)_"
exit 0
