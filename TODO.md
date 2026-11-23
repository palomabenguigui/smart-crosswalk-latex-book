# TODO – ordered checklist

Mirrors the phases in [`PLAN.md`](PLAN.md). Tick items only when their exit gate passes. Each item = one logged prompt + one commit.

## P0 – Planning
- [x] Repository setup, `CLAUDE.md`, prompt log, `.gitignore`, README (Step 01)
- [x] Rename repository to `smart-crosswalk-latex-book` (Step 02)
- [x] Reference materials: ignore copyrighted files, `references/README.md` (Step 04)
- [x] Expert committee → `PRD.md`, `PLAN.md`, `TODO.md` (Step 05)
- [x] User reviews and approves PRD (incl. INC-000 correction) (Step 06)
- [x] PRD/PLAN v1.1: Writing style, AC-19, AC-20, online source verification (Step 06)

## P1a – Toolchain and environment ✅ DONE (Steps 07–08)
- [x] `.gitignore`: `!references/VERIFICATION.md` exception; `references/VERIFICATION.md` created and tracked (Step 07)
- [x] MiKTeX tried: packages updated, but MiKTeX for macOS is frozen at 22.1 (LuaHBTeX 1.14) and can't compile current babel (`\matheqdirmode` undefined) → **abandoned** (Step 07)
- [x] Toolchain switched to **TeX Live 2026 (MacTeX .pkg)**: LuaHBTeX 1.24.0, biber 2.21, babel v26.4, LaTeX2e 2025-11-01 (Step 08)
- [x] Toolchain versions recorded in `README.md` (Step 08)
- [x] Noto Serif Hebrew 2.004, Noto Sans Hebrew 3.001, Noto Serif 2.015, Noto Sans 2.015, Noto Sans Mono 2.014 in `fonts/` with OFL licence files (Step 07)
- [x] Font + BiDi smoke test `scripts/font-test.tex` compiles cleanly: 0 errors, 0 warnings, 0 missing characters, 0 overfull boxes (Step 08)
- [x] Hebrew-font **fallback** (Noto Hebrew has no digits, Latin or punctuation) + `\setmathrm` → pattern to copy into `smartcross.cls` (Step 08)
- [x] Python env `.venv` + `requirements.txt` (matplotlib, numpy, python-bidi) (Step 07)

## P1b – Project skeleton (Step 09)
- [x] `data/` folder (+ README with transcription rules) and `INCIDENTS.md` (INC-000, INC-001, style-sample findings DS-01…DS-10)
- [x] `smartcross.cls` v0.1: full PRD §6 design system (tokens, fonts + fallbacks, banner, footer, road-sign openers + 3-lamp indicator, crosswalk rules, 6 boxes, booktabs, BiDi commands, cover, IEEE bibliography), engine guard
- [x] `main.tex` skeleton: cover, TOC, chapter `\input`s (commented), references
- [x] `scripts/build.sh` implementing PLAN §8 + log summary; `scripts/render_pages.js` (PDF → PNG)
- [x] `.claude/skills` → `../skills` symlink
- [x] `references/refs.bib` with the flagship paper, **verified online** (Crossref via doi.org) and logged in `VERIFICATION.md`
- [x] Style sample `chapters/00-style-sample.tex` built clean (0 errors / warnings / missing chars / over- and underfull boxes); 6 pages rendered to `screenshots/style-sample/`; 10 defects found and fixed in the `.cls`
- [x] Step 10: premium redesign → `smartcross.cls` v0.2 with two directions (A editorial / B engineering), samples `samples/style-A.tex` (6 pp) and `samples/style-B.tex` (5 pp), clean logs, 9 more defects fixed (DS-11…DS-19); renders in `screenshots/style-sample-A/` and `-B/`
- [x] User chose a **mix** (A layout + B boxes/tables) → `smartcross.cls` v1.0, A/B branches and samples removed (Step 13)
- [x] Final sample `samples/style-final.tex` (3 pp) built clean, renders in `screenshots/style-final/`; PRD §6 describes the final design (Step 13)
- [x] Authors' photo `figures/photo-crosswalk.jpg` (1170×1544, no people) used via `\authorphoto` (Step 13)

## P2 – QA skills (before any content) ✅ DONE (Step 13)
- [x] `scripts/qa.py`: deterministic Detector for every family (cls-version, infra, typeset, bidi, table, img, code, content, super); standard report format; exit 1 on blocker/major
- [x] `skills/qa-super`, `qa-cls-version`, `qa-infra`, `qa-typeset`, `qa-BiDi`, `qa-table`, `qa-code`, `qa-img` (each: script checks + visual checklist + DS regressions)
- [x] Production-agent skills: `writer` (voice PRD §12), `researcher` (online verification, drop-if-unverifiable, rendered-page data rule), `python-graphs`, `tikz-illustrations`
- [x] AC-21 scene checks and AC-22 verification check in `qa.py content`
- [x] Regression tests `tests/qa/run_tests.py`: 17/17 pass (each detector fires on the bad fixture, silent on the final sample)
- [x] Dry run on the final sample: 0 blocker / 0 major / 0 minor

