# Step 18 – Visual check of the cover (subagent, Sonnet)

Role: Detector (visual). You report only; you fix nothing and edit no file except your report.
Project: /Users/palomabenguigui/BIU/T02 (Hebrew RTL LaTeX book). Built PDF: build/main.pdf (do NOT rebuild it).

Task: render page 1 (the cover) and inspect it at readable zoom:
  osascript -l JavaScript scripts/render_pages.js "$PWD/build/main.pdf" "$PWD/build/qa/page" 1.6
(or any other renderer available), then open the PNG of page 1 and look at it.

Check: (1) the third info column is labelled "מחברים" and lists exactly "פלומה בנגיגי, שירה דביר" (both names present, spelled exactly like that, Hebrew in correct reading order, not reversed); (2) a line "קבוצה: shirloma" (group code) is still present; (3) nothing is clipped, overlapping or outside the frame; the author column does not collide with the course / date lines below it; (4) the old text "קבוצת shirloma" no longer appears; (5) any other visible defect.

Return ONLY a text report, one finding per line, mandatory format:
[skill] [blocker|major|minor] [page N] [file:line] "exact text" -> rule (PRD/AC id)
file:line = the source line responsible (main.tex / smartcross.cls, grep to find it). End with counts, and one line "inspected pages: 1 (cover)". If there are no findings say so with the counts – "OK" alone is a failure.
Do not paste or describe images beyond what the findings need.
