#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

SOURCE="../../hokkien-writing/dataset/export/rime/rime-teochew"

if [ ! -d "$SOURCE" ]; then
    echo "Error: source directory $SOURCE not found. Run 'bash build.sh' in dataset first."
    exit 1
fi

rsync -av --delete \
    --exclude='build' \
    --exclude='.git' \
    --exclude='build.sh' \
    --exclude='sync.sh' \
    --exclude='release.sh' \
    --exclude='LICENSE' \
    --exclude='README.md' \
    --exclude='.gitignore' \
    "$SOURCE/" .

COMMIT_MSG=$(git -C ../../hokkien-writing/dataset log -1 --format='%s')

git add -A
if git diff --cached --quiet; then
    echo "No changes to sync."
else
    git commit -m "$COMMIT_MSG"
    echo "Committed: $COMMIT_MSG"
fi
