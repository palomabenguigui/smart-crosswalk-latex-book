# PLAN – How the book is produced

Companion to [`PRD.md`](PRD.md) (what to build) and [`TODO.md`](TODO.md) (ordered checklist).
**Version:** 1.1 (2026-11-19) · **Target `.cls` version:** `smartcross` v1.0 (tracked by `qa-cls-version`) · v1.1 adds §10 Writing style, §11 Parallel-agent run, and online source verification

---

## 1. The brief's 8-step workflow, mapped to this project

| # | Step in the Assignment 02 brief | How we do it | Output |
|---|---|---|---|
| 1 | Open a dedicated project folder | Repository `smart-crosswalk-latex-book`, folder structure, `CLAUDE.md` rules | Done (Steps 01–04 in the prompt log) |
| 2 | Write `PRD.md` | Expert committee → merged requirements | `PRD.md` |
| 3 | Write `PLAN.md` | This file | `PLAN.md` |
| 4 | Write `TODO.md`: atomic tasks | Ordered checklist that mirrors the phases below | `TODO.md` |
| 5 | Use QA skills (`qa-super`, `qa-BiDi`, `qa-table`, `qa-code`, `qa-img`, …) | Write all 8 skills in `skills/` **before** any content; run them on every build | `skills/*/SKILL.md` |
| 6 | Give the agent precise prompts covering all requirements | Each phase has a logged prompt; agents get PRD section IDs and acceptance criteria | `prompts/PROMPTS_LOG.md` |
| 7 | Run, check, fix **through a skill or the CLS, never by hand** | Detector → Fixer loop (§4) + incident procedure (§6) | Clean QA reports |
| 8 | Save all working files (`.tex`, `.cls`, `.md`, `.pdf`) | Commit + push after every task (`CLAUDE.md`) | Git history, `build/main.pdf` |

Inside step 7, content is produced in the booklet's Vibe-Coding stages (booklet ch. 18):
setup → skeleton by page map → sources → chapter writing → graphics and tables → compile and fix → page-by-page check → red team.

## 2. Phases

| Phase | Name | Main agents | Exit gate |
|---|---|---|---|
| P0 | Planning (PRD / PLAN / TODO) | Leader + committee | Documents committed |
| P1 | Infrastructure: toolchain, fonts, Python env, `.cls` v0.1, `main.tex` skeleton, build script | Leader, TikZ agent (for `.cls` graphics) | Empty skeleton compiles; `qa-infra` + `qa-typeset` clean |
| P2 | QA skills written and tested on the skeleton | QA lead | Every skill runs and produces a report in the standard format |
| P3 | Sources and data: `.bib`, verified DOIs, data transcription of Tables 1–2, recomputation script | Researcher, Python agent | AC-09 (partial), AC-14 |
| P4 | Design system in `.cls` v1.0: colours, fonts, banner/footer, chapter openers, boxes, rules, cover | TikZ agent, Leader | `qa-cls-version`, `qa-BiDi`, `qa-img` clean on a design-sample page |
| P5 | Figures: Python graphs G1–G4, TikZ T1–T4 | Python agent, TikZ agent | AC-04, AC-05, `qa-img`, `qa-code` |
| P6 | Writing: chapters 1–10 + front matter, in order; **Writer, Researcher and QA red team run in parallel** (§11) | Writer, Researcher, QA red team | Each chapter passes the Detector → Fixer loop before it is merged; AC-20, AC-21 |
| P7 | Integration build + full QA | All QA skills via `qa-super` | AC-01 to AC-15, AC-21, AC-22 |
| P8 | Red team (fresh session, ideally another model) | Red-team lead | AC-16 |
| P9 | Release: README with screenshots (book pages, graphs, TikZ, agents in action) and INC-000 showcase, skills list, final PDF, tag `v1.0` | Leader | AC-17, AC-18, AC-19 |

## 3. The agent team

The **Leader (orchestrator)** is the main Claude Code session.
- It owns `PRD.md`, `PLAN.md` and `TODO.md`, dispatches tasks, merges results and commits.
- Specialist agents run as **subagents** (Agent tool), each with a role prompt stored in `skills/` or `prompts/`.
- The agent-teams / cross-session messaging mode (`ListAgents` / `SendMessage`, L04 guide ch. 11) is an optional upgrade for P6–P7. It is used only after a ping/pong mesh check passes.

### 3.1 Production agents

