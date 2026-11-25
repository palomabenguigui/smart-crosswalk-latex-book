# PRD – Product Requirements Document

**Project:** Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report
**Hebrew title:** חוצים באדום – מעבר חצייה חכם: דוח מכין
**Group:** `shirloma` · **Course:** Generative AI: LLMs, Agents and Multi-Agent Systems – Dr. Yoram Segal, Bar-Ilan University
**Version:** 1.4 (2026-11-24) · **Status:** **approved by the user** (incl. the INC-000 correction in §9) · v1.4 (Step 15): final concept = adaptive red + clearance-only countdown + campaign (§1 pivot) · v1.1 adds §12 Writing style, AC-19, AC-20 and the Researcher verification rule (§11) · no book content written yet

Sources this PRD is built on (all in `references/`, kept locally): the Assignment 02 brief, the booklet *From Problem to PDF*
(Part A: report content, Part B: production), the L04 multi-agent guide, and the flagship paper (Rosenbloom, 2009).

---

## 1. Goal

Produce a **professional Hebrew (RTL) PDF book**, compiled with **LuaLaTeX + biber** and a **custom `.cls`**, written as a
*preparatory report* (דוח מכין) for a technology-management project: a **Smart Pedestrian Crossing** that combines
(**final concept, Step 15**):

1. **Adaptive red (core):** curb-side sensing detects pedestrians waiting at the curb – their number and waiting time, with
   priority for **a lone pedestrian** – and the controller **shortens the pedestrian red phase within safe limits**
   (vehicle minimum green, cycle bounds, coordination constraints; exact limits are requirements in ch. 3).
2. **Standard-compliant countdown:** a pedestrian countdown **only during the clearance interval** (flashing DON'T WALK / flashing
   green), as required by the US MUTCD 11th ed. §4I.04 [`fhwa2025mutcd`]. **No countdown during red.**
3. **Social-control campaign:** an awareness campaign (on-site display + media) that presents waiting at the curb as the norm.

**Motivation, from the flagship paper [`rosenbloom2009`]:**
- Pedestrians **alone** at the curb cross on red more than pedestrians standing with others; each additional person waiting lowers the odds.
- Men cross on red more than women.
- The paper recommends **shortening the red-light duration at certain times of the day** and campaigns based on the positive value of social control (§4.5); it also suggests signals that show the remaining time (§4.2).
- Its stated limitations motivate the sensing component: dichotomous data, no waiting-time measurement, a single site, and a call for video or technology-based timing (§4.4).

**Evidence-driven design pivot (Step 15 – must be presented explicitly in the book, ch. 1, 4, 6, 7, 9):**
the original concept (PRD v1.0–1.3) was a countdown showing the **time left on red**. The round-1 research showed that
(a) the MUTCD allows pedestrian countdowns only during the clearance interval [`fhwa2025mutcd`], and (b) a countdown during red
**increased early starts** among children [`fu2016`]; evidence on red-phase countdowns is mixed. The project therefore moved the
countdown to the clearance interval and uses sensing to act on the cause the flagship paper identified – the *lone, waiting*
pedestrian – by **shortening red** instead of displaying it. The red-phase countdown is kept as **Alternative 1** in ch. 6 and rejected
in the weighted decision matrix; **Alternative 2** = the final concept; **Alternative 3** = campaign only (no hardware).

The report must persuade an evaluation committee that:
- the problem is real and quantified;
- the solution is feasible and was chosen by a transparent comparison;
- the project can be managed (WBS, RACI, Gantt, risks).

The book is also a showcase of the **multi-agent production workflow** required by the brief.

## 2. Audience

| Reader | What they need |
|---|---|
| Course lecturer / grader | Every requirement in the brief and the booklet met and easy to verify |
| Technology-management evaluation committee | A quantified problem, a justified choice of solution, a feasible plan |
| Municipal traffic engineer (persona) | A credible, standards-aware system concept with costs and risks |
| Fellow students | A model of a well-built LaTeX/BiDi document |

## 3. The expert committee

The committee leader (orchestrator) convened six experts. Each stated the bar for a **top-grade (100) version**. Section 4
onwards merges these bars into a single specification. Where experts disagreed, the decision and its reason are recorded.

### 3.1 Academic Hebrew editor
- Third person only, formal and fact-based tone, no marketing language (booklet §11.2).
- The first Hebrew occurrence of every technical term carries the English term in parentheses.
- **Zero copied sentences** from any source. Every claim taken from a source is paraphrased and cited.
- Every figure and table is referenced in the text, and the text says what the reader learns from it (booklet §11.1).
- A consistent glossary of terms, for example "חצייה באדום" for red-light crossing and "שליטה חברתית" for social control, used the same way everywhere.

