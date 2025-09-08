#!/usr/bin/env bash
set -euo pipefail

# Usage: ./update_submodule.sh [branch]
# Default branch is "main"

cd /Users/soheila/Documents/GitHub/CS108

SUBMODULE_PATH="./instructor_updates"
BRANCH="${1:-main}"

# Point the submodule to the repo URL and branch

git submodule set-url instructor_updates https://github.com/UNM-Courses/instructor_updates.git
git config -f .gitmodules submodule.instructor_updates.branch main

echo "Syncing submodules…"
git submodule sync

echo "Updating '$SUBMODULE_PATH' to latest on '$BRANCH'…"
git submodule update --init --remote "$SUBMODULE_PATH"

echo "Staging .gitmodules…"
git add .gitmodules || true

echo "Committing (if needed)…"
git commit -m "Configure ${SUBMODULE_PATH} submodule to track ${BRANCH} branch" || echo "No changes to commit."

echo "Pushing…"
git push

echo "Done."
