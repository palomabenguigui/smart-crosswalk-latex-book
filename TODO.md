# TODO – ordered checklist

Mirrors the phases in [`PLAN.md`](PLAN.md). Tick items only when their exit gate passes. Each item = one logged prompt + one commit.

## P0 – Planning
- [x] Repository setup, `CLAUDE.md`, prompt log, `.gitignore`, README (Step 01)
- [x] Rename repository to `smart-crosswalk-latex-book` (Step 02)
- [x] Reference materials: ignore copyrighted files, `references/README.md` (Step 04)
- [x] Expert committee → `PRD.md`, `PLAN.md`, `TODO.md` (Step 05)
- [x] User reviews and approves PRD (incl. INC-000 correction) (Step 06)
- [x] PRD/PLAN v1.1: Writing style, AC-19, AC-20, online source verification (Step 06)

## P1 – Infrastructure
- [ ] Update MiKTeX (local 22.1 → current) and record versions in `README.md`
- [ ] Download Noto Serif Hebrew, Noto Sans Hebrew, Noto Serif/Sans, Noto Sans Mono into `fonts/` with OFL licence files
- [ ] Python env: `scripts/requirements.txt` (matplotlib, numpy, pandas, python-bidi) + venv instructions
- [ ] Add `data/`, `fonts/` folders and `INCIDENTS.md` (with INC-000)
- [ ] `smartcross.cls` v0.1: babel Hebrew main + English, fontspec, geometry, biblatex `style=ieee`
- [ ] `main.tex` skeleton: front matter + empty `\input` for chapters 1–10
- [ ] `scripts/build.sh` implementing PLAN §8; first successful build of the skeleton
- [ ] Mirror `skills/` into `.claude/skills/` (symlink) so Claude Code can load them

## P2 – QA skills (before any content)
- [ ] `skills/qa-infra/SKILL.md`
- [ ] `skills/qa-typeset/SKILL.md`
- [ ] `skills/qa-cls-version/SKILL.md`
- [ ] `skills/qa-BiDi/SKILL.md` (Prompt B2 checks + page render)
- [ ] `skills/qa-table/SKILL.md`
- [ ] `skills/qa-img/SKILL.md` (incl. greyscale and colour-blind checks)
- [ ] `skills/qa-code/SKILL.md`
- [ ] `skills/qa-super/SKILL.md` (order, report format, n-gram copy check, AC table)
- [ ] Production-agent skills: `writer` (authorial voice, PRD §12), `researcher` (online verification, drop-if-unverifiable), `python-graphs`, `tikz-illustrations`
- [ ] Add the AC-21 scene checks (line count, no digits, citations or first person) and the AC-22 verification check to `qa-super`
- [ ] Dry-run all skills on the skeleton; save a sample report

## P3 – Sources and data
- [ ] `references/refs.bib` with the flagship paper (DOI 10.1016/j.trf.2009.05.002)
- [ ] Create `references/VERIFICATION.md` (entry key, DOI/URL, date opened, metadata match, verdict)
- [ ] Find ≥ 11 more sources (countdown-signal studies, pedestrian detection, social control / social learning, Israeli road-safety statistics, relevant standards); **open each DOI/URL online and record the check**; drop any source that can't be verified
- [ ] `references/notes/` – one paraphrased note per source (no copied sentences)
- [ ] `data/rosenbloom2009_table1.csv`, `data/rosenbloom2009_table2.csv` with page refs, checked against the **rendered** page (INC-000)
- [ ] `scripts/recompute_table2.py` – reproduces PRD §9 (D1–D5) numbers

## P4 – Design system (`.cls` v1.0)
- [ ] Colour tokens (PRD §6.1) and font setup (§6.2)
- [ ] Banner (header) and footer with crosswalk rule
- [ ] Chapter openers: road-sign badge + 3-lamp progress indicator; warning-triangle variant for ch. 9
- [ ] `\crosswalkrule`
- [ ] Boxes: `scenebox` (chapter street scene), `findingbox`, `cautionbox`, `trapbox`, `definitionbox`, `projectbox`
- [ ] BiDi commands: `\en{}`, number/range/percent units, Hebrew-in-math
- [ ] Table style (column 1 on the right) and caption style
- [ ] Cover page (double frame, TikZ art, bilingual title, no page number)
- [ ] Design-sample page passes `qa-cls-version`, `qa-BiDi`, `qa-img`; bump to v1.0

## P5 – Figures
- [ ] G1 red-light crossing rate by gender (Table 1)
- [ ] G2 odds-ratio forest plot: reported vs recomputed (Table 2)
- [ ] G3 relative odds vs number of people waiting (reported vs recomputed)
- [ ] G4 risk heat-map (after the ch. 9 risk register exists)
- [ ] T1 crosswalk scene with sensing zones + countdown head
- [ ] T2 system architecture
- [ ] T3 WBS tree
- [ ] T4 social-control feedback loop
- [ ] Positioning graph for ch. 5 (sourced numbers or explicitly qualitative)
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
