#!/usr/bin/env bash
# Auto-format a file edited by Claude, using the PROJECT's own local Prettier.
#
# Why a hook: formatting deterministically here is far cheaper (in tokens) than
# asking the model to format. See code.claude.com/docs/en/costs.
#
# Safe by design:
#   - never fails the tool call (always exits 0)
#   - silent when there's nothing to do
#   - only runs if the project already has Prettier installed locally
#     (so it respects projects that don't use it)
set -u

# Read the hook payload from stdin (JSON with tool_input.file_path).
input="$(cat 2>/dev/null || true)"
command -v jq >/dev/null 2>&1 || exit 0

file="$(printf '%s' "$input" | jq -r '.tool_input.file_path // .tool_input.filePath // empty' 2>/dev/null)"
[ -z "$file" ] && exit 0
[ -f "$file" ] || exit 0

case "$file" in
  *.ts|*.tsx|*.js|*.jsx|*.mjs|*.cjs|*.json|*.css|*.scss|*.md|*.mdx|*.html|*.vue|*.svelte) ;;
  *) exit 0 ;;
esac

# Walk up from the file's directory to find the nearest package.json (project root).
dir="$(cd "$(dirname "$file")" 2>/dev/null && pwd)" || exit 0
root=""
while [ -n "$dir" ] && [ "$dir" != "/" ]; do
  if [ -f "$dir/package.json" ]; then root="$dir"; break; fi
  dir="$(dirname "$dir")"
done
[ -z "$root" ] && exit 0

prettier="$root/node_modules/.bin/prettier"
[ -x "$prettier" ] || exit 0

"$prettier" --write --log-level silent "$file" >/dev/null 2>&1 || true
exit 0
