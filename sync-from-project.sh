#!/usr/bin/env bash
# Sync skill logic from the canonical project into this repo, excluding data/.
# Usage: ./sync-from-project.sh [path-to-project-skills-dir]
set -euo pipefail
SRC="${1:-$HOME/Sites/thetoddlerkitchen/.claude/skills}"
REPO="$(cd "$(dirname "$0")" && pwd)"
for s in kitchen kitchen-hooks kitchen-post; do
  [ -d "$SRC/$s" ] || { echo "missing: $SRC/$s"; exit 1; }
  rsync -a --delete --exclude 'data' "$SRC/$s/" "$REPO/$s/"
done
echo "Synced from $SRC (data/ excluded). Review 'git status', then commit."
