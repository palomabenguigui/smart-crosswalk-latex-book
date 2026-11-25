# Prompt Engineering Log

Every prompt given to the AI agents in this project is recorded here **verbatim**, in chronological order.
Earlier entries are never edited or summarized.

---

## Step 01 – Repository setup
**Date/time:** 2026-11-19 13:54

```text
Set up a brand-new project repository for Assignment 02 (Hebrew PDF book in LaTeX, produced by a team of AI agents). Do NOT write any book content yet. Do the following:

1. Create this folder structure (with a .gitkeep in each empty folder):
   references/   chapters/   figures/   scripts/   skills/   prompts/   screenshots/   build/

2. Create CLAUDE.md in the root with these standing rules for every future session:
   - PROMPT LOGGING: before doing any task, append the user's prompt VERBATIM to prompts/PROMPTS_LOG.md, under a header with the step number, date/time and a one-line title. Never edit or summarize earlier entries.
   - After finishing each task: git add, commit with a clear message, and git push.
   - Book language is Hebrew (RTL); code, commands and file names are in English.
   - Never copy text from the source paper; always paraphrase and cite.
   - Copyright: no images from the internet; illustrations are drawn with TikZ or Python.

3. Create prompts/PROMPTS_LOG.md and log THIS prompt as "Step 01 – Repository setup".

4. Create a .gitignore suitable for LaTeX + Python on macOS (aux, log, toc, bbl, bcf, run.xml, synctex.gz, __pycache__, .DS_Store, etc.). Keep the final PDF tracked.

5. Create an initial README.md (English, with a short Hebrew subtitle) containing: project title "Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report", course (Generative AI: LLMs, Agents and Multi-Agent Systems – Dr. Yoram Segal, Bar-Ilan University), group code shirloma, a "Project status: in progress" badge, and placeholder sections: Overview, Agent Team, Repository Structure, How to Build (lualatex → biber → lualatex ×2), Screenshots, Prompt Engineering Log (link to prompts/PROMPTS_LOG.md), Credits.

6. Run git init (if needed), make the first commit, then create a NEW PUBLIC GitHub repository named shirloma-ex02 with the gh CLI and push. Show me the repository URL at the end.
```

---

## Step 02 – Rename GitHub repository
**Date/time:** 2026-11-19 13:57

```text
Rename the GitHub repository to smart-crosswalk-latex-book using the gh CLI (gh repo rename), make sure the local "origin" remote points to the new URL (check with git remote -v and fix it if needed), update the repository name anywhere it appears in README.md, then commit, push and show me the new URL.
```

---

## Step 03 – Open references folder
**Date/time:** 2026-11-19 14:15

```text
open~/BIU/T02/references
```

---

## Step 04 – Reference materials
**Date/time:** 2026-11-19 14:18

```text
Step 02 – Reference materials. The folder references/ now contains copyrighted PDFs (the Elsevier paper and the course booklets). The repository is public, so:

1. Add a rule to .gitignore so that all PDF files inside references/ are never committed (references/*.pdf). Verify with git status that none of them are staged; if any was already committed, remove it from the index with git rm --cached (keep the local file).
2. Create references/README.md listing each reference file by title, author, year and purpose in this project (e.g., "flagship paper", "assignment definition", "report-writing guide", "multi-agent guide"), with a note that the files are kept locally for copyright reasons. For the paper include its full citation and DOI: 10.1016/j.trf.2009.05.002.
3. Read every file in references/ and give me a short summary (5 lines max per file) so I can confirm you can access them.
4. Log this prompt, commit and push.
```

---

## Step 05 – Expert committee and PRD
**Date/time:** 2026-11-19 14:22

