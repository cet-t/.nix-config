#!/usr/bin/env bash
# claude-code の manifest.json を最新版 (または指定バージョン) に更新する。
#   ./pkgs/claude-code/update.sh          # latest
#   ./pkgs/claude-code/update.sh 2.1.300  # バージョン指定
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

BASE_URL="https://downloads.claude.ai/claude-code-releases"
VERSION="${1:-$(curl -fsSL "$BASE_URL/latest")}"

curl -fsSL "$BASE_URL/$VERSION/manifest.json" --output manifest.json
echo "claude-code -> $VERSION (sudo nixos-rebuild switch --flake .#act で反映)"
