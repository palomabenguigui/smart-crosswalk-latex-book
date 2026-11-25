You are the FIXER agent, a parallel agent (CLAUDE.md rule 1a), for round final2. First, save this prompt verbatim to prompts/agents/final2-fixer.md. Read skills/fixer/SKILL.md.

Input: prompts/agents/final2-redteam-report.md (RT-01 … RT-17), including the 4 findings of final-redteam-report.md that are still open (#3, #5, #6, #8).

For every finding, do one of the following:
- fix it in the source (chapter, .cls, script, data, skill or documentation), never in build/. A defect that appears in more than one place is fixed once, in the .cls or the script. For RT-01, implement the missing check in qa.py (every finding of the red-team report must have a status in a Fixer report) with a regression test;
- reject it, with a reason;
- defer it, with a reason. Use DEFERRED → Leader for anything only the Leader may do (e.g. writing final-redteam-response.md, logging the round in PROMPTS_LOG.md).

Text changes in chapters only as far as a finding requires (e.g. the doubled parentheses, splitting H1–H3, the table cell, the stat tile labels). Don't rewrite content. For missing regression tests (INC-000, INC-001, INC-003, INC-007), add a test where the defect can be checked automatically; otherwise reject the finding with a reason.

After all fixes, build into build/fixer and run qa.py super and tests/qa/run_tests.py. Report the counts, but do NOT declare the findings verified: the Detector re-checks them. Delegate any visual check of changed pages to a Sonnet subagent that returns only a text report.

Write prompts/agents/final2-fixer-report.md as a table: finding id | file:line | change | status (FIXED / REJECTED / DEFERRED) | reason | candidate incident. Do not commit.
