# Round 1 – Writer report

## Files written
- `chapters/ch04-literature.tex` (new) – flagship-paper sections of chapter 4.
- `prompts/agents/round1-writer-report.md` (this file).
- `main.tex` – `\input{chapters/ch04-literature}` was uncommented for the self-check build and **commented out again** (no net change).
- `build/main.pdf` was overwritten by the self-check build and **restored with `git checkout`** (no net change). The Leader should rebuild after the merge.

## Content
| Element | Status |
|---|---|
| `\ChapterMission`, `\ChapterIcon{sensor}`, `\chapter{סקירת ספרות ומאמר הדגל}` | done |
| `scenebox` | 3 source lines, about 4 rendered lines, no numbers/names/first person (passes AC-21 check) |
| `\section{סקירה תמטית}` | placeholder with only `% TODO round 2: thematic review (Researcher sources)` |
| `\section{מאמר הדגל: …}` | why chosen, method (`\paragraph{שיטה.}`), results (`\paragraph{ממצאים.}`), `fig:g1`, `statrow` (13.5%, 3.71, 0.63 recomputed), logistic model as numbered equation `eq:logit` + OR = e^β |
| `\section{ניתוח ביקורתי של הנתונים}` | `cautionbox` with D1–D6 as a list, running text on every issue, `fig:g2`, `fig:g3`, and why no absolute probability (no intercept β0) |
| `\section{פער הידע}` | three gaps (waiting time, single site/hour, no technology), ends with `findingbox` |

Issue labels are written `\en{D1}`…`\en{D6}` (Latin, as in PRD §9). A Hebrew "ד1" put a bare digit in the text and failed the BiDi rule-4 lint.

All numbers come from `data/recomputed.json` or the `data/*.csv` files: 1,392; 842/550 (60.5/39.5%); 563 (40.4%); 76; 5.5%; 13.5%;
28/330 = 8.5%; 48/233 = 20.6%; χ² = 17.17; 3.71; 0.71→0.63; 0.67→0.63; −0.03/0.03 → 0.97, 0.92–1.03; 2.20; 6.06; b≈0.79;
−24.24/8,184.53; 60.8→61.8 (512/829); about 37% vs 29% per extra person waiting (1−0.63 vs 1−0.71); 0.63³ ≈ 0.25 ("about a quarter with three waiting").
Taken from the paper's text and not from `data/`: observation hours 07:30–08:30 and eight one-hour sessions (Methods §2.3).
The Leader may want to add these to `data/` or to `quoted_in_book`.

## Pages produced
About **4.3 pages** (chapter opener page with scene and §4.1/§4.2 start, then 3 full pages and about ¼ page). That is about 0.8 page over the 3.5-page target.
Most of the excess comes from the three full-width figures (`width=\linewidth`, as the prompt requires). I already cut the text by about 25% from my first draft (5.3 pages).
Options for the Leader: set G1/G3 to `0.85\linewidth`, or take the overrun from the thematic review's budget.

## QA (self-check, chapter 4 only in `main.tex`)
`scripts/build.sh`: 0 errors, 0 undefined refs, 0 missing chars, 0 overfull, 0 underfull, 0 warnings.

| Family | blocker | major | minor |
|---|---:|---:|---:|
| `qa.py bidi` | 0 | 0 | 0 |
| `qa.py content` (incl. 8-word copy check against the paper) | 0 | 0 | 0 |
| `qa.py typeset` | 0 | 0 | 0 |

I rendered the pages (PDFKit) and checked them by eye. Hebrew order, numbers, citations [1], the equation and the boxes are correct.

## NEEDS-SOURCE items
None. Every factual claim in the chapter is from `rosenbloom2009` or from the recomputation. The project-side claims (the sensing + countdown system) are design statements, not empirical claims.
In round 2, the thematic review will need sources for social control (Hirschi), social learning (Bandura), countdown-signal effects and pedestrian sensing.

## Open questions / notes for the Leader and QA
1. **PRD §4 mandatory element "Tables 1 & 2 re-typeset with citation"** was not in this round's task, so it is not in the chapter. A compact Table 2 (printed vs recomputed e^b) would fit naturally in the critical-analysis section. Should it go in round 2? It would add about ⅓ page.
2. **G2 legend (figure file, not my file):** at render resolution, the legend entry "מחושב מחדש מ-b ו-SE" may show the maqaf/Latin order wrong (looks like `SE-ו b-מחושב…`). Please ask the QA red team / Python agent to check it at full zoom.
3. Hebrew subscripts in `eq:logit` (`\hebmath`) render correctly but are small. If the committee prefers it, they can be replaced by x₁…x₅ with a legend line.
4. I used `\paragraph{שיטה.}` / `\paragraph{ממצאים.}` (standard LaTeX, not banned) to save space instead of subsections. Check that this matches the house style.
