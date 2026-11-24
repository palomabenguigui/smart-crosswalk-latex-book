# Round 2 – Leader's response to the QA red team (short form, Step 16: finish efficiently – blockers/majors only)

| # | Status | Resolution |
|---|---|---|
| R2-01 | fixed | `build.sh` runs a further lualatex pass when the log asks for a rerun |
| R2-02 | answered | `\prevgraf` is not set under babel's Lua line breaking (probe logged 0 even in the env's own end code); the scene-length check stays the character heuristic in `qa.py` |
| R2-03 | fixed | number register matches only `\num`/`\pct`/`\range` arguments **in the registered chapter**; sample moved out of `chapters/` |
| R2-04 | fixed | bibliography list redefined in the `.cls` (no mirrored hanging indent): items inside the text block |
| R2-05, 06, 13, 15 | fixed | by the Writer in round 2 (thematic review, gap section and findingbox aligned with PRD §1 v1.4) |
| R2-07 | fixed | D5 now says "arrived on green and crossed on green" |
| R2-08 … 11 | fixed | the four sentences rewritten in a different structure (AC-11 b) |
| R2-12 | fixed | G3 label "המחשה בלבד: טווח הממתינים לא דווח" now agrees with the caption |
| R2-14 | fixed | subtitle: "אדום אדפטיבי, ספירה לאחור בזמן הפינוי ושליטה חברתית" (cover + samples) |
| R2-16 | fixed | ch. 4 gap section and PRD: "eight sessions in the same morning hour" |
| R2-17 (minor) | answered | the regression test needs the built sample; run `scripts/build.sh samples/style-final.tex` first |
| Minors | not addressed | per Step 16 (finish efficiently) |
| D8–D10 | answered | recorded in the data inventory and PRD §9, not discussed in the book (scope) |
