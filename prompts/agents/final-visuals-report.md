# Final round – Researcher + Visuals report

## Figures produced (all checked on a rendered page of `samples/figures-test.tex`, built with `BUILD_DIR=build/visuals`: 0 errors, 0 overfull, 0 missing glyphs; `qa.py img` 0/0/0)
| Figure | File | Include as | Suggested label |
|---|---|---|---|
| T2 architecture | `figures/tikz/t2-architecture.tex` | `\begin{ltrblock}\input{figures/tikz/t2-architecture}\end{ltrblock}` | `fig:t2` |
| T4 social-control loop | `figures/tikz/t4-social-loop.tex` | same pattern | `fig:t4` |
| T3 WBS tree (project → 5 WPs → 16 tasks) | `figures/tikz/t3-wbs.tex` (generated) | same pattern | `fig:t3` |
| T5 Gantt, months 1–12, milestones M1 permit (task 1.3), M2 acceptance (3.4), M3 final report (5.3) | `figures/tikz/t5-gantt.tex` (generated) | same pattern | `fig:t5` |
| G4 risk heat-map 5×5 (critical R ≥ 12: red tint + hatch) | `figures/g4-risk-heatmap.pdf` via `scripts/fig_risk_heatmap.py` | `\includegraphics[width=\linewidth]` | `fig:g4` |

- T3/T5 come from `scripts/make_plan_figures.py` (reads `data/wbs.csv`); G4 from `data/risks.csv` (inherent P, I; residual P_res/I_res are not drawn). Both registered in `scripts/make_figures.py` (runs on every build).
- Suggested captions are in `samples/figures-test.tex` (placeholders only – the Writer's captions win).
- Gantt/heat-map numeric axes are LTR; Hebrew order/direction checked visually. Greyscale safe (hatch + labels; amber bars + black WP bars; no red/green-only meaning).
- Milestone tasks (1.3, 3.4, 5.3) are a constant in `make_plan_figures.py`; the month positions come from the CSV.
- The class does not load `arrows.meta`, so the figures use the built-in `latex` arrow tip.
- Not changed: `smartcross.cls`. Not committed, PROMPTS_LOG untouched (rule 1a).

## Sources
- MUTCD pedestrian clearance / walking speed: already in `refs.bib` as `fhwa2025mutcd` (11th ed. Rev. 1, Part 4, §4I.04–4I.06, pp. 718–724, verified in VERIFICATION.md). No new entry needed.
- `% NEEDS-SOURCE` markers: none found in `chapters/` at the time of the check (ch01–ch04). Nothing added.

## Open issues
- If a Writer chapter changes the WBS/risk wording, regenerate via `scripts/make_figures.py` (the CSV is the single source).
- The T4 campaign→"visible norm" arrow crosses the dashed lone-pedestrian arrows once (kept for readability of the layout).
