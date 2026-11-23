---
name: qa-typeset
description: Scans the LuaLaTeX log for errors, undefined references/citations, missing glyphs, overfull boxes > 1pt, underfull boxes, LaTeX/package/font warnings and rerun requests (AC-03). Then checks page breaks visually.
---
# qa-typeset (Detector)

Run: `.venv/bin/python scripts/qa.py typeset --log build/main.log`

## Log checks (AC-03)
| Pattern | Severity |
|---|---|
| `! …` / `file:line:` errors | blocker |
| undefined reference/citation | blocker |
| `Missing character` (INC-001 regression: fallback fonts broken) | blocker |
| Overfull box > 1 pt | major |
| LaTeX / Package / Class / Font warnings, "Rerun to get…" | major |
| Underfull box | minor |

## Visual checks (render pages, see qa-super)
- No widow/orphan lines, no heading alone at a page bottom, no box split with only a title line.
- No page that holds only a float or only a closing rule (DS-16, DS-19 regressions).
- Chapter openers: title and mission do not touch the giant number (DS-14).
