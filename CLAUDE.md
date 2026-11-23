# CLAUDE.md – Standing rules for every session

Project: **Assignment 02 – Hebrew PDF book in LaTeX, produced by a team of AI agents**
("Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report"). Group code: `shirloma`.

## 1. Prompt logging (do this FIRST, before any task)
- Before doing anything else, append the user's prompt **verbatim** to `prompts/PROMPTS_LOG.md`.
- Each entry goes under a header with the **step number**, **date/time** and a **one-line title**, e.g.:
  `## Step 07 – Build chapter 2 figures` followed by `**Date/time:** YYYY-MM-DD HH:MM`, then the prompt in a ```text block.
- Step numbers continue sequentially from the last entry in the log.
- **Never edit, reorder or summarize earlier entries.** Append only.

## 1a. Parallel agents (Writer / Researcher / QA red team in separate sessions – PLAN §11)
- A session started from a prompt in `prompts/agents/` is a **parallel agent**. Rules 1 and 2 do NOT apply to it:
  it does **not** edit `prompts/PROMPTS_LOG.md`, does **not** commit or push, and writes **only** the files its prompt assigns
  plus its report `prompts/agents/<round>-<role>-report.md`.
- The Leader (main session) logs the round, merges the results, runs QA and commits.

## 2. Version control (after finishing each task)
- `git add` the changes, `git commit` with a clear, descriptive message, and `git push`.

## 3. Language
- The book is written in **Hebrew (RTL)**.
- Code, commands, file names, folder names and commit messages are in **English**.

## 4. Academic integrity
- **Never copy text from the source paper.** Always paraphrase in your own words and cite the source (BibLaTeX/biber, entries in `references/`).

## 5. Copyright
- **No images from the internet.** All illustrations are drawn with **TikZ** or **Python** (scripts in `scripts/`, output in `figures/`).
- **Only exception:** photographs taken by the group itself, placed with `\authorphoto` and credited "צילום: המחברים" (PRD §5).

## Repository layout
| Folder | Purpose |
|---|---|
| `references/` | Source paper(s) and `.bib` files |
| `chapters/` | LaTeX chapter files |
| `figures/` | Generated figures (TikZ / Python output) |
| `scripts/` | Python scripts (figure generation, helpers) |
| `skills/` | Agent skills / role definitions |
| `prompts/` | Prompt engineering log (`PROMPTS_LOG.md`) and agent prompts |
| `screenshots/` | Screenshots of the agent workflow |
| `build/` | Build output; the final PDF is tracked in git |

## Build
`lualatex` → `biber` → `lualatex` → `lualatex`