```text
Step – Expert committee and PRD. Using everything you just read in references/ (especially the assignment brief and its 8-step workflow, and Parts A and B of the preparatory-report booklet), act as the leader of an expert committee.

PROJECT VISION
- Deliverable: a professional Hebrew PDF book of at least 25 pages (target 28–32), compiled with LuaLaTeX and a custom .cls, written as a "preparatory report" (דוח מכין) for a technology-management project: a SMART PEDESTRIAN CROSSING (countdown signal + sensing of pedestrians waiting at the curb + a "social control" awareness campaign), motivated by the findings of the flagship paper (Rosenbloom 2009) and its own recommendation of countdown lights.
- The Rosenbloom paper is the flagship paper (מאמר הדגל). Use its data (Table 1, Table 2) with citation; never copy its text.
- Our own visual identity (not model defaults): a traffic-light palette (red / amber / green on dark asphalt grey), chapter openers styled like road signs, colored "fancy" callout boxes, crosswalk-stripe decorative rules.

COMMITTEE
Assemble 5–6 experts (academic Hebrew editor, LaTeX/BiDi typesetter, data-visualization engineer, road-safety researcher, technology project manager, QA/red-team lead). Each states what a top-grade (100) version must meet; then merge into one document.

OUTPUT — create in the project root:
1. PRD.md — goal, audience, chapter structure with page allocation following the booklet (abstract, introduction, problem & research question, requirements, literature review + flagship paper, market/existing products, design alternatives + weighted decision matrix, system architecture, WBS/RACI/Gantt, risk analysis, summary, IEEE bibliography); mandatory elements (table of contents, list of figures/tables, abstract, ≥1 Python graph, ≥1 table, ≥1 formula such as the logistic regression model, ≥1 TikZ illustration, no copyrighted images); design system (colors, fonts, boxes, header/footer/banner); BiDi rules for Hebrew/English mixing; measurable acceptance criteria. Add a "Known data issues" section: in the paper's Table 2 some b coefficients are positive while e^b < 1, traffic volume b = 0.03 does not match e^b = 2.20, and the results text says both hypotheses failed while the discussion says H1 was supported — the book must discuss these critically.
2. PLAN.md — the 8-step workflow of the brief; the agent team (Writer, Researcher/bibliography, Python-graphs agent, TikZ-illustrations agent, and the QA skills qa-super, qa-BiDi, qa-table, qa-code, qa-img, qa-typeset, qa-infra, qa-cls-version) with a Detector→Fixer red-team loop; the rule that no output is fixed by hand (every fix goes through a skill or the .cls) plus an incident-investigation procedure for every bug we find ourselves; folder structure; compile sequence (lualatex → biber → lualatex ×2).
3. TODO.md — an ordered checklist of tasks matching PLAN.md.

Show me a short summary of the committee's main decisions. Do not write any book content yet. Log this prompt, commit and push.
```

---

## Step 06 – PRD approval and amendments
**Date/time:** 2026-11-19 14:33

```text
1. PRD approved, including the INC-000 correction (keep it: it will be shown in the README as a real red-team example). Add these changes:
   a. A "Writing style" section in PRD.md and PLAN.md: the Writer agent has a defined authorial voice — each chapter opens with a brief real-life street scene at a crosswalk (max 4 lines, in a styled opener box), then switches to the formal third-person academic register required by the Hebrew editor.
   b. AC-19: README.md shows screenshots of book pages, the Python graphs, the TikZ illustrations and the agent team in action (stored in screenshots/).
   c. AC-20: evidence that at least 3 agents ran in parallel (Writer, Researcher, QA red team), with screenshots and their prompts in prompts/.
   d. Researcher rule: every bibliography entry must be verified online (DOI or URL opened and checked); unverifiable sources are dropped, never invented.
   Mark the PRD-approval item in TODO.md as done.
```

---

## Step 07 – P1 environment setup
**Date/time:** 2026-11-19 14:40

