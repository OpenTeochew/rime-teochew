#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

REMOTE="origin"
TAG_PREFIX="tag."
DATE=$(date +%Y%m%d)
TAG="${TAG_PREFIX}${DATE}"
REPO="hokkien-writing/rime-teochew"
BUILD_DIR="build"

if git tag -l "$TAG" | grep -q .; then
    PREV_TAG=$(git tag --sort=-v:refname | sed -n '2p')
else
    PREV_TAG=$(git tag --sort=-v:refname | head -1)
fi

if [ -n "$PREV_TAG" ]; then
    NOTES=$(git log "${PREV_TAG}"..HEAD --pretty=format:"- %s")
else
    NOTES=$(git log --pretty=format:"- %s")
fi

if [ -z "$NOTES" ]; then
    NOTES="No changes since last release."
fi

echo "==> Building..."
bash build.sh

if git tag -l "$TAG" | grep -q .; then
    echo "==> Tag $TAG already exists, deleting..."
    if gh release view "$TAG" --repo "$REPO" &>/dev/null; then
        gh release delete "$TAG" --repo "$REPO" --yes
    fi
    git push "$REMOTE" --delete "$TAG" 2>/dev/null || true
    git tag -d "$TAG"
fi

echo "==> Creating tag: $TAG"
git tag "$TAG"

echo "==> Pushing tag to $REMOTE..."
git push "$REMOTE" "$TAG"

echo "==> Creating GitHub release..."
gh release create "$TAG" \
    --repo "$REPO" \
    --title "$TAG" \
    --notes "$NOTES" \
    ${BUILD_DIR}/*.zip

echo "==> Done! Release $TAG created."
