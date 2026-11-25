---
name: qa-infra
description: Checks toolchain (TeX Live 2026 lualatex from /Library/TeX/texbin, biber 2.21), required files, bundled fonts + OFL licences, that copyrighted references are never tracked, README image links (AC-19), and page counts of the final PDF (AC-01/02).
---
# qa-infra (Detector)

Run: `.venv/bin/python scripts/qa.py infra --pdf build/main.pdf`

## Checks
- `lualatex --version` contains "TeX Live 2026" and resolves to `/Library/TeX/texbin` (not an old MiKTeX link in `~/bin`); `biber` 2.21.
- Required files: CLAUDE/README/PRD/PLAN/TODO/INCIDENTS, main.tex, smartcross.cls, hebrew.lbx, refs.bib, VERIFICATION.md, prompt log, requirements.txt, build.sh (AC-17).
- `fonts/<family>/*.otf` + `OFL.txt` for all five Noto families.
- `references/*.pdf` and the booklet are git-ignored and **not tracked** (copyright) – blocker otherwise.
- Every local image linked from README.md exists (AC-19).
- `build/main.pdf`: page count inside the range of **PRD AC-01** and enough Arabic-numbered body pages per **AC-02** (the numbers live in PRD.md and `scripts/qa.py`, never in this skill).
- **Skill ↔ code consistency (INC-005):** every version (`vX.Y`) or page range (`N–M pages`) written in `skills/*/SKILL.md` must agree with `CLS_TARGET` in `scripts/qa.py` and with the AC-01 range in `PRD.md`. A contradiction is a major finding.
- Clean-clone build (AC-18, release only): `git clone . /tmp/x && cd /tmp/x && scripts/build.sh`.