## P3 – Sources and data
- [x] `references/refs.bib` with the flagship paper (DOI 10.1016/j.trf.2009.05.002), verified online (Step 09)
- [ ] Create `references/VERIFICATION.md` (entry key, DOI/URL, date opened, metadata match, verdict)
- [ ] **→ Researcher agent, parallel round 1 (PLAN §11):** find ≥ 11 more sources (countdown-signal studies, pedestrian detection, social control / social learning, Israeli road-safety statistics, relevant standards); **open each DOI/URL online and record the check**; drop any source that can't be verified
- [ ] **→ Researcher agent:** `references/notes/` – one paraphrased note per source (no copied sentences)
- [x] `data/rosenbloom2009_table1.csv`, `data/rosenbloom2009_table2.csv` with page refs, checked against the **rendered** page (INC-000) (Step 13)
- [x] `scripts/recompute_table2.py` → `data/recomputed.json` – reproduces PRD §9 (D1–D5): e^b 0.71/0.67 vs 0.63; traffic row implies b≈0.79, p≈0.014; χ² 17.17 ✓; female 61.76% vs 60.8% (Step 13)

## P4 – Design system (`.cls` v1.0) ✅ DONE (Steps 09–13)
- [x] Colour tokens (PRD §6.1) and font setup (§6.2)
- [x] Banner (header) and footer with crosswalk rule
- [x] Chapter openers: road-sign badge + 3-lamp progress indicator; warning-triangle variant for ch. 9
- [x] `\crosswalkrule`
- [x] Boxes: `scenebox` (chapter street scene), `findingbox`, `cautionbox`, `trapbox`, `definitionbox`, `projectbox`
- [x] BiDi commands: `\en{}`, number/range/percent units, Hebrew-in-math
- [x] Table style (column 1 on the right) and caption style
- [x] Cover page (double frame, TikZ art, bilingual title, no page number)
- [x] Design-sample page passes `qa-cls-version`, `qa-BiDi`, `qa-img`; bump to v1.0

## P5 – Figures
- [x] `scripts/palette.py`, `figstyle.py`, `make_figures.py` (deterministic PDFs) (Step 13)
- [x] G1 red-light crossing rate by gender (Table 1) → `figures/g1-crossing-by-gender.pdf`
- [x] G2 odds-ratio forest plot: reported vs recomputed (Table 2) → `figures/g2-odds-ratios.pdf`
- [x] G3 relative odds vs number of people waiting (reported vs recomputed) → `figures/g3-relative-odds.pdf`
- [ ] G4 risk heat-map → **after** the ch. 9 risk register exists (writing round)
- [x] T1 crosswalk plan view: waiting zone, sensing zone, countdown heads, awareness display, controller → `figures/tikz/t1-crosswalk-zones.tex`; all figures checked in `samples/figures-test.tex` (clean log, 0 BiDi findings)
- [ ] T2 system architecture → after ch. 6 picks the alternative (writing round)
- [ ] T3 WBS tree → with ch. 8 (writing round)
- [ ] T4 social-control feedback loop → with ch. 4 theory section (writing round)
- [ ] Positioning graph for ch. 5 → after the Researcher's market sources (writing round)
- [ ] `qa-img` + `qa-code` clean

## P6 – Writing (one chapter per task, Detector → Fixer loop after each)
Every chapter opens with a `scenebox` street scene (≤ 4 lines), then formal third person (PRD §12).
- [ ] Parallel round (PLAN §11): save prompts in `prompts/agents/`, run Writer + Researcher + QA red team at the same time, take screenshots while they run, save their reports (AC-20)
- [ ] Ch. 1 מבוא ורקע (2 pp)
- [ ] Ch. 2 הגדרת הבעיה, שאלת המחקר והיעדים (2 pp)
- [ ] Ch. 3 מפרט הדרישות (2 pp)
- [ ] Ch. 4 סקירת ספרות ומאמר הדגל, incl. `cautionbox` on data issues D1–D6 (6 pp)
- [ ] Ch. 5 חקר שוק ומוצרים קיימים (3 pp)
- [ ] Ch. 6 חלופות תכן ומטריצת החלטה (3 pp)
- [ ] Ch. 7 ארכיטקטורת המערכת וחדשנות (2 pp)
- [ ] Ch. 8 תוכנית עבודה: WBS, RACI, גאנט (3 pp)
- [ ] Ch. 9 ניתוח סיכונים ותוכנית הפחתה (2 pp)
- [ ] Ch. 10 סיכום (1 p)
- [ ] Front matter: Hebrew abstract + keywords, English abstract, abbreviations list

## P7 – Integration and full QA
- [ ] Full build via `scripts/build.sh`
- [ ] `qa-super` full run; loop until 0 blocker / 0 major
- [ ] Check AC-01 to AC-15 and record results in a table in `README.md`
- [ ] Page-by-page visual check at readable zoom (booklet §19.5); screenshots saved

## P8 – Red team
- [ ] Fresh session (another model if possible): Prompt 9, 10 weakest points with page + sentence
- [ ] Resolve or answer each point in writing; rebuild; re-run `qa-super`

## P9 – Release
- [ ] Screenshots into `screenshots/`: ≥ 3 book pages (cover, chapter opener, content page), every Python graph, every TikZ illustration, agents in action (AC-19)
- [ ] README: overview, agent team (with parallel-run evidence), structure, build, screenshots, skills list, credits, final status badge
- [ ] README: INC-000 as a real red-team example (wrong claim → checked against the rendered page → corrected → new detection rule)
- [ ] Final `build/main.pdf` committed; clean-clone build test (AC-18)
- [ ] Tag `v1.0` and push
