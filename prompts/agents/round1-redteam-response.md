# Round 1 – Leader's response to the QA red team (AC-16)

Status legend: **fixed** (change made; evidence = commit "Step 14: merge round 1 …" + location) · **answered** (no change, reason given –
needs the user's acceptance under AC-16) · **open** (scheduled, with owner).

## Findings QA-01 … QA-38

| # | Status | Owner | What was done / answer |
|---|---|---|---|
| QA-01 | fixed | TikZ | T1 sensing zone: tint + `north east lines` hatch in `SignalAmberDark`; PRD §6.1 rule: meaning-bearing fills need ≥ 3:1 or a pattern |
| QA-02 | fixed | Python + Writer | G3 now k = 0–5, solid only to 3, dashed + shaded "illustration outside the reported range"; ch. 4 caption says so |
| QA-03 | fixed | Python + Writer | G2 traffic row labelled "סתירה פנימית" (contradiction), legend "derived from the printed b and SE"; ch. 4 text says the row cannot be resolved |
| QA-04 | fixed | Python | G3 numeric axis left-to-right like G2. Categorical axes (G1) keep RTL order – rule recorded in PRD §7 rule 7 sense |
| QA-05 | fixed | Writer | G2 caption names the omitted 5th predictor and D4 |
| QA-06 | fixed | Python | derived CI lines now Asphalt (high contrast); amber kept only for the marker fill |
| QA-07 | fixed | Python | G3 band alpha 0.45 + dotted hatch + dark-amber edge |
| QA-08 | answered | TikZ | red figure on black mimics a real signal head and is always labelled in text; not a data encoding |
| QA-09 | fixed | TikZ | data link rerouted below the awareness display |
| QA-10 | fixed | TikZ | waiting box narrowed (x 58–80); sensing leader ends at the fan tip outside it |
| QA-11 | fixed | `.cls` + TikZ | new documented token `SignalAmberDark` (#9A6B00), used instead of `SignalAmber!85!black` |
| QA-12 | fixed | Python | G1 genders in neutral greys (+ hatch); red keeps its warning meaning; colour-meaning rule added to PRD §6.1 |
| QA-13 | fixed | Python + data | reference line with white halo; 95 % Wilson intervals from `recompute_table2.py` |
| QA-14 | fixed | Writer + Leader | glossary spelling "חצייה" everywhere (sources, T1, meta, README, PRD §3.1); `qa-BiDi` lint added |
| QA-15 | fixed | data + Writer + PRD | new issue **D7** in PRD §9, recompute script, ch. 4 cautionbox + paragraph |
| QA-16 | fixed | data | CSV prints "Gender" + `coding_note` (male = 1 inferred) |
| QA-17 | fixed | data | 60+/Red/Red stored empty (= printed "–"); scripts treat it as 0 with a note |
| QA-18 | fixed | PRD | §11: DOI-registry (Crossref/DataCite) records are an accepted verification source; Leader re-resolved all 11 DOIs + 3 URLs + 2 ISBNs (all match) |
| QA-19 | fixed | data | p-values stored to 2 significant digits, never 0 |
| QA-20 | fixed | PRD + Writer | 37.5 % (joining ≈ 37 %); ch. 4 shows 37.5 |
| QA-21 | fixed | PRD + Writer | "eight one-hour sessions in the same morning hour over six weeks" (PRD D6, ch. 4 D6 ×3) |
| QA-22 | fixed | Leader (qa.py) | verdict compared cell-exactly; regression test added |
| QA-23 | fixed | Leader (qa.py) | per-page allowance only for figures actually placed on that page; 2 regression tests |
| QA-24 | fixed | Leader (qa.py) | `data/quoted_in_book.json` (15 numbers of ch. 4) → each must equal its `recomputed.json` path to the shown precision **and** appear as a `\num`/`\pct` argument |
| QA-25 | answered + fixed | PRD | n-grams cannot catch translation; AC-11 now adds a manual **translation check** by the red team each round |
| QA-26 | fixed | Leader (qa.py) | reversed words without final letters caught via the source-word vocabulary; 2 regression tests. Reversed *numbers* remain a visual check (documented) |
| QA-27 | fixed | Leader (qa.py) | `super --pdf build/X.pdf` also lints `samples/X.tex` (body only) |
| QA-28 | fixed | Leader | count corrected: the suite now has **24** tests (all pass); counts in commit messages are taken from the run |
| QA-29 | fixed | `.cls` + qa.py | scene lines measured by TeX (`\prevgraf` → `SCENE-LINES` in the log) and checked by `qa-typeset` |
| QA-30 | fixed | Leader (qa.py) | named colours and RGB tuples flagged; `WHITE` token added to `palette.py` |
| QA-31 | fixed | Leader (qa.py) | `data/` included in the stale check |
| QA-32 | answered + fixed | PRD | measurable rule (≥ 3:1 or pattern) in PRD §6.1; automatic greyscale contrast measurement stays a visual check |
| QA-33 | fixed | Leader (qa.py) | `super` prints which families ran, their counts, the chapter count and the PDF |
| QA-34 | fixed | PRD + venv | PRD §3.7 no longer prescribes python-bidi; package removed from `requirements.txt` |
| QA-35 | fixed | PLAN | §11 uses the real file names (`roundN-<role>.md`) and states round 1's special target |
| QA-36 | fixed | PRD | §5: G4 uses the team's estimates, stated in its caption |
| QA-37 | fixed | PRD | §6.1 documents all tokens and one meaning per colour |
| QA-38 | fixed | PLAN | "12 skills (8 QA + 4 production)" |

## The 10 weakest points

| # | Status | Resolution |
|---|---|---|
| 1 | fixed | = QA-34 |
| 2 | fixed | = QA-25: AC-11 (b) translation check |
| 3 | fixed | = QA-29: rendered lines measured |
| 4 | fixed | AC-15 now observable: (1) each Dn named – automatic check in `qa.py content`; (2) numbers shown; (3) consequence stated – red team |
| 5 | fixed | = QA-15 (D7) |
| 6 | fixed | = QA-21 |
| 7 | fixed | = QA-36 |
| 8 | fixed | = QA-24 |
| 9 | answered | the reference list counts as body (Arabic numbering): planned body 27–28 ≥ 25; openers are inside each chapter's budget; `qa-infra` now reports the running page count each round (binding once all 10 chapters are in) – PRD §4 |
| 10 | fixed | AC-16 now requires evidence (commit + location) or the user's written acceptance; this file is that record |

## Leader's own findings on the merged book (round 1)
| # | Status | Finding |
|---|---|---|
| L1 | fixed (`.cls` v1.1) | ch. 4 rendered as "Chapter 01" with the red lamp, because it was the first `\chapter` in `main.tex` → `\inputchapter{N}{file}` fixes number, phase, lamp and tab (DS-22) |
| L2 | fixed (Writer) | ch. 4 D6 said "one hour" (contradicting the method paragraph) |
| L3 | fixed (Writer) | G2 caption did not mention the omitted predictor (= QA-05) |

## Needs the user's decision
**Researcher finding 1 (standards conflict):** the US MUTCD (11th ed., §4I.04, pp. 718–719) allows a pedestrian countdown only during
the flashing DON'T WALK clearance interval – never during red/steady DON'T WALK; `fu2016` found that a countdown during red
**increased** early starts among children. The project's core feature as written in PRD §1 ("time left on red") is therefore
non-standard and has mixed evidence. Chapters 3, 6, 7 and 9 depend on this decision.
