---
name: qa-img
description: Checks figures and images – no raster images except the authors' own photos (photo-*.jpg via \authorphoto), every figure PDF has a generating script, figure files exist, figures have captions, Python colours come only from scripts/palette.py; plus visual checks (labels, overlap, greyscale, colour-blind encoding).
---
# qa-img (Detector)

Run: `.venv/bin/python scripts/qa.py img`

## Checks
- Raster files in `figures/` must be `photo-*.jpg|png` (authors' photos, AC-12); anything else = blocker.
- Every `figures/*.pdf` is produced by a script that names it (AC-04).
- Every `\includegraphics` file exists; every `figure` has a caption (booklet §16.6); `\authorphoto` captions end with "צילום: המחברים".
- Hex colours in Python scripts come from `scripts/palette.py` (PRD §6.1).

## Visual checks (booklet §16.6, PRD §3.3)
1. Hebrew caption that says what the figure shows; numbered and referenced.
2. Labels readable at print size; no overlapping labels; Hebrew in graphs not reversed.
3. Same meaning → same colour across the book.
4. **Never red-vs-green alone**: a second channel (lightness, pattern, label) is present. Check a greyscale render.
5. Photos: no identifiable people without consent; sharp at the printed size.