### 3.2 LaTeX / BiDi typesetter
- Zero compile errors, zero undefined references or citations, zero `Overfull \hbox` above 1 pt in the final log.
- Every visual rule lives in the `.cls`. Chapter files contain only content and template commands.
- Every English word, number, percentage, range, version and unit is marked LTR as one unit (booklet Prompt B1).
- Diagrams and code are built in an LTR environment; table column 1 is on the right.
- A **versioned `.cls`** (`\ProvidesClass{smartcross}[YYYY/MM/DD vX.Y ...]`) whose version is checked by `qa-cls-version`.

### 3.3 Data-visualization engineer
- Every number in a figure is traceable to a cited table, or to a script that computes it from cited data.
- One colour meaning throughout the book (booklet §16.6).
- **Never encode data by red-versus-green alone.** The traffic palette is a colour-blindness trap, so use lightness, patterns, direct labels and marker shape as well.
- Graphs must stay readable in greyscale print.
- Vector output (PDF), the book's Hebrew font inside the graphs, and no overlapping labels.

### 3.4 Road-safety researcher
- The flagship paper is analysed critically, not summarised. Reproduce its key statistics, flag its internal inconsistencies (§9) and state its limitations: one site, eight sessions in the same morning hour, estimated ages, groups not identified, observations not independent.
- Do not over-claim: the study is observational and correlational, and it does not show that countdown signals or campaigns *cause* compliance. Any claim about their effect must come from other, cited, peer-reviewed studies.
- Use Israeli context data only with a citation.

### 3.5 Technology project manager
- The structure follows the booklet's page map (scaled from about 40 to about 27 body pages).
- A SMART problem statement, measurable design goals and a requirements spec with ID, target value and verification method for every requirement ("a requirement without a test method is a wish").
- Two or three alternatives that are fundamentally different, compared in a weighted matrix with justified weights.
- A WBS of 5 work packages with RACI and a Gantt chart, plus a risk register using R = P × I with mitigation for every R ≥ 12.

### 3.6 QA / red-team lead
- Every QA skill reports **page number + exact text + rule broken**, never just "checked".
- Every bug a human finds that the skills missed opens an **incident** (PLAN.md §6). The skill or `.cls` is updated so the bug can't recur.
- A final red-team pass in a **fresh session** (booklet Prompt 9) finds the 10 weakest points. All of them are resolved or explicitly answered before submission.

### 3.7 Disagreements resolved by the leader

| Issue | Positions | Decision |
|---|---|---|
| Hebrew fonts | Use installed system fonts vs bundle fonts | **Bundle open-licensed (SIL OFL) Noto Hebrew fonts in `fonts/`**, loaded by path from the `.cls`. The build then works on any machine. Fallback: Times New Roman / Arial, which have Hebrew glyphs and are installed. |
| Graph text language | English labels (easy) vs Hebrew labels (consistent) | **Hebrew labels**, written in logical order with a leading RTL mark via `scripts/figstyle.py` `he()`; numbers and units LTR. **Not** `python-bidi`: with matplotlib ≥ 3.11 it reverses Hebrew twice (INC-002, amended in Step 14). The caption is always in LaTeX. |
| Absolute probability curves from Table 2 | Plot P(cross) vs number waiting | **Not possible**: the paper reports no intercept. Plot **relative odds** (OR^k) only, and say why. |
| Market graphs with prices | Include specific prices vs a qualitative map | **Only sourced numbers.** Unverifiable values are omitted or shown as a positioning map that is clearly labelled as qualitative. |
| Traffic-light palette vs accessibility | Pure red/green vs adjusted | Keep the identity. Data encoding always uses a second channel (lightness, pattern or label). |

## 4. Chapter structure and page allocation

**Target: 40–46 physical pages** (minimum 25, per the brief; raised from 28–32 by the user in Step 17 – full chapters, 10 chapter openers and the front matter need it).
- Front matter uses Hebrew-letter page numbers (א׳–ט׳ in the final book).
- The reference list is Arabic-numbered and counts as body. Planned body = 26 chapter pages + 1–2 reference pages = **27–28 ≥ 25** (the final book has 31 chapter pages + 4 reference pages = 35); each chapter opener costs about ⅓ page and is included in its chapter's budget. `qa-infra` reports the running page count after every round, so a short chapter is caught early.
- The body uses Arabic page numbers and must be **≥ 25 pages on its own**, so the minimum holds however pages are counted.
- The allocation follows the booklet's page map (Table 1.1), scaled down. The literature review and design alternatives keep the largest share, as the booklet advises.

