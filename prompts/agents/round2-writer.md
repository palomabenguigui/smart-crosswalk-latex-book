# Round 2 – WRITER (parallel agent)

You are the **Writer** agent of the "Smart Crosswalk" book project (repository root = current directory), one of three agents running
**in parallel**. Read `CLAUDE.md` first – rule 1a applies: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push.

## Load first
The `writer` skill. `PRD.md` §3.1, §4, §7 (rules 1–13), §9 (D1–D7), §12. `prompts/agents/round1-redteam-response.md` (what changed in ch. 4).
`references/notes/*.md` – **respect the read depth** stated in `prompts/agents/round1-researcher-report.md`: `keegan2003`, `lipovac2013`,
`brosseau2013` may be cited **at title level only** (no numbers, no findings beyond the title); abstract-level sources only for what the note states.

## Task A – finish chapter 4 (`chapters/ch04-literature.tex`, total ≈ 6.5 pages)
1. Replace the placeholder `\section{סקירה תמטית}` with a **thematic, critical** review (≈ 2–2.5 pages), four themes:
   social control and social learning (`hirschi1969`, `bandura1977`, `rosenbloom2009`); social influence at the curb (`lefkowitz1955`, `zhou2009`,
   `faria2010`, `brosseau2013`); countdown signals – **mixed evidence**, incl. `fu2016`'s early starts and the MUTCD clearance-only rule
   (`keegan2003`, `eccles2004`, `lipovac2013`, `fu2016`, `fhwa2025mutcd`); curb-side pedestrian detection (`hughes2000`, `wickramasinghe2020`).
   End the section with a **literature matrix** table (rows = sources, columns = themes/what each shows; booktabs, `\headrow`, column 1 on the right,
   caption above, `\label{tab:litmatrix}`, referenced in the text) – the empty cells show the gap.
2. Add a compact **Table 2 re-typeset** in the critical-analysis section (`\label{tab:table2}`): predictor | printed e^b | printed CI | e^b derived
   from b and SE | CI derived – values only from `data/rosenbloom2009_table2.csv` and `data/recomputed.json`; caption "עובד מתוך \cite{rosenbloom2009}".
3. Keep everything that round 1 fixed (D1–D7, captions, "חצייה"). Do not change figures.

## Task B – chapter 1 (`chapters/ch01-intro.tex`, ≈ 2.5 pages)
`\ChapterMission`, `\ChapterIcon{pedestrian}`, `\chapter{מבוא ורקע}`, a `scenebox` (≤ 4 lines). Three stations (booklet ch. 3):
the global picture of pedestrian safety (`who2023`), the Israeli picture (`who2023israel` – the ≈ 98 pedestrian deaths figure is a **derivation**:
say so explicitly), the flagship insight and the project idea (`rosenbloom2009`), then a roadmap of chapters 2–10.
One `statrow` with sourced numbers. No design decision about *when* the countdown runs (that decision is pending with the user).

## Rules for numbers (AC-14)
Every number you **compute** (not one printed in a source) must be registered: append an entry to `data/quoted_in_book.json`
(`shown`, `source` = path in `data/recomputed.json`, `decimals`, `chapter`). If the value is not in `recomputed.json`, do not compute it yourself –
list it in your report for the Leader. Numbers printed in a source are cited, not registered.

## Files you may write
`chapters/ch04-literature.tex`, `chapters/ch01-intro.tex`, `data/quoted_in_book.json` (append only), and temporarily `main.tex`
(uncomment `\inputchapter{1}{chapters/ch01-intro}` for your self-check – leave it **uncommented** when you finish).

## Check before you finish
`scripts/build.sh` → `.venv/bin/python scripts/qa.py super --pdf build/main.pdf`: 0 blocker / 0 major (ignore `qa-code` git-state findings).
Render your pages (`osascript -l JavaScript scripts/render_pages.js "$PWD/build/main.pdf" /tmp/w2/p 1.6`) and check them by eye.

## Report
`prompts/agents/round2-writer-report.md`: files, pages per chapter, QA counts (paste the `-- ran:` line), numbers registered, numbers you need from the Leader, open questions.
