# Incident log

Procedure: [`PLAN.md` §6](PLAN.md). An *incident* is a defect that an earlier check should have caught.
Each entry records the symptom, root cause, the fix (always in a source, the `.cls`, a script or a skill: never by hand)
and the **detection gap** closed so it can't recur.

---

## INC-000 – Wrong data issue in the brief: minus signs lost in PDF text extraction
- **Date / found by:** 2026-11-19, Leader during the expert-committee review (Step 05)
- **Symptom:** the brief stated that some Table 2 coefficients in Rosenbloom (2009) are positive while e^b < 1.
- **Root cause:** text extracted from the PDF rendered the minus glyph as `/C0`, so −0.47 read as 0.47. The rendered page shows the minus signs clearly.
- **Fix:** PRD §9 corrected; the real inconsistencies (D1–D6) were recomputed and documented.
- **Detection gap closed:** the Researcher skill must check every transcribed number against a *rendered image* of the source page; `data/*.csv` records the page of each value (`data/README.md`).
- **Showcase:** presented in the README as a real red-team example.
- **Fix commit:** 9dacd01 (Step 06). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-001 – Noto Hebrew fonts have no digits, Latin letters or punctuation
- **Date / found by:** 2026-11-23, font + BiDi smoke test (Step 08)
- **Symptom:** in Hebrew paragraphs, "13.5%", "0.51–0.78", "2009" and commas were silently dropped; the log showed `Missing character` for U+0030–U+0039, U+002C, U+002E, U+0025, U+2013.
- **Root cause:** Noto Serif Hebrew / Noto Sans Hebrew cover only the Hebrew block; the build exited 0, so only the log revealed it.
- **Fix:** luaotfload fallback chains (`schebrm`, `schebrmbf`, `schebsf`, `schebsfbf`) from the Hebrew fonts to Noto Serif / Noto Sans, defined in `smartcross.cls`; `\setmathrm` set to Noto Serif.
- **Detection gap closed:** `scripts/build.sh` counts `Missing character` lines and `qa-typeset` must fail on any non-zero count (AC-03).
- **Fix commit:** 667c2a2 (Step 08). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-002 – Hebrew reversed in every Python graph
- **Date / found by:** 2026-11-24, Leader, visual inspection of the rendered figures G1–G3 (P5, Step 13)
- **Symptom:** all Hebrew labels in `figures/g1…g3.pdf` read backwards ("מודאב םיצוחה רועיש" for "שיעור החוצים באדום").
- **Root cause:** the `python-graphs` skill prescribed `python-bidi`'s `get_display()` (the classic workaround), but matplotlib 3.11 already applies the bidi algorithm itself → the text was reversed twice. Also, without an RTL base direction, numbers sat on the wrong side, and in multi-line labels the RTL mark only affects the first line.
- **Fix:** `scripts/figstyle.py` `he()` returns logical-order text with a leading RLM (U+200F); one line per text object; G1 counts moved into the bars.
- **Detection gap closed:** `qa.py img` now runs the BiDi scan on every `figures/*.pdf` in **logical** extraction order (matplotlib PDFs extract in reading order, LuaTeX PDFs in visual order); it flagged 23 reversed words on the bad figures and 0 after the fix. Two regression tests added to `tests/qa/run_tests.py`; the `python-graphs` skill now forbids `get_display()`.
- **Fix commit:** e944a44 (Step 13.6). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-003 – The committee's "every value recomputed" missed the age chi-square
- **Date / found by:** 2026-11-24, QA red team round 1 (QA-15)
- **Symptom:** PRD §9 claimed full recomputation, but the printed age χ²(2, N = 1392) = 1.02 had never been checked; it does not reproduce (2.95 / 0.96 / 0.55).
- **Root cause:** recomputation covered the tables' cells and the gender test only; test statistics quoted in the *text* of the paper were not inventoried.
- **Fix:** issue D7 (PRD §9, ch. 4); `recompute_table2.py` computes all age variants.
- **Detection gap closed:** the Researcher skill must inventory every statistic printed in the source text as well as the tables; AC-15 now checks every Dn of PRD §9 in ch. 4 automatically.
- **Fix commit:** 68f2501 (Step 14). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-004 – QA detectors that could pass while the defect was present
- **Date / found by:** 2026-11-24, QA red team round 1 (QA-22 … QA-33)
- **Symptom:** "unverified" counted as verified; any word in any figure masked book-wide; AC-14 vacuous; reversed words without final letters invisible; scene lines estimated from characters.
- **Root cause:** detectors were tested only for *firing on a planted defect*, not for *false passes* (negative cases that must still be reported).
- **Fix:** each gap fixed in `scripts/qa.py`; register `data/quoted_in_book.json`; `\prevgraf` scene measurement in the `.cls`.
- **Detection gap closed:** 5 new regression tests target false passes (24 tests in total); every future detector gets a "must fire" **and** a "must not be masked" test.
- **Fix commit:** 68f2501 (Step 14). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-005 – Skills documented stale targets
- **Date / found by:** 2026-11-25, the students (human review of the repository)
- **Symptom:** `skills/qa-cls-version` said the class target is v1.0 and `skills/qa-infra` said 28–32 pages, while the code used v1.5 and 40–46 pages (PRD AC-01).
- **Root cause:** version bumps and the Step 17 page-range change were made in the code (`CLS_TARGET`, `qa.py`, PRD) but not in the skills. Not detected because no check linked skill text to the code.
- **Fix:** the skills now refer to `CLS_TARGET` and AC-01 instead of repeating numbers.
- **Detection gap closed:** `qa.py infra` fails when a version or page range in `skills/*/SKILL.md` contradicts `CLS_TARGET` or PRD AC-01; regression test in `tests/qa/run_tests.py`.
- **Fix commit:** 20c7cda (Step 18). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-006 – The final red-team pass was interim and never repeated on the full book
- **Date / found by:** 2026-11-25, the students (human review of the repository)
- **Symptom:** the only red-team pass covered 16 pages (ch. 1 and 4). Chapters 2, 3 and 5–10 of the 45-page book were checked only by the Leader, who had also fixed them – this breaks PLAN §4 ("a fixer never marks its own work as verified").
- **Root cause:** the Step 16 "finish efficiently" decision allowed the merge without a re-run gate.
- **Fix:** the full-book red-team round is scheduled after Step 18 (TODO P8).
- **Detection gap closed:** exit gate in PLAN §4 and `skills/qa-super/SKILL.md` – a final round cannot be merged unless a red-team report exists whose inspected page count equals the built PDF's; `qa.py infra --redteam <report>` and a regression test enforce it.
- **Fix commit:** 20c7cda (Step 18). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-007 – The cover had no author names
- **Date / found by:** 2026-11-25, the students (human review of the repository)
- **Symptom:** the cover showed only "קבוצת shirloma"; red-team finding 10 (`final-redteam-report.md`) named this and was left open with no owner.
- **Root cause:** minor findings had no status tracking, so nobody owned it.
- **Fix:** `\Authors{פלומה בנגיגי, שירה דביר}` in `main.tex`; the `.cls` (v1.6) prints the authors and keeps the group code line "קבוצה: shirloma".
- **Detection gap closed:** every finding must get a status in a Fixer report (`skills/fixer/SKILL.md`, PLAN §4).
- **Fix commit:** 20c7cda (Step 18). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

