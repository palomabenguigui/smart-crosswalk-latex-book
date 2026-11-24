# FINAL ROUND – WRITER (parallel agent)

You are the **Writer** of the "Smart Crosswalk" book (repository root = current directory), one of three agents running **in parallel**.
Read `CLAUDE.md` – rule 1a: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push. Goal: **finish the book**. Load the `writer` skill.
Read `PRD.md` §1 (final concept + evidence-driven pivot), §4 (chapters), §7 (BiDi rules), §12 (voice), and `references/notes/*.md`.
Done already: ch. 1 and ch. 4 – do not rewrite them (only fix a cross-reference such as "פרק \num{6}" → `\ref{chap:alternatives}`).

## Step 0 – FIRST, before any chapter (the visuals agent waits for these files)
- `data/wbs.csv`: `wp_id,wp_name_he,task_id,task_name_he,start_month,end_month,deliverable_he,R,A,C,I` – 5 work packages, 3–4 tasks each, about 12 months.
  Roles: מנהל פרויקט, מהנדס תנועה, מהנדס חישה ונתונים, נציג העירייה, מנהל קמפיין.
- `data/risks.csv`: `id,scenario_he,domain_he,P,I,mitigation_he,contingency_he,P_res,I_res` – 6–8 risks, P and I on 1–5; R = P×I ≥ 12 is critical.
  Must include: regulatory approval of adaptive red, missed or false detection, privacy (camera), extra vehicle delay, early starts, campaign without effect.

## Chapters to write (budget in pages – the whole book must stay ≤ 32 pages)
Each one: `\ChapterMission{…}`, `\ChapterIcon{…}`, `\chapter{…}\label{chap:<name>}`, one `scenebox` (≤ 4 lines, no numbers), then formal third person.
| File | Title | Pages | Must contain |
|---|---|---|---|
| `chapters/ch02-problem.tex` | הגדרת הבעיה, שאלת המחקר והיעדים | 2 | quantified problem (current vs desired), research question + hypotheses, SMART design goals; figures `\inputfigure{figures/tikz/t4-social-loop}` (`fig:t4`) and the existing `\inputfigure{figures/tikz/t1-crosswalk-zones}` (`fig:t1`) |
| `chapters/ch03-requirements.tex` | מפרט הדרישות | 2 | table `REQ-…` (ID, requirement, class, target, verification): detection of waiting pedestrians, adaptive-red **safe limits** (minimum vehicle green, clearance time / walking speed, maximum shortening), countdown **only in clearance** (`fhwa2025mutcd`), privacy (no stored images), availability, campaign |
| `chapters/ch05-market.tex` | חקר שוק ומוצרים קיימים | 2 | three market layers; technical comparison table of product classes (countdown heads `current2023gtx`, curb detectors `agd2024agd645`, `tfl2015kerbside`, vision `wickramasinghe2020`, detector reviews `trl2006ppr087`) |
| `chapters/ch06-alternatives.tex` | חלופות תכן ומטריצת החלטה | 2.5 | `\label{chap:alternatives}`; **A1 red-phase countdown**, **A2 adaptive red + clearance countdown + campaign (chosen)**, **A3 campaign only**; formula $S_j=\sum_i w_i c_{ij}$ (numbered); weighted matrix table with justified weights; A1 rejected with `fhwa2025mutcd` and `fu2016`; tell the pivot as an evidence-driven change |
| `chapters/ch07-architecture.tex` | ארכיטקטורת המערכת וחדשנות | 2 | `\inputfigure{figures/tikz/t2-architecture}` (`fig:t2`); data flow; adaptive-red logic in words (lone pedestrian priority, safe limits); clearance-only countdown; privacy by design; innovation |
| `chapters/ch08-workplan.tex` | תוכנית עבודה: WBS, RACI, גאנט | 2.5 | `\inputfigure{figures/tikz/t3-wbs}` (`fig:t3`), RACI table built from `data/wbs.csv`, `\inputfigure{figures/tikz/t5-gantt}` (`fig:gantt`), milestones |
| `chapters/ch09-risks.tex` | ניתוח סיכונים ותוכנית הפחתה | 2 | numbered formula R = P × I; risk table from `data/risks.csv` (with R); mitigation + contingency for every R ≥ 12; `\includefigure{figures/g4-risk-heatmap.pdf}` (`fig:g4`, caption: "הערכות הצוות") |
| `chapters/ch10-summary.tex` | סיכום | 1 | findings, readiness, immediate next steps; no new facts |
| `chapters/front-abstract.tex` | – | 1 | `\chapter*{תקציר}` + Hebrew abstract (250–350 words) + keywords; then `\section*{Abstract}` in `\begin{otherlanguage}{english}` (≈ 150 words) |
| `chapters/front-abbreviations.tex` | – | ½ | `\chapter*{רשימת קיצורים}` + table (abbreviation, full English, Hebrew) for every acronym used |

Use only verified keys in `references/refs.bib` (re-read it before each chapter; the Researcher adds keys during the round) and respect each note's read depth.
Every figure: `\begin{figure}[ht]\centering … \caption{…}\label{…}\end{figure}` and referenced in the text. Tables: booktabs, `\headrow \thead{…}`, caption above.

## Check
Build with your own folder: `BUILD_DIR=build/writer scripts/build.sh`, then `.venv/bin/python scripts/qa.py super --pdf build/writer/main.pdf`.
Render pages (`osascript -l JavaScript scripts/render_pages.js "$PWD/build/writer/main.pdf" /tmp/wf/p 1.6`) and look at them. Fix what a reader would see.

## Report
`prompts/agents/final-writer-report.md`: files, pages per chapter, total pages, QA line, open questions.