```text
Go ahead with P1. Before starting:

0. Fix .gitignore: references/VERIFICATION.md must be committed. Add the exception !references/VERIFICATION.md and verify with git status that it is tracked while the PDFs stay ignored.

Then set up the environment on macOS:
1. Update MiKTeX to the latest version and update all packages. If any step needs my action (admin password, MiKTeX Console GUI), stop and tell me exactly what to do.
2. Create a Python virtual environment in .venv (add it to .gitignore), install matplotlib, numpy and python-bidi, and save requirements.txt.
3. Download the OFL-licensed Noto Serif Hebrew, Noto Sans Hebrew, Noto Serif, Noto Sans and Noto Sans Mono fonts into fonts/, include their OFL license files, and verify that LuaLaTeX loads them with a minimal Hebrew+English test document compiled in build/ (do not commit the test PDF).
4. Report what was installed with versions. Log this prompt, commit and push.
```

---

## Step 08 – Switch toolchain to TeX Live 2026 (MacTeX)
**Date/time:** 2026-11-23 21:46

```text
MacTeX is installed (LuaHBTeX 1.24.0, TeX Live 2026, biber 2.21) in /Library/TeX/texbin — add it to PATH for this session if needed. Homebrew's cask failed on macOS 14, so it was installed directly from the downloaded .pkg; MiKTeX is no longer used.

1. Re-run the font + BiDi smoke test and confirm it compiles cleanly.
2. Update README with one short paragraph: MiKTeX for macOS is frozen at 22.1 and cannot compile current Hebrew babel, so the project uses TeX Live 2026 (MacTeX) with the same LuaLaTeX + biber toolchain.
3. Adapt PLAN.md, TODO.md and the qa-cls-version / qa-infra checks to TeX Live 2026 instead of MiKTeX 25.x.
4. Mark P1 done in TODO.md, report versions, log this prompt, commit and push.
```

---

## Step 09 – P1b project skeleton and style sample
**Date/time:** 2026-11-23 22:47

```text
Go ahead with P1b (project skeleton), with this addition:

1. Build smartcross.cls v0.1 implementing the full design system of PRD §6 (colour tokens, Noto fonts loaded by path, banner header, footer, road-sign chapter openers with the 3-lamp traffic-light progress indicator, crosswalk-stripe rules, the boxes findingbox / cautionbox / trapbox / definitionbox / projectbox / scenebox, booktabs tables, BiDi template commands \en, \num, \range, etc.), plus main.tex, build.sh, data/, INCIDENTS.md (INC-000, INC-001) and the skills mirror.

2. Create a temporary STYLE SAMPLE (chapters/00-style-sample.tex, Hebrew placeholder text) that shows on 4–6 pages: the cover, the table of contents, one chapter opener (red lamp) and one with the amber lamp, every box type, a sample table, a numbered formula, mixed Hebrew/English sentences with numbers and percentages, and the header/footer.

3. Build it, render the pages to PNG in screenshots/style-sample/, inspect them yourself for BiDi and layout defects, fix through the .cls only, then show me the result and stop so I can approve the design before any real content is written.

Log this prompt, commit and push.
```

---

## Step 10 – Premium redesign: two design directions (A editorial, B engineering)
**Date/time:** 2026-11-23 23:17

```text
The style sample is functional but looks generic. Redesign smartcross.cls so the book looks like a premium, professionally designed report (think high-end municipal / engineering consultancy report or an editorial annual report), clearly the result of deliberate design work. Keep the PRD identity (asphalt + signal red/amber/green, road-sign language, crosswalk stripes) but raise the craft level:

- COVER: full-bleed design; a large TikZ aerial (top-down) view of a crosswalk with zebra stripes, curb, a countdown signal head and stylised pedestrian silhouettes casting shadows; title block on a solid asphalt band; small "דוח מכין" label styled like a road-sign plate.
- CHAPTER OPENERS: full-width asphalt band with a very large chapter number, the 3-lamp traffic-light indicator, a one-line chapter "mission" subtitle, and the scenebox below.
- THUMB TABS: coloured tabs on the outer page edge per phase (red ch.1–3, amber ch.4–7, green ch.8–10) so the book's structure is visible from the side.
- KEY-FIGURE TILES: a "stat tile" component (big number + short label) for headline data such as 13.5% or 1,392 pedestrians.
- PULL QUOTES and MARGIN NOTES components, a refined typographic hierarchy (sizes, weights, spacing, small caps/letter-spacing for English labels), and a consistent grid.
- PICTOGRAMS: a small set of TikZ icons (pedestrian, signal head, sensor, warning triangle) reused in boxes and headings.
- PHOTO: add an "authorphoto" figure style for our own photograph (figures/photo-crosswalk.jpg, taken by us — no internet images) with a caption that credits "Photo: the authors"; add this to PRD §5 and §10 as an allowed image source.

Produce TWO distinct design directions as separate style samples (A: bold editorial, B: clean engineering-report), each 5–6 pages showing cover, TOC, two chapter openers, all boxes, a stat tile, a table, a formula and a placeholder photo frame. Render both to PNG in screenshots/style-sample-A/ and -B/, self-inspect for BiDi/layout defects, fix only via the .cls, then stop and show me both so I can choose. Log this prompt, commit and push.
```

