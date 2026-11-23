---
name: qa-BiDi
description: Hebrew/English direction audit – source lint (English via \en, numbers via \num/\pct/\range/\unit, maqaf after prefix letters, no typed citation brackets) and PDF audit (reversed Hebrew, mirrored brackets, hyphenated English), plus the booklet's Prompt B2 visual checklist.
---
# qa-BiDi (Detector)

Run: `.venv/bin/python scripts/qa.py bidi --pdf build/main.pdf`

## Source checks (PRD §7)
- Latin words outside `\en{}` / `\cite` / math → major (rule 2).
- Digits outside `\num` / `\pct` / `\range` / `\unit` / math → major (rule 4).
- Prefix letter(s) glued to `\num`/`\en` without maqaf ("ו\num{…}") → minor (rule 12).
- Typed brackets "[3]" instead of `\cite` → major (rule 13).

## PDF checks (pypdf extracts Hebrew in VISUAL order)
- A Hebrew word whose **final letter (ךםןףץ) is extracted at its end** was rendered reversed → blocker (DS-01).
- `]1[` → mirrored citation brackets → blocker (DS-04).
- `word--` → English hyphenated beside RTL text → major (DS-11).

## Visual checklist (booklet Prompt B2) – every page image
- Paragraphs start at the right; nothing hugs the left margin.
- Numbers, decimals, ranges, versions, percentages in the right order; section/figure numbers read 4.1, not 1.4 (DS-03).
- Headers, footers, TOC rows, captions, tables, boxes, tiles and chapter bands: Hebrew not reversed (DS-01, DS-02).
- No diagram, box or background shifted off the page (DS-02).

Report page + exact text + rule. Do not fix. A repeated defect is routed to the `.cls` (booklet §14.6).
