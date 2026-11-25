#!/usr/bin/env bash
# build.sh – reproducible build of build/main.pdf (PLAN §8).
# Usage (from anywhere):  scripts/build.sh [file.tex]      default: main.tex  (e.g. samples/style-A.tex)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
SRC="${1:-main.tex}"
JOB="$(basename "$SRC" .tex)"
B="${BUILD_DIR:-build}"          # parallel agents: BUILD_DIR=build/<role> scripts/build.sh

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
  if [[ ! -x .venv/bin/python ]]; then   # clean clone (AC-18): the venv is not tracked
    echo "[build] creating .venv from requirements.txt"
    python3 -m venv .venv && .venv/bin/pip install -q -r requirements.txt
  fi
  echo "[build] regenerating figures"
  .venv/bin/python scripts/make_figures.py
fi

# --- LaTeX: lualatex -> biber -> lualatex x2
mkdir -p "$B"
LTX=(lualatex -interaction=nonstopmode -halt-on-error -file-line-error -output-directory="$B" "$SRC")
run() { echo "[build] $*"; "$@" > "$B/$JOB.console" 2>&1 || { tail -30 "$B/$JOB.console"; exit 1; }; }
run "${LTX[@]}"
run biber --input-directory "$B" --output-directory "$B" "$JOB"
run "${LTX[@]}"
run "${LTX[@]}"
if grep -q "Rerun to get" "$B/$JOB.log"; then run "${LTX[@]}"; fi   # labels moved (long books): one more pass

# --- log summary (AC-03)
LOG="$B/$JOB.log"
count() { grep -c -E "$1" "$LOG" || true; }
echo "[build] done: $B/$JOB.pdf"
echo "[build] errors:            $(count '^!|^[^ ]*:[0-9]+: ')"
echo "[build] undefined refs:    $(count 'undefined|There were undefined')"
echo "[build] missing chars:     $(count 'Missing character')"
echo "[build] overfull boxes:    $(count '^Overfull')"
echo "[build] underfull boxes:   $(count '^Underfull')"
echo "[build] LaTeX warnings:    $(count 'LaTeX Warning|Package [A-Za-z]+ Warning|Class [A-Za-z]+ Warning')"
