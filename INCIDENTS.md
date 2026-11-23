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

## INC-001 – Noto Hebrew fonts have no digits, Latin letters or punctuation
- **Date / found by:** 2026-11-23, font + BiDi smoke test (Step 08)
- **Symptom:** in Hebrew paragraphs, "13.5%", "0.51–0.78", "2009" and commas were silently dropped; the log showed `Missing character` for U+0030–U+0039, U+002C, U+002E, U+0025, U+2013.
- **Root cause:** Noto Serif Hebrew / Noto Sans Hebrew cover only the Hebrew block; the build exited 0, so only the log revealed it.
- **Fix:** luaotfload fallback chains (`schebrm`, `schebrmbf`, `schebsf`, `schebsfbf`) from the Hebrew fonts to Noto Serif / Noto Sans, defined in `smartcross.cls`; `\setmathrm` set to Noto Serif.
- **Detection gap closed:** `scripts/build.sh` counts `Missing character` lines and `qa-typeset` must fail on any non-zero count (AC-03).

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
