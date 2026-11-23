# Round 1 – WRITER (parallel agent)

You are the **Writer** agent of the "Smart Crosswalk" book project (repository root = current directory).
You are one of three agents running **in parallel** (Writer, Researcher, QA red team). Read `CLAUDE.md` first —
rule 1a applies to you: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push.

## Load first
1. The `writer` skill (`skills/writer/SKILL.md`) and follow it exactly.
2. `PRD.md` §3.1, §4 (chapter 4 row), §7 (BiDi rules 1–13), §9 (known data issues D1–D6), §12 (writing style).
3. `data/recomputed.json` (the ONLY source for recomputed numbers), `data/rosenbloom2009_table1.csv`, `..._table2.csv`.
4. The flagship paper, for reading only: `references/מאמר מס 7.pdf` (copyrighted – never copy sentences).

## Task
Write `chapters/ch04-literature.tex`, **sections on the flagship paper only** (about 3.5 of the chapter's 6 pages;
the thematic literature review §4.1 is written in round 2, once the Researcher's sources are verified):
- `\ChapterMission{…}`, `\ChapterIcon{sensor}`, `\chapter{סקירת ספרות ומאמר הדגל}`, a `scenebox` (≤ 4 lines, no numbers).
- A placeholder `\section{סקירה תמטית}` containing only the comment `% TODO round 2: thematic review (Researcher sources)`.
- `\section{מאמר הדגל: חצייה באדום, יחידים וקבוצות}` – why this paper was chosen; method (site, hour, sample, observation grid) in your own words; key results with the existing figures:
  `figures/g1-crossing-by-gender.pdf` (label `fig:g1`), a `statrow` with 3 tiles, the logistic model as a numbered equation.
- `\section{ניתוח ביקורתי של הנתונים}` – D1–D6 from PRD §9 in a `cautionbox` and running text, with
  `figures/g2-odds-ratios.pdf` (`fig:g2`) and `figures/g3-relative-odds.pdf` (`fig:g3`); explain why no absolute probability can be drawn.
- `\section{פער הידע}` – the gap the project addresses (waiting time not measured, single site, no technology → sensing + countdown), ending with a `findingbox`.
- Figures: `\begin{figure}[ht]\centering\includegraphics[width=\linewidth]{figures/…}\caption{…(עובד מתוך \cite{rosenbloom2009})}\label{…}\end{figure}`.
- Cite only `rosenbloom2009` (the only verified key now). Any other claim that needs a source: write `% NEEDS-SOURCE: <claim>` and leave the sentence out.

## Check before you finish
To build your chapter, temporarily uncomment `\input{chapters/ch04-literature}` in `main.tex` (that is the only other file you may touch), then:
`scripts/build.sh` → `.venv/bin/python scripts/qa.py bidi` → `.venv/bin/python scripts/qa.py content`. Fix your chapter until 0 blocker/major on it.

## Report
Write `prompts/agents/round1-writer-report.md`: files written, pages produced, QA counts, every `NEEDS-SOURCE` item, open questions.