| # | Part / chapter (Hebrew working title) | Pages | Core content | Mandatory elements |
|---|---|---:|---|---|
| — | Cover page (שער) | 1 | Bilingual title, "דוח מכין", group, course, lecturer, date, © line; **no page number** | TikZ cover art (crosswalk + signal) |
| — | Abstract + keywords (תקציר) | 1 | Hebrew abstract (≈ 250–350 words) + keywords; **short English abstract** | — |
| — | Table of contents | 1 | Auto-generated, 3 levels | — |
| — | Lists of figures and tables, abbreviations | 1–2 | Auto-generated lists; alphabetical abbreviation table | — |
| 1 | מבוא ורקע | 2 | Global pedestrian-safety context, Israeli context, motivation, report roadmap | ≥ 1 cited statistic |
| 2 | הגדרת הבעיה, שאלת המחקר והיעדים | 2 | Quantified problem (current vs desired), research question + hypotheses, SMART design goals | Problem in numbers |
| 3 | מפרט הדרישות | 2 | Functional / non-functional requirements and constraints, each with ID, target and verification method | Requirements table (`REQ-…`) |
| 4 | סקירת ספרות ומאמר הדגל | 6 | Thematic, critical review (social control, social learning, countdown signals, pedestrian sensing); literature matrix; **flagship paper analysis**: method, Table 1 and 2 data, logistic model, **critical analysis of the data issues (§9)**; knowledge gap | Literature-matrix table; Tables 1 & 2 re-typeset with citation; logistic-regression formula; ≥ 2 Python graphs |
| 5 | חקר שוק ומוצרים קיימים | 3 | Market in three layers; technical (not marketing) comparison of existing product classes (countdown heads, pedestrian detectors, audible/smart crossings) | Product-comparison table; positioning graph |
| 6 | חלופות תכן ומטריצת החלטה | 3 | Three alternatives: **A1 red-phase countdown** (rejected: MUTCD §4I.04, `fu2016`), **A2 adaptive red + clearance countdown + campaign** (chosen), **A3 campaign only**; weighted decision matrix with justified weights; the pivot told as an evidence-driven change | Formula S_j = Σ w_i c_ij; matrix table |
| 7 | ארכיטקטורת המערכת וחדשנות | 2 | Block diagram (curb sensing → adaptive-red logic in the controller (safe limits) → signal heads with clearance-only countdown → campaign/data layer), data flow, privacy by design, innovation | **TikZ architecture diagram**; TikZ crosswalk scene with sensing zones |
| 8 | תוכנית עבודה: WBS, RACI, גאנט | 3 | 5 work packages, RACI matrix, Gantt with milestones | TikZ WBS tree; RACI table; Gantt (pgfgantt) |
| 9 | ניתוח סיכונים ותוכנית הפחתה | 2 | Risk register with R = P × I, mitigation + contingency for R ≥ 12, residual risk | Risk table; risk heat-map (Python) |
| 10 | סיכום | 1 | Findings, readiness, immediate next steps | — |
| — | מקורות (IEEE) | 1–2 | biblatex `style=ieee`, auto-generated | ≥ 12 sources |
| | **Total** | **≈ 30–32** | front ≈ 4–5 + body ≈ 26–27 | |

## 5. Mandatory elements

| Element | Requirement | Planned instances |
|---|---|---|
| Table of contents | Auto-generated, 3 levels, Hebrew numbering correct | `\tableofcontents` |
| List of figures / tables | Auto-generated | `\listoffigures`, `\listoftables` |
| Abstract | Hebrew + keywords; English abstract (excellence) | Front matter |
| Abbreviations list | Alphabetical, every acronym used | Front matter |
| **Python graphs (≥ 1)** | Vector PDF, generated by scripts in `scripts/`; data from cited tables, **except G4**, whose P/I values are the team's own estimates from the risk register (the caption says so) | **G1** red-light crossing rate among red-phase arrivals by gender (from Table 1); **G2** forest plot of odds ratios, *reported vs recomputed* (Table 2, §9); **G3** relative odds of crossing vs number of people waiting (reported vs recomputed OR); **G4** risk heat-map |
| **Tables (≥ 1)** | Booktabs style from the `.cls`, column 1 on the right | Tables 1 & 2 re-typeset ("adapted from [n]"), literature matrix, requirements, product comparison, decision matrix, RACI, risk register, abbreviations |
| **Formulas (≥ 1)** | Numbered and referenced in the text | Logistic model logit(p) = β₀ + Σ βᵢxᵢ; OR = e^β; Wald = (b/SE)²; 95% CI = e^(b ± 1.96·SE); S_j = Σ wᵢcᵢⱼ; R = P × I |
| **TikZ illustrations (≥ 1)** | Drawn in code, no external images | **T1** crosswalk scene with curb-sensing zones, adaptive-red controller and clearance countdown head; **T2** system architecture; **T3** WBS tree; **T4** social-control feedback loop; chapter-opener road signs; cover art |
| Bibliography | IEEE, biber, two-way match between citations and list | ≥ 12 sources, ≥ 8 peer-reviewed, each DOI/URL **verified online** (§11, AC-22) |
| **No copyrighted images** | Zero images from the internet or from the references | Only TikZ / Python output in `figures/`, plus **our own photographs** (see next row) |
| **Authors' own photograph** (allowed source) | A photo taken by the group itself (e.g. `figures/photo-crosswalk.jpg`), placed with `\authorphoto`, caption credits **"צילום: המחברים"** (Photo: the authors); no people identifiable without consent; no internet or stock photos | `\authorphoto[height]{file}{caption}{label}`; a placeholder frame is drawn until the file exists |

