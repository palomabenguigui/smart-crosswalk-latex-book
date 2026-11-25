#!/usr/bin/env python3
"""Regression tests for scripts/qa.py: every Detector must FIRE on known-bad input and stay SILENT on the
known-good final sample. Run: .venv/bin/python tests/qa/run_tests.py   (needs build/style-final.pdf)"""
import subprocess, sys, importlib.util
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
PY = str(ROOT / '.venv/bin/python')
spec = importlib.util.spec_from_file_location('qa', ROOT / 'scripts/qa.py'); qa = importlib.util.module_from_spec(spec); spec.loader.exec_module(qa)
fails = 0
def expect(name, cond):
    global fails
    print(('PASS ' if cond else 'FAIL ') + name); fails += (not cond)

# 1. chapter-source fixture: each planted violation must be reported
out = subprocess.run([PY, 'scripts/qa.py', 'super', '--chapters', 'tests/qa/bad-chapters', '--pdf', 'build/style-final.pdf'],
                     cwd=ROOT, capture_output=True, text=True).stdout
for rule in ['rule 2: English', 'rule 4: number', 'rule 12: maqaf', 'rule 13: typed citation', 'third person',
             'number or citation in scene', 'not referenced', 'no vertical rules', 'cell count', 'without \\caption',
             'formatting only in the .cls', 'figure without caption',
             'RT-10: caption with', 'RT-13: \\eqref inside brackets']:
    expect(f'fixture reports: {rule}', rule in out)

# 2. PDF-level BiDi scan on synthetic extracted text (visual order)
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['חכם מעבר', 'see ]1[ here', 'countdown sig--ו'], 'synthetic')
rules = ' '.join(f[5] for f in qa.FINDINGS)
for r in ['DS-01', 'DS-04', 'DS-11']: expect(f'synthetic PDF text reports {r}', r in rules)
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['םכח רבעמ', 'see [1] here', 'countdown signal-ו'], 'synthetic-good')
expect('synthetic correct text is clean', not qa.FINDINGS)

qa.FINDINGS.clear(); qa.pdf_bidi_scan(['רועיש םיצוחה םודאב'], 'mpl-bad', order='logical')
expect('matplotlib-order reversed Hebrew reported (INC-002)', any('INC-002' in f[5] for f in qa.FINDINGS))
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['שיעור החוצים באדום'], 'mpl-good', order='logical')
expect('matplotlib-order correct Hebrew is clean', not qa.FINDINGS)

# QA-23: a figure word on a page WITHOUT that figure must not be masked; with the figure placed it is allowed once
from collections import Counter
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['האדום'], 'mask', allow_pages=[Counter()], vocab={'האדום'})
expect('QA-23 no book-wide masking: reversed word reported', any('reversed' in f[5] for f in qa.FINDINGS))
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['האדום'], 'mask', allow_pages=[Counter({'האדום': 1})], vocab={'האדום'})
expect('QA-23 occurrence inside an embedded figure is allowed', not qa.FINDINGS)
# QA-26: reversed word WITHOUT final letters is caught by the source vocabulary
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['רמזור'], 'vocab', vocab={'רמזור'})
expect('QA-26 reversed word without final letters reported', any('reversed' in f[5] for f in qa.FINDINGS))
qa.FINDINGS.clear(); qa.pdf_bidi_scan(['רוזמר'], 'vocab', vocab={'רמזור'})
expect('QA-26 correct visual order is clean', not qa.FINDINGS)
# QA-22: 'unverified' must not count as verified
import re as _re
row = '| `x` | doi | 2026 | ✓ | ✓ | ✓ | ✓ | ✓ | **unverified** | |'
cells = [c.strip().strip('*').strip().lower() for c in row.split('|')]
expect('QA-22 "unverified" is not "verified"', 'verified' not in cells)

# INC-005: skill text must agree with CLS_TARGET and PRD AC-01
import tempfile
with tempfile.TemporaryDirectory() as d:
    (Path(d) / 'bad').mkdir(); (Path(d) / 'bad/SKILL.md').write_text('target class v0.9\nbuild must be 28–32 pages\n')
    (Path(d) / 'ok').mkdir(); (Path(d) / 'ok/SKILL.md').write_text(f'class v{qa.CLS_TARGET}\n{qa.prd_page_range()[0]}–{qa.prd_page_range()[1]} pages\n')
    qa.FINDINGS.clear(); qa.check_skill_consistency(d)
    hits = [f[3] for f in qa.FINDINGS]
    expect('INC-005 stale version and page range in a skill are reported', sum('bad' in h for h in hits) == 2)
    expect('INC-005 matching skill text is clean', not any('/ok/' in h for h in hits))
qa.FINDINGS.clear(); qa.check_skill_consistency()
expect('INC-005 the real skills/*.md agree with the code', not qa.FINDINGS)
# INC-006: red-team report must cover the built page count
with tempfile.TemporaryDirectory() as d:
    rp = Path(d) / 'r.md'; rp.write_text('PDF: **3 pages**\n')
    npages = len(qa.pdf_pages('build/style-final.pdf')[0].pages)
    qa.FINDINGS.clear(); qa.check_redteam_gate('build/style-final.pdf', str(rp))
    expect('INC-006 gate fires on page-count mismatch', npages == 3 or any('inspected' in f[4] for f in qa.FINDINGS))
    rp.write_text(f'PDF: **{npages} pages**\n'); qa.FINDINGS.clear(); qa.check_redteam_gate('build/style-final.pdf', str(rp))
    expect('INC-006 gate silent when counts match', not qa.FINDINGS)

