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
             'formatting only in the .cls', 'figure without caption']:
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

# 3. the real final sample must be clean
r = subprocess.run([PY, 'scripts/qa.py', 'super', '--pdf', 'build/style-final.pdf'], cwd=ROOT, capture_output=True, text=True)
expect('final sample: 0 findings', r.returncode == 0 and '0 blocker, 0 major, 0 minor' in r.stdout)
print(f'== {fails} failing'); sys.exit(1 if fails else 0)
