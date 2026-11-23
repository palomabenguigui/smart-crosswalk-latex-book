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
