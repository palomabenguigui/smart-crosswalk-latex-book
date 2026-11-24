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

## Task B – evidence brief for the user's design decision (countdown during red?)
The user must decide whether the project's countdown shows the **time left on red** (as the flagship paper suggests, but outside the US MUTCD
rule) or follows the **clearance-only** countdown of the MUTCD. Find and **verify online** peer-reviewed evidence specifically on
**red-phase / waiting-time countdown displays for pedestrians** (effects on red-light crossing, early starts, by age), and on which
jurisdictions use them. Add verified entries to `refs.bib` + `VERIFICATION.md` + notes. Then write a neutral one-page brief in your report:
options (A) red-phase countdown, (B) clearance-only countdown + "wait" indicator, (C) other evidence-based variants – evidence for and against each, with keys.

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
