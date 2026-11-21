#!/bin/zsh
# Sync buy-vs-rent.html -> index.html, commit, and push to GitHub Pages
set -euo pipefail
cd "$(dirname "$0")"
cp buy-vs-rent.html index.html
echo "Synced buy-vs-rent.html -> index.html."

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Note: Not inside a git repository yet. Skipping git commit/push."
  exit 0
fi

git add buy-vs-rent.html index.html .nojekyll .gitignore publish.sh
if git diff --cached --quiet; then
  echo "No new changes to publish."
else
  MSG="${1:-Update Buy vs. Rent Net Worth Dashboard}"
  git commit -m "$MSG"
  BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  git push origin "$BRANCH"
  echo "Published successfully to GitHub Pages ($BRANCH)!"
fi
