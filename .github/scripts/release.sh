#!/usr/bin/env bash
# Creates a Release for every deploy commit on HEAD that does not have one yet.
set -euo pipefail

pattern='^chore: 배포본을 ([0-9]+\.[0-9]+\.[0-9]+) (으로|로) 다시 굽는다'
tags=$(gh release list --limit 1000 --json tagName --jq '.[].tagName')

# Oldest first, so the newest version is created last and becomes Latest.
while read -r sha subject; do
  [[ $subject =~ $pattern ]] || continue
  tag="v${BASH_REMATCH[1]}"
  grep -qxF "$tag" <<<"$tags" && continue
  # A bullet's wrapped lines are indented; keep them with the bullet.
  notes=$(git log -1 --format=%b "$sha" | awk '/^- /{b=1; print; next} b && /^  /{print; next} {b=0}')
  gh release create "$tag" --target "$sha" --title "$tag" --notes "$notes"
  tags+=$'\n'"$tag"
done < <(git log --reverse --format='%H %s' HEAD)
