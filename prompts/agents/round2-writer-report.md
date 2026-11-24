# Round 2 – Writer report

## Files
| File | Change |
|---|---|
| `chapters/ch04-literature.tex` | §4.1 thematic review (4 themes + literature matrix `tab:litmatrix`); Table 2 re-typeset (`tab:table2`) in §4.3; §4.4 "פער הידע" + `findingbox` rewritten for the final concept (PRD §1); `\label{sec:critical}` on §4.3; §4.1 and §4.4 trimmed for length |
| `chapters/ch01-intro.tex` | new: opener, scene, §1.1 global, §1.2 Israel, statrow, §1.3 flagship insight, §1.4 project in one paragraph + §1.4.1 evidence-driven pivot, §1.5 roadmap ch. 2–10 |
| `data/quoted_in_book.json` | appended 1 entry (`0.63` ← `table2.joining.exp_b_recomputed`, ch04) |
| `main.tex` | `\inputchapter{1}{chapters/ch01-intro}` uncommented and **left uncommented** as instructed |
| `prompts/agents/round2-writer-report.md` | this file |

`build/main.pdf` was rebuilt by my self-check. I did **not** restore it, because the Leader (and the other agents) build in the same `build/` folder concurrently (see note 6).

## Pages
| Chapter | Pages | Target |
|---|---|---|
| 1 Introduction | about 2.3 (3 physical pages, last one about ⅓ full) | ≈ 2.5 ✓ |
| 4 Literature + flagship | **7.0** (7 full physical pages) | ≈ 6.5, about 0.5 page over |

Chapter 4 already had about 4.7 pages before this round (flagship sections, D7, three full-width figures). §4.1 + matrix take about 2 pages and Table 2 about ⅓ page.
I cut §4.1 and §4.4 by about 30% from my first draft (which ran to 8 pages).
To reach 6.5 pages: G1 or G3 at `0.85\linewidth`, or drop the `\paragraph{שיטה.}` detail list. Your call.

## QA (self-check)
`scripts/build.sh`: 0 errors, 0 undefined refs, 0 missing chars, 0 overfull, 0 underfull, 0 warnings.
```
-- ran: cls-version (0), infra (2), typeset (0), bidi (0), table (0), img (0), code (2), content (13) | chapters: 2 files | pdf: build/main.pdf
== super: 0 blocker, 1 major, 16 minor
```
- The 1 major is `qa-code` "data/quoted_in_book.json differs from the committed file". That is a git-state finding (my append is uncommitted), and the prompt says to ignore those.
- Minors: page count (2 of 10 chapters present), an uncommitted new data file from another agent, and 13 new refs.bib entries from the Researcher that are not cited yet.
- Rendered all ch. 1 and ch. 4 pages (PDFKit) and checked them by eye. Hebrew order, numbers, citations, both tables (column 1 on the right, caption above, booktabs) and boxes are correct.

## Numbers registered (AC-14)
- `0.63` → `table2.joining.exp_b_recomputed` (joining row of Table 2 and the cautionbox; it already existed as text but only the waiting path was registered).

## Numbers I need from the Leader (computed, not in `recomputed.json`, so not shown)
1. **Israel pedestrian deaths ≈ 98** (`0.27 × 364`). Ch. 1 currently says "קרוב למאה … חישוב של המחברים, \pct{27} מתוך \num{364}" and has a `% LEADER:` comment.
   After you add the value to `recomputed.json`, replace the words with `\num{98}` and register it.
2. **Derived 95% CIs in Table 2 and §4.3** (`\range{1.98}{6.94}`, `\range{0.50}{0.78}`, `\range{0.49}{0.81}`, `\range{0.92}{1.03}`). The values come from `table2.*.ci_recomputed`.
   They cannot be registered yet: the AC-14 check in `qa.py` only scans `\num`/`\pct` arguments, not `\range`, so registering them would raise false "not in text" majors.
   Suggest extending the regex to `\range{a}{b}` (both arguments).

All other numbers in ch. 1 are **printed in the cited sources** (1.19 million, 5–29, 2030, 364, 4.2 per 100,000, 27%, 77%, 13.5%, 1,392) and are cited, not registered.
Ch. 4 §4.1 numbers are printed in the source abstracts: 1.5–2.5 (`faria2010`), 72%/≈50% (`wickramasinghe2020`), "seven seconds" (`fhwa2025mutcd`).

## Read-depth compliance
- `keegan2003`, `lipovac2013`, `brosseau2013`: **title level only**, in both the text ("לפי כותרתו/כותרותיהם … ממצאיהם טרם נקראו") and the matrix (marked `*`, explained in the caption). No findings or numbers attributed to them.
- `hirschi1969`, `bandura1977`: only as theory origins, as the flagship uses them.
- `who2023`: only landing-page facts. `who2023israel` and `fhwa2025mutcd`: from the notes, including §4I.04.
- The Researcher has since added 13 more keys (`lipovac2013jte`, `vanhouten2007`, …). I did **not** use them: they were not in this round's list and their read depth is unknown to me.

## Final-concept alignment (PRD §1, Step 15)
- Ch. 4 §4.1.3 is where the reader first sees why there is no red-phase countdown (MUTCD clearance-only + `fu2016`).
  §4.1.4 sets up adaptive red as the novelty, and the matrix column "קיצור האדום" is empty except for the flagship's recommendation.
- Ch. 4 §4.4 cites the flagship's §4.2 (time-remaining signals) **and** §4.5 (shorter red at certain times + campaigns). It says the project follows §4.5 for red and the standard for the countdown.
- Ch. 1 §1.4 gives the final concept in one paragraph. §1.4.1 presents the pivot as an evidence-driven strength and points to ch. 6, where the red-phase countdown is Alternative 1 and is rejected.

## Open questions / notes
1. **Length of ch. 4** (see above): which trimming option?
2. **Cross-reference to ch. 6** is written "פרק \num{6}" (ch. 6 does not exist yet). Change it to `\ref{chap:alternatives}` once that label exists.
3. **Roadmap** in §1.5 follows the PRD §4 chapter titles. Ch. 3 is described as including "the safe limits for shortening red", so the ch. 3 writer must deliver that.
4. **Footer glyph bug (seen mid-round, now gone):** once the reference list ran past one page, the References page footer "חוצים באדום" was set in the Latin font (10 missing-glyph blockers). It did not happen at HEAD with ch. 4 alone. After the Leader's concurrent `smartcross.cls` change the final build shows 0 missing chars. Please confirm that the fix was intended and add a regression test (two-page bibliography).
5. In ch. 1 the scene uses a lone **man** (ch. 4's scene also has a man stepping out). The flagship's gender finding makes that plausible. The scene is still a composite with no facts.
6. **Concurrent builds:** two agents building into the same `build/` produced a truncated PDF and a malformed `.bcf` once. I had to retry. Suggest a per-agent `-output-directory` (for example `build/agent-<role>/`) in `build.sh` for parallel rounds.