# RT-01 / INC-007: every red-team finding needs a status in the Fixer report
with tempfile.TemporaryDirectory() as d:
    rt = Path(d) / 'x-redteam-report.md'; fx = Path(d) / 'x-fixer-report.md'
    rt.write_text('RT-01. [qa] [major] one\nRT-02. [qa] [minor] two\nRT-10. [qa] [minor] three\n')
    qa.FINDINGS.clear(); qa.check_fixer_statuses(str(rt), str(fx))
    expect('INC-007 missing Fixer report is reported', any('no Fixer report' in f[4] for f in qa.FINDINGS))
    fx.write_text('| RT-01 | a:1 | c | FIXED | - | - |\n| RT-10 | b:2 | c | pending | - | - |\n')   # RT-02 absent, RT-10 without status; RT-1 must not match RT-10
    qa.FINDINGS.clear(); qa.check_fixer_statuses(str(rt), str(fx))
    miss = sorted(f[4].split(':')[0] for f in qa.FINDINGS)
    expect('INC-007 findings without a status row are reported (RT-02, RT-10; not RT-01)', miss == ['RT-02', 'RT-10'])
    fx.write_text('| RT-01 | a | c | FIXED | - | - |\n| RT-02 | a | c | REJECTED | r | - |\n| RT-10 | a | c | DEFERRED → Leader | r | - |\n')
    qa.FINDINGS.clear(); qa.check_fixer_statuses(str(rt), str(fx))
    expect('INC-007 gate silent when every finding has a status', not qa.FINDINGS)
# RT-03/05/06: README/PLAN claims versus the repository
with tempfile.TemporaryDirectory() as d:
    rd = Path(d) / 'R.md'; rd.write_text('write all 3 skills (1 QA + 9 production)\n**Target `.cls` version:** `smartcross` v0.1\n')
    (Path(d) / 'sk/qa-a').mkdir(parents=True); (Path(d) / 'sk/qa-a/SKILL.md').write_text('x'); (Path(d) / 'sk/w').mkdir(); (Path(d) / 'sk/w/SKILL.md').write_text('x')
    qa.FINDINGS.clear(); qa.check_doc_claims(None, str(rd), str(Path(d) / 'none.md'), str(Path(d) / 'sk'))
    expect('RT-05/06 stale skill count and class version in a doc are reported', len(qa.FINDINGS) == 2)
    rd.write_text('1 QA + 1 production\n**Target `.cls` version:** `smartcross` v' + qa.CLS_TARGET + '\n')
    qa.FINDINGS.clear(); qa.check_doc_claims(None, str(rd), str(Path(d) / 'none.md'), str(Path(d) / 'sk'))
    expect('RT-05/06 matching doc claims are clean', not qa.FINDINGS)
# INC-008: the incident count in the README must match INCIDENTS.md
with tempfile.TemporaryDirectory() as d:
    inc = Path(d) / 'I.md'; inc.write_text('## INC-000 – a\n## INC-001 – b\n'); rd = Path(d) / 'R.md'
    rd.write_text('has 5 incidents (INC-000…INC-004) and 22 findings\n')
    qa.FINDINGS.clear(); qa.check_doc_claims(None, str(rd), str(Path(d) / 'none.md'), str(Path(d) / 'sk'), None, str(inc))
    expect('INC-008 README incident count != INCIDENTS.md is reported', len(qa.FINDINGS) == 1)
    rd.write_text('has 2 incidents (INC-000…INC-001) and 22 findings\n')
    qa.FINDINGS.clear(); qa.check_doc_claims(None, str(rd), str(Path(d) / 'none.md'), str(Path(d) / 'sk'), None, str(inc))
    expect('INC-008 matching incident count is clean', not qa.FINDINGS)
# INC-001: a "Missing character" log line must be a blocker
with tempfile.TemporaryDirectory() as d:
    lg = Path(d) / 'm.log'; lg.write_text('Missing character: There is no 5 (U+0035) in font NotoSerifHebrew\n')
    class A: pass
    a = A(); a.log = str(lg)
    qa.FINDINGS.clear(); qa.check_typeset(a)
    expect('INC-001 "Missing character" log line is a blocker', any(f[1] == 'blocker' and 'INC-001' in f[5] for f in qa.FINDINGS))
    lg.write_text('This is LuaHBTeX\n'); qa.FINDINGS.clear(); qa.check_typeset(a)
    expect('INC-001 clean log is silent', not qa.FINDINGS)
# INC-003: AC-15 fires when a PRD §9 issue is missing from chapter 4
with tempfile.TemporaryDirectory() as d:
    (Path(d) / 'ch04-literature.tex').write_text('\\begin{cautionbox}\\en{D1}\\end{cautionbox}\n')
    qa.CHAPTERS = d; qa.FINDINGS.clear()
    class B: pdf = 'build/style-final.pdf'
    qa.check_content(B)
    expect('INC-003 AC-15 reports data issues missing from chapter 4', any('AC-15' in f[5] and f[4] == 'D7' for f in qa.FINDINGS))
    qa.CHAPTERS = 'chapters'

# 3. the real final sample must be clean
r = subprocess.run([PY, 'scripts/qa.py', 'super', '--pdf', 'build/style-final.pdf'], cwd=ROOT, capture_output=True, text=True)
bad = [l for l in r.stdout.splitlines() if ('[blocker]' in l or '[major]' in l) and not l.startswith('[qa-code]')]
expect('final sample: 0 blocker / 0 major (qa-code excluded: it depends on the git working tree)', not bad)
print(f'== {fails} failing'); sys.exit(1 if fails else 0)
