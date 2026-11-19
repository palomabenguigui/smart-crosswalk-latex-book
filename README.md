# Crossing at a Red Light – Smart Pedestrian Crossing: A Preparatory Report

**חוצים באדום – מעבר חציה חכם: דוח הכנה**

![Project status: in progress](https://img.shields.io/badge/Project%20status-in%20progress-yellow)

| | |
|---|---|
| **Course** | Generative AI: LLMs, Agents and Multi-Agent Systems – Dr. Yoram Segal, Bar-Ilan University |
| **Assignment** | 02 – Hebrew PDF book in LaTeX, produced by a team of AI agents |
| **Group code** | `shirloma` |

---

## Overview
_TBD – short description of the book and its goals._

## Agent Team
_TBD – the AI agents, their roles and how they collaborate._

## Repository Structure
```
.
├── CLAUDE.md          # Standing rules for every AI session
├── README.md
├── references/        # Source paper(s) and .bib files
├── chapters/          # LaTeX chapters (Hebrew, RTL)
├── figures/           # Figures drawn with TikZ / Python
├── scripts/           # Python scripts
├── skills/            # Agent skills / role definitions
├── prompts/           # Prompt engineering log
├── screenshots/       # Screenshots of the workflow
└── build/             # Build output (final PDF tracked)
```

## How to Build
```bash
lualatex main.tex
biber main
lualatex main.tex
lualatex main.tex
```
_TBD – exact file names and output location._

## Screenshots
_TBD._

## Prompt Engineering Log
All prompts are logged verbatim in [prompts/PROMPTS_LOG.md](prompts/PROMPTS_LOG.md).

## Credits
_TBD._