| Agent | Responsibility | Inputs | Outputs | Must never |
|---|---|---|---|---|
| **Writer** | Hebrew chapter text in the defined authorial voice (§10): street-scene `scenebox` first, then formal third person; paraphrased and cited; template commands only | PRD §4 row and §12, Researcher notes, figure/table labels | `chapters/chNN-*.tex` | Copy source text; define formatting; hard-code colours; put facts or numbers in a scene |
| **Researcher / bibliography** | Find sources and **verify each one online**: open the DOI/URL and check title, authors, year, venue and pages against the landing page; write `.bib`, per-source notes and verification records; transcribe published data | `references/`, web | `references/refs.bib`, `references/VERIFICATION.md`, `references/notes/*.md`, `data/*.csv` | Cite an unverified source; invent or "reconstruct" metadata; keep an entry it couldn't open. **Unverifiable ⇒ dropped** |
| **Python-graphs agent** | Reproducible graphs from `data/*.csv`; recomputation of Table 2 checks | `data/`, design tokens | `scripts/*.py`, `figures/*.pdf` | Hand-edit a generated figure; use a colour outside the tokens |
| **TikZ-illustrations agent** | Diagrams, chapter openers, cover art, crosswalk rules | PRD §6, architecture spec | `figures/tikz/*.tex`, `.cls` graphic macros | Embed raster images; draw outside an LTR environment |

### 3.2 QA skills (one folder each in `skills/`, mirrored to `.claude/skills/`)

| Skill | Checks | Typical defects |
|---|---|---|
| `qa-super` | Orchestrates all QA families in the right order (template first); also checks figure/table references, citation two-way match, n-gram copy check against references, PRD acceptance criteria | Orphan figure, uncited entry, copied sentence |
| `qa-BiDi` | Full-PDF text extraction + page render; booklet Prompt B2 | Reversed English or numbers, Hebrew words starting with a final letter, mirrored headers, flipped TOC numbers |
| `qa-table` | Column order (column 1 on the right), alignment, width within margins, captions | Table beyond the margins, wrong column order |
| `qa-code` | Python scripts run cleanly from a fresh env, outputs match committed figures, numbers in text match script output; code boxes LTR | Stale figure, mismatched number |
| `qa-img` | Every figure exists, is vector, has a Hebrew caption and a reference, readable labels, palette consistency, greyscale legibility, no external images | Overlapping labels, red/green-only encoding |
| `qa-typeset` | Log: errors, warnings, overfull/underfull boxes, undefined references, widows/orphans, boxes split badly | `Overfull \hbox`, `??` in the text |
| `qa-infra` | Folder structure, required files, paths, page counts (AC-01/02), clean-clone build, `.gitignore` protects references | Missing file, broken path |
| `qa-cls-version` | `.cls` version matches PLAN; no `\newcommand` / colour / font definitions in chapter files | Formatting defined outside the `.cls` |

**Standard report format (every skill):**
`[skill] [severity: blocker/major/minor] [page N] [file:line] "exact text" → rule broken (PRD/AC id)`.
A skill that says only "checked" or "OK" without counts and page numbers has failed (booklet §19.5).

## 4. Detector → Fixer red-team loop

```
          ┌──────────────── build (lualatex → biber → lualatex ×2) ────────────────┐
          ▼                                                                       │
   DETECTORS (QA skills, report only, never fix)                                  │
          │  findings: page + exact text + rule                                    │
          ▼                                                                       │
   TRIAGE (Leader): repeats across the document? ── yes ──► fix in .cls / skill    │
          │                                       no ───► fix in the one sentence  │
          ▼                                               (via the Writer agent)   │
   FIXER (owning agent) changes SOURCE only, logs the incident id ────────────────┘
          │
          ▼
   Loop until 0 blocker + 0 major findings, or 3 rounds → escalate to the user
```

- Detectors and Fixers are **separate agents**. A detector never fixes, and a fixer never marks its own work as verified.
- Order of detection follows the booklet: template (`qa-cls-version`) → infrastructure → typesetting → BiDi → tables → images → code → content (`qa-super`).
- Before/after evidence (finding text and page, re-run result) is saved in `build/qa/` (ignored) and summarised in the commit message.

## 5. The rule: no output is fixed by hand

- The PDF, generated figures, `.aux`/`.bbl` files and any build artefact are **never edited directly**.
- Every fix is a change to a **source**: the `.cls` (for anything recurring or visual), a chapter `.tex` (for one-off wording, made by the Writer agent following its skill), a `scripts/*.py` file, `data/*.csv`, `refs.bib`, or a `skills/*/SKILL.md`.
- A defect that repeats is **always** fixed in the `.cls` or the generating script, never patched occurrence by occurrence (booklet §14.6, Prompt B3).
- If a fix seems to need a manual tweak, that is a missing feature of the `.cls` or a skill. Add the feature, then use it.

## 6. Incident-investigation procedure (for every bug we find ourselves)

An *incident* is any defect found by a human, or by a later stage, that an earlier QA skill should have caught.

1. **Open** an entry in `INCIDENTS.md`: `INC-NNN`, date, reporter, page, exact text, screenshot path (`screenshots/INC-NNN.png`, our own screenshot).
2. **Contain:** label the commit/build as known-bad; don't release.
3. **Root cause:** ask "why" up to five times. *Why did it appear?* (source cause) and *why didn't a skill catch it?* (detection gap).
4. **Fix the cause**, never the symptom, in the `.cls`, script or skill (§5).
5. **Close the detection gap:** add a check (regression test) to the skill that should have caught it, and show that it now fails on the bad build and passes on the fixed build.
6. **Verify** with a full build and full `qa-super` run.
7. **Record** the root cause, fix, skill change and commit hash in `INCIDENTS.md`, and add a lesson to the relevant `SKILL.md`.

