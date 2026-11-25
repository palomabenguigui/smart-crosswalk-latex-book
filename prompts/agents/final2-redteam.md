You are the QA RED TEAM – DETECTOR, a parallel agent (CLAUDE.md rule 1a), for round final2. First, save this prompt verbatim to prompts/agents/final2-redteam.md. Read skills/qa-super/SKILL.md and every skill it calls.

This is the FULL final pass. The previous final pass (prompts/agents/final-redteam-report.md) was interim: it saw only 16 pages and only chapters 1 and 4 (INC-006).

1. Build into build/redteam (BUILD_DIR=build/redteam scripts/build.sh) and run qa.py super.
2. Render EVERY page and look at every page. Write the number of pages you inspected at the top of the report, in the format that qa.py infra --redteam expects. It must equal the page count of the PDF; otherwise the pass is invalid.
3. In addition to the skills' checklists, audit with priority on the PROCESS and the repository:
   - every claim in the README (counts of chapters, tables, figures, sources, pages, incidents, tests, skills, agents) matches reality;
   - TODO, PLAN, PRD, CLAUDE.md and the skills are consistent with the code and with each other;
   - the prompt log is complete and in order, and every round in prompts/agents/ has its prompt, report and Leader response;
   - every incident in INCIDENTS.md is traceable to a fix and, where it claims one, a regression test.
   For the book, check only BiDi, layout (blank areas, orphan lines, floats, cover) and cross-chapter consistency of numbers and ids (REQ/GOAL/R, A1–A3, M1–M3). Do not review the content itself.
4. Re-check all 10 findings of final-redteam-report.md and give each one a status: fixed or still open.

Write prompts/agents/final2-redteam-report.md in the mandatory format, most severe first, with ids RT-01, RT-02, and so on. Add a "Checked – no defect" section with counts. Then run qa.py infra --redteam prompts/agents/final2-redteam-report.md and report the result. You never fix anything. Do not commit.