---

## Step 11 – Add the authors' crosswalk photograph
**Date/time:** 2026-11-24 00:09

```text
cp ~/Downloads/IMG_9744.* ~/BIU/T02/figures/photo-crosswalk.jpg
open ~/BIU/T02/figures/photo-crosswalk.jpg
```

---

## Step 12 – Resize the authors' photo and rebuild the samples
**Date/time:** 2026-11-24 00:10

```text
I added my own photo at figures/photo-crosswalk.jpg. Resize it to max 2400 px wide at good JPEG quality, then rebuild the sample so it replaces the placeholder. Log this prompt, commit and push.
```

---

## Step 13 – Final mixed design, final sample, then continue to P2
**Date/time:** 2026-11-24 00:12

```text
Design decision: use a MIX. From A: cover, chapter openers, stat tiles, thumb tabs, footer, serif body with the wide outer margin for notes. From B: boxes with a coloured side bar and coloured title text, and booktabs tables.

1. Implement this as the single final design in smartcross.cls (bump the version), remove the unused A/B branches and delete both style samples — do NOT rebuild them.
2. My own photo is at figures/photo-crosswalk.jpg: resize it to max 2400 px wide at good JPEG quality and use it in the \authorphoto frame.
3. Build ONE short final sample (cover + one chapter opener + one content page with the photo), render it to screenshots/style-final/, self-inspect and fix only via the .cls. Update PRD §6 to describe the final design.
4. Then continue with the next TODO phase (P2) without waiting for me. Stop only when (a) a step needs my decision, or (b) you reach the point where the Writer, Researcher and QA agents must run in parallel — then stop and tell me, because I will launch them in separate Terminal windows.

Log this prompt, commit and push after each step.
```

---

## Step 14 – Merge parallel round 1, QA, prepare round 2
**Date/time:** 2026-11-24 14:46

```text
The three agents finished round 1 (reports in prompts/agents/round1-*-report.md). Merge their results, run the QA skills, fix via the owning agents or the .cls, log the round, commit and push. Then prepare round 2.
```

---

## Step 15 – Design pivot: clearance-only countdown + adaptive red + campaign
**Date/time:** 2026-11-24 15:01

```text
Decision on the countdown question: the project changes, based on the evidence. Final concept = countdown ONLY during the pedestrian clearance interval (standard-compliant, MUTCD §4I.04) + ADAPTIVE RED: curb sensing detects pedestrians waiting (especially a lone pedestrian) and shortens the red phase within safe limits (grounded in the paper's §4.5 recommendation and its lone-pedestrian finding) + the social-control campaign. A red-phase countdown is NOT part of the solution: it becomes Alternative 1 in chapter 6, compared in the weighted decision matrix and rejected with the MUTCD and fu2016 evidence; Alternative 3 = campaign only. Present this pivot explicitly in the book as an evidence-driven design change. Update PRD §1 (bump version), the round-2 prompts (especially the Writer's chapter 1 brief) and TODO.md before I launch round 2. Log this prompt, commit and push, then tell me when to launch.
```

---

## Step 16 – Finish efficiently: one final parallel round
**Date/time:** 2026-11-24 15:18