**INC-000 (already opened during planning):** PDF text extraction dropped the minus signs in Table 2 of the flagship
paper (`/C0` glyph), which led to a wrong data issue in the initial brief. *Detection gap:* nothing compared extracted numbers
with the rendered page. *Action:* the Researcher skill must check every transcribed number against a rendered image of
the source page, and `data/*.csv` stores the page reference for each value.

## 7. Folder structure

```
.
├── CLAUDE.md                # standing rules (prompt logging, commit/push, language, copyright)
├── README.md  PRD.md  PLAN.md  TODO.md  INCIDENTS.md
├── main.tex                 # master file: front matter + \input of chapters
├── smartcross.cls           # custom class: ALL formatting lives here (versioned)
├── chapters/                # ch01-intro.tex … ch10-summary.tex, front-matter.tex
├── figures/                 # generated PDFs (Python) and tikz/*.tex sources
├── data/                    # CSV transcriptions of published tables, with page references
├── requirements.txt         # Python deps for .venv (pip freeze)
├── scripts/                 # Python: graphs, recomputation, build helpers, font-test.tex
├── fonts/                   # bundled OFL fonts + licences
├── references/              # README.md, refs.bib, VERIFICATION.md tracked; copyrighted PDFs/MD local only
├── skills/                  # qa-* skills + production-agent skills (SKILL.md each)
├── prompts/                 # PROMPTS_LOG.md (verbatim); agents/ = each agent's prompt, verbatim
├── screenshots/             # our own screenshots: book pages, graphs, TikZ, agents in action, incidents
└── build/                   # build output; only build/main.pdf is tracked
```

## 8. Build

```bash
# from the repository root (wrapped by scripts/build.sh)
python3 scripts/make_figures.py                       # regenerate all Python graphs
lualatex -output-directory=build main.tex             # pass 1
biber --input-directory build --output-directory build main   # bibliography
lualatex -output-directory=build main.tex             # pass 2
lualatex -output-directory=build main.tex             # pass 3: settle refs and TOC
```

The final artefact is `build/main.pdf` (tracked). Any non-zero exit code or log warning listed in AC-03 fails the build.

## 9. Git discipline

- After each task: `git add` → commit with a clear message (`Step NN: …`) → `git push` (`CLAUDE.md`).
- The prompt is logged first, before any work starts.
- Copyrighted references are never staged (`.gitignore`). `qa-infra` checks this on every run.

## 10. Writing style (authorial voice)

Full specification: PRD §12. Operational rules for the Writer agent:

1. **Order inside every chapter:** road-sign chapter opener (from the `.cls`) → `\begin{scenebox} … \end{scenebox}` → formal body.
2. **Scene:** ≤ 4 rendered lines. Present tense, concrete crosswalk details, an illustrative composite. No facts, numbers, citations, real names or first person.
3. **Bridge:** the first body sentence ties the scene to the chapter's question. From then on, formal third-person academic Hebrew only (PRD §3.1).
4. **Thread:** the same imagined crosswalk at different moments (morning rush, empty midday, rain, evening), chosen to match each chapter's theme.
5. **Detection:** `qa-super` counts the rendered lines of each `scenebox` and flags any digit, `\cite` or first-person form inside it. It also flags narrative or first-person forms in the body (AC-21).
6. Any defect in the scene box's *appearance* is fixed in the `.cls` (`scenebox` definition), never in the chapter.

## 11. Parallel-agent run (evidence for AC-20)

At least one production round in P6 runs **three agents at the same time**, each in its own session or subagent:

| Agent | Task in the parallel round | Prompt file |
|---|---|---|
| Writer | Draft the next chapter in `chapters/` | `prompts/agents/writer-chNN.md` |
| Researcher | Verify online the sources that chapter needs; update `refs.bib` + `VERIFICATION.md` | `prompts/agents/researcher-chNN.md` |
| QA red team | Run the detectors on the previously merged chapter and report findings (no fixes) | `prompts/agents/redteam-chNN.md` |

Procedure:
1. Save each agent's prompt **verbatim** in `prompts/agents/` before launch, and log the round in `PROMPTS_LOG.md`.
2. If cross-session mode is used, run a ping/pong mesh check first (L04 guide §11.7) and screenshot the result.
3. Launch all three. Take **screenshots while they run** showing the three running at the same time (terminal panes or the agent list with status), saved as `screenshots/parallel-<date>-*.png`.
4. Save each agent's final report in `prompts/agents/*-report.md`. The Leader merges the results; the work goes through the normal Detector → Fixer loop.
5. The README "Agent Team" section links the prompts, reports and screenshots (AC-19, AC-20).

Agents in a parallel round work on **different files** (chapter / `.bib` / QA report), so they never edit the same file at once.