## 6. Design system (our own identity)

### 6.1 Colour tokens (defined once in the `.cls`)

| Token | Hex | Use | Rule |
|---|---|---|---|
| `Asphalt` | `#2E3338` | Banner, chapter-opener background, headings, body-text accents | Primary dark |
| `AsphaltLight` | `#5A6068` | Secondary text, grid lines | — |
| `SignalRed` | `#C8102E` | Warnings, "trap" boxes, critical risks | Text-safe on white (≈ 5.9:1) |
| `SignalAmber` | `#F2A900` | "Data issue / caution" boxes, highlights | **Fill only; never text on white** |
| `SignalGreen` | `#00843D` | Key findings and recommendations | Text-safe on white (≈ 4.9:1) |
| `StripeWhite` | `#F4F4F2` | Crosswalk stripes, box backgrounds | — |
| `Paper` | `#FFFFFF` | Page | — |
| `SignalAmberDark` | `#9A6B00` | Amber **lines and text** on light backgrounds (data links, hatch, outlines) | ≥ 4.5:1 on white |
| `AsphaltDeep` | `#1E2226` | Cover title band, scene box, unnumbered chapter bands | Primary dark, deeper |
| `HousingBlack` | black 88% | Signal-head housings (lamps, pictograms) | Illustration only |
| `Road`, `Curb`, `Concrete`, `ConcreteJoint` | `#353A40`, `#9298A0`, `#CFD2D5`, `#BCC0C4` | Road surface, curbs, sidewalks and paving joints in illustrations | Illustration only – never encode data |
| `Hairline` | `#C9CDD2` | Hairlines, table rules in light contexts, grids | — |

**Colour meaning (one meaning per colour, PRD §3.3):** red = violation / warning / the problem phase; amber = caution, data issues and the analysis phase; green = findings and the implementation phase; asphalt greys = neutral categories (e.g. gender in G1). Any fill that encodes meaning must reach ≥ 3:1 against its background **or** carry a pattern (hatch), so that it survives greyscale print (QA-01, QA-32).

### 6.2 Fonts
- **Hebrew serif (body):** Noto Serif Hebrew. **Hebrew sans (headings, boxes, graphs):** Noto Sans Hebrew.
- **Latin:** Noto Serif / Noto Sans, for matching metrics. **Mono:** Noto Sans Mono or DejaVu Sans Mono.
- All OFL-licensed and bundled in `fonts/` with their licence files.
- Body size 11 pt and line spread 1.15, on A4.

### 6.3 Final design (`smartcross.cls` v1.0, chosen in Step 13)

The final design is a **mix of the two directions sampled in Step 10**: the editorial layout of direction A, with the
side-bar boxes and booktabs tables of direction B. Reference renders: `screenshots/style-final/` (sample
`samples/style-final.tex`); design history: `screenshots/style-sample/` (v0.1), `-A/`, `-B/` (v0.2).

**Grid and typography**
- A4, text block 138 mm wide; right (start) margin 22 mm; **left (outer) margin 50 mm** carrying margin notes (31 mm column) and thumb tabs at the page edge.
- Body: Noto Serif Hebrew 11 pt, line spread 1.18, paragraphs separated by space (no indent).
- Headings: Noto Sans Hebrew Bold. Sections at 16.5 pt with the number in a filled asphalt chip; subsections at 12.5 pt with the number in the phase colour.
- English labels in letter-spaced capitals (`\enlabel`). English inside Hebrew is never hyphenated.

**From direction A (editorial)**
- **Cover** (`\makecover`): full-bleed TikZ aerial view of the crosswalk across the top two thirds (zebra, curbs, stop lines, a stopped car, two countdown signal heads showing "12", a waiting group and a lone pedestrian casting shadows, the amber curb-sensing zone). A solid deep-asphalt title band below has a red top edge, the "דוח מכין" road-sign plate, a 50 pt title, the subtitle, the English title in amber italic, a zebra rule and a three-column details row (institution, lecturer, group). No page number.
- **Chapter openers:** full-bleed asphalt band about 98 mm tall with subtle texture and a zebra bottom edge. It holds a 150 pt two-digit chapter number in the phase colour, a vertical 3-lamp signal with the phase lamp lit, an English label ("CHAPTER 01 · THE PROBLEM"), a Hebrew phase label with a pictogram, the title (27 pt, white) and the mission line under a short coloured rule. Then comes the dark `scenebox` (striped edges, red-man icon).
- **Stat tiles** (`statrow` / `\stattile`): dark asphalt tiles, big number in the signal colour, short white label.
- **Thumb tabs:** rounded tabs on the outer (left) edge with the chapter number: red at 112 mm (ch. 1–3), amber at 162 mm (ch. 4–7), green at 212 mm (ch. 8–10).
- **Running head:** English label on the left, Hebrew chapter title on the right with a phase-colour square. **Footer:** large bold page number with a mini zebra strip, plus "חוצים באדום · shirloma · © 2026".
- **Pull quote** with a red side bar; **margin notes** (`\sidenote`) with an info pictogram, ragged.

