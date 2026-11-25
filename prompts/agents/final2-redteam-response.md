# Round final2 – Leader's response to the QA red team (Step 19)

Status = final status after the Fixer (`final2-fixer-report.md`) and the Detector re-check (`final2-redteam-report.md`, "Re-check"). "Agree" = whether the Leader accepts the finding as stated.

## RT-01 … RT-17

| # | Agree | Final status | Note |
|---|---|---|---|
| RT-01 | yes | closed (Detector confirmed) | exit gate now reads the Fixer report; INC-008; 3 tests |
| RT-02 | yes | closed | Leader response for the interim pass written; findings 1–10 have statuses; Step 19 logged |
| RT-03 | yes | closed | README "10 front matter + 35 body"; `check_doc_claims` enforces it |
| RT-04 | yes | closed | abbreviations table split over pp. 9–10; the remaining blank space is table end, accepted |
| RT-05 | yes | closed | "8 QA + 5 production" in README and PLAN, checked by code |
| RT-06 | yes | closed | PLAN/PRD/README versions and page figures corrected |
| RT-07 | yes | closed | tests for INC-001/003/007 added; INC-000 has no automatable test (a human check of rendered source pages) – accepted; fix commit per incident added; no screenshot of a broken state exists and none was invented |
| RT-08 | yes | closed | CLAUDE.md layout table complete |
| RT-09 | yes | closed | cell emptied (paper's countdown position not re-checked) |
| RT-10 | yes | closed | short captions; new caption lint |
| RT-11 | yes | closed | label shortened |
| RT-12 | yes | closed | pointer to D1 added |
| RT-13 | partly | closed | fixed once in the class (`\eqnum`); the ch. 6 call-out had no outer brackets, so it needed no change |
| RT-14 | yes | closed | three separate paragraphs |
| RT-15 | yes | closed | TOC lists abstracts, lists of figures/tables, abbreviations |
| RT-16 | yes (minor) | closed | fixed within AC-01 (45 pages): Table 3.1 moved up, photo 56 mm; first attempt reopened by the Detector, second confirmed |
| RT-17 | yes | closed | no underfull box in the build log |
| NEW-1 | yes | closed | found by the re-check: running head of p.10 |

## Old findings (`final-redteam-report.md`)

| # | Agree | Final status |
|---|---|---|
| 1, 2, 4, 7, 9, 10 | yes | closed – fixed by the content rounds, confirmed in the final2 re-check table |
| 3 | yes | closed – RT-09 |
| 5 | yes | closed – RT-10 |
| 6 | yes | closed – RT-11 |
| 8 | yes | closed – RT-12 |

Exit gate (PLAN §4): the red-team report inspected 45 pages = the built PDF; every finding has a status in the Fixer report; the Detector, not the Leader, confirmed the fixes.
