# Round 2 – QA red team report (Detector only, no fixes)

**Date:** 2026-11-24 · **Agent:** QA red team (parallel agent, CLAUDE.md rule 1a) · **Target:** commit `68f2501` (round 1 merged), audited in a
worktree at `/tmp/rt2`. The git-ignored references were symlinked into the worktree from the main checkout, and the worktree was removed at the end.
**Concept reference:** PRD §1 v1.4 at `e08b6bc`: adaptive red + clearance-only countdown + campaign. A countdown during red is the rejected Alternative 1.
**Page numbers:** the printed body page numbers of `build/main.pdf`. Ch. 4 = pp. 1–5, references = p. 6. Line numbers refer to `chapters/ch04-literature.tex` at `68f2501`.

**Totals:** 0 blocker · 16 major · 21 minor (37 findings R2-01 … R2-37). Round-1 verification (44 items): 33 confirmed · 1 confirmed with a new
defect (QA-02) · 5 not fixed or partly fixed (QA-21, QA-24, QA-29, WP-4, L2) · 5 answers (3 accepted, 2 accepted with a condition).

---

## 1. QA run on the worktree (verbatim summaries)

| Command | Result |
|---|---|
| `scripts/build.sh` (main.tex) | `done: build/main.pdf` · errors 0 · undefined refs 0 · missing chars 0 · overfull 0 · underfull 0 · **LaTeX warnings: 1** (`Label(s) may have changed. Rerun to get cross-references right.`, main.log:2071) |
| 4th / 5th `lualatex` pass (diagnostic) | `Rerun` count 0 / 0. The documented 3-pass sequence is one pass short (R2-01) |
| `tests/qa/run_tests.py` (fresh worktree) | 23 PASS, **1 FAIL**: `final sample: 0 blocker / 0 major` → `== 1 failing`. Cause: the test needs `build/style-final.pdf`, which a fresh checkout does not have (R2-17) |
| same, after `scripts/build.sh samples/style-final.tex` | 24 PASS · `== 0 failing` |
| `scripts/qa.py super --pdf build/main.pdf` | `-- ran: cls-version (0), infra (2), typeset (2), bidi (0), table (0), img (0), code (0), content (15) \| chapters: 2 files` · `== super: 0 blocker, 2 major, 17 minor` (exit 1). Majors: 2 × AC-03 rerun. Minors: 8 pages / 7 body pages (1/10 chapters, expected now) and 15 refs.bib entries not yet cited |
| `scripts/qa.py super --pdf build/figures-test.pdf` | `== super: 0 blocker, 1 major, 15 minor`. Major: `[qa-BiDi] … [samples/figures-test.tex] "2" -> PRD §7 rule 4` (real, line 19) |

---

## 2. Step 1 – verification of the round-1 response

Method: re-ran the relevant check, rendered the page, and for each qa.py fix ran a **mutation test**: inject the defect into the worktree,
run the detector, then `git checkout` to restore the file.

