# Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report

**חוצים באדום – מעבר חצייה חכם: אדום אדפטיבי, ספירה לאחור בזמן הפינוי ושליטה חברתית (דוח מכין)**

![Project status: complete](https://img.shields.io/badge/Project%20status-complete-brightgreen)
![Pages](https://img.shields.io/badge/PDF-45%20pages-2E3338)
![Build](https://img.shields.io/badge/LuaLaTeX%20%2B%20biber-0%20errors%20%C2%B7%200%20warnings-00843D)
![QA](https://img.shields.io/badge/QA%20super-0%20blocker%20%C2%B7%200%20major-00843D)
![Tests](https://img.shields.io/badge/QA%20regression%20tests-41%20passing-00843D)

| | |
|---|---|
| **Course** | Generative AI: LLMs, Agents and Multi-Agent Systems – Dr. Yoram Segal, Bar-Ilan University |
| **Assignment** | 02 – Hebrew PDF book in LaTeX, produced by a team of AI agents |
| **Group code** | `shirloma` |
| **Final PDF** | [`build/main.pdf`](build/main.pdf) – 45 pages (10 front matter + 35 body), Hebrew RTL |

---

## Overview

A professional Hebrew **preparatory report** (דוח מכין) for a technology-management project: a **smart pedestrian crossing**.
The report follows the course booklet's structure. It covers the problem and its numbers, requirements, the literature and the flagship paper,
the market, alternatives with a weighted decision matrix, architecture, the work plan (WBS, RACI, Gantt), risks and a summary.

**Flagship paper:** T. Rosenbloom, "Crossing at a red light: Behaviour of individuals and groups", *Transportation Research Part F* 12(5), 2009.
It shows that a pedestrian waiting **alone** crosses on red more often, and that each additional person waiting lowers the odds.

**Final concept** (PRD §1):
1. **Adaptive red:** curb-side sensing counts waiting pedestrians and their waiting time. Giving priority to a lone pedestrian, the controller shortens the pedestrian red within safe limits.
2. **A countdown only during the clearance interval,** as the US MUTCD §4I.04 requires.
3. **A social-control campaign** that presents waiting as the norm.

**An evidence-driven pivot.** The project started from a countdown showing the time left on red. The research round showed that the standard
allows countdowns only during clearance, and that a red-phase countdown was linked to earlier starts among children (Fu & Zou, 2016).
The concept therefore changed: the red-phase countdown is kept as **Alternative 1** in chapter 6 and rejected in the decision matrix
(PRD §13, decision log).

**What is in the book:** 10 chapters, 8 tables, 10 figures (4 Python graphs, 5 TikZ diagrams, the authors' photograph), 4 numbered equations, 29 sources.
Each of the 29 sources was **verified online** ([`references/VERIFICATION.md`](references/VERIFICATION.md)).

**Critical reading of the flagship paper.** The tables were transcribed and checked against the rendered page, then every value was recomputed
(`scripts/recompute_table2.py`). This found **seven data issues (D1–D7)**, discussed in chapter 4. Examples: printed odds ratios that do not match
the coefficients; a self-contradictory traffic-volume row; an age χ² that cannot be reproduced.

## Agent Team

The book was produced by a **Leader** (the main Claude Code session) and specialised agents. They ran **in parallel in separate Terminal sessions**
(PLAN §11) over four rounds.

| Agent | Role | Model |
|---|---|---|
| Leader (main session) | Plans (PRD/PLAN/TODO), designs the `.cls`, merges each round, runs QA, fixes, commits | Claude Opus 5.5 |
| **Writer** | Hebrew chapters in the defined voice (street-scene opener, then formal third person); paraphrase + cite | main model (Opus 5.5) |
| **Researcher / Visuals** | Finds and verifies sources online, transcribes data; Python graphs and TikZ diagrams | Sonnet 5.5 |
| **Fixer** | Own skill ([`skills/fixer`](skills/fixer/SKILL.md)): takes a Detector report, changes sources only, gives every finding a status (FIXED / REJECTED / DEFERRED) in `<round>-fixer-report.md`; never verifies its own work | Main model |
| **QA red team** | Detector only: finds what a reader would see (layout, BiDi, numbers, contradictions, close translation) | Sonnet 5.5 |
| **Detector re-check** | A fresh Sonnet subagent re-inspects only the findings the Fixer marked FIXED and returns a text report; a finding is closed only when it confirms it (the Leader and the Fixer never verify their own fixes) | Sonnet 5.5 |

The agents ran on different models according to their task. The Writer used the main model because the Hebrew prose needs it;
Visuals and the QA red team used Sonnet. The rules for parallel agents are in `CLAUDE.md` rule 1a: they don't edit the prompt log, they don't commit,
and each writes only its assigned files plus a report.

| Round | Writer | Researcher / Visuals | QA red team |
|---|---|---|---|
| 1 | ch. 4 – flagship paper | 15 verified sources | 38 findings + 10 weakest points of the plan |
| 2 | ch. 1 + ch. 4 thematic review, literature matrix, Table 2 | 13 sources, statistics inventory, evidence per component | 37 findings on ch. 4 |
| Final | ch. 2, 3, 5–10, abstracts, abbreviations, plan + risk data | T2–T5, G4 | reader-visible defects (interim pass, 16 pages) |
| final2 | – | – | all 45 pages: 17 findings (RT-01…RT-17) → Fixer (status for every finding) → Detector re-check (two passes) |

All agent prompts, reports and the Leader's responses are in [`prompts/agents/`](prompts/agents/). The QA skills and the production skills are in [`skills/`](skills/).

### Skills used

| QA skills (Detectors) | Production skills |
|---|---|
| `qa-super` (orchestrator), `qa-BiDi`, `qa-table`, `qa-code`, `qa-img`, `qa-typeset`, `qa-infra`, `qa-cls-version` | `writer`, `researcher`, `python-graphs`, `tikz-illustrations`, **`fixer`** (the Fixer of the Detector → Fixer loop) |

The checks are implemented in [`scripts/qa.py`](scripts/qa.py), with regression fixtures and 41 regression tests in [`tests/qa/`](tests/qa/) (`tests/qa/run_tests.py`).
**Fixes never touch the output.** Every fix goes into a source (a chapter, the `.cls`, a script or a skill), and recurring defects are fixed in the `.cls`.

### A real red-team example: INC-000

The initial brief claimed that some Table 2 coefficients in the flagship paper were "positive while e^b < 1". The committee checked this against the
**rendered** page and found that the minus signs were printed correctly. PDF text extraction had turned them into `/C0`, so the claim was an
artefact of text extraction. The brief was corrected, the real inconsistencies (D1–D7) were recomputed, and a rule was added: every transcribed number
is checked against a rendered image of the source page.
The full incident log ([`INCIDENTS.md`](INCIDENTS.md)) has 9 incidents (INC-000…INC-008) and 22 design-inspection findings, including:
- the Hebrew fonts lack digits (INC-001);
- matplotlib reversed Hebrew twice (INC-002);
- QA checks that could pass while the defect was present (INC-004).

## Repository Structure

```
.
├── CLAUDE.md                # standing rules for every session (incl. 1a: parallel agents)
├── README.md  PRD.md  PLAN.md  TODO.md  INCIDENTS.md
├── main.tex                 # master file: cover, front matter, \inputchapter{1..10}, references
├── smartcross.cls           # the document class – ALL formatting (v1.7)
├── hebrew.lbx               # biblatex Hebrew module (English bibliography strings)
├── chapters/                # ch01 … ch10, front-abstract, front-abbreviations
├── figures/                 # Python graphs (PDF), figures/tikz/*.tex, authors' photo
├── data/                    # transcribed tables, recomputed values, number register, WBS and risk data
├── scripts/                 # build.sh, qa.py, render_pages.js, figure scripts, recompute_table2.py
├── fonts/                   # bundled OFL Noto fonts + licences
├── references/              # refs.bib, VERIFICATION.md, notes/ (copyrighted PDFs kept local only)
├── skills/                  # 8 QA skills + 5 production skills (SKILL.md each)
├── prompts/                 # PROMPTS_LOG.md (every prompt, verbatim) + agents/ (round prompts and reports)
├── samples/                 # design samples
├── screenshots/             # book pages, figures, design history, agents at work
├── tests/qa/                # QA regression fixtures
└── build/                   # build output; build/main.pdf is tracked
```

## How to Build

**Toolchain.** The assignment brief names MiKTeX, but MiKTeX for macOS is frozen at version 22.1. Its LuaHBTeX 1.14 engine can't compile
current Hebrew `babel`. The project therefore uses **TeX Live 2026 (MacTeX)** with the same LuaLaTeX + biber toolchain: LuaHBTeX 1.24.0,
biber 2.21 and babel v26.4. It also needs Python 3.13 (`.venv`, see `requirements.txt`) and the bundled OFL Noto fonts in `fonts/`.

```bash
python3 -m venv .venv && .venv/bin/pip install -r requirements.txt
scripts/build.sh                      # figures → lualatex → biber → lualatex ×2 (+1 if refs moved) → build/main.pdf
.venv/bin/python scripts/qa.py super  # QA report (0 blocker, 0 major on the final build)
```

`build.sh` puts `/Library/TeX/texbin` first on `PATH` and stops if `lualatex` isn't TeX Live 2026. The manual sequence is
`lualatex main.tex` → `biber main` → `lualatex main.tex` → `lualatex main.tex`, run from the repository root.

## Screenshots

### The book

| | | |
|---|---|---|
| ![Cover](screenshots/book/13-cover-v1.0.png) | ![Abstract](screenshots/book/02-abstract.png) | ![Contents](screenshots/book/03-contents.png) |
| Cover – aerial view of the crosswalk, clearance countdown | Hebrew abstract | Table of contents |
| ![Chapter 1](screenshots/book/04-ch01-opener.png) | ![Chapter 2](screenshots/book/05-ch02-problem-figures.png) | ![Literature matrix](screenshots/book/06-ch04-literature-matrix.png) |
| Chapter opener (red phase) | Problem chapter: SMART goals, T1 | Chapter 4: literature matrix |
| ![Critical analysis](screenshots/book/07-ch04-critical-analysis.png) | ![Decision matrix](screenshots/book/08-ch06-decision-matrix.png) | ![Architecture](screenshots/book/09-ch07-architecture.png) |
| Chapter 4: data issues D1–D7 | Chapter 6: weighted decision matrix | Chapter 7: architecture (T2) |
| ![Gantt](screenshots/book/10-ch08-gantt.png) | ![Risk map](screenshots/book/11-ch09-risk-map.png) | ![References](screenshots/book/12-references.png) |
| Chapter 8: Gantt chart | Chapter 9: risk register + heat-map | IEEE references |

### Python graphs (generated by `scripts/make_figures.py`)

| G1 – crossing rate by gender (95% Wilson CI) | G2 – odds ratios: printed vs derived |
|---|---|
| ![G1](screenshots/figures/g1-crossing-by-gender.png) | ![G2](screenshots/figures/g2-odds-ratios.png) |
| **G3 – relative odds vs people waiting** | **G4 – risk heat-map (team estimates)** |
| ![G3](screenshots/figures/g3-relative-odds.png) | ![G4](screenshots/figures/g4-risk-heatmap.png) |

### TikZ diagrams (drawn in code, no external images)

| T1 – the smart crossing in plan view | T2 – system architecture |
|---|---|
| ![T1](screenshots/figures/t1-crosswalk-zones.png) | ![T2](screenshots/figures/t2-architecture.png) |
| **T4 – the social-control loop** | **T3 – work breakdown structure** |
| ![T4](screenshots/figures/t4-social-loop.png) | ![T3](screenshots/figures/t3-wbs.png) |

![T5 – Gantt chart](screenshots/figures/t5-gantt.png)

### The agent team at work (parallel sessions)

| Round 1 – Writer, Researcher and QA red team in parallel | |
|---|---|
| ![Round 1](screenshots/agents/round1-parallel-agents-1.png) | ![Round 1](screenshots/agents/round1-parallel-agents-2.png) |
| ![Round 1](screenshots/agents/round1-parallel-agents-3.png) | ![Round 1](screenshots/agents/round1-parallel-agents-4.png) |
| ![Round 1](screenshots/agents/round1-parallel-agents-5.png) | ![Round 2](screenshots/agents/round2-parallel-agents.png) |
| **Final round – QA red team (Sonnet) while the Writer works** | |
| ![Final round](screenshots/agents/final-round-parallel-agents.png) | |
| *Round final2 ran in separate terminal sessions; its prompts and reports are in `prompts/agents/final2-*.md`.* | |

### Design history

The design went through four stages:
1. **v0.1**: the first sample, [`screenshots/style-sample/`](screenshots/style-sample/).
2. **Two premium directions** sampled side by side:
   - A, editorial: [`style-sample-A/`](screenshots/style-sample-A/);
   - B, engineering: [`style-sample-B/`](screenshots/style-sample-B/).
3. **The final mix**, [`style-final/`](screenshots/style-final/): A's layout with B's side-bar boxes and booktabs tables.

## Prompt Engineering Log

Every prompt given in this project is logged verbatim, in order, in [prompts/PROMPTS_LOG.md](prompts/PROMPTS_LOG.md).
The agents' round prompts are in [prompts/agents/](prompts/agents/).

## Credits

- **Group `shirloma`.** Course: Generative AI – LLMs, Agents and Multi-Agent Systems, Dr. Yoram Segal, Bar-Ilan University (2026).
- **Produced with Claude Code:** a Leader session and parallel agents (Writer, Researcher/Visuals, QA red team).
- **Flagship paper:** Rosenbloom (2009), cited and paraphrased; copyrighted references are not included in this repository.
- **Fonts:** Noto Serif/Sans Hebrew, Noto Serif/Sans, Noto Sans Mono – SIL Open Font License (`fonts/*/OFL.txt`).
- **Images:**
  - all illustrations are drawn with TikZ or generated with Python;
  - the only photograph (Figure 7.2) was taken by the authors;
  - no images come from the internet.

---

## תקציר העבודה

עבודה זו מציגה פרויקט בניהול טכנולוגיה לתכנון **מעבר חצייה חכם**, שמטרתו להפחית חצייה באדום במעברי חצייה מרומזרים. הספר נכתב בעברית (10 פרקים, 45 עמודים ב[קובץ הספר המלא](build/main.pdf)) במסגרת הקורס בינה מלאכותית יוצרת: מודלי שפה גדולים, סוכנים ומערכות מרובות סוכנים באוניברסיטת בר-אילן.

### רקע, בעיה וממצאי מאמר הדגל
* **תמונת המצב:** בעולם נהרגים מדי שנה כ-1.19 מיליון בני אדם בתאונות דרכים לפי נתוני ארגון הבריאות העולמי, ובישראל דווחו בשנת 2021 כ-364 הרוגים, מהם כ-27% הולכי רגל (כ-98 בשנה).
* **מאמר הדגל (רוזנבלום, 2009):** בתצפית על 1,392 הולכי רגל בתל אביב נמצא כי 13.5% ממי שהגיעו במופע האדום חצו באדום. הולך רגל שעמד **לבדו** על המדרכה חצה באדום יותר מהולך שעמד עם אחרים, וכל ממתין נוסף הקטין את הסיכוי להפרה (מנגנון של שליטה חברתית). בשילוב ממצאים שלפיהם הנטייה להפר עולה ככל שההמתנה מתארכת, הוגדרה הבעיה כצירוף של **הולך יחיד והמתנה ארוכה**.
* **בדיקה ביקורתית של הנתונים:** חישוב מחדש של טבלאות המאמר חשף שבע סוגיות בנתונים, ובהן אי-התאמות בין מקדמים ליחסי סיכויים ושורה לא עקבית במודל. כיוון הממצא המרכזי נשמר, אך גודל האפקט שונה מן המודפס.

### שינוי כיוון מבוסס ראיות והפתרון המוצע
הרעיון הראשוני — הצגת ספירה לאחור של הזמן שנותר באדום — נדחה כיוון שתקן התעבורה האמריקני מתיר ספירה לאחור רק במופע הפינוי, ומחקר ליד בתי ספר (פו וזואו, 2016) מצא קשר בין ספירה באדום לעלייה בהפרות וביציאות מוקדמות של ילדים. הפתרון שנבחר במטריצת ההחלטה המשוקללת משלב שלושה רכיבים:
1. **אדום מסתגל:** חישה בשפת המדרכה הסופרת ממתינים ומודדת את זמן המתנתם, ומקצרת את מופע האדום בגבולות בטוחים — בעדיפות להולך יחיד.
2. **ספירה לאחור במופע הפינוי בלבד:** הצגת הספירה רק בזמן שהאות להולכי הרגל מהבהב, ללא ספירה בזמן האדום.
3. **קמפיין שליטה חברתית:** הצגת ההמתנה על המדרכה כנורמה באתר ובאמצעי התקשורת.

### מבנה הספר, מוכנות וצעדים הבאים
* **תכולת הספר (פרקים 1–10):** מבוא ורקע (פרק 1), הגדרת בעיה, שאלת מחקר ויעדי תכן (פרק 2), מפרט דרישות מדיד כולל גבולות בטוחים ואיסור שמירת תמונות (פרק 3), סקירת ספרות וניתוח ביקורתי (פרק 4), חקר שוק של מוצרי מדף (פרק 5), השוואת שלוש חלופות במטריצת החלטה (פרק 6), ארכיטקטורה עם פרטיות כבר בתכנון (פרק 7), תוכנית עבודה ל-12 חודשים עם 5 חבילות עבודה, מטריצת אחריות ותרשים גאנט (פרק 8), ניתוח סיכונים ותוכניות הפחתה (פרק 9) וסיכום (פרק 10).
* **מוכנות והמשך הדרך:** הרכיבים הטכניים זמינים כמוצרי מדף, והפער העיקרי הוא רגולטורי — קבלת היתר לקיצור האדום והתאמת הגבולות הבטוחים לתקן הישראלי. ארבעת צעדי הפתיחה הם: פנייה לעירייה לבחירת אתר והליך אישור; מיפוי התקן הישראלי וקביעת גבולות בטוחים; בדיקת מעבדה של שני גלאים לפחות לדיוק ולפרטיות; ותכנון מדידת הבסיס לניסוי לפני ואחרי.

