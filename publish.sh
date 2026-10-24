#!/bin/zsh
# Sync buy-vs-rent.html -> index.html, commit, and push to GitHub Pages
set -e
cp buy-vs-rent.html index.html
git add buy-vs-rent.html index.html
if git diff --cached --quiet; then
  echo "No new changes to publish."
else
  MSG="${1:-Update Buy vs. Rent Net Worth Dashboard}"
  git commit -m "$MSG"
  git push origin main
  echo "Published successfully to GitHub Pages!"
fi
