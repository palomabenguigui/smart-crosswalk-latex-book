# PRD – Product Requirements Document

**Project:** Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report
**Hebrew title:** חוצים באדום – מעבר חציה חכם: דוח מכין
**Group:** `shirloma` · **Course:** Generative AI: LLMs, Agents and Multi-Agent Systems – Dr. Yoram Segal, Bar-Ilan University
**Version:** 1.1 (2026-11-19) · **Status:** **approved by the user** (incl. the INC-000 correction in §9) · v1.1 adds §12 Writing style, AC-19, AC-20 and the Researcher verification rule (§11) · no book content written yet

Sources this PRD is built on (all in `references/`, kept locally): the Assignment 02 brief, the booklet *From Problem to PDF*
(Part A: report content, Part B: production), the L04 multi-agent guide, and the flagship paper (Rosenbloom, 2009).

---

## 1. Goal

Produce a **professional Hebrew (RTL) PDF book**, compiled with **LuaLaTeX + biber** and a **custom `.cls`**, written as a
*preparatory report* (דוח מכין) for a technology-management project: a **Smart Pedestrian Crossing** that combines:

1. **A countdown pedestrian signal** that shows the time left on red.
2. **Curb-side sensing** of pedestrians waiting at the curb (count and waiting time).
3. **A "social control" awareness campaign** that presents waiting at the curb as the norm.

**Motivation, from the flagship paper:**
- Pedestrians alone at the curb cross on red more than pedestrians standing with others.
- Men cross on red more than women.
- The paper itself recommends signals that show the remaining time (§4.2) and campaigns based on the positive value of social control (§4.5).
- Its stated limitations motivate the sensing component: dichotomous data, no waiting-time measurement, a single site, and a call for video or technology-based timing (§4.4).

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
- A consistent glossary of terms, for example "חציה באדום" for red-light crossing and "שליטה חברתית" for social control, used the same way everywhere.

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
- The flagship paper is analysed critically, not summarised. Reproduce its key statistics, flag its internal inconsistencies (§9) and state its limitations: one site, one morning hour, estimated ages, groups not identified, observations not independent.
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
| Graph text language | English labels (easy) vs Hebrew labels (consistent) | **Hebrew labels** via `python-bidi`, with numbers and units LTR. The caption is always in LaTeX. |
| Absolute probability curves from Table 2 | Plot P(cross) vs number waiting | **Not possible**: the paper reports no intercept. Plot **relative odds** (OR^k) only, and say why. |
| Market graphs with prices | Include specific prices vs a qualitative map | **Only sourced numbers.** Unverifiable values are omitted or shown as a positioning map that is clearly labelled as qualitative. |
| Traffic-light palette vs accessibility | Pure red/green vs adjusted | Keep the identity. Data encoding always uses a second channel (lightness, pattern or label). |

## 4. Chapter structure and page allocation

**Target: 28–32 physical pages** (minimum 25, per the brief).
- Front matter uses Hebrew-letter page numbers (א׳–ה׳).
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
| 6 | חלופות תכן ומטריצת החלטה | 3 | 2–3 fundamentally different alternatives; weighted decision matrix with justified weights; choice | Formula S_j = Σ w_i c_ij; matrix table |
| 7 | ארכיטקטורת המערכת וחדשנות | 2 | Block diagram (sensing → controller → countdown display → campaign/data layer), data flow, privacy by design, innovation | **TikZ architecture diagram**; TikZ crosswalk scene with sensing zones |
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
| **Python graphs (≥ 1)** | Vector PDF, generated by scripts in `scripts/`, data from cited tables | **G1** red-light crossing rate among red-phase arrivals by gender (from Table 1); **G2** forest plot of odds ratios, *reported vs recomputed* (Table 2, §9); **G3** relative odds of crossing vs number of people waiting (reported vs recomputed OR); **G4** risk heat-map |
| **Tables (≥ 1)** | Booktabs style from the `.cls`, column 1 on the right | Tables 1 & 2 re-typeset ("adapted from [n]"), literature matrix, requirements, product comparison, decision matrix, RACI, risk register, abbreviations |
| **Formulas (≥ 1)** | Numbered and referenced in the text | Logistic model logit(p) = β₀ + Σ βᵢxᵢ; OR = e^β; Wald = (b/SE)²; 95% CI = e^(b ± 1.96·SE); S_j = Σ wᵢcᵢⱼ; R = P × I |
| **TikZ illustrations (≥ 1)** | Drawn in code, no external images | **T1** crosswalk scene with curb-sensing zones and countdown head; **T2** system architecture; **T3** WBS tree; **T4** social-control feedback loop; chapter-opener road signs; cover art |
| Bibliography | IEEE, biber, two-way match between citations and list | ≥ 12 sources, ≥ 8 peer-reviewed, each DOI/URL **verified online** (§11, AC-22) |
| **No copyrighted images** | Zero raster images from the internet or from the references | Only TikZ / Python output in `figures/` |

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

