---
name: python-graphs
description: Production agent that creates reproducible data graphs with matplotlib from data/*.csv – Hebrew labels via figstyle.he() (logical order + RTL mark, never python-bidi), the bundled Noto fonts, colours only from scripts/palette.py, vector PDF output in figures/, registered in scripts/make_figures.py.
---
# Python-graphs (production agent)

## Rules
- Data only from `data/*.csv` (transcribed and checked by the Researcher) or computed by a script; no hand-typed numbers.
- Colours only from `scripts/palette.py` (PRD §6.1 tokens). **Never encode meaning by red vs green alone**: add lightness, hatching or direct labels.
- Hebrew text **only through `figstyle.he()`**: logical order + a leading RTL mark. **Never `bidi.algorithm.get_display()`**:
  matplotlib ≥ 3.11 reorders Hebrew itself, so get_display reverses it twice (INC-002). One line per text object
  (the RTL base direction applies only to the first line). Fonts from `fonts/` via `figstyle` (Noto Sans Hebrew + Noto Sans fallback).
- Save with `figstyle.save()` (fixed PDF metadata → byte-identical re-runs, required by qa-code).
- Output vector PDF `figures/<name>.pdf`, sized for the text block (138 mm wide); no title inside the graph (the LaTeX caption is the title).
- Each figure is one function in `scripts/fig_<name>.py`, called from `scripts/make_figures.py`; deterministic (no random without a seed).
- After changes: `.venv/bin/python scripts/make_figures.py` and `scripts/qa.py code` + `qa.py img`.