**From direction B (engineering)**
- **Callout boxes:** light background, **coloured side bar on the start (right) edge**, title in the box colour with a pictogram:

| Box | Colour / pictogram | Purpose |
|---|---|---|
| `scenebox` | deep asphalt, white text, striped edges, red-man icon (A style, part of the opener) | Chapter-opening street scene (max 4 lines, §12) |
| `findingbox` | SignalGreen · signal head | Key finding / recommendation |
| `cautionbox` | dark amber · warning triangle | Data issue, methodological caution |
| `trapbox` | SignalRed · pedestrian | Pitfall / warning |
| `definitionbox` | Asphalt · info | Definition, formula explanation |
| `projectbox` | AsphaltLight · sensor | "In the current project" |

- **Tables:** booktabs (0.9 pt top/bottom rules, 0.4 pt mid rule, asphalt), bold sans header row, column 1 on the right, caption above.

**Shared rules**
- `\crosswalkrule` closes a section; it is dropped when it would land alone at a page top.
- Float pages are top-aligned. Figures and photos are captioned below, tables above.
- `\authorphoto` frames the group's own photographs with a thin asphalt border; the caption ends with "צילום: המחברים".

### 6.4 Component reference

| Component | Command |
|---|---|
| Cover | `\makecover` (metadata: `\Title`, `\Subtitle`, `\EnglishTitle`, `\Institution`, `\Course`, `\Lecturer`, `\Authors`, `\DocDate`, `\GroupCode`, `\FooterTitle`) |
| Chapter opener | `\ChapterMission{…}` `\ChapterIcon{pedestrian\|signal\|sensor\|warning\|info\|camera}` `\chapter{…}` |
| Street scene | `\begin{scenebox} … \end{scenebox}` |
| Boxes | `findingbox`, `cautionbox`, `trapbox`, `definitionbox[title]`, `projectbox` |
| Key figures | `\begin{statrow}[n] \stattile[colour]{number}{label} … \end{statrow}` |
| Pull quote | `\begin{pullquote}[attribution] … \end{pullquote}` (our own sentences only) |
| Margin note | `\sidenote{…}` |
| Pictogram | `\picto[colour]{name}` |
| Tables | `\toprule` / `\headrow \thead{…} & …` / `\midrule` / `\bottomrule` |
| Author photo | `\authorphoto[height]{file}{caption}{label}` |
| BiDi | `\en`, `\num`, `\pct`, `\range`, `\unit`, `\hebmath`, `\enlabel`, `ltrblock` (§7) |
| Closing rule | `\crosswalkrule` |

## 7. BiDi rules (Hebrew / English mixing)

Based on booklet ch. 14 and Prompt B1. These apply everywhere: titles, captions, tables, header, footer and cover.

1. Main language Hebrew (`babel` + `\babelprovide[import, main, bidi=basic]{hebrew}` on LuaLaTeX). English is a secondary language.
2. Every English word, name and acronym is marked English through **template commands only** (for example `\en{...}`).
3. A multi-word English phrase is marked as **one unit**.
4. Every number, decimal, range, percentage, date, currency and version is **one LTR unit with its symbol or unit** (for example `\num{13.5\%}`, `\range{0.51}{0.78}`).
5. Never put Hebrew inside an English-marked unit.
6. Hebrew inside formulas uses the template's math-text command.
7. Diagrams, code boxes and graphs are built in an LTR environment. Box frames are LTR and their content is RTL.
8. In tables **column 1 is on the right**.
9. Citations (`\cite`) and cross-references (`\ref`) render with correct order, for example "[3]" and "איור 4.2", never "2.4".
10. Only template commands are used; agents never invent new formatting commands in chapter files.
11. Any BiDi defect that repeats across the document is fixed in the `.cls`. Only a one-off defect is fixed in its sentence (booklet §14.6).
12. A Hebrew prefix letter (ו, ה, ב, ל, מ, ש, כ) before a number or an English word is joined with a **maqaf**: `ו-\num{1,392}`, `ב-\en{LuaLaTeX}` (found in the Step 09 style sample).
13. Citations are always `\cite{…}`. The `.cls` sets them as one LTR English unit, so brackets never mirror. Never type brackets around a citation by hand.