### 6.2 Fonts
- **Hebrew serif (body):** Noto Serif Hebrew. **Hebrew sans (headings, boxes, graphs):** Noto Sans Hebrew.
- **Latin:** Noto Serif / Noto Sans, for matching metrics. **Mono:** Noto Sans Mono or DejaVu Sans Mono.
- All OFL-licensed and bundled in `fonts/` with their licence files.
- Body size 11 pt and line spread 1.15, on A4.

### 6.3 Page elements
- **Banner (header):** a thin asphalt strip with a crosswalk-stripe pattern, chapter title on the right (RTL) and group code on the left.
- **Footer:** page number (outer side), "© shirloma 2026 – חוצים באדום" and a thin crosswalk rule.
- **Chapter openers styled as road signs**, each drawn in TikZ:
  - The chapter number sits in a sign-shaped badge (a rounded square with a white border on asphalt).
  - A **3-lamp traffic-light progress indicator** shows where the reader is: red lamp for chapters 1–3 (the problem), amber for 4–7 (analysis and design), green for 8–10 (ready to implement).
  - The risk chapter uses a warning-triangle variant.
- **Crosswalk-stripe decorative rules** (`\crosswalkrule`): alternating asphalt/white bars under chapter titles and at chapter ends. Used sparingly, never between paragraphs.
- **Callout boxes** (`tcolorbox`, defined only in the `.cls`):

| Box | Colour | Purpose |
|---|---|---|
| `scenebox` | Asphalt fill, StripeWhite text, crosswalk-stripe edge, small pedestrian-signal icon | **Chapter-opening street scene** (max 4 lines, §12); placed directly under the chapter opener |
| `findingbox` | SignalGreen | Key finding / recommendation |
| `cautionbox` | SignalAmber (fill) + Asphalt text | Data issue, methodological caution |
| `trapbox` | SignalRed | Pitfall / warning |
| `definitionbox` | Asphalt | Definition, formula explanation |
| `projectbox` | AsphaltLight | "In our project" applying a principle |

- **Cover:** a double frame, TikZ crosswalk-and-signal art, bilingual title, subtitle "דוח מכין", authors, affiliation, date and © line. No page number, and no keywords on the cover.

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

## 8. Measurable acceptance criteria

