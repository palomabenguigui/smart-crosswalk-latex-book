# Final round – Writer report

Parallel agent (CLAUDE.md rule 1a): no edits to `PROMPTS_LOG.md`, no commit/push. Build: `BUILD_DIR=build/writer scripts/build.sh`.

## Files written
| File | Content |
|---|---|
| `data/wbs.csv` (step 0) | 5 WPs, 17 tasks, months 1–12, deliverable + R/A/C/I (one role per column; exactly one R and one A per task) |
| `data/risks.csv` (step 0) | R1–R8, P/I 1–5 + residual. Critical (R ≥ 12): R1 = 15, R2 = 12, R3 = 12, R5 = 12; all residual ≤ 8 |
| `chapters/ch02-problem.tex` | problem in numbers (rosenbloom2009, zhu2021, guo2011, vanhouten2007), research question (definitionbox), H1–H3, Table `tab:problem` (current vs desired, GOAL-1..6, SMART); `fig:t4`, `fig:t1` |
| `chapters/ch03-requirements.tex` | sources of requirements, safe limits, **eq:clearance** t = L/v (v ≤ 1.07 m/s), Table `tab:req` REQ-01..13 (ID, requirement, class, target, verification) |
| `chapters/ch05-market.tex` | 3 layers (display / sensing / control+data), Table `tab:market` (5 product classes), projectbox. No market sizes or prices: none verifiable |
| `chapters/ch06-alternatives.tex` | A1 / A2 (chosen) / A3, **eq:score**, justified weights, Table `tab:matrix`, sensitivity check, the pivot told as evidence-driven |
| `chapters/ch07-architecture.tex` | `fig:t2`, data flow, adaptive-red logic in 4 rules, clearance-only countdown + privacy by design, innovation |
| `chapters/ch08-workplan.tex` | `fig:t3`, `fig:gantt`, milestones M1–M3 (matching the Gantt that the visuals agent drew), Table `tab:raci` generated from `data/wbs.csv` |
| `chapters/ch09-risks.tex` | **eq:risk**, Table `tab:risks` generated from `data/risks.csv`, `fig:g4` (caption: "הערכות הצוות"), mitigation + contingency for R1, R2, R3, R5 |
| `chapters/ch10-summary.tex` | findings and readiness, next steps (no new facts) |
| `chapters/front-abstract.tex` | Hebrew abstract (~255 words) + keywords; English abstract (~180 words) in `otherlanguage{english}` |
| `chapters/front-abbreviations.tex` | table (not a float): acronyms + ID prefixes, in alphabetical order |
| `chapters/ch01-intro.tex` | one cross-reference only: `פרק \num{6} מציג` → `פרק~\ref{chap:alternatives} מציג` |

Labels added: `chap:problem`, `chap:requirements`, `chap:market`, `chap:alternatives`, `chap:architecture`, `chap:workplan`, `chap:risks`.
New citations used: `zhu2021`, `guo2011`, `vanhouten2007`, `shah2024`, `xing2022`, `lipovac2013jte` (abstract-level wording only; "display interval not stated"), `fhwa2008stm`, `tfl2015kerbside`, `agd2024agd645`, `current2023gtx`, `trl2006ppr087`.
Still uncited: `lenne2007`, `pele2019` (minor).

## Pages (build/writer/main.pdf, 44 pages total)
| Part | Pages |
|---|---|
| Front matter: cover, abstract (2: the English abstract does not fit under the band), TOC, LOF, LOT, abbreviations | 10 |
| ch1 | 3 (1–3) |
| ch2 | 3 (4–6) |
| ch3 | 3 (7–9) |
| ch4 | 7 (10–16) |
| ch5 | 2 (17–18) |
| ch6 | 2 (19–20) |
| ch7 | 2 (21–22) |
| ch8 | 4 (23–26): the Gantt and the RACI table are each just over ½ page, so each takes its own float page |
| ch9 | 3 (27–29) |
| ch10 | 1 (30) |
| References | 4 (31–34) |

**The ≤ 32-page target is not reachable from chapter text alone.** Every chapter starts on a new page with a ~⅓-page band, and the fixed parts (front matter 10, ch4 7, references 4, ch1 3) already take 24 pages.
Options for the Leader:
(a) Raise the AC-01 ceiling to ≈ 44. Body = 34 ≥ 25, so AC-02 holds either way.
(b) In the `.cls`: shorter chapter band and LOF + LOT on one page (could save ~3–5 pages).
(c) Move T1 from ch2 to ch7, and/or reduce the RACI table to WP level (saves ~1–2 pages).

## QA line
Build: 0 errors, 0 undefined refs, 0 overfull boxes, 0 LaTeX warnings.
`qa.py super --pdf build/writer/main.pdf`: **0 blocker, 31 major, ~35 minor**. None of the majors are text defects:
- 1 × AC-01 page count (see above).
- 30 × qa-BiDi lint false positives: `SAFE_CMDS` in `scripts/qa.py` lacks `inputfigure|includefigure|addcontentsline`, so the figure paths (e.g. `figures/tikz/t4-social-loop`) are flagged as English/numbers. The prompt requires these template commands.
  **Fix:** add the three names to `SAFE_CMDS` (qa.py line 136).
- Minor: underfull boxes in narrow `X` table columns (justified text).

## Defects seen in the render that need the `.cls` (not a Writer file)
1. **Header row offset in `tabularx` X columns**: `\thead` in an `X` (p) column sits about one line lower than in `l`/`c` columns (Tables 2.1, 3.1, 5.1, 8.1).
   Cause: `\color` at the start of a p-cell. **Fix:** `\newcommand\thead[1]{\leavevmode{\sffamily\bfseries\color{Asphalt}#1}}`.
2. **Ragged X columns**: justified narrow cells leave large word gaps (REQ table). Suggest a ragged column type in the `.cls` (e.g. redefine `\tabularxcolumn` with `\raggedleft` for RTL).
3. **Abstract page number**: the first front-matter page prints "1" (and the TOC lists תקציר at "1"), but the next page prints "ב". `\FrontMatter` is called after `\makecover`, but the abstract's page is numbered before the letters counter takes effect. Check `\FrontMatter` / `\inputfront` order in `main.tex`.

## Numbers the Leader may want in `data/quoted_in_book.json`
- Decision-matrix scores: 2.40 / 3.80 / 3.30.
- Sensitivity check: 3.68 vs 3.36 (effect + gap weight 0.20, rest scaled), 3.83 vs 3.50 (equal weights).
  These are computed from Table 6.1. No script exists yet; a one-line computation could go into `recompute_table2.py` or a new script.
- Risk R values = P × I come from `data/risks.csv`.

## Open questions
- GOAL / REQ target values (25% reduction, 90% counting, 2 s error, 30% max shortening, 5% delay, 99% availability, 60% awareness) are **team targets** and are labelled so in the captions. Please confirm.
- Safe limits are taken from US documents (MUTCD 11th ed., FHWA STM 2008). The Israeli standard is listed as WP1 task 1.2 and as a gap in ch10, not cited.
- `lipovac2013jte`: per the note, the interval of the countdown is unclear, so the text says so explicitly.
- The ch8 title is now "תוכנית עבודה: פירוק, אחריות וגאנט", without WBS/RACI: `\en{}` in a chapter title raised hyperref bookmark warnings. Restore it with `\texorpdfstring` if preferred (qa lint would then need `texorpdfstring` in `SAFE_CMDS`).
