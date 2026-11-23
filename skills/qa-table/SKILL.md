---
name: qa-table
description: Checks every table – caption above, label, referenced in text, booktabs rules, no vertical rules, cell count per row equals the column spec, column 1 on the right, width inside the margins.
---
# qa-table (Detector)

Run: `.venv/bin/python scripts/qa.py table`

## Source checks
- `table` float has `\caption` (above the tabular) and `\label`; the label is `\ref`-ed in the text (AC-08).
- Column spec has no `|`; `\toprule` / `\midrule` / `\bottomrule` used; header row `\headrow \thead{…}`.
- Every row has exactly as many cells as the spec declares.

## Visual checks
- Column 1 is the **rightmost** column (babel `layout=tabular`).
- Table fits the text width (no overfull box in qa-typeset); numbers aligned and readable; units in the header.
- Numbers in the table equal the source/script values (cross-check with qa-code, AC-14).