| # | Leader status | Verdict | Evidence |
|---|---|---|---|
| QA-01 | fixed | **confirmed** (T1) | T1 greyscale render shows the hatch clearly. The same faint fill (`SignalAmber,opacity=0.16`, no hatch) remains in the cover art (R2-33) |
| QA-02 | fixed | **confirmed, new defect** | k = 0–5, dashed beyond 3, shaded band. The in-figure label contradicts the caption, and the cut-off at 3 has no source (R2-12) |
| QA-03 | fixed | confirmed | G2 p. 4: traffic row labelled "סתירה פנימית", legend "נגזר מ-b ו-SE שפורסמו"; ch04:81 says the row cannot be resolved |
| QA-04 | fixed | confirmed | G3 x-axis 0 → 5 left to right, like G2 |
| QA-05 | fixed | confirmed (ch. 4) | ch04:86 names the 5th predictor and D4. `samples/figures-test.tex:19` still carries the old caption (R2-34) |
| QA-06 | fixed | confirmed | derived CI lines are dark (Asphalt) |
| QA-07 | fixed | confirmed | G3 band visible, with an edge line |
| QA-08 | answered | **accepted** | moot: at `e08b6bc` the heads show a green walker (clearance interval) |
| QA-09 | fixed | confirmed | link runs below the awareness display (render) |
| QA-10 | fixed | confirmed | sensing leader ends at the fan tip outside the waiting box |
| QA-11 | fixed | confirmed | `SignalAmberDark #9A6B00` measures 4.69:1 on white |
| QA-12 | fixed | confirmed | G1 uses grey + hatch |
| QA-13 | fixed | confirmed | Wilson 95% recomputed independently: F 5.94–11.99, M 15.90–26.25 = `recomputed.json` |
| QA-14 | fixed | confirmed | the only remaining "חציה" is the lint regex itself (qa.py:174) |
| QA-15 | fixed | confirmed | D7 in PRD §9, `recomputed.json`, ch04:72/94; values equal my round-1 recompute |
| QA-16 | fixed | confirmed | CSV prints "Gender" + `coding_note`. The text still states the coding as fact (R2-37) |
| QA-17 | fixed | confirmed | 60+/Red/Red cell empty |
| QA-18 | fixed (rule change) | **accepted** | — |
| QA-19 | fixed | confirmed | `p_from_printed_wald` 3.4e-05 / 1.6e-05 |
| QA-20 | fixed | confirmed | PRD §9 D1 + ch04:78 "37.5" |
| QA-21 | fixed | **not fixed (2 places)** | PRD.md:71 (`68f2501`; :83 at HEAD) "one site, **one morning hour**"; ch04:113 "אתר אחד ו**שעת בוקר אחת**" (R2-16) |
| QA-22 | fixed | confirmed | mutation `**verified**` → `**unverified**` ⇒ `[qa-super] [blocker] … AC-22 entry not verified online` |
| QA-23 | fixed | confirmed | regression tests "QA-23 …" pass |
| QA-24 | fixed | **partly fixed** | mutation 1 (`\pct{37.5}` → bare 37.5) ⇒ detected ✓. Mutation 2 (every `\pct{13.5}` in ch04 → 13.6) ⇒ **0 findings**: the `chapter` field is ignored, and `chapters/00-final-sample.tex` (not in the book) contains `\pct{13.5}` ×3 and `\num{0.63}` (R2-03) |
| QA-25 | answered + fixed | **accepted** | AC-11 (b) performed in §3 below |
| QA-26 | fixed | confirmed | regression tests pass |
| QA-27 | fixed | confirmed | `super --pdf build/figures-test.pdf` now lints the sample and finds a real bare "2". The finding has no line number (R2-18) |
| QA-28 | fixed | confirmed | 24 tests. One fails on a fresh checkout (R2-17) |
| QA-29 | fixed | **not fixed** | `SCENE-LINES` is always 0: main.log `SCENE-LINES:4:0`, style-final.log `SCENE-LINES:1:0`, and a probe scene that renders **13 lines** logged `SCENE-LINES:1:0` (render checked). The 330-character fallback (qa.py:323) is the only working check (R2-02) |
| QA-30 | fixed | confirmed | mutation `color='red'` ⇒ `[qa-img] [major] … named colour` |
| QA-31 | fixed | confirmed | mutation in table1.csv ⇒ stale `recomputed.json`, G1 and a rounding error are reported. The CSV itself is mislabelled as "regenerated output" (R2-19) |
| QA-32 | answered + fixed | **accepted, with a condition** | the greyscale render must be recorded in every round report (this report does) |
| QA-33 | fixed | confirmed | `-- ran: …` line present |
| QA-34 | fixed | confirmed | PRD §3.7 amended; `python-bidi` gone from requirements.txt |
| QA-35 | fixed | confirmed | PLAN §11 `roundN-<role>.md` |
| QA-36 | fixed | confirmed | PRD §5 "except G4" |
| QA-37 | fixed | confirmed | PRD §6.1 lists all cls tokens |
| QA-38 | fixed | confirmed | PLAN §1 "12 skills (8 QA + 4 production)" |
| WP-4 (AC-15 auto) | fixed | **partly fixed** | mutation: `\en{D5}` removed from the cautionbox ⇒ 0 findings, because the check accepts `\en{D5}` anywhere in ch. 4 (R2-20) |
| WP-9 | answered | **accepted, with a condition** | ch. 4 = 5 pages against a 6-page budget, with §4.1 still empty. Re-check when §4.1 is written |
| WP-10 | fixed | confirmed | — |
| L1 | fixed | confirmed | opener reads "CHAPTER 04 · ANALYSIS & DESIGN", amber lamp, tab 04 at the amber position |
| L2 | fixed | **partly fixed** | ch04:97 is fixed, but ch04:113 still says "שעת בוקר אחת" |
| L3 | fixed | confirmed | — |

---