## 8. Measurable acceptance criteria

| ID | Criterion | Threshold | Verified by |
|---|---|---|---|
| AC-01 | Total physical pages | 40–46 (Step 17) | `qa-infra` (page count of `build/main.pdf`) |
| AC-02 | Body pages (Arabic numbered) | ≥ 25 | `qa-infra` |
| AC-03 | Compile log | 0 errors, 0 undefined refs/cites, 0 overfull boxes > 1 pt | `qa-typeset` |
| AC-04 | Python graphs | ≥ 1 (target 4), each regenerated by `scripts/*.py` from versioned data | `qa-img`, `qa-code` |
| AC-05 | TikZ illustrations | ≥ 1 (target 4 + openers + cover) | `qa-img` |
| AC-06 | Tables | ≥ 1 (target ≥ 8), column 1 on the right, none beyond the margins | `qa-table` |
| AC-07 | Numbered formulas | ≥ 1 (target ≥ 5), each referenced in the text | `qa-typeset` |
| AC-08 | Figure/table references | 100% of figures and tables referenced in the text | `qa-super` |
| AC-09 | Bibliography | ≥ 12 entries, ≥ 8 peer-reviewed, 100% cited ↔ listed, 100% DOI/URL verified | Researcher + `qa-super` |
| AC-10 | BiDi | 0 reversed words, numbers or section numbers in a full-PDF audit (Prompt B2) | `qa-BiDi` |
| AC-11 | Copied text | (a) 0 sequences of ≥ 8 consecutive words matching the local sources (English inside `\en{}`, Hebrew vs the Hebrew booklet) – automatic; (b) **translation check** – the red team compares every paragraph that cites a source with the cited passage; a sentence-by-sentence translation of the source is a fail (cross-language copying cannot be caught by n-grams, QA-25) | `qa-super` (n-gram) + red team (manual, recorded in the round report) |
| AC-12 | External images | 0 raster images other than our scripts' output and the authors' own credited photographs (`\authorphoto`) | `qa-img`, `qa-infra` |
| AC-13 | `.cls` | Version string matches `PLAN.md`; no formatting commands defined in chapter files | `qa-cls-version` |
| AC-14 | Data traceability | Every number taken from the flagship paper matches the source; every recomputed number is reproduced by a script | `qa-code` + Researcher |
| AC-15 | Data issues | Every issue D1–D7 of §9 is (1) named (`\en{Dn}`) in a `cautionbox` in ch. 4, (2) shown with its numbers, and (3) followed by its consequence for the book's argument | `qa-super` (1, automatic) + red team (2–3) |
| AC-16 | Red team | 10 weakest points found in a fresh session; each point is closed either by a **resolution with evidence** (commit hash + where the change is) or by a **written answer accepted by the user**; open points block release | QA/red-team lead + user |
| AC-17 | Repository | `PRD.md`, `PLAN.md`, `TODO.md`, `README.md`, `.tex`, `.cls`, `.bib`, skills list, final PDF all committed | `qa-infra` |
| AC-18 | Reproducibility | A clean clone builds `build/main.pdf` with the documented command sequence | `qa-infra` |
| AC-19 | README screenshots | `README.md` embeds screenshots, all stored in `screenshots/`, of: (1) ≥ 3 book pages (cover, a chapter opener, a content page), (2) every Python graph, (3) every TikZ illustration, (4) the agent team in action; every image link resolves | `qa-infra` |
| AC-20 | Parallel agents | Evidence that **≥ 3 agents ran in parallel**: Writer, Researcher, QA red team. Evidence = screenshots in `screenshots/` showing them running at the same time, plus each agent's prompt saved verbatim in `prompts/agents/`, and the run recorded in `prompts/PROMPTS_LOG.md` | `qa-infra` + Leader |
| AC-21 | Chapter openers | Every chapter 1–10 opens with exactly one `scenebox` of ≤ 4 **rendered** lines (measured by TeX: `\prevgraf`, logged as `SCENE-LINES`), followed by formal third-person text (§12) | `qa-typeset` (rendered lines) + `qa-super` |
| AC-22 | Verified sources | 100% of `.bib` entries carry a verification record (DOI/URL opened, date, metadata match) in `references/VERIFICATION.md`; 0 unverified entries | `qa-super` + Researcher |

## 9. Known data issues in the flagship paper (must be discussed critically)

The committee checked Table 1 and Table 2 of Rosenbloom (2009) against the PDF and recomputed every value; the red team of round 1 found that the age χ² had been missed (now D7, Step 14).
The book must present these issues **critically and respectfully** in a `cautionbox` in chapter 4. Recomputation is done
by `scripts/` so the numbers in the book are reproducible.