```text
Change of pace: the goal now is to FINISH efficiently. Do not add new acceptance criteria, tests or extra review rounds.

1. Countdown decision: final concept = countdown ONLY during the pedestrian clearance interval (MUTCD §4I.04) + ADAPTIVE RED (curb sensing shortens the red phase when pedestrians, especially a lone pedestrian, are waiting — grounded in the paper's §4.5 and its lone-pedestrian finding) + the social-control campaign. Red-phase countdown becomes Alternative 1 in chapter 6, rejected in the decision matrix with the MUTCD and fu2016 evidence; campaign-only is Alternative 3. Present this as an evidence-driven design change. Update PRD §1.

2. Replace rounds 2+ with ONE final round covering everything left: all remaining chapters, remaining figures (G4, T2–T4), cover, front matter and README. Prepare the 3 agent prompts (writer, researcher+visuals, redteam), tell me the 3 commands, and I will launch them once.

3. After that round: merge, run QA once, fix blockers and majors only (minors may stay), build the final PDF, update README with screenshots, commit and push. Only stop if something truly needs my decision.

Log this prompt, commit and push.
```

---

## Step 17 – Merge the final round, final PDF, README
**Date/time:** 2026-11-25 00:31

```text
The final round is done (reports in prompts/agents/final-*-report.md). My agent screenshots are in screenshots/agents/.

Decisions:
1. Page count: accept the current length. Change the PRD target to 40–46 pages (the brief only sets a minimum of 25). Do NOT cut content.
2. Team targets approved as written (25% reduction, 90% counting accuracy, 30% max red shortening), clearly labelled as the team's own targets.
3. Fix the three visible .cls defects from the Writer's report (table header alignment in wrapping columns, ragged-right in narrow columns, abstract page numbering in Hebrew letters).
4. Add \inputfigure, \includefigure and \addcontentsline to SAFE_CMDS in qa.py so the 30 false majors disappear. Cite lenne2007 and pele2019 where relevant or remove them from the bibliography.

Then merge, run QA, fix blockers and majors only, build the final PDF, update the README with all screenshots (note that the agents ran on different models by task: Writer on the main model, Visuals and QA red team on Sonnet), commit and push. Only stop if something truly needs my decision.
```

---

---

## Step 18 – Process cleanup before the last red-team round
**Date/time:** 2026-11-25 19:35