## 3. Step 3 – AC-11 (b) translation check (ch. 4 vs Rosenbloom 2009)

Paper pages are PDF / journal pages (PDF p. 2 = journal 390). **Fail** = same sentence structure and order of claims. **Borderline** = same order with reworded structure.

| ch04 line (page) | Book sentence (start) | Paper passage | Verdict |
|---|---|---|---|
| 23 (p. 1) | "שלפיה אדם הממתין לבדו חש מחויבות חלשה יותר לנורמה מאשר אדם המוקף באחרים" | p. 4 §4.2 "people who reach a crosswalk alone … while those **surrounded** by other pedestrians … feel more **committed** to social order and to social norms" | borderline (condensed, but keeps the lexical pair "surrounded/committed") |
| 26 (p. 1) | "זהו מחקר תצפית שדה, שבו ההולכים לא ידעו שהם נצפים" | p. 1 abstract "unobtrusively observed" | pass |
| **27 (p. 1)** | "שני צופים מיומנים עמדו בצד הדרך ותיעדו כל הולך רגל…" | p. 2 §2.3 "Two trained observers stood on the side of the road and unobtrusively collected pedestrian crossing behaviour data…" | **FAIL** – same subject, verb, location phrase and order (R2-08) |
| 29 (p. 2) | "המשתנה התלוי היה דו-ערכי: חצה באדום או המתין לירוק" | p. 2 §2.1 "The dependent variable recorded was whether the participant crossed at a red or green light" | borderline |
| **30 (p. 2)** | "בסך הכול נצפו 1,392 הולכי רגל, מהם 842 נשים (60.5%) ו-550 גברים (39.5%)" | p. 2 §2 "We observed the behaviours of 1392 pedestrians, 842 females (60.5%) and 550 males (39.5%)" | **FAIL** – clause-for-clause (R2-09) |
| 33 (p. 2) | "563 מן הנצפים (40.4%) הגיעו כשהרמזור אדום, ו-76 מהם חצו באדום: 5.5%…" | p. 3 §3 "Of the 1392 valid observations, 563 (40.4%) pedestrians arrived … Only 76 pedestrians (5.5% of total observations) actually crossed" | borderline (adds 13.5% and its reasoning) |
| 35 (p. 2) | χ² sentence + "משתחזר במדויק" | p. 3 §3 | pass (own recomputation added) |
| **50–51 (p. 2)** | "הסיכויים של גבר … גבוהים פי 3.71 … וכל אדם נוסף הממתין … או מצטרף … מקטין אותם. נפח התנועה וחצייה של אדם אחר באדום לא נמצאו מנבאים מובהקים" | p. 3 §3 "Male pedestrians were more likely… The presence of other pedestrians waiting … as well as the arrival of other pedestrians … decreased the likelihood… Neither Traffic volume, nor the red-light crossing of another pedestrian, significantly predicted…" | **FAIL** – same three claims in the same order; line 51 is a sentence-level translation (R2-10) |
| **52 (p. 2)** | "וככל שעל המדרכה יותר אנשים, כך פחות אנשים חוצים באדום" | p. 4 §4.2 "The more pedestrians present at the curb, the lower was the rate of people crossing on red" | **FAIL** – same comparative construction (R2-11) |
| 90–91 (p. 3) | D3 critique | p. 3 §3 / p. 5 §4.3 | pass (critical synthesis) |
| 97 (p. 4) | D6 list | p. 2 §2.3, p. 5 §4.4 | pass |
| 112 (p. 4) | "איש לא מדד כמה שניות … והמחבר עצמו מציע לעשות זאת בתוכנת תזמון או בצילום וידאו" | p. 5 §4.4 "could not measure the exact waiting time … special software … video footage" | borderline (same order of claims) |
| 114 (p. 4) | "המאמר ממליץ על רמזורים המציגים את הזמן שנותר" | p. 4 §4.2 "install more traffic lights that also indicate the time remaining" | pass |

**Result:** 4 fail (lines 27, 30, 50–51, 52) · 4 borderline · 6 pass.

---

## 4. Step 4 – AC-14 traceability and AC-15 manual parts

### 4.1 Every number in ch. 4

