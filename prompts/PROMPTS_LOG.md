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
