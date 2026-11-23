---
name: qa-super
description: Orchestrates every QA family on the built book (template first), then content checks (figure/table references, citations ↔ refs.bib ↔ VERIFICATION.md, 8-word copy check, scene boxes, third person). Use after every build and before every merge. Reports only – never fixes.
---
# qa-super – QA orchestrator (Detector)

**Role:** Detector in the Detector → Fixer loop (PLAN §4). You never edit sources. You produce a report.

## Procedure
1. Build: `scripts/build.sh` (or `scripts/build.sh <file.tex>`). A failed build = blocker; stop here.
2. Run the families **in this order** (the template first: an old template causes defects everywhere else):
   `qa-cls-version → qa-infra → qa-typeset → qa-BiDi → qa-table → qa-img → qa-code → content`.
   All of them at once: `.venv/bin/python scripts/qa.py super --pdf build/main.pdf`.
3. **Visual pass** (no script can replace it): render every page
   `osascript -l JavaScript scripts/render_pages.js "$PWD/build/main.pdf" "$PWD/build/qa/page" 1.6`
   and open each PNG. Apply the visual checklists of `qa-BiDi`, `qa-table` and `qa-img`.
4. Merge script findings + visual findings into `build/qa/report-<date>.md` (ignored by git). Summarise the counts in the commit message.
5. Exit gate: **0 blocker, 0 major**. Otherwise hand the report to the Leader for triage (PLAN §4).

## Content checks done here (scripts/qa.py `content`)
- Every `\label` of a figure/table is referenced in the text (AC-08).
- Cited keys ⊆ `refs.bib`; every `refs.bib` key cited (AC-09); every key has a **verified** row in `references/VERIFICATION.md` (AC-22).
- No 8-word sequence shared with the local reference texts (AC-11).
- One `scenebox` per chapter, ≤ ~4 lines, no digits or citations inside (AC-21); no first person outside scenes and pull quotes (PRD §3.1).

## Report format (mandatory)
`[skill] [blocker|major|minor] [page N] [file:line] "exact text" -> rule (PRD/AC id)`
A report that says only "OK" or "checked" is itself a failure (booklet §19.5). Give counts.

## Regression tests
`.venv/bin/python tests/qa/run_tests.py` must pass before relying on the detectors (each must fire on the fixture).