| Line (page) | Number(s) as shown | Source | Status |
|---|---|---|---|
| 27 (p. 1) | 07:30, 08:30, "שמונה מפגשים" | paper p. 2 §2.3 | ✓ |
| 30 (p. 2) | 1,392 · 842 (60.5) · 550 (39.5) | paper p. 2 §2 / p. 3 Table 1 | ✓ |
| 33 (p. 2) | 563 (40.4) · 76 · 5.5 · 13.5 | paper p. 3 §3; `table1.arrived_red_pct`, `crossed_red_pct_of_all`, `crossed_red_pct_of_red_arrivals` (registered) | ✓ |
| 34 (p. 2) | 20.6 (48/233) · 8.5 (28/330) · "פי שניים ויותר" | `table1.by_gender_red_arrivals.*` (registered) · ratio 2.43, **not registered** | ✓ / unregistered (R2-35) |
| 35 (p. 2) | χ²(1, N = 563) = 17.17 | paper p. 3; `table1.chi2_gender_recomputed` = 17.169 – **not registered** | ✓ / unregistered |
| 40 (caption) | 95 | `wilson95_pct` | ✓ |
| 49 (p. 2) | 1 (OR threshold) | definition | ✓ |
| 50, 56 (p. 2) | 3.71 | paper p. 3 Table 2; `table2.gender.exp_b_recomputed` 3.706 (registered) | ✓ |
| 55 (p. 2) | 13.5 (tile) | registered | ✓ |
| 57, 66, 78 | 0.63 | `table2.waiting.exp_b_recomputed` 0.625 (registered). The joining 0.63 (line 66) maps to `table2.joining.exp_b_recomputed` 0.631, **not registered** | ✓ / unregistered |
| 66 (p. 3) | 0.71 · 0.67 | paper p. 3 Table 2 | ✓ |
| 78 (p. 3) | 37.5 · 29 | `issues.odds_reduction_pct_per_person.*` (registered) | ✓ |
| 79 (p. 3) | b = −0.03 · 0.03 · 0.97 · 0.92–1.03 | paper Table 2 · `table2.traffic.exp_b_recomputed` (registered) · `ci_recomputed` 0.915–1.029 **not registered** | ✓ / unregistered |
| 80 (p. 3) | 2.20 · 6.06 · b ≈ 0.79 | paper Table 2 · `issues.D2_traffic_row.ci_and_exp_b_imply_b` 0.785 **not registered** (it is in math, outside `\num`) | ✓ / unregistered |
| 92 (p. 3) | −24.24 · 8,184.53 | paper Table 2 | ✓ |
| 93 (p. 3) | 60.8 · 61.8 (512/829) · 20–40 · 94.4 · 94.3 | paper p. 3 Table 1, p. 2 §2 · `female_pct_green_green_recomputed` (registered) | ✓ (wording wrong: R2-07) |
| 94 (p. 3–4) | χ²(2, N = 1392) = 1.02 · 2.95 · 0.96 · 0.55 · 0.82 · "60+" | paper p. 3 §3 · `table1.age_chi2_variants.*` (registered) | ✓ |
| 101 (p. 4) | "כרבע" (0.63³) | 0.625³ = 0.244, **not registered** (with the printed 0.71 it would be 0.36) | unregistered |
| 106 (caption) | "ארבעה ממתינים ויותר" | no source: the paper does not report the observed range | ✗ (R2-12) |

All values match their source. Six recomputed numbers are not in `data/quoted_in_book.json`, so AC-14's "every recomputed number is reproduced by a script" is not enforced for them.

### 4.2 AC-15 (D1–D7)

| Dn | (1) named in cautionbox | (2) numbers shown | (3) consequence for the book's argument |
|---|---|---|---|
| D1 | ✓ l. 66 | ✓ 0.71/0.63, 0.67/0.63, 37.5 vs 29 (l. 66, 78) | ✓ direction kept, effect stronger; the tile uses 0.63 (l. 57, 78) |
| D2 | ✓ l. 67 | ✓ −0.03, 0.03, 0.97, 0.92–1.03, 2.20, 6.06, 0.79 (l. 79–80) | ✓ "הדוח אינו נשען על שורה זו" (l. 81) |
| D3 | ✓ l. 68 | n/a (textual issue) | **partial**: says which section is wrong (l. 90); does not say what the book relies on as a result |
| D4 | ✓ l. 69 | ✓ −24.24, 8,184.53 (l. 92) | **partial**: "H2 untestable", but not linked to the project (e.g. no claim about imitation of a red-crosser can rest on this paper) |
| D5 | ✓ l. 70 (summary inaccurate: R2-24) | ✓ 60.8/61.8, 94.4/94.3 (l. 93) | **✗ missing**: l. 95 moves on with "כל שאר הערכים… משתחזרים במדויק" |
| D6 | ✓ l. 71 | **✗** no number in the D6 paragraph (l. 97–98) | ✓ CIs possibly too narrow (l. 98); gap section (l. 111–113) |
| D7 | ✓ l. 72 | ✓ 1.02, 2.95, 0.96, 0.55, 0.82 (l. 94) | ✓ "ההחלטה… אינה נשענת על חישוב שאפשר לשחזר" (l. 94) |

