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

**Toolchain.** The assignment brief names MiKTeX, but MiKTeX for macOS is frozen at version 22.1. Its LuaHBTeX 1.14 engine can't compile current Hebrew `babel`. The project therefore uses **TeX Live 2026 (MacTeX)** with the same LuaLaTeX + biber toolchain: LuaHBTeX 1.24.0, biber 2.21, babel v26.4, Python 3.13 (`.venv`, see `requirements.txt`) and bundled OFL Noto fonts in `fonts/`.

```bash
export PATH=/Library/TeX/texbin:$PATH   # make sure TeX Live, not an old MiKTeX, is used
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
