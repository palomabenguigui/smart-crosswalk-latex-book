# FINAL ROUND – RESEARCHER + VISUALS (parallel agent)

You are the **Researcher and Visuals** agent of the "Smart Crosswalk" book (repository root = current directory), one of three agents running
**in parallel**. Read `CLAUDE.md` – rule 1a: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push.
Load the skills `researcher`, `python-graphs`, `tikz-illustrations`. Read `PRD.md` §1 (final concept), §5, §6.

## Part A – figures (all Hebrew node text with the `rtl` style; colours only from the `.cls` tokens / `scripts/palette.py`)
Start immediately with A1–A2; A3–A4 need the Writer's data files (wait until they exist, check every few minutes).
1. **T2 architecture** → `figures/tikz/t2-architecture.tex`: curb sensing (count, waiting time, lone pedestrian) → controller with **adaptive-red logic within safe limits** → signal heads with **clearance-only countdown** → campaign / awareness display + data layer (privacy: counts only, no images stored). Use `\picto`.
2. **T4 social-control loop** → `figures/tikz/t4-social-loop.tex`: others waiting → visible norm / social control → lower odds of crossing on red (flagship finding); lone pedestrian → weaker control + longer perceived wait → higher odds; the system acts on both (shorter red for the lone pedestrian; campaign).
3. **T3 WBS + Gantt** from `data/wbs.csv` → `scripts/make_plan_figures.py` writes `figures/tikz/t3-wbs.tex` (tree: project → 5 WPs → tasks) and `figures/tikz/t5-gantt.tex` (pgfgantt or TikZ bars, months 1–12, milestones). Register it in `scripts/make_figures.py`.
4. **G4 risk heat-map** from `data/risks.csv` → `scripts/fig_risk_heatmap.py` → `figures/g4-risk-heatmap.pdf` (5×5 P×I grid, risk IDs placed in cells, critical zone R ≥ 12 marked by a pattern **and** colour). Register it in `scripts/make_figures.py`. Hebrew via `figstyle.he()` only.
Each TikZ figure must fit 138 mm width. Check each one: `BUILD_DIR=build/visuals scripts/build.sh samples/figures-test.tex` after adding it to
`samples/figures-test.tex`, render the page, and look (no reversed Hebrew, no overlaps, readable in greyscale).

## Part B – sources (only if the Writer's chapters need them; keep it short)
Verify online and add to `refs.bib` + `VERIFICATION.md` + a note: the MUTCD pedestrian clearance / walking-speed provision (for ch. 3 safe limits), and
anything a Writer chapter marks `% NEEDS-SOURCE`. Unverifiable → dropped.

## Files you may write
`figures/tikz/t2-architecture.tex`, `t4-social-loop.tex`, `t3-wbs.tex`, `t5-gantt.tex`, `figures/g4-risk-heatmap.pdf`, `scripts/make_plan_figures.py`,
`scripts/fig_risk_heatmap.py`, `scripts/make_figures.py`, `samples/figures-test.tex`, `references/refs.bib`, `references/VERIFICATION.md`, `references/notes/*.md`.

## Report
`prompts/agents/final-visuals-report.md`: figures produced (file, label to use), sources added, open issues.