## INC-008 – A gate was documented but not coded; README/PLAN claims drifted from the repository
- **Date / found by:** 2026-11-25, QA red team of round final2 (RT-01, RT-03, RT-05, RT-06), confirmed by the Fixer
- **Symptom:** PLAN §4, `skills/qa-super/SKILL.md` and INC-006/INC-007 said the final round cannot be merged unless every red-team finding has a status in a Fixer report, "checked by `qa.py infra --redteam`". The script only compared page counts. In the same way the README and PLAN stated "9 front matter + 36 body" pages, "12 skills (8 QA + 4 production)" and `.cls` v1.0, while the repository had 10 + 35, 13 skills (8 + 5) and v1.7.
- **Root cause:** documentation drift (INC-005 class). A rule was written into the documents when the gate was designed, but the code was never changed to enforce it; and the INC-005 check covered `skills/*/SKILL.md` only, not README/PLAN/PRD.
- **Fix:** `check_fixer_statuses` in `scripts/qa.py` (every `RT-nn` / `R2-nn` / `QA-nn` finding needs a FIXED / REJECTED / DEFERRED row in the Fixer report; a missing report is a blocker) and `check_doc_claims` (README/PLAN page split, skill counts and `.cls` version against the PDF, `skills/` and `CLS_TARGET`); stale numbers corrected in README, PLAN and PRD.
- **Detection gap closed:** the RT-01 check and its regression tests in `tests/qa/run_tests.py` (3 for the Fixer statuses, 2 for doc claims). Rule from now on: a gate described in a document must have a test that fails when the gate is open.
- **Fix commit:** the Step 19 commit (tag `v1.0-submission`). **Screenshot:** none – the defect was found and fixed in the same session without a screenshot of the broken state; the fixed result is in `screenshots/`.

---

## Style-sample findings (Step 09) – found by page-render inspection, all fixed in `smartcross.cls`

These defects were found by the planned design inspection (render every page → look), not by a missed check.
They're recorded because each one becomes a regression check in `qa-BiDi` / `qa-typeset`.

