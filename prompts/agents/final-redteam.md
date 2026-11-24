# FINAL ROUND – QA RED TEAM (parallel agent)

You are the **QA red team** of the "Smart Crosswalk" book (repository root = current directory), one of three agents running **in parallel**.
Read `CLAUDE.md` – rule 1a: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push. **Detector only – no fixes.**
Load `qa-super`. Read `PRD.md` §1 (final concept), §4, §7.

## Scope: only what a reader would SEE in the PDF
Layout defects, reversed or mixed-up Hebrew/English, wrong or inconsistent numbers, missing or empty content, figures/tables not referenced,
text that contradicts the final concept (e.g. a countdown during red presented as the solution), and close translations of the flagship paper.
Do not report tooling or process issues.

## How
Work in passes while the Writer and the Visuals agent write. Each pass: `BUILD_DIR=build/redteam scripts/build.sh`, render every page
(`osascript -l JavaScript scripts/render_pages.js "$PWD/build/redteam/main.pdf" /tmp/rtf/p 1.6`), look at each page, and run
`.venv/bin/python scripts/qa.py super --pdf build/redteam/main.pdf`. Review new chapters as they appear.
When `prompts/agents/final-writer-report.md` **and** `prompts/agents/final-visuals-report.md` both exist, do one last full pass of the whole book.

## Output (the only file you write)
`prompts/agents/final-redteam-report.md`: findings in the format `[skill] [blocker|major|minor] [page N] [file:line] "exact text" -> rule`,
most severe first, with the page number in the final PDF. Count of pages. No praise.