| ID | Criterion | Threshold | Verified by |
|---|---|---|---|
| AC-01 | Total physical pages | 28–32 | `qa-infra` (page count of `build/main.pdf`) |
| AC-02 | Body pages (Arabic numbered) | ≥ 25 | `qa-infra` |
| AC-03 | Compile log | 0 errors, 0 undefined refs/cites, 0 overfull boxes > 1 pt | `qa-typeset` |
| AC-04 | Python graphs | ≥ 1 (target 4), each regenerated by `scripts/*.py` from versioned data | `qa-img`, `qa-code` |
| AC-05 | TikZ illustrations | ≥ 1 (target 4 + openers + cover) | `qa-img` |
| AC-06 | Tables | ≥ 1 (target ≥ 8), column 1 on the right, none beyond the margins | `qa-table` |
| AC-07 | Numbered formulas | ≥ 1 (target ≥ 5), each referenced in the text | `qa-typeset` |
| AC-08 | Figure/table references | 100% of figures and tables referenced in the text | `qa-super` |
| AC-09 | Bibliography | ≥ 12 entries, ≥ 8 peer-reviewed, 100% cited ↔ listed, 100% DOI/URL verified | Researcher + `qa-super` |
| AC-10 | BiDi | 0 reversed words, numbers or section numbers in a full-PDF audit (Prompt B2) | `qa-BiDi` |
| AC-11 | Copied text | 0 sentences of ≥ 8 consecutive words matching the source papers | `qa-super` (n-gram check) |
| AC-12 | External images | 0 raster images not produced by our scripts | `qa-img`, `qa-infra` |
| AC-13 | `.cls` | Version string matches `PLAN.md`; no formatting commands defined in chapter files | `qa-cls-version` |
| AC-14 | Data traceability | Every number taken from the flagship paper matches the source; every recomputed number is reproduced by a script | `qa-code` + Researcher |
| AC-15 | Data issues | All issues in §9 are discussed critically in ch. 4, in a `cautionbox` | `qa-super` |
| AC-16 | Red team | 10 weakest points found in a fresh session; each resolved or answered in writing | QA/red-team lead |
| AC-17 | Repository | `PRD.md`, `PLAN.md`, `TODO.md`, `README.md`, `.tex`, `.cls`, `.bib`, skills list, final PDF all committed | `qa-infra` |
| AC-18 | Reproducibility | A clean clone builds `build/main.pdf` with the documented command sequence | `qa-infra` |
| AC-19 | README screenshots | `README.md` embeds screenshots, all stored in `screenshots/`, of: (1) ≥ 3 book pages (cover, a chapter opener, a content page), (2) every Python graph, (3) every TikZ illustration, (4) the agent team in action; every image link resolves | `qa-infra` |
| AC-20 | Parallel agents | Evidence that **≥ 3 agents ran in parallel**: Writer, Researcher, QA red team. Evidence = screenshots in `screenshots/` showing them running at the same time, plus each agent's prompt saved verbatim in `prompts/agents/`, and the run recorded in `prompts/PROMPTS_LOG.md` | `qa-infra` + Leader |
| AC-21 | Chapter openers | Every chapter 1–10 opens with exactly one `scenebox` of ≤ 4 rendered lines, followed by formal third-person text (§12) | `qa-super` |
| AC-22 | Verified sources | 100% of `.bib` entries carry a verification record (DOI/URL opened, date, metadata match) in `references/VERIFICATION.md`; 0 unverified entries | `qa-super` + Researcher |

## 9. Known data issues in the flagship paper (must be discussed critically)

The committee checked Table 1 and Table 2 of Rosenbloom (2009) against the PDF and recomputed every value.
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
waiting lowers the odds of crossing on red) holds either way. Its size per person is about 37% lower odds, not 29%.

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
- A single crosswalk in Tel Aviv, one morning hour (07:30–08:30), and age estimated by eye.
- Pre-formed groups could not be told apart from strangers who happened to be waiting together.
- Pedestrians in the same group are **not independent observations**, which the logistic model assumes.
- No intercept is reported, so absolute probabilities cannot be computed (see §3.7).
- The outcome is dichotomous, with no waiting-time measurement. The author proposes video or software timing, which is exactly the gap our sensing component addresses.

## 10. Out of scope

- Implementing, piloting or field-testing the system. This is a *preparatory* report.
- Collecting new field data. The book uses only published, cited data.
- Any image not produced by our own TikZ or Python code.

## 11. Constraints

- Hebrew RTL book; code, commands, file names and commit messages in English (`CLAUDE.md`).
- No text copied from sources: always paraphrase and cite (`CLAUDE.md`).
- Copyrighted references stay local (`references/README.md`, `.gitignore`).
- Toolchain: LuaLaTeX (LuaHBTeX) + biber, MiKTeX. The brief targets MiKTeX 25.x and the local machine has **MiKTeX 22.1**, so updating is a TODO item and a risk.
- Every prompt is logged verbatim in `prompts/PROMPTS_LOG.md`.
- **Source verification (Researcher rule):** every bibliography entry must be **verified online**. The DOI or URL is actually opened, and the title, authors, year, venue and pages are checked against the landing page. The result is recorded in `references/VERIFICATION.md`. **Any source that can't be verified is dropped, never invented or "reconstructed".** If dropping sources takes the count below AC-09, the Researcher searches again rather than lowering the bar.
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