| ID | Symptom on the rendered page | Root cause | Fix in `smartcross.cls` |
|---|---|---|---|
| DS-01 | Hebrew inside TikZ nodes reversed ("קרפ", chapter titles, "תורוקמ", footer) | TikZ pictures are built in an LTR box; node text inherits LTR | TikZ style `rtl` (`\pardir TRT\textdir TRT`) on every Hebrew node |
| DS-02 | Every tcolorbox frame shifted off the right page edge; titles invisible, text faded | tcolorbox draws its frame with TikZ in LTR coordinates inside an RTL paragraph | Public box environments build the box in an LTR paragraph, title + content set RTL (`before upper/title`) |
| DS-03 | "טבלה 1.4" / "(1.4)" in chapter 4 (should be 4.1) | babel `layout=counters` reorders numbers that `bidi=basic` already handles | Dropped `counters` (`layout=tabular` only) |
| DS-04 | Citation brackets broken: "[,1", then mirrored "]1[" | Brackets are mirrored in a Hebrew run, even inside an LTR box | `\cite` wrapped as one LTR **English** unit |
| DS-05 | TOC entries after the first chapter set in the Latin font, 174 missing glyphs | biblatex `autolang=other` wraps each citation in `otherlanguage`, writing `\babel@toc{english}` into the TOC | `autolang=none`; language handled by the `.cls` |
| DS-06 | No traffic-light lamp lit | Lamp test compared against an unexpanded macro (`\def` instead of `\edef`) | `\edef\sc@ph{#1}` |
| DS-07 | Cover "©" detached on its own line | `\num` at paragraph start added an `\hbox` to the vertical list | `\num` starts with `\leavevmode` |
| DS-08 | Cover art pushed to the right | LTR box inside a centred RTL paragraph | `\sc@ltrcenter` (LTR box `to\linewidth` with `\hss` on both sides) |
| DS-09 | Bibliography title opened with a Hebrew quote ”…” | csquotes kept the Hebrew quote style after `autolang=none` | `\setquotestyle{english}` inside `\printreferences` |
| DS-10 | Log warnings: csquotes missing; "Language 'hebrew' not supported" (biblatex, csquotes) | No Hebrew modules in biblatex/csquotes | Load `csquotes`; `hebrew.lbx` inherits English strings; Hebrew quote style declared |

## Design-direction findings (Step 10) – found by page-render inspection of samples A and B, all fixed in `smartcross.cls` v0.2

| ID | Symptom on the rendered page | Root cause | Fix in `smartcross.cls` |
|---|---|---|---|
| DS-11 | B: English phrase hyphenated at a line end next to RTL text ("countdown sig--ו") | English words inherited normal hyphenation inside a Hebrew paragraph | `\en` sets `\lefthyphenmin=\righthyphenmin=62`: English inside Hebrew never hyphenates |
| DS-12 | Margin notes justified with huge gaps, one word per line | Narrow justified column | `\sidenote` is ragged, no hyphenation |
| DS-13 | Thumb tab overlapping the chapter band; page 4 tab showing "03" for chapter 1 | Tab position above band bottom; tab read `\c@chapter` at ship-out (after `\setcounter`) | Tabs start below the band (112/162/212 mm); number frozen at chapter start (`\sc@tabnum`) |
| DS-14 | A: chapter title/mission running close to the giant number | Title block 104 mm wide | Title block 96 mm |
| DS-15 | Stat row 1.5–3.8 pt overfull / underfull | Spaces between tiles; tile border widening the bounding box; no stretch | `\ignorespaces`, clamped bounding box, gap `4mm plus 2pt minus 1pt` |
| DS-16 | Photo float alone on a vertically centred page | Default float-page centring | Float pages top-aligned (`\@fptop` = 0pt) |
| DS-17 | Font warning: Hebrew italic undefined (cover) | `\itshape` selected before switching to English | Italic selected inside `\en` |
| DS-18 | Cover: sensing zone clipped at the page top; pedestrians too small to read | Fan angles reached above the sidewalk | Fan turned along the sidewalk (154°–186°); pedestrians ×1.45 |
| DS-19 | B: closing crosswalk rule alone on an otherwise empty last page | Ornament placed after a full page | `\crosswalkrule` is dropped at a page top or when < 20 pt remain |

| DS-20 | T1 TikZ diagram mirrored and shifted off the page inside `ltrblock` | `\pardir TLT` alone is overridden: babel resets the paragraph direction from the language | `ltrblock` now builds its content in an explicit `\hbox dir TLT` (lrbox), centred |
| DS-21 | `qa-BiDi` flagged the Hebrew of embedded graphs in the book PDF (false positive) | matplotlib text keeps logical extraction order inside the LuaTeX PDF | The book scan skips words from `figures/*.pdf`; `qa-img` scans those in logical mode |

| DS-22 | Chapter 4 rendered as "Chapter 01" (red lamp, red tab) in the partial book | the chapter counter follows the order of `\input`s; chapters 1–3 not yet written | `\inputchapter{N}{file}` sets the counter, so number, phase, lamp and tab are fixed per file |

Build-time errors met while writing v0.2 (not visual defects): `\pdfstrcmp` doesn't exist in LuaTeX; `\@seccntformat` is
expanded inside `\protected@edef`; `\@fptop`/`\@fpsep`/`\@fpbot` are skip registers in LaTeX 2025+ (use `\setlength`);
xcolor can't append `!70!black` to an expression that is already a mix.
