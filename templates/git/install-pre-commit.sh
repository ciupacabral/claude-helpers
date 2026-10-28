#!/usr/bin/env bash
# Instaleaza hook-ul pre-commit (gitleaks) in repo-ul git CURENT.
# Uz: din radacina unui proiect ->  bash ~/claude-stack/templates/git/install-pre-commit.sh
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/pre-commit"
ROOT="$(git rev-parse --show-toplevel 2>/dev/null)" || { echo "Nu esti intr-un repo git."; exit 1; }

mkdir -p "$ROOT/.git/hooks"
cp "$SRC" "$ROOT/.git/hooks/pre-commit"
chmod +x "$ROOT/.git/hooks/pre-commit"
echo "✓ pre-commit (gitleaks) instalat in $ROOT/.git/hooks/"
command -v gitleaks >/dev/null 2>&1 || echo "! Mai instaleaza gitleaks:  brew install gitleaks"
