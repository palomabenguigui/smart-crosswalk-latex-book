# Final round – QA red team report (pass 1, interim)

Build: `BUILD_DIR=build/redteam scripts/build.sh` → 0 errors, 0 warnings. `qa.py super`: 0 blocker, 0 major, 17 minor (all tooling-level: 13 uncited bib entries, 2 untracked tikz files, 2 page-count notes).
PDF: **16 pages** (front matter 4 pages [cover, TOC, LoF, LoT]; body pages 1–10 printed; references 2 pages). Every page rendered and viewed.
Status of this pass: `final-writer-report.md` and `final-visuals-report.md` did **not exist** when this pass ran. Only chapters 01 and 04 exist; this is NOT the last full pass and must be repeated once both reports exist.

Page numbers below = PDF page (printed page in parentheses).

## Findings (most severe first)

1. [qa-super] [blocker] [page 2–16] [main.tex:29-37] "פרק 2 … פרק 10" -> missing content: only 2 of 10 chapters are in the PDF; no abstract, no abbreviations page, chapters 2, 3, 5–10 absent. The TOC jumps from chapter 01 straight to chapter 04, and §1.5 on p.7 (printed 3) promises nine chapters the reader cannot find. Page count 16 vs AC-01 target 28–32 (AC-01/02).
2. [qa-super] [blocker] [page 5–16] [chapters/] "no chapter presents the final concept" -> PRD §1: the book contains no section stating the final design (adaptive red + clearance-only countdown + campaign) as the solution; the reader sees it only as a one-sentence pivot in §1.4/1.4.1 (printed 2) and the ch04 summary box (p.14). Re-check once ch06/ch07 exist.
3. [qa-table] [minor] [page 10] [chapters/ch04-literature.tex:58] "רוזנבלום [3] | יחיד חוצה יותר | המלצה | לא נמדד | המלצה" -> table 4.1: the word "המלצה" under the column "ספירה לאחור" reads as if the flagship recommends a countdown; this contradicts the final concept (countdown only in the clearance interval). Name what is recommended (e.g. "המלצה: להתערב בהמתנה") or leave the cell empty. Also the source says "לא נמדדה", the rendered cell reads "לא נמדד" (check agreement/clipping).
4. [qa-table] [minor] [page 10] [chapters/ch04-literature.tex:56] header "חישה" -> column header is right-aligned at a different x than the cells below it (cells "לא נמדד / דיוק בינוני / גלאים מותרים" end ~65 px right of the header text); other columns align. Header and body of the "חישה" column look shifted.
5. [qa-BiDi] [minor] [page 3, 4] [chapters/ch04-literature.tex:98,143,161,181] "(עובד מתוך [3])" -> every figure/table caption repeats the citation, so the lists of figures/tables get long entries that wrap, leave "[3])" alone on a line (p.4 table 4.2) and leave a stray "." after "(D4)" in the list of figures (p.3, entry 4.2). Shorten LoF/LoT entries (`\caption[short]{…}`) without the citation.
6. [qa-img] [minor] [page 6] [chapters/ch01-intro.tex:30] "מן המגיעים באדום חצו באדום במעבר שנצפה בתל אביב" -> first stat tile: the last word "אביב" sits on a third line at the bottom border of the tile (tile text overflows the card; the other two tiles have two lines). Shorten the label.
7. [qa-img] [minor] [page 11] [figures/g1-crossing-by-gender.pdf] "קו שגיאה: רווח סמך 95% (וילסון)" -> the legend note sits directly on top of the error-bar whisker of the men's bar and the mean-line label "ממוצע כלל המגיעים באדום: 13.5%" runs into the 20.6% bar region; move the annotations clear of the bars.
8. [qa-typeset] [minor] [page 12] [chapters/ch04-literature.tex:124-130] "ממתינים (0.71 במקום 0.63) ומצטרפים (0.67 במקום 0.63)" -> D1 is easy to misread (two different published values, both "corrected" to the same 0.63, shown with the same number in the green stat tile on p.11 as "0.63 לכל ממתין נוסף"). Tile on p.11 appears before the D1 explanation; the reader meets the recomputed 0.63 without knowing it differs from the published 0.71. Add a pointer to D1 / Table 4.2 in the tile label.
9. [qa-super] [minor] [page 12–13] [chapters/ch04-literature.tex:120-132] "D1 … D7" -> the data-issue list uses codes D1–D7 that the reader meets first on p.7 (printed 3 LoF "(D4)") and p.9 ("סעיף 4.3 (D4)") before D1–D7 are defined on p.12; the forward reference is not marked by a cross-reference.
10. [qa-super] [minor] [page 1] [chapters/front-*] "Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report" -> cover shows the English title in italic amber while the group line reads "קבוצה: shirloma"; the cover has no student names/ID (author line missing) – confirm with the assignment cover requirements.

## Checked – no defect found (counts only)
- Numbers cross-checked inside the book: 1,392 = 842+550; 842/1,392 = 60.5%; 563/1,392 = 40.4%; 76/563 = 13.5%; 48/233 = 20.6%; 28/330 = 8.5%; 512/829 = 61.8%; 98/364 = 27% – 8 of 8 consistent. 13.5% appears in ch01 (tile, §1.3) and ch04 (tile, Fig 4.1) – consistent.
- Figures referenced: 3 of 3 (4.1, 4.2, 4.3); tables referenced: 2 of 2. Bibliography: 16 entries, all English LTR, numbered [1]–[16], matching the in-text numbers seen on pp. 5–14.
- Direction: no reversed Hebrew, no mirrored brackets in the body; mixed English terms (`social control`, `countdown`, `clearance interval`, `adaptive`) render in the right order.
- Close translation of the flagship paper: none seen in ch01/ch04 (paraphrase with explicit "עובד מתוך" credit on figures/tables).
- Contradiction with the final concept: no countdown-during-red is presented as the solution in ch01/ch04 (§1.4.1 and p.14 summary describe it as the abandoned original idea).

## Next pass
Re-run when `final-writer-report.md` and `final-visuals-report.md` exist: all new chapters, front matter, T2–T5/G4 figures, plan/risk tables, page count 28–32.