---

## 5. Findings – `[skill] [severity] [page N] [file:line] "exact text" -> rule`

### 5.1 Major (16)

| # | Finding |
|---|---|
| R2-01 | `[qa-typeset] [major] [-] [build/main.log:2071] "LaTeX Warning: Label(s) may have changed. Rerun to get cross-references right."` → occurs after the documented lualatex → biber → lualatex ×2 sequence; a 4th pass clears it. -> AC-03; PLAN §8 build sequence |
| R2-02 | `[qa-typeset] [major] [-] [smartcross.cls:396] "after upper={\par\typeout{SCENE-LINES:\thechapter:\the\prevgraf}}"` → always logs 0 (a 13-line probe scene logged `SCENE-LINES:1:0`). The rendered-line check never fires. -> AC-21; QA-29 not fixed |
| R2-03 | `[qa-code] [major] [-] [scripts/qa.py:296-307] "args.setdefault(m.group(1)…, []).append(str(f))"` → the registry ignores `item['chapter']`. `chapters/00-final-sample.tex` satisfies `13.5` and `0.63`, so changing every `\pct{13.5}` in ch. 4 to 13.6 produced 0 findings. Numbers that are not registered are never checked. -> AC-14; QA-24 partly fixed |
| R2-04 | `[qa-typeset] [major] [page 6] [main.tex:28 \printreferences]` → the reference list spans x = 14.1–151.1 mm while the body text block spans 22.0–160.0 mm (measured on the ×3 render). The list is shifted 8 mm into the left margin. -> PRD §6.3 grid; DS-02 "nothing shifted" |
| R2-05 | `[content] [major] [p. 4] [ch04:114-115] "המאמר ממליץ על רמזורים המציגים את הזמן שנותר … יחד עם תצוגת ספירה לאחור (\en{countdown}), יכול … לבחון את ההמלצה בשטח"` → presents the red-phase countdown (time left to green) as what the project will test. That is rejected Alternative 1. -> PRD §1 v1.4 |
| R2-06 | `[content] [major] [p. 5] [ch04:119] "מערכת המשלבת חישת ממתינים, מדידת זמן המתנה ותצוגת ספירה לאחור עונה ישירות על שלושת הפערים האלה"` → the key finding names a countdown display as the solution and omits adaptive red, the core of v1.4. -> PRD §1 v1.4 |
| R2-07 | `[content] [major] [p. 3] [ch04:93] "שיעור הנשים בקרב החוצים בירוק מודפס כ-\pct{60.8}"` → 829 is the Green/**Green** cell (arrived *and* crossed on green). People who crossed on green number 829 + 487 = 1,316. The sentence misdescribes the cell it criticises. -> AC-14 accuracy |
| R2-08 | `[researcher] [major] [p. 1] [ch04:27] "שני צופים מיומנים עמדו בצד הדרך ותיעדו…"` → close translation of p. 2 §2.3. -> AC-11 (b) |
| R2-09 | `[researcher] [major] [p. 2] [ch04:30] "בסך הכול נצפו \num{1,392} הולכי רגל, מהם \num{842} נשים…"` → clause-for-clause translation of p. 2 §2. -> AC-11 (b) |
| R2-10 | `[researcher] [major] [p. 2] [ch04:51] "נפח התנועה וחצייה של אדם אחר באדום לא נמצאו מנבאים מובהקים"` (with l. 50) → sentence-level translation of p. 3 §3 "Neither Traffic volume, nor the red-light crossing of another pedestrian, significantly predicted…", in the paper's order of claims. -> AC-11 (b) |
| R2-11 | `[researcher] [major] [p. 2] [ch04:52] "וככל שעל המדרכה יותר אנשים, כך פחות אנשים חוצים באדום"` → close translation of p. 4 §4.2 "The more pedestrians present at the curb, the lower was the rate…". -> AC-11 (b) |
| R2-12 | `[qa-img] [major] [p. 5] [figures/g3-relative-odds.pdf] "המחשה: מחוץ לטווח שדווח במאמר"` vs caption ch04:106 `"טווח מספר הממתינים שנצפו אינו מדווח במאמר"` → the figure says a range was reported; the caption says it was not. The solid line to k = 3 implies 0–3 was observed, which no source supports. -> PRD §3.4 do not over-claim; QA-02 new defect |
| R2-13 | `[content] [major] [p. 1] [ch04:15-16] "\section{סקירה תמטית}" + "% TODO round 2"` → an empty section is merged and listed in the TOC (p. א). Ch. 4 cites one source, against the PRD §4 row for a "thematic, critical review". -> PRD §4 ch. 4; booklet §11 |
| R2-14 | `[content] [major] [cover] [main.tex:5] "\Subtitle{מעבר חצייה חכם: ספירה לאחור, חישת ממתינים ושליטה חברתית}"` → the countdown comes first and adaptive red is absent. Still present at HEAD `e08b6bc`. -> PRD §1 v1.4 |
| R2-15 | `[content] [major] [p. 4–5] [ch04:111-114 vs 118]` → the section lists the gaps as "זמן ההמתנה / היקף התצפית / המעבר מתיאור להתערבות"; the findingbox lists "אינו מודד זמני המתנה, נשען על אתר אחד ואינו מאפשר לחשב הסתברות מוחלטת". The two lists differ, and the box claims a display system "עונה ישירות" on the missing-intercept gap, which hardware cannot answer. -> logic consistency; PRD §3.4 |
| R2-16 | `[researcher] [major] [p. 4] [ch04:113] "אתר אחד ושעת בוקר אחת"` and `[PRD.md:71]` "one site, one morning hour" → contradicts ch04:27/97 (eight sessions over six weeks). -> QA-21 / L2 not fully fixed |

### 5.2 Minor (21)

| # | Finding |
|---|---|
| R2-17 | `[qa-infra] [minor] [-] [tests/qa/run_tests.py:52] "scripts/qa.py', 'super', '--pdf', 'build/style-final.pdf'"` → fails on a fresh checkout until the sample is built by hand; the suite does not build its own input. -> AC-18 reproducibility |
| R2-18 | `[qa-BiDi] [minor] [-] [scripts/qa.py rule 2/4 reports] "[samples/figures-test.tex] "2""` → no `:line`. -> PLAN §3.2 standard format |
| R2-19 | `[qa-code] [minor] [-] [scripts/qa.py stale check] "[data/rosenbloom2009_table1.csv] regenerated output differs"` → an *input* CSV is reported as "regenerated output". -> report clarity |
| R2-20 | `[qa-super] [minor] [-] [scripts/qa.py:333] "if f'\\en{{{d}}}' not in c4"` → searches all of ch. 4, not the cautionbox; removing `\en{D5}` from the box ⇒ 0 findings. -> AC-15 (1) |
| R2-21 | `[content] [minor] [p. 2, p. 4] [ch04:44, 112] "המחבר התאים…" / "והמחבר עצמו מציע"` → assigns the author a grammatical gender that the source does not state; a neutral form ("במאמר מוצע…") avoids it. -> PRD §3.1 accuracy |
| R2-22 | `[content] [minor] [p. 1] [ch04:9] "איש לא אמר לו מילה"` → past tense inside the scene. -> PRD §12 "present tense" |
| R2-23 | `[content] [minor] [p. 4] [ch04:95] "כל שאר הערכים המרכזיים משתחזרים במדויק"` → Wald from b/SE: gender 16.76 vs 17.20, waiting 18.26 vs 18.63, joining 12.52 vs 12.00 (rounding, but not "exact"); Hosmer–Lemeshow p = 0.65 cannot be checked. -> over-claim |
| R2-24 | `[content] [minor] [p. 3] [ch04:70] "\en{D5}: שני אחוזים מודפסים אינם תואמים את הספירות"` → 94.4% matches the counts; the 94.3% conflict is table vs Methods text. Only one printed percentage conflicts with the counts. -> AC-15 accuracy |
| R2-25 | `[content] [minor] [p. 1–2] [ch04:28] "בטופס תצפית מובנה … נרשמו … מספר הממתינים שכבר עמדו על המדרכה, מספר המצטרפים אחריו…"` → the paper's grid (p. 2 §2.1) lists "if there was only an individual or a group", date, red/green durations, not counts. -> AC-14 accuracy |
| R2-26 | `[qa-BiDi] [minor] [p. 2] [ch04:49] "(\en{odds ratio})"` → the one English unit breaks across two lines ("odds" ends line 1, "ratio" starts line 2). -> PRD §7 rule 3 |
| R2-27 | `[qa-img] [minor] [p. 2] [ch04:56] "\stattile[SignalAmber]{\num{3.71}}"` → amber means "data issue / caution" (PRD §6.1); the gender OR is not a data issue. -> PRD §6.1 one meaning per colour |
| R2-28 | `[content] [minor] [p. 1] [ch04:20] "כלומר בהקשר שבו אמורה לפעול המערכת המוצעת"` → the deployment context (Tel Aviv / Israel) is defined nowhere in PRD or text. -> unsupported claim |
| R2-29 | `[content] [minor] [p. 1] [ch04:23] "תאוריית השליטה החברתית (\en{social control}), שלפיה אדם הממתין לבדו חש מחויבות חלשה יותר"` → no citation on the sentence; `hirschi1969` is in refs.bib but uncited. The text presents the paper's application as the theory's definition. -> PRD §3.1 cite every claim |
| R2-30 | `[qa-typeset] [minor] [p. 1] [ch04:5] "\chapter{סקירת ספרות ומאמר הדגל}"` → the title wraps with a single word "הדגל" on line 2. -> booklet page check |
| R2-31 | `[qa-infra] [minor] [-] [build/main.pdf page labels] ['1','א','1','2',…]` → the cover is labelled "1", duplicating body page 1 in PDF viewers. -> PRD §4 "cover: no page number" |
| R2-32 | `[qa-cls-version] [minor] [-] [PRD.md §6.3] "right (start) margin 22 mm; left (outer) margin 50 mm"` → renders (and the approved `screenshots/style-final/page-02.png`) give left 22 mm, right 50 mm (`smartcross.cls:29` is swapped by the RTL layout). The PRD describes the mirror image of the approved design. -> PRD accuracy |
| R2-33 | `[qa-img] [minor] [cover] [smartcross.cls:552 @HEAD] "\fill[SignalAmber,opacity=0.16]"` → the cover sensing fan has the QA-01 defect (no hatch, about 1.06:1 in greyscale). -> PRD §6.1 ≥ 3:1 or pattern |
| R2-34 | `[qa-BiDi] [minor] [-] [samples/figures-test.tex:19] "יחסי הסיכויים בטבלה 2 של המקור"` → bare digit (found by qa.py), and the G2 caption differs from ch04:86. -> PRD §7 rule 4 |
| R2-35 | `[qa-code] [minor] [p. 2–4] [ch04:34, 35, 66, 79, 80, 101]` → recomputed values not in `quoted_in_book.json`: ×2.43, 17.17, joining 0.63, 0.92–1.03, 0.79, "כרבע". -> AC-14 |
| R2-36 | `[content] [minor] [p. 3] [ch04:94] "אך אף הצלבה של טבלת הספירות אינה מחזירה ערך זה"` → three tabulations were tried; "no cross-tabulation" over-generalises. -> over-claim |
| R2-37 | `[content] [minor] [p. 2] [ch04:50] "הסיכויים של גבר לחצות באדום גבוהים פי \num{3.71} משל אישה"` → the coding male = 1 is inferred (CSV `coding_note`, QA-16) but is stated as fact. -> AC-14 |

### 5.3 Concept audit summary (PRD §1 v1.4)

| Location (at `68f2501`) | Status at HEAD `e08b6bc` |
|---|---|
| ch04:114–115 countdown as the tested recommendation (R2-05) | open (Writer rewriting) |
| ch04:119 findingbox: countdown display as solution (R2-06) | open (Writer rewriting) |
| ch04:3/13 "פער הידע שהפרויקט נועד לגשר עליו": neutral | ok |
| ch04:21 sensing "can intervene" at the number of people waiting | consistent with adaptive red ✓ |
| main.tex:5 subtitle (R2-14) | **still open** |
| cover art + T1: red figure + "12" (red-phase countdown) | fixed in `e08b6bc` (green walker, "ספירה לאחור בזמן הפינוי בלבד", "בקר: אדום אדפטיבי") |
| PRD.md:71/83 §3.4 "one morning hour" (R2-16) | still open |

---

## 6. Visual audit of ch. 4 (pp. 1–6)

Renders: `/tmp/rt2x/p-0N.png` (×1.6), `/tmp/rt2x/h-0N.png` (×3), plus greyscale crops. Checklists qa-BiDi (B2), qa-table and qa-img.

- **BiDi:** 0 reversed words. Numbers, ranges and χ² read correctly ("0.92–1.03", "20–40", "−24.24", "8,184.53", "(4.1)", "4.1–4.3").
  Times read correctly ("בין 07:30 ל-08:30"). The only defect is R2-26.
- **Tables:** none in ch. 4 at `68f2501`. Tables 1–2 re-typesetting is planned for round 2.
- **Figures:** G1 (p. 2) shows Wilson whiskers, a haloed mean line and grey + hatch; its greyscale render is readable. G2 (p. 4) is correct apart from what QA-03 already covers. G3 (p. 5) has R2-12. Every caption carries `\cite`, and all three figures are referenced in the text (4.1–4.3).
- **Layout:** R2-04 (references shifted into the margin), R2-30 (title widow). The scenebox renders 4 lines ✓ (AC-21). Page 5 is half empty because the chapter ends there.

---

## 7. The 10 weakest points of chapter 4 as a text (booklet Prompt 9)

1. **The chapter argues for the rejected design.** p. 4, l. 115: "חיישן הסופר ממתינים ומודד זמני המתנה, יחד עם תצוגת ספירה לאחור (\en{countdown}), יכול גם לאסוף את הנתונים החסרים וגם לבחון את ההמלצה בשטח."
   The recommendation being tested is the red-phase countdown. The text never mentions shortening red, so the bridge from the paper to the final concept (adaptive red) is missing.
2. **The key finding over-claims.** p. 5, l. 119: "…ותצוגת ספירה לאחור עונה ישירות על שלושת הפערים האלה."
   A display cannot supply the paper's missing intercept, and one installation cannot fix the "one site" gap. The box also lists different gaps from §4.4.
3. **The Results summary is a translation, not an analysis.** p. 2, l. 50–52: "…נפח התנועה וחצייה של אדם אחר באדום לא נמצאו מנבאים מובהקים … וככל שעל המדרכה יותר אנשים, כך פחות אנשים חוצים באדום."
   These lines follow the paper's sentences in order (AC-11 b). They also repeat the "not significant" claim for traffic volume without flagging that D2 contradicts it two pages later.
4. **It misdescribes the cell it criticises.** p. 3, l. 93: "שיעור הנשים בקרב החוצים בירוק מודפס כ-60.8%".
   The criticism of the paper is itself imprecise: the cell is arrived-and-crossed-on-green, not "those who crossed on green".
5. **"Exactly" is a blanket claim.** p. 4, l. 95: "כל שאר הערכים המרכזיים משתחזרים במדויק."
   Three Wald values differ by 0.37–0.52, and the Hosmer–Lemeshow test cannot be checked. The sentence also takes the place of D5's consequence.
6. **The chapter contradicts itself on the study design.** p. 4, l. 113: "השני הוא היקף התצפית: אתר אחד ושעת בוקר אחת…"
   Pages 1 and 4 (l. 27, 97) say eight sessions over six weeks.
7. **A theory is defined without a source, and inaccurately.** p. 1, l. 23: "…תאוריית השליטה החברתית (\en{social control}), שלפיה אדם הממתין לבדו חש מחויבות חלשה יותר לנורמה…"
   Hirschi's theory concerns social bonds. The "alone at the curb" reading is the paper's application. No citation is given, and `hirschi1969` sits uncited in refs.bib.
8. **The paper's relevance rests on an undefined deployment site.** p. 1, l. 20: "הוא נערך בצומת עירוני בתל אביב, כלומר בהקשר שבו אמורה לפעול המערכת המוצעת."
   No chapter or PRD section says where the system will operate.
9. **The main finding is declared safe before its threats are discussed.** p. 3, l. 62: "הן אינן מבטלות את כיוון הממצא המרכזי, אך משנות את גודל האפקט…"
   This is asserted before D6. D6 itself (l. 98) concedes the CIs may be too narrow, which threatens *significance*, and D2 is left unresolved. The sentence claims more than the section shows.
10. **A "literature review" with one source.** p. 1, l. 15–16: "\section{סקירה תמטית}" (empty).
    Every claim in the chapter rests on `rosenbloom2009`. PRD §3.4 requires claims about countdowns or campaigns to come from *other* peer-reviewed studies, yet l. 114–115 already makes such a claim with no source.