```text
Step 18 – Process cleanup before the last red-team round. Log this prompt first (rule 1). An external review of the repository against the assignment brief found the gaps below. Fix them in sources only, never by hand in the output. Don't change chapter content: this round is about the process, not the text.

1. Stale documentation – make the docs match the code:
   - skills/qa-cls-version/SKILL.md says the target is v1.0, while smartcross.cls and CLS_TARGET are v1.5. Make the skill refer to CLS_TARGET in scripts/qa.py instead of hard-coding a version.
   - skills/qa-infra/SKILL.md says 28–32 pages, while PRD AC-01 and qa.py say 40–46. Make the skill refer to AC-01 instead of repeating the number.
   - TODO.md has 29 unchecked items although the README says "complete". Mark each item done or obsolete with a one-line reason (e.g. "superseded by the Step 15 pivot"). Nothing may stay open without a reason.
   - Add a check to qa-infra (scripts/qa.py + a regression test in tests/qa/) that fails when a version or page range written in skills/*.md contradicts PRD.md or qa.py.

2. Fixer agent. Create skills/fixer/SKILL.md: the Fixer role in the Detector → Fixer loop (PLAN §4).
   - Input: a Detector report in the mandatory format.
   - Rules: fix only sources (chapters, .cls, scripts, data, skills), never build/. A defect repeated in several places is fixed once in the .cls or the script. Give every finding a status: FIXED / REJECTED (reason) / DEFERRED (reason). The Fixer never marks its own work as verified; the Detector re-checks.
   - Output: prompts/agents/<round>-fixer-report.md with the columns: finding id | file:line | change | status | reason | candidate incident.
   - Update PLAN §4, the README Agent Team table and the Skills table so that the Fixer is a separate agent with its own skill.

3. Incidents found by us, the students (human review). Add them to INCIDENTS.md, each with: found by "the students (human review of the repository)", symptom, root cause, fix, and the detection gap closed:
   - INC-005: skills documented stale targets (v1.0, 28–32 pages) while the code used v1.5 and 40–46. Why it happened: version bumps changed the code but not the skills. Why it was not detected: no check linked skill text to the code. Gap closed: the qa-infra check from point 1.
   - INC-006: the final red-team pass was interim (16 pages, only ch. 1 and 4) and was never repeated on the full 45-page book. Chapters 2, 3 and 5–10 were checked only by the Leader, who had also fixed them, which breaks PLAN §4 ("a fixer never marks its own work as verified"). Why: the Step 16 "finish efficiently" decision merged without a re-run gate. Gap closed: add an exit gate to PLAN §4 and to skills/qa-super/SKILL.md – a final round can't be merged unless a red-team report exists whose inspected page count equals the page count of the built PDF.
   - INC-007: the cover has no author names. Red-team finding 10 (final-redteam-report.md) was left open with no owner. Why: minor findings had no status tracking. Gap closed: every finding must get a status in a Fixer report.

4. Cover: replace "קבוצת shirloma" with the authors' names: פלומה בנגיגי, שירה דביר. Keep the group code. Do it through the main.tex metadata and the .cls, not by editing the cover by hand.

5. For every visual page check, delegate the rendering and inspection to a subagent (Task tool) running on Sonnet: it renders the pages, looks at them, and returns only a text report in the mandatory format (page, file:line, exact text, rule). Do not load page images into your own context. Here, check only the cover. Save the subagent's prompt and report in prompts/agents/.

Then build, run qa.py super (0 blocker, 0 major), commit and push.
```

## Step 19 – Merge round final2 (red team + Fixer), Detector re-check, release
**Date/time:** 2026-11-25 20:27

```text
Step 19 – Merge round final2 (red team + Fixer). Log this prompt first (rule 1). The parallel agents' prompts and reports are in prompts/agents/final2-redteam*.md and final2-fixer*.md.

1. Leader response. Write prompts/agents/final2-redteam-response.md: for each RT finding and each old finding (final-redteam #1–#10), whether you agree and its final status. Also write the missing prompts/agents/final-redteam-response.md for the interim pass (RT-02), stating that it was superseded by round final2.

2. Deferred items: do the parts of RT-07 and RT-02 deferred to the Leader. For RT-16 (float whitespace), fix it if the page count stays within AC-01; otherwise reject it with the reason.

3. Re-verification by the Detector. Run a Sonnet subagent (Task tool) as Detector, only on the findings marked FIXED in final2-fixer-report.md. It returns a text report only (no page images in your context). Append its result to final2-redteam-report.md under "Re-check". A finding is closed only when the Detector confirms it. If it reopens a finding, fix it and re-check once more.

4. Incidents: add INC-008 as proposed in the Fixer report (a gate documented but not coded; documentation drift), with the detection gap closed by the RT-01 check and its tests.

5. Build build/main.pdf with scripts/build.sh. qa.py super must give 0 blocker and 0 major, qa.py infra --redteam prompts/agents/final2-redteam-report.md must pass, and tests/qa/run_tests.py must have 0 failing.

6. README:
   - the Agent Team table, with the Fixer and the Detector re-check;
   - the rounds table, with round final2 (red team on all 45 pages → Fixer → Detector re-check);
   - the incident count, the test count, the skill count, the page split and the badges;
   - a new screenshot of the cover;
   - my screenshots in screenshots/agents/final2-*.png, if they exist.
   Every number in the README must match the repository; the RT-01 check enforces it.

7. TODO.md: close the red-team re-run item. For the release: run the AC-18 clean-clone build (git clone . /tmp/x && cd /tmp/x && scripts/build.sh); if it passes, tag the commit v1.0-submission.

Commit and push. Stop only for decisions that need me.
```
