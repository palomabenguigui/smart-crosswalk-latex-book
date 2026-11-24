# Round 2 – WRITER (parallel agent)

You are the **Writer** agent of the "Smart Crosswalk" book project (repository root = current directory), one of three agents running
**in parallel**. Read `CLAUDE.md` first – rule 1a applies: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push.

## Load first
The `writer` skill. **`PRD.md` §1 (final concept and the evidence-driven pivot, v1.4)**, §3.1, §4, §7 (rules 1–13), §9 (D1–D7), §12, §13 (decision log). `prompts/agents/round1-redteam-response.md` (what changed in ch. 4).
`references/notes/*.md` – **respect the read depth** stated in `prompts/agents/round1-researcher-report.md`: `keegan2003`, `lipovac2013`,
`brosseau2013` may be cited **at title level only** (no numbers, no findings beyond the title); abstract-level sources only for what the note states.

## Task A – finish chapter 4 (`chapters/ch04-literature.tex`, total ≈ 6.5 pages)
1. Replace the placeholder `\section{סקירה תמטית}` with a **thematic, critical** review (≈ 2–2.5 pages), four themes:
   social control and social learning (`hirschi1969`, `bandura1977`, `rosenbloom2009`); social influence at the curb (`lefkowitz1955`, `zhou2009`,
   `faria2010`, `brosseau2013`); countdown signals – **mixed evidence**, incl. `fu2016`'s early starts with a red-phase countdown and the MUTCD
   clearance-only rule (`keegan2003`, `eccles2004`, `lipovac2013`, `fu2016`, `fhwa2025mutcd`) – this theme is where the reader first sees **why the
   project does not count down during red**; curb-side pedestrian detection (`hughes2000`, `wickramasinghe2020`) – the basis of **adaptive red**.
   End the section with a **literature matrix** table (rows = sources, columns = themes/what each shows; booktabs, `\headrow`, column 1 on the right,
   caption above, `\label{tab:litmatrix}`, referenced in the text) – the empty cells show the gap.
2. Add a compact **Table 2 re-typeset** in the critical-analysis section (`\label{tab:table2}`): predictor | printed e^b | printed CI | e^b derived
   from b and SE | CI derived – values only from `data/rosenbloom2009_table2.csv` and `data/recomputed.json`; caption "עובד מתוך \cite{rosenbloom2009}".
3. **Align with the final concept (PRD §1):** rewrite `\section{פער הידע}` and its `findingbox` so the answer to the gaps is
   *curb sensing of waiting (especially lone) pedestrians + adaptive shortening of red within safe limits + clearance-only countdown + campaign* –
   not a countdown during red. Where the text cites the paper's §4.2 suggestion (time-remaining signals), also cite its §4.5 recommendation
   (shorter red at certain times) and say that the project follows §4.5 for red and the standard for the countdown.
4. Keep everything that round 1 fixed (D1–D7, captions, "חצייה"). Do not change figures.

## Task B – chapter 1 (`chapters/ch01-intro.tex`, ≈ 2.5 pages)
`\ChapterMission`, `\ChapterIcon{pedestrian}`, `\chapter{מבוא ורקע}`, a `scenebox` (≤ 4 lines; e.g. a lone pedestrian at a long red). Three stations (booklet ch. 3):
the global picture of pedestrian safety (`who2023`), the Israeli picture (`who2023israel` – the ≈ 98 pedestrian deaths figure is a **derivation**:
say so explicitly), the flagship insight (`rosenbloom2009`: the lone pedestrian crosses on red more; each person waiting lowers the odds).
Then **the project in one paragraph – the final concept of PRD §1**: curb sensing detects waiting pedestrians (especially a lone one) and the
controller shortens red within safe limits (adaptive red); a countdown runs **only during the clearance interval**, as the standard requires
(`fhwa2025mutcd`); and a social-control campaign. Then **a short subsection on the evidence-driven pivot**: the project started from a countdown
showing the time left on red; the evidence (`fhwa2025mutcd` §4I.04, `fu2016`: early starts with a red-phase countdown) moved the countdown to the
clearance interval and turned the sensing toward shortening red. Present it as a strength (a decision driven by evidence), point to ch. 6, where the
red-phase countdown is Alternative 1 and is rejected in the weighted matrix. End with a roadmap of chapters 2–10.
One `statrow` with sourced numbers.

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