> **Correction to the initial brief.** The brief said that "some b coefficients are positive while e^b < 1". That is **not
> the case in the published PDF**: the b values for *waiting*, *joining*, *traffic volume* and *other pedestrian crossing* are
> printed as **negative** (−0.47, −0.46, −0.03, −24.24). Text extraction dropped the minus glyph, which appears as `/C0`.
> The real inconsistencies are listed below. Lesson for the workflow: data is always verified against the rendered page, never
> against extracted text alone. This is recorded as incident INC-000 in `PLAN.md`.

### Issue D1 – the e^b column does not equal exp(b) for two predictors
| Predictor | b | SE | Reported e^b | exp(b) recomputed | Reported 95% CI | CI from b ± 1.96·SE |
|---|---:|---:|---:|---:|---|---|
| Gender (male) | 1.31 | 0.32 | 3.71 | **3.71** ✓ | 2.00–6.88 | 1.98–6.94 ✓ |
| No. waiting upon arrival | −0.47 | 0.11 | 0.71 | **0.63** ✗ | 0.51–0.78 | 0.50–0.78 ✓ |
| No. joining after arrival | −0.46 | 0.13 | 0.67 | **0.63** ✗ | 0.48–0.82 | 0.49–0.81 ✓ |

The confidence intervals agree with b and SE, but the reported e^b does not. The direction of the effect (each extra person
waiting lowers the odds of crossing on red) holds either way. Its size per person is about 37.5% lower odds for waiting, not 29% (joining: about 37%, not 33%).

### Issue D2 – the traffic-volume row is internally inconsistent
- With b = −0.03 and SE = 0.03, we get e^b = 0.97, Wald = 1.0 and a 95% CI of 0.92–1.03 (not significant).
- The paper reports **e^b = 2.20, CI 1.17–4.11 and Wald = 6.06**. These three agree with each other, but they imply **b ≈ +0.79, SE ≈ 0.32**.
- Wald 6.06 on 1 df gives p ≈ 0.014, and a CI that excludes 1 means the predictor would be **significant at α = 0.05**.
- That contradicts the results text, which says traffic volume did not significantly predict crossing.
- So either the b/SE columns or the e^b/CI/Wald columns are wrong. The book must say this cannot be resolved from the paper.

### Issue D3 – the hypotheses: the Results section contradicts the Discussion
- **Results (§3):** the findings are "in contrast of both hypotheses".
- **Discussion (§4.2):** the findings **support** Hypothesis 1 (more red-light crossing when alone than in a group).
- **Discussion (§4.3):** Hypothesis 2 was **not confirmed**.

The data (negative coefficients for people waiting and joining) agree with H1, so the Results sentence appears to be the error.
Section 4.3 also says that one person crossing on red "seems to encourage" others, then reports that observed pedestrians were *not*
encouraged. The book should point out this internal tension.

### Issue D4 – "other pedestrian crossing on red" is not interpretable
b = −24.24 with SE = 8184.53 (Wald 0.0, no e^b). This is the signature of **(quasi-)complete separation** in logistic
regression. The coefficient is meaningless, and H2 cannot be tested from this model at all.

### Issue D5 – minor reporting inconsistencies
- Table 1, Green/Green column: female 512 of 829 is **61.8%**, printed as 60.8% (the male 38.2% is correct, and the two column percentages add up to 99%).
- Age 20–40: 1314 of 1392 is 94.4%. The table prints 94.4% but the Methods section says 94.3%.
- **Verified correct:** 563 red-phase arrivals (40.4%), 76 red-light crossers (5.5% of all observations, 13.5% of red-phase arrivals), and the gender χ²(1, N = 563) = 17.17, which reproduces exactly from Table 1 (females 28/330 = 8.5%, males 48/233 = 20.6%).

### Issue D6 – methodological limitations (stated in the paper or implied by it)
- A single crosswalk in Tel Aviv, eight one-hour sessions all in the same morning hour (07:30–08:30) over six weeks, and age estimated by eye.
- Pre-formed groups could not be told apart from strangers who happened to be waiting together.
- Pedestrians in the same group are **not independent observations**, which the logistic model assumes.
- No intercept is reported, so absolute probabilities cannot be computed (see §3.7).
- The outcome is dichotomous, with no waiting-time measurement. The author proposes video or software timing, which is exactly the gap our sensing component addresses.

### Issue D7 – the printed age chi-square cannot be reproduced (found by the round-1 red team)
- The paper prints χ²(2, N = 1392) = 1.02 for age and drops age from the model on that basis.
- From Table 1: age × light phase (3×3) gives 2.95 with 4 df; crossed-on-red vs not × age gives 0.96 (df 2); red-phase arrivals only (N = 563) give 0.55 (df 2). None reproduces 1.02 with df 2 and N 1392.
- The 60+ group expects fewer than one red-light crosser (0.82), so the test is not valid there. The decision to drop age is probably right in direction but rests on a calculation that cannot be reproduced. Computed by `scripts/recompute_table2.py` (`age_chi2_variants`).

