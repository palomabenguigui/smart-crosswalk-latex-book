# Round 2 – QA RED TEAM (parallel agent)

You are the **QA red team** of the "Smart Crosswalk" book project (repository root = current directory), one of three agents running
**in parallel**. Read `CLAUDE.md` first – rule 1a applies: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push. **Detector only: no fixes.**

## Load first
`qa-super` and the family skills. `PRD.md` §8 (AC-11 (b), AC-14, AC-15 now have manual parts), §9. `prompts/agents/round1-redteam-report.md`
and the Leader's `prompts/agents/round1-redteam-response.md`.

## Note: the concept changed after commit `68f2501` (Step 15, PRD §1 v1.4)
Final concept = adaptive red + clearance-only countdown + campaign; a countdown during red is the rejected Alternative 1.
Audit chapter 4 **against the final concept too**: list every passage that presents a countdown during red as the solution, or that is otherwise
inconsistent with PRD §1 v1.4 (the Writer is rewriting the knowledge-gap section in parallel – report, don't fix).

## Target: the state at commit `68f2501` (round 1 merged) – chapter 4 as merged
Work on a copy so the parallel Writer does not disturb you: `git worktree add /tmp/rt2 68f2501 && cd /tmp/rt2`
(the copyrighted references are git-ignored: read them from the main checkout's `references/`).

1. **Verify the response:** for every item marked *fixed* in `round1-redteam-response.md`, check that the fix exists and works
   (re-run the relevant check, render the page). Mark each: confirmed / not fixed / regressed. For items marked *answered*, say whether you accept the answer.
2. **Full QA run** on the copy: `scripts/build.sh`, `.venv/bin/python tests/qa/run_tests.py`, `.venv/bin/python scripts/qa.py super --pdf build/main.pdf`.
3. **AC-11 (b) translation check:** compare every paragraph of `chapters/ch04-literature.tex` that cites `rosenbloom2009` with the cited passage
   of the paper. Report any sentence that is a close translation (same sentence structure and order of claims).
4. **AC-14 / AC-15 manual parts:** every number in ch. 4 traced to the paper (page) or to `data/recomputed.json` (key); for D1–D7: numbers shown? consequence stated?
5. **Visual audit** of every page of ch. 4 (qa-BiDi, qa-table, qa-img checklists) and the 10 weakest points of **chapter 4 as a text** (booklet Prompt 9: vague claims, claims without sources, over-claiming, logic gaps). Quote page + sentence.

## Output (the only file you write)
`prompts/agents/round2-redteam-report.md` (standard finding format; tables for steps 1, 4; the 10 weakest points). Remove the worktree at the end
(`git worktree remove /tmp/rt2`).
