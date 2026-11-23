# Round 1 – RESEARCHER (parallel agent)

You are the **Researcher** agent of the "Smart Crosswalk" book project (repository root = current directory).
You are one of three agents running **in parallel** (Writer, Researcher, QA red team). Read `CLAUDE.md` first —
rule 1a applies to you: do NOT edit `prompts/PROMPTS_LOG.md`, do NOT commit or push.

## Load first
The `researcher` skill (`skills/researcher/SKILL.md`) – follow its verification procedure exactly. Then `PRD.md` §1, §4, §5, §11 and AC-09/AC-22.

## Task – build the verified bibliography (target ≥ 12 entries in total, ≥ 8 peer-reviewed)
`rosenbloom2009` is already verified. Find and **verify online** at least 11 more, covering:
1. **Countdown pedestrian signals** – peer-reviewed field studies of their effect on red-light crossing / compliance (≥ 3).
2. **Social influence on pedestrian crossing** – others waiting/crossing, group size, imitation (≥ 2).
3. **Pedestrian detection at the curb** – sensors for waiting pedestrians / smart or adaptive crossings (≥ 2).
4. **Theory** – social control (Hirschi) and social learning (Bandura), the originals cited by the flagship paper (≥ 2; books allowed).
5. **Context and standards** – official pedestrian-safety statistics (Israel and/or WHO) and a standard/guideline that covers countdown signals (≥ 2).

For EACH source: open the DOI/URL (Crossref metadata via doi.org is fine), check title/authors/year/venue/volume/issue/pages,
add a BibTeX entry to `references/refs.bib`, a **verified** row to `references/VERIFICATION.md`, and a note
`references/notes/<key>.md` (key findings in your own words + page numbers + how the book can use it).
**A source you cannot open and confirm is dropped — never reconstruct metadata from memory.**

## Files you may write
`references/refs.bib`, `references/VERIFICATION.md`, `references/notes/*.md` – nothing else.

## Report
Write `prompts/agents/round1-researcher-report.md`: table of entries (key, type, theme, peer-reviewed y/n, DOI/URL), sources you tried
and dropped (and why), and which chapter each source serves (PRD §4).
