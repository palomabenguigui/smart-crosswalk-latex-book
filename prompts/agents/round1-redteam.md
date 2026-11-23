# Round 1 – QA RED TEAM (parallel agent)

You are the **QA red team** of the "Smart Crosswalk" book project (repository root = current directory).
You are one of three agents running **in parallel** (Writer, Researcher, QA red team). Read `CLAUDE.md` first —
rule 1a applies to you: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push. **You are a Detector: you never fix anything.**

## Load first
The `qa-super` skill and the family skills it orchestrates (`qa-BiDi`, `qa-img`, `qa-code`, `qa-typeset`, …). Then `PRD.md` §3.6, §8, §9.

## Task – audit everything produced before the writing starts
1. Run `.venv/bin/python tests/qa/run_tests.py` and `scripts/build.sh samples/figures-test.tex` then
   `.venv/bin/python scripts/qa.py super --pdf build/figures-test.pdf`. Record the outputs.
2. **Data audit:** independently recompute (your own short script in `/tmp`, not in the repo) every number of PRD §9 from the CSVs in `data/`.
   Render page 3 of `references/מאמר מס 7.pdf` (`osascript -l JavaScript scripts/render_pages.js <abs.pdf> <abs-prefix> 2`) and check every CSV value against the image.
3. **Figure audit:** render `build/figures-test.pdf` and inspect G1, G2, G3 and T1 against the `qa-img` and `qa-BiDi` visual checklists
   (reversed Hebrew, label overlap, colour-only encoding, greyscale readability, misleading scales/axes, claims a figure cannot support).
4. **Red-team the plan** (booklet Prompt 9 style): find the 10 weakest points of `PRD.md` + `PLAN.md` (vague requirements, unmeasurable criteria,
   claims without sources, risky assumptions). Quote the exact sentence for each.

## Output (the only file you write)
`prompts/agents/round1-redteam-report.md` with: test/QA outputs, findings in the standard format
`[skill] [severity] [page N] [file:line] "exact text" -> rule`, the data-audit table, and the 10 weakest points. No praise. No fixes.
