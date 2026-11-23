---
name: qa-code
description: Checks reproducibility of code-generated content – every script compiles, scripts/make_figures.py regenerates the committed figures byte-for-byte (no stale figure), and numbers quoted in the book match data/recomputed.json (AC-04, AC-14). Also checks code boxes are LTR.
---
# qa-code (Detector)

Run: `.venv/bin/python scripts/qa.py code`

## Checks
- `py_compile` passes for every `scripts/*.py`.
- `scripts/make_figures.py` runs in the project `.venv`; afterwards `git status figures/` is clean (a diff = stale figure, AC-04).
- Every value listed in `data/recomputed.json` → `quoted_in_book` appears in the chapter text (AC-14).
- Code listings (if any) are inside an `ltrblock` and render left-to-right.

## Visual checks
Numbers in figures, tiles and tables match the script output; no hand-typed number that a script computes.
