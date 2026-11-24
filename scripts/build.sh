#!/usr/bin/env bash
# build.sh – reproducible build of build/main.pdf (PLAN §8).
# Usage (from anywhere):  scripts/build.sh [file.tex]      default: main.tex  (e.g. samples/style-A.tex)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
SRC="${1:-main.tex}"
JOB="$(basename "$SRC" .tex)"

# --- toolchain: TeX Live 2026 first on PATH (old MiKTeX links in ~/bin must not win)
export PATH="/Library/TeX/texbin:$PATH"
ENGINE="$(lualatex --version | head -1)"
case "$ENGINE" in
  *"TeX Live 2026"*) echo "[build] engine: $ENGINE" ;;
  *) echo "[build] ERROR: lualatex is not TeX Live 2026: $ENGINE" >&2; exit 2 ;;
esac
echo "[build] biber:  $(biber --version)"

# --- figures (Python), when the generator exists
if [[ -f scripts/make_figures.py ]]; then
  echo "[build] regenerating figures"
  .venv/bin/python scripts/make_figures.py
fi

# --- LaTeX: lualatex -> biber -> lualatex x2
mkdir -p build
LTX=(lualatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build "$SRC")
run() { echo "[build] $*"; "$@" > "build/$JOB.console" 2>&1 || { tail -30 "build/$JOB.console"; exit 1; }; }
run "${LTX[@]}"
run biber --input-directory build --output-directory build "$JOB"
run "${LTX[@]}"
run "${LTX[@]}"
if grep -q "Rerun to get" "build/$JOB.log"; then run "${LTX[@]}"; fi   # labels moved (long books): one more pass

# --- log summary (AC-03)
LOG="build/$JOB.log"
count() { grep -c -E "$1" "$LOG" || true; }
echo "[build] done: build/$JOB.pdf"
echo "[build] errors:            $(count '^!|^[^ ]*:[0-9]+: ')"
echo "[build] undefined refs:    $(count 'undefined|There were undefined')"
echo "[build] missing chars:     $(count 'Missing character')"
echo "[build] overfull boxes:    $(count '^Overfull')"
echo "[build] underfull boxes:   $(count '^Underfull')"
echo "[build] LaTeX warnings:    $(count 'LaTeX Warning|Package [A-Za-z]+ Warning|Class [A-Za-z]+ Warning')"