**Further candidates D8–D10** (round-2 Researcher inventory, `data/rosenbloom2009_text_stats.csv`): inconsistencies in
statistics printed in the paper's *text* (e.g. the traffic figures of §2.2, p. 390). Recorded in the data inventory; **not discussed in the
book** (scope decision, Step 16 – finish efficiently).

## 10. Out of scope

- Implementing, piloting or field-testing the system. This is a *preparatory* report.
- Collecting new field data. The book uses only published, cited data.
- Any image not produced by our own TikZ or Python code, **except** photographs taken by the group itself, placed with `\authorphoto` and credited "צילום: המחברים" (allowed image source, Step 10). Internet, stock and reference-paper images remain out of scope.

## 11. Constraints

- Hebrew RTL book; code, commands, file names and commit messages in English (`CLAUDE.md`).
- No text copied from sources: always paraphrase and cite (`CLAUDE.md`).
- Copyrighted references stay local (`references/README.md`, `.gitignore`).
- Toolchain: LuaLaTeX (LuaHBTeX) + biber on **TeX Live 2026 (MacTeX)**: LuaHBTeX 1.24.0, biber 2.21. The brief names MiKTeX, but MiKTeX for macOS is frozen at 22.1 (LuaHBTeX 1.14), which can't compile current Hebrew babel. The compile sequence (lualatex → biber → lualatex ×2) is unchanged (decision of Step 08).
- The Noto Hebrew fonts contain only Hebrew glyphs. Digits, Latin letters and punctuation in Hebrew text come from a luaotfload **fallback** to Noto Serif/Sans, defined in the `.cls` (INC-001).
- Every prompt is logged verbatim in `prompts/PROMPTS_LOG.md`.
- **Source verification (Researcher rule):** every bibliography entry must be **verified online**. The DOI or URL is actually opened, and the title, authors, year, venue and pages are checked against the landing page **or against the DOI registry record (Crossref/DataCite metadata deposited by the publisher, retrieved through doi.org)**; books against a library edition record (ISBN). The result is recorded in `references/VERIFICATION.md`. **Any source that can't be verified is dropped, never invented or "reconstructed".** If dropping sources takes the count below AC-09, the Researcher searches again rather than lowering the bar.
- **INC-000 is kept as a showcase:** the README presents it as a real red-team example (wrong claim in the brief → detected against the rendered page → corrected → detection rule added).

## 12. Writing style (authorial voice)

The Writer agent has one defined authorial voice with two registers, used in a fixed order in every chapter.

**1. Street-scene opener (narrative register)**
- Every chapter 1–10 opens with a short scene at a crosswalk, inside a `scenebox` (§6.3). It sits directly under the road-sign chapter opener.
- At most **4 rendered lines**. Present tense, concrete, sensory: the curb, the red figure, the people around, the seconds ticking.
- The scene illustrates the chapter's theme. Examples: a lone pedestrian on an empty street for the problem chapter, a crowded curb for social control, a countdown head for the architecture chapter.
- Scenes are **illustrative composites**. They name no real people, contain no statistics and make no factual claims; facts belong in the body, with citations. No first person.
- No dialogue longer than a few words. No humour at the expense of victims of road accidents.

**2. Body (formal academic register)**
- Straight after the box, the text switches to the **formal third-person register** required by the Hebrew editor (§3.1): fact-based, cited, no "we/I", no marketing language.
- The first body paragraph links the scene to the chapter's question in one sentence, then proceeds formally.

**Consistency rules**
- One voice across the book. The scenes follow a light thread (the same crosswalk at different times of day), but each scene stands on its own.
- Scenes don't count toward any chapter's content requirements; page allocation (§4) includes them.
- Checked by AC-21. The Hebrew editor's skill rejects scenes over 4 lines, scenes with facts or numbers, and any narrative tone in the body.

## 13. Decision log

| Date | Step | Decision | Evidence | Affects |
|---|---|---|---|---|
| 2026-11-19 | 06 | PRD approved incl. INC-000 correction | rendered page of the flagship paper | §9 |
| 2026-11-24 | 13 | Final design = A layout + B boxes/tables | style samples A/B | §6 |
| 2026-11-24 | 15 | **Pivot:** countdown only in the clearance interval; adaptive red as the core; red-phase countdown becomes rejected Alternative 1; campaign-only = Alternative 3 | `fhwa2025mutcd` §4I.04 (pp. 718–719), `fu2016`, `rosenbloom2009` §4.5 + lone-pedestrian finding | §1, §4 (ch. 1, 4, 6, 7, 9), §5 T1/T2, cover art |
