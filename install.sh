#!/usr/bin/env bash
# Installs the pstack skills and the poteto-agent subagent into ZCode's user-level directories.
# Requires Git Bash (or any POSIX shell) on Windows.
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$HOME/.zcode/skills" "$HOME/.zcode/agents"

count=0
for d in "$DIR"/skills/*/; do
  name="$(basename "$d")"
  rm -rf "$HOME/.zcode/skills/$name"
  cp -R "$d" "$HOME/.zcode/skills/$name"
  count=$((count + 1))
done

cp "$DIR/agents/poteto-agent.md" "$HOME/.zcode/agents/"

echo "Installed $count pstack skills into ~/.zcode/skills and poteto-agent into ~/.zcode/agents."
echo "Start a new ZCode session, then try: /poteto-mode"
