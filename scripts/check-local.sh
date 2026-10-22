#!/usr/bin/env bash
# Local test mode: validate every entry against testdata/packages (no downloads, drafts included) and build
# _site/index.json. Usage: scripts/check-local.sh   (BHMOD=/path/to/bhmod to use a local SDK build)
set -euo pipefail
cd "$(dirname "$0")/.."
BHMOD="${BHMOD:-bhmod}"
args=(index validate --repo . --packages testdata/packages --allow-multiple --report _site/report.md --labels _site/labels.txt)
if command -v luau-compile >/dev/null; then args+=(--luau-compile "$(command -v luau-compile)"); fi
mkdir -p _site
"$BHMOD" "${args[@]}"
"$BHMOD" index build --repo . --include-drafts -o _site/index.json
echo "report: _site/report.md, index: _site/index.json"
