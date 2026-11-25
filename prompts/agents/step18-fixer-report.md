# Step 18 – Fixer report (Leader acting in the Fixer role; verification by the Detector subagent, not by the Fixer)

| finding id | file:line | change | status | reason | candidate incident |
|---|---|---|---|---|---|
| final-redteam#10 (cover has no author names) | `main.tex:10`, `smartcross.cls` cover block | `\Authors{פלומה בנגיגי, שירה דביר}`; cover column labelled "מחברים"; group code kept as its own line "קבוצה: shirloma"; `.cls` v1.6, `CLS_TARGET` 1.6 | FIXED | – | INC-007 |
| step18-cover#1 (group line mis-aligned) | `smartcross.cls:607` | group line moved out of the `\foreach` into its own right-aligned node | FIXED | – | – |
| step18-cover#2 (group line font) | `smartcross.cls:607` | same node font as the authors (sffamily 9/12) | FIXED | – | – |
| step18-cover#3 (crowded with date) | `smartcross.cls:612-613` | date and course lines moved down (y 14.5 → 10.5) | FIXED | – | – |
| step18-cover#4 (kicker repeats group code) | `smartcross.cls:604` | none | REJECTED (informational; intentional kicker, not a defect) | – | – |
| skills stale v1.0 / 28–32 pages | `skills/qa-cls-version`, `skills/qa-infra` | refer to `CLS_TARGET` / AC-01; new `qa.py` check + test | FIXED | – | INC-005 |
| TODO.md 29 open items | `TODO.md` | every item done/obsolete with reason; 2 stay open with owner | FIXED | – | – |
| final round merged on an interim red-team pass | `PLAN.md` §4, `skills/qa-super` | exit gate + `qa.py infra --redteam` + test | FIXED | the full-book red-team re-run itself is DEFERRED (owner: Leader, next round, TODO P8) | INC-006 |

FIXED 7 / REJECTED 1 / DEFERRED 0 (plus the deferred re-run noted above). Verification: cover re-checked by a Sonnet Detector subagent (0 findings); `qa.py super` 0 blocker / 0 major; `tests/qa/run_tests.py` 0 failing.
