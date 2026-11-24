# Round 2 – RESEARCHER (parallel agent)

You are the **Researcher** agent of the "Smart Crosswalk" book project (repository root = current directory), one of three agents running
**in parallel**. Read `CLAUDE.md` first – rule 1a applies: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push.

## Load first
The `researcher` skill (note the new section "Inventory of printed statistics", INC-003). `PRD.md` §1, §9, §11. Your round-1 report.

## Task A – inventory of printed statistics in the flagship paper (INC-003)
Read `references/מאמר מס 7.pdf` and list **every** statistic printed in the *text* (χ², p, percentages, counts, OR, Hosmer–Lemeshow, sample sizes…)
with its page. Check each against the rendered page and against `data/recomputed.json`. Write them to `data/rosenbloom2009_text_stats.csv`
(`statistic, value_as_printed, page, reproducible (yes/no/not-checkable), recomputed_value, note`). Any non-reproducible value → flag it as a
candidate issue D8+ in your report (do not edit the PRD).

## Task B – evidence for the FINAL concept (decided by the user in Step 15 – see `PRD.md` §1 v1.4 and §13)
Final concept: **adaptive red** (curb sensing of waiting pedestrians, especially a lone one, shortens the pedestrian red within safe limits)
+ **clearance-only countdown** (MUTCD §4I.04) + **social-control campaign**. The red-phase countdown is the rejected Alternative 1 (ch. 6).
Find and **verify online**:
1. Peer-reviewed evidence that **shorter pedestrian waiting / red time** reduces red-light crossing (waiting-time tolerance, delay–violation curves).
2. Evidence on **pedestrian-actuated / adaptive / detector-based signal timing** (e.g. Puffin-type or demand-responsive crossings): effects on waiting, violations, delays to traffic.
3. **Safe limits** for shortening red: minimum vehicle green, pedestrian clearance time / walking speed, cycle and coordination constraints (standard or guideline, e.g. MUTCD Part 4 sections you can open).
4. More evidence on **red-phase countdowns** (for the rejection of Alternative 1): effects on early starts / violations, by age.
Add verified entries to `refs.bib` + `VERIFICATION.md` + notes. In your report, give a one-page **evidence summary per component** (adaptive red,
clearance countdown, campaign, rejected A1) with keys and read depth.

## Task C – sources for chapters 2, 3 and 5
- ch. 2: waiting time and its effect on violations (open-access full text preferred, so numbers can be cited).
- ch. 3/5: verifiable technical documents for commercial **pedestrian countdown heads** and **curb-side pedestrian detectors**
  (manufacturer datasheets with model names and key specs; product pages must be opened and checked like any source).
Target: ≥ 6 new verified entries in total for tasks B + C. Unverifiable → dropped, never invented. Keep the read-depth column honest.

## Files you may write
`references/refs.bib`, `references/VERIFICATION.md`, `references/notes/*.md`, `data/rosenbloom2009_text_stats.csv`.

## Report
`prompts/agents/round2-researcher-report.md`: inventory summary (and any D8+ candidates), the decision brief, the table of new entries
(key, type, theme, peer-reviewed, read depth, DOI/URL), dropped candidates and why, source → chapter map.
