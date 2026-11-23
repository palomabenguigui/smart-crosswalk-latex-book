---
name: qa-cls-version
description: Checks the document class – version matches PLAN (v1.0), engine guard for TeX Live 2026, Hebrew font fallbacks, babel/biblatex settings from the incident log – and that chapter files contain no formatting commands. Run first in every QA pass.
---
# qa-cls-version (Detector)

Run: `.venv/bin/python scripts/qa.py cls-version`

## Checks
- `\ProvidesClass{smartcross}[… v1.0 …]` equals the target in `scripts/qa.py` (`CLS_TARGET`) and PLAN.
- The `.cls` contains: the engine guard (`\luatexversion<124` → error), the luaotfload fallbacks `schebrm…` (INC-001),
  `layout=tabular` without `layout=counters` (DS-03), `autolang=none` (DS-05).
- Chapter files (`chapters/*.tex`) define **no formatting**: no `\newcommand`, `\def`, `\definecolor`, `\usepackage`,
  `\setlength`, `\fontsize`, `\color`, `\textcolor`, fonts… (major); `\hspace`/`\vspace` are minor (usually a missing `.cls` feature).

## Visual check
Open one chapter opener and one body page: cover/opener/tabs/footer match PRD §6.3. A mismatch means someone changed the `.cls` without bumping the version.

## Fix routing (for the Leader)
Any finding here is fixed **in `smartcross.cls`** (bump the version, update `CLS_TARGET`), never in a chapter.
