#!/usr/bin/env python3
"""qa.py – deterministic Detector checks behind the QA skills (PLAN §3.2, §4).

Usage (from the repo root, with the project venv):
    .venv/bin/python scripts/qa.py <family> [--pdf build/main.pdf] [--log build/main.log]
families: cls-version | infra | typeset | bidi | table | img | code | content | super

Every finding is printed in the standard report format (PLAN §3.2):
    [skill] [severity] [page N|-] [file:line|-] "exact text" -> rule (PRD/AC id)
Detectors NEVER fix anything. Exit code: 1 if any blocker/major finding, else 0.
"""
from __future__ import annotations
import argparse, json, os, re, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
os.chdir(ROOT)
FINDINGS: list[tuple] = []
HEB = '\u0590-\u05FF'
FINALS = 'ךםןףץ'
CLS_TARGET = '1.4'                      # PLAN: target .cls version (qa-cls-version)

def report(skill, sev, page, loc, text, rule):
    text = text.replace('\n', ' ').strip()
    if len(text) > 90: text = text[:87] + '...'
    FINDINGS.append((skill, sev, page, loc, text, rule))

CHAPTERS = 'chapters'
EXTRA_TEX: list = []          # e.g. samples/<job>.tex when checking build/<job>.pdf (QA-27)
def chapter_files():
    return sorted(p for p in Path(CHAPTERS).glob('*.tex')) + [Path(x) for x in EXTRA_TEX]

def read(p): return Path(p).read_text(encoding='utf-8')

def strip_comments(s):
    return '\n'.join(re.sub(r'(?<!\\)%.*', '', l) for l in s.split('\n'))

def lineno(s, idx): return s.count('\n', 0, idx) + 1

def pdf_pages(pdf):
    try:
        import pypdf
    except ImportError:
        report('qa-infra', 'major', '-', '-', 'pypdf not installed', 'requirements.txt'); return None, []
    if not Path(pdf).exists(): return None, []
    r = pypdf.PdfReader(pdf)
    return r, [pg.extract_text() or '' for pg in r.pages]

# --------------------------------------------------------------------------- qa-cls-version
def check_cls_version(a):
    cls = read('smartcross.cls')
    m = re.search(r'\\ProvidesClass\{smartcross\}\[(\S+) v(\S+)', cls)
    if not m: report('qa-cls-version', 'blocker', '-', 'smartcross.cls', 'no \\ProvidesClass version', 'AC-13')
    elif m.group(2) != CLS_TARGET:
        report('qa-cls-version', 'major', '-', 'smartcross.cls', f'v{m.group(2)} != target v{CLS_TARGET}', 'AC-13')
    for needle, rule in [(r'\luatexversion<124', 'engine guard (TeX Live 2026)'),
                         ('add_fallback("schebrm"', 'Hebrew font fallback INC-001'),
                         ('layout=tabular', 'babel layout DS-03'), ('autolang=none', 'biblatex DS-05')]:
        if needle not in cls: report('qa-cls-version', 'major', '-', 'smartcross.cls', f'missing: {needle}', rule)
    if 'layout=counters' in cls.split('% NOT layout=counters')[0]:
        report('qa-cls-version', 'major', '-', 'smartcross.cls', 'layout=counters enabled', 'DS-03')
    banned = r'\\(newcommand|renewcommand|providecommand|def|gdef|definecolor|colorlet|usepackage|RequirePackage|setlength|fontsize|selectfont|textcolor|color|babelfont|setmainfont|hspace\*?|vspace\*?)(?![a-zA-Z])'
    for f in chapter_files():
        s = strip_comments(read(f))
        for m in re.finditer(banned, s):
            sev = 'minor' if m.group(1).startswith(('hspace', 'vspace')) else 'major'
            report('qa-cls-version', sev, '-', f'{f}:{lineno(s, m.start())}', m.group(0), 'PLAN §5 / AC-13: formatting only in the .cls')

# --------------------------------------------------------------------------- qa-infra
def check_infra(a):
    texbin = '/Library/TeX/texbin'
    env = dict(os.environ, PATH=f'{texbin}:{os.environ.get("PATH", "")}')
    lua = shutil.which('lualatex', path=env['PATH'])
    try:
        v = subprocess.run(['lualatex', '--version'], capture_output=True, text=True, env=env).stdout.splitlines()[0]
        if 'TeX Live 2026' not in v: report('qa-infra', 'blocker', '-', lua or '-', v, 'toolchain: TeX Live 2026')
        b = subprocess.run(['biber', '--version'], capture_output=True, text=True, env=env).stdout.strip()
        if '2.21' not in b: report('qa-infra', 'major', '-', '-', b, 'toolchain: biber 2.21')
    except Exception as e:
        report('qa-infra', 'blocker', '-', '-', str(e), 'toolchain')
    if lua and not lua.startswith(texbin):
        report('qa-infra', 'major', '-', lua, 'lualatex not from /Library/TeX/texbin', 'toolchain (old MiKTeX link?)')
    for f in ['CLAUDE.md', 'README.md', 'PRD.md', 'PLAN.md', 'TODO.md', 'INCIDENTS.md', 'main.tex', 'smartcross.cls',
              'hebrew.lbx', 'references/refs.bib', 'references/VERIFICATION.md', 'references/README.md',
              'prompts/PROMPTS_LOG.md', 'requirements.txt', 'scripts/build.sh']:
        if not Path(f).exists(): report('qa-infra', 'major', '-', f, 'missing required file', 'AC-17')
    for fam in ['NotoSerifHebrew', 'NotoSansHebrew', 'NotoSerif', 'NotoSans', 'NotoSansMono']:
        if not list(Path('fonts', fam).glob('*.otf')) or not Path('fonts', fam, 'OFL.txt').exists():
            report('qa-infra', 'blocker', '-', f'fonts/{fam}', 'font or OFL.txt missing', 'PRD §6.2')
    for p in Path('references').glob('*.pdf'):
        if subprocess.run(['git', 'check-ignore', '-q', str(p)]).returncode != 0:
            report('qa-infra', 'blocker', '-', str(p), 'copyrighted reference not ignored', '.gitignore / references/README.md')
    tracked = subprocess.run(['git', 'ls-files', 'references'], capture_output=True, text=True).stdout.split()
    for t in tracked:
        if t.endswith('.pdf') or t.endswith('preparation-report-book.md'):
            report('qa-infra', 'blocker', '-', t, 'copyrighted reference tracked in git', 'copyright')
    # README images (AC-19)
    readme = read('README.md')
    for m in re.finditer(r'!\[[^\]]*\]\(([^)\s]+)\)', readme):
        if not m.group(1).startswith('http') and not Path(m.group(1)).exists():
            report('qa-infra', 'major', '-', f'README.md:{lineno(readme, m.start())}', m.group(1), 'AC-19 image link')
    r, _ = pdf_pages(a.pdf)
    if r is not None and Path(a.pdf).name == 'main.pdf':
        n = len(r.pages); labels = r.page_labels
        body = sum(1 for l in labels if l.isdigit())
        active = [n for n, f in re.findall(r'^\\inputchapter\{(\d+)\}\{([^}]+)\}', read('main.tex'), re.M) if Path(f + '.tex').exists()]
        sev = 'major' if len(active) == 10 else 'minor'          # gate: binding only when all 10 chapters are in
        if not 28 <= n <= 32: report('qa-infra', sev, '-', a.pdf, f'{n} pages ({len(active)}/10 chapters)', 'AC-01 (28–32)')
        if body < 25: report('qa-infra', sev, '-', a.pdf, f'{body} body pages ({len(active)}/10 chapters)', 'AC-02 (>= 25)')

# --------------------------------------------------------------------------- qa-typeset
def check_typeset(a):
    if not Path(a.log).exists():
        report('qa-typeset', 'blocker', '-', a.log, 'log not found – build first', 'AC-03'); return
    log = Path(a.log).read_text(encoding='utf-8', errors='replace')
    pats = [(r'^(!|\S+:\d+:) .*', 'blocker', 'error'),
            (r'^LaTeX Warning: (Reference|Citation) .*undefined.*', 'blocker', 'undefined ref/cite'),
            (r'^LaTeX Warning: There were undefined references.*', 'blocker', 'undefined refs'),
            (r'^Missing character: .*', 'blocker', 'missing glyph (INC-001)'),
            (r'^Underfull \\[hv]box .*', 'minor', 'underfull box'),
            (r'^(LaTeX|Package \w+|Class \w+) Warning: .*', 'major', 'warning'),
            (r'^LaTeX Font Warning: .*', 'major', 'font warning')]
    for pat, sev, rule in pats:
        for m in re.finditer(pat, log, re.M):
            report('qa-typeset', sev, '-', f'{a.log}:{lineno(log, m.start())}', m.group(0), f'AC-03 {rule}')
    for m in re.finditer(r'^Overfull \\[hv]box \(([\d.]+)pt too (wide|high)\).*', log, re.M):
        if float(m.group(1)) > 1.0:
            report('qa-typeset', 'major', '-', f'{a.log}:{lineno(log, m.start())}', m.group(0), 'AC-03 overfull > 1pt')
    for m in re.finditer(r'^SCENE-LINES:(\d+):(\d+)', log, re.M):
        if int(m.group(2)) > 4:
            report('qa-typeset', 'major', '-', f'chapter {m.group(1)}', f'scene box has {m.group(2)} rendered lines', 'AC-21 (<= 4)')
    if 'Rerun to get' in log:
        report('qa-typeset', 'major', '-', a.log, 'rerun requested', 'AC-03 build passes')

# --------------------------------------------------------------------------- qa-BiDi
SAFE_CMDS = r'en|num|pct|range|unit|cite|ref|eqref|label|enlabel|picto|includegraphics|authorphoto|input|begin|end|ChapterIcon|stattile|headrow|thead|SetLamp|setcounter|sidenote|texttt'
def strip_safe(s):
    """Remove constructs where Latin/digits are legitimate; what remains must be Hebrew + punctuation."""
    s = strip_comments(s)
    if '\\begin{document}' in s: s = s.split('\\begin{document}', 1)[1]     # master files: body only
    s = re.sub(r'\\begin\{(equation\*?|align\*?)\}.*?\\end\{\1\}', ' ', s, flags=re.S)
    s = re.sub(r'\$[^$]*\$', ' ', s)
    out, i = [], 0
    pat = re.compile(r'\\(' + SAFE_CMDS + r')(?![a-zA-Z])\*?')
    while True:
        m = pat.search(s, i)
        if not m: out.append(s[i:]); break
        out.append(s[i:m.start()]); j = m.end()
        # swallow following [..] and {..} groups
        while j < len(s) and s[j] in '[{':
            close = ']' if s[j] == '[' else '}'; depth = 0
            for k in range(j, len(s)):
                if s[k] == s[j]: depth += 1
                elif s[k] == close:
                    depth -= 1
                    if depth == 0: j = k + 1; break
            else: break
            if s[m.start()+1:m.end()].startswith(('stattile', 'sidenote', 'authorphoto')) and close == '}':
                pass
        out.append(' '); i = j
    s = ''.join(out)
    s = re.sub(r'\\[a-zA-Z@]+\*?(\[[^\]]*\])?', ' ', s)      # remaining command names
    return s

def check_bidi(a):
    for f in chapter_files():
        raw = strip_comments(read(f)); s = strip_safe(raw)
        for m in re.finditer(r'[A-Za-z]{2,}(?:[ \-][A-Za-z]+)*', s):
            report('qa-BiDi', 'major', '-', f'{f}', m.group(0), 'PRD §7 rule 2: English must use \\en{}')
        for m in re.finditer(r'\d[\d.,%]*', s):
            report('qa-BiDi', 'major', '-', f'{f}', m.group(0), 'PRD §7 rule 4: number must use \\num/\\pct/\\range/\\unit')
        for m in re.finditer(r'(?<![' + HEB + r'])([ובלמשהכ]{1,3})\\(num|en|pct|range|unit)\{', raw):
            report('qa-BiDi', 'minor', '-', f'{f}:{lineno(raw, m.start())}', m.group(0), 'PRD §7 rule 12: maqaf after prefix letter')
        for m in re.finditer(r'(?<![' + HEB + r'])[והבלמשכ]{0,3}חציה(?![' + HEB + r'])', raw):
            report('qa-BiDi', 'minor', '-', f'{f}:{lineno(raw, m.start())}', m.group(0), 'PRD §3.1 glossary: "חצייה" (full spelling)')
        for m in re.finditer(r'(?<![}\]a-zA-Z@*])\[\s*\d+\s*\]', raw):   # not an optional argument
            report('qa-BiDi', 'major', '-', f'{f}:{lineno(raw, m.start())}', m.group(0), 'PRD §7 rule 13: typed citation brackets')
    _, pages = pdf_pages(a.pdf)
    # Embedded matplotlib figures extract in LOGICAL order. Allow, per page, only as many occurrences of a word as the
    # figures actually placed on that page contain (QA-23: no book-wide masking).
    from collections import Counter
    figs = []
    for fp in Path('figures').glob('*.pdf'):
        _, fpages = pdf_pages(str(fp))
        figs.append(Counter(w for t in fpages for w in re.findall(r'[' + HEB + r']{2,}', t)))
    allow_pages = []
    for t in pages:
        pc = Counter(re.findall(r'[' + HEB + r']{2,}', t)); allow = Counter()
        for fc in figs:
            if fc and sum(min(pc[w], c) for w, c in fc.items()) >= 0.8 * sum(fc.values()): allow += fc
        allow_pages.append(allow)
    # dictionary of the Hebrew words actually written in the sources (logical order) – QA-26
    vocab = set()
    for f in chapter_files() + [Path('main.tex'), Path('smartcross.cls')] + list(Path('samples').glob('*.tex')):
        if f.exists(): vocab |= set(re.findall(r'[' + HEB + r']{2,}', read(f)))
    pdf_bidi_scan(pages, a.pdf, allow_pages=allow_pages, vocab=vocab)

def pdf_bidi_scan(pages, name, order='visual', allow_pages=None, vocab=None):
    """PDF-level BiDi regressions on extracted page text.
    order='visual'  – LuaTeX PDFs: correct Hebrew extracts reversed, so a final letter (ךםןףץ) can only come FIRST.
    order='logical' – matplotlib PDFs: correct Hebrew extracts in reading order, so a final letter can only come LAST."""
    for n, t in enumerate(pages, 1):
        allow = dict(allow_pages[n - 1]) if allow_pages else {}
        for w in re.findall(r'[' + HEB + r']{2,}', t):
            if allow.get(w, 0) > 0: allow[w] -= 1; continue        # an occurrence that belongs to an embedded figure
            bad = (w[-1] in FINALS and w[0] not in FINALS) if order == 'visual' else (w[0] in FINALS and w[-1] not in FINALS)
            if not bad and vocab and order == 'visual' and len(w) >= 3:
                # visual extraction of correct text = reversed source word; the source word itself = reversed rendering
                bad = w in vocab and w[::-1] not in vocab
            if bad:
                report('qa-BiDi', 'blocker', n, name, w, 'reversed Hebrew (DS-01 / INC-002)')
        for m in re.finditer(r'\]\s*\d+(?:\s*,\s*\d+)*\s*\[', t):
            report('qa-BiDi', 'blocker', n, name, m.group(0), 'mirrored citation brackets (DS-04)')
        for m in re.finditer(r'[A-Za-z]{2,}-{2,}', t):
            report('qa-BiDi', 'major', n, name, m.group(0), 'hyphenated English next to RTL (DS-11)')

# --------------------------------------------------------------------------- qa-table
def check_table(a):
    for f in chapter_files():
        s = strip_comments(read(f))
        for m in re.finditer(r'\\begin\{table\}(.*?)\\end\{table\}', s, re.S):
            body, ln = m.group(1), lineno(s, m.start())
            if '\\caption' not in body: report('qa-table', 'major', '-', f'{f}:{ln}', 'table without \\caption', 'booklet §11.1')
            lab = re.search(r'\\label\{([^}]+)\}', body)
            if not lab: report('qa-table', 'major', '-', f'{f}:{ln}', 'table without \\label', 'AC-08')
            elif body.find('\\caption') > body.find('\\begin{tabular'):
                report('qa-table', 'minor', '-', f'{f}:{ln}', 'caption below table', 'PRD §6.3: table captions above')
            for t in re.finditer(r'\\begin\{tabularx?\}(\{[^}]*\})?\{([^}]*)\}(.*?)\\end\{tabularx?\}', body, re.S):
                spec, rows = t.group(2), t.group(3)
                if '|' in spec: report('qa-table', 'major', '-', f'{f}:{ln}', spec, 'booktabs: no vertical rules')
                ncol = len(re.findall(r'[lcrXpmb]', re.sub(r'\{[^}]*\}', '', spec)))
                for row in re.split(r'\\\\', rows):
                    row = re.sub(r'\\(toprule|midrule|bottomrule|headrow)', '', row).strip()
                    if row and row.count('&') + 1 != ncol:
                        report('qa-table', 'major', '-', f'{f}:{ln}', row[:60], f'cell count != {ncol} columns')
                for r in ('\\toprule', '\\bottomrule'):
                    if r not in rows: report('qa-table', 'minor', '-', f'{f}:{ln}', f'missing {r}', 'booktabs style')

# --------------------------------------------------------------------------- qa-img
def check_img(a):
    allowed_raster = re.compile(r'^photo-[\w-]+\.(jpe?g|png)$')
    for p in Path('figures').rglob('*'):
        if p.suffix.lower() in ('.png', '.jpg', '.jpeg') and not allowed_raster.match(p.name):
            report('qa-img', 'blocker', '-', str(p), 'raster image not from our scripts / not an authors\' photo', 'AC-12')
    scripts = ' '.join(read(s) for s in Path('scripts').glob('*.py'))
    for p in Path('figures').glob('*.pdf'):
        if p.stem not in scripts:
            report('qa-img', 'major', '-', str(p), 'figure PDF with no generating script', 'AC-04 reproducibility')
        _, pages = pdf_pages(str(p))
        pdf_bidi_scan(pages, str(p), order='logical')   # matplotlib output (INC-002 detection gap)
    for f in chapter_files():
        s = strip_comments(read(f))
        for m in re.finditer(r'\\(includegraphics(\[[^\]]*\])?|authorphoto(\[[^\]]*\])?)\{([^}]+)\}', s):
            if not Path(m.group(4)).exists() and not m.group(1).startswith('authorphoto'):
                report('qa-img', 'blocker', '-', f'{f}:{lineno(s, m.start())}', m.group(4), 'missing figure file')
        for m in re.finditer(r'\\begin\{figure\}(.*?)\\end\{figure\}', s, re.S):
            if '\\caption' not in m.group(1):
                report('qa-img', 'major', '-', f'{f}:{lineno(s, m.start())}', 'figure without caption', 'booklet §16.6')
    pal = set(h.lower() for h in re.findall(r'#([0-9A-Fa-f]{6})', read('scripts/palette.py'))) if Path('scripts/palette.py').exists() else set()
    for sp in Path('scripts').glob('*.py'):
        if sp.name in ('palette.py', 'qa.py'): continue
        src = read(sp)
        for m in re.finditer(r'#([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})\b', src):
            if m.group(1).lower() not in pal:
                report('qa-img', 'major', '-', f'{sp}', '#' + m.group(1), 'PRD §6.1 colour outside the tokens')
        for m in re.finditer(r"(?:color|fc|ec|mec|mfc|facecolor|edgecolor)\s*=\s*['\"]([a-z]+)['\"]", src):
            if m.group(1) not in ('none',):
                report('qa-img', 'major', '-', f'{sp}:{lineno(src, m.start())}', m.group(0), 'PRD §6.1 named colour – use palette.py')
        for m in re.finditer(r'(?:color|fc|ec)\s*=\s*\(\s*[\d.]+\s*,', src):
            report('qa-img', 'major', '-', f'{sp}:{lineno(src, m.start())}', m.group(0), 'PRD §6.1 RGB tuple – use palette.py')

# --------------------------------------------------------------------------- qa-code
def check_code(a):
    py = ROOT / '.venv/bin/python'
    for sp in sorted(Path('scripts').glob('*.py')):
        if sp.name == 'qa.py': continue
        r = subprocess.run([str(py), '-m', 'py_compile', str(sp)], capture_output=True, text=True)
        if r.returncode: report('qa-code', 'blocker', '-', str(sp), r.stderr.strip()[-80:], 'script does not compile')
    if Path('scripts/make_figures.py').exists():
        r = subprocess.run([str(py), 'scripts/make_figures.py'], capture_output=True, text=True)
        if r.returncode: report('qa-code', 'blocker', '-', 'scripts/make_figures.py', r.stderr.strip()[-80:], 'AC-04 figures regenerate')
        for line in subprocess.run(['git', 'status', '--porcelain', 'figures', 'data'], capture_output=True, text=True).stdout.splitlines():
            st, path = line[:2], line[3:]
            if st == '??': report('qa-code', 'minor', '-', path, 'new file not committed yet', 'AC-04')
            elif st[1] != ' ':   # regenerated output differs from the staged/committed version (staged edits are intended)
                report('qa-code', 'major', '-', path, 'regenerated output differs from the staged/committed file', 'AC-04 stale figure/data')
    q = Path('data/quoted_in_book.json')
    if not q.exists():
        report('qa-code', 'major', '-', str(q), 'missing: register of numbers quoted in the book', 'AC-14')
    else:
        reg = json.loads(read(q)); rec = json.loads(read('data/recomputed.json'))
        def lookup(path):
            cur = rec
            for k in path.split('.'): cur = cur[int(k)] if isinstance(cur, list) else cur[k]
            return cur
        args = {}
        for f in chapter_files():
            src = strip_comments(read(f))
            vals = re.findall(r'\\(?:num|pct)\{([^}]*)\}', src) + [v for pair in re.findall(r'\\range\{([^}]*)\}\{([^}]*)\}', src) for v in pair]
            for v in vals: args.setdefault(v.replace(',', ''), []).append(f.stem)
        for item in reg.get('numbers', []):
            try: val = lookup(item['source'])
            except Exception: report('qa-code', 'major', '-', str(q), item['source'], 'AC-14 source path not in recomputed.json'); continue
            shown = item['shown']
            if abs(float(shown) - float(val)) > 0.5 * 10 ** (-item.get('decimals', 2)):
                report('qa-code', 'major', '-', str(q), f"{shown} vs {val}", f"AC-14 rounding of {item['source']}")
            if not any(item.get('chapter', '') in ch for ch in args.get(shown.replace(',', ''), [])):
                report('qa-code', 'major', '-', item.get('chapter', 'chapters/'), shown, f"AC-14 registered number not in \\num/\\pct ({item['source']})")

# --------------------------------------------------------------------------- content (qa-super only)
FIRST_PERSON = ['אני', 'אנחנו', 'שלנו', 'שלי', 'לדעתי', 'בדקנו', 'ראינו', 'מצאנו', 'נראה לנו', 'אנו']
def check_content(a):
    labels, refs, text = {}, set(), ''
    for f in chapter_files():
        s = strip_comments(read(f)); text += s
        for m in re.finditer(r'\\label\{([^}]+)\}', s): labels[m.group(1)] = f'{f}:{lineno(s, m.start())}'
        refs |= set(re.findall(r'\\(?:eq)?ref\{([^}]+)\}', s))
        # scene boxes (AC-21)
        scenes = list(re.finditer(r'\\begin\{scenebox\}(.*?)\\end\{scenebox\}', s, re.S))
        if '\\chapter' in s and len(scenes) != s.count('\\chapter{'):
            report('qa-super', 'major', '-', str(f), f'{len(scenes)} scene boxes for {s.count(chr(92)+"chapter{")} chapters', 'AC-21')
        for sc in scenes:
            body = sc.group(1); ln = lineno(s, sc.start())
            if len(' '.join(body.split())) > 330: report('qa-super', 'major', '-', f'{f}:{ln}', 'scene longer than ~4 lines', 'AC-21 / PRD §12')
            if re.search(r'\d|\\cite|\\num|\\pct', body): report('qa-super', 'major', '-', f'{f}:{ln}', 'number or citation in scene', 'PRD §12')
        for w in FIRST_PERSON:
            for m in re.finditer(r'(?<![' + HEB + r'])' + w + r'(?![' + HEB + r'])', re.sub(r'\\begin\{(scenebox|pullquote)\}.*?\\end\{\1\}', '', s, flags=re.S)):
                report('qa-super', 'major', '-', str(f), w, 'PRD §3.1 third person only')
    ch4 = Path(CHAPTERS, 'ch04-literature.tex')
    if ch4.exists():
        c4 = read(ch4); issues = re.findall(r'^### Issue (D\d)', read('PRD.md'), re.M)
        if '\\begin{cautionbox}' not in c4: report('qa-super', 'major', '-', str(ch4), 'no cautionbox', 'AC-15')
        for d in issues:
            if f'\\en{{{d}}}' not in c4: report('qa-super', 'major', '-', str(ch4), d, 'AC-15 data issue not discussed')
    for lab, loc in labels.items():
        if lab not in refs and not lab.startswith('eq:'):
            report('qa-super', 'major', '-', loc, lab, 'AC-08 figure/table not referenced in text')
    # citations <-> bib <-> verification (AC-09, AC-22)
    bib = read('references/refs.bib'); keys = set(re.findall(r'@\w+\{([^,]+),', bib))
    cited = set(k.strip() for c in re.findall(r'\\cite(?:\[[^\]]*\])*\{([^}]+)\}', text) for k in c.split(','))
    ver = read('references/VERIFICATION.md')
    for k in sorted(cited - keys): report('qa-super', 'blocker', '-', 'chapters/', k, 'cited key missing from refs.bib')
    for k in sorted(keys - cited): report('qa-super', 'minor', '-', 'references/refs.bib', k, 'AC-09 entry never cited')
    for k in sorted(keys):
        row = re.search(r'^\|\s*`' + re.escape(k) + r'`.*$', ver, re.M)
        cells = [c.strip().strip('*').strip().lower() for c in row.group(0).split('|')] if row else []
        if not row or 'verified' not in cells:
            report('qa-super', 'blocker', '-', 'references/VERIFICATION.md', k, 'AC-22 entry not verified online')
    # copy check: 8-word n-grams shared with the local references (AC-11)
    refs_txt = ''
    try:
        import pypdf
        for p in Path('references').glob('*.pdf'):
            refs_txt += ' '.join((pg.extract_text() or '') for pg in pypdf.PdfReader(str(p)).pages)
    except Exception: pass
    md = Path('references/preparation-report-book.md')
    if md.exists(): refs_txt += read(md)
    if refs_txt:
        norm = lambda x: re.findall(r'[A-Za-z' + HEB + r']+', x.lower())
        ref_words = norm(refs_txt); grams = set(' '.join(ref_words[i:i+8]) for i in range(len(ref_words) - 7))
        book = norm(strip_safe(text)) + norm(' '.join(re.findall(r'\\en\{([^}]*)\}', text)))
        for i in range(len(book) - 7):
            g = ' '.join(book[i:i+8])
            if g in grams: report('qa-super', 'blocker', '-', 'chapters/', g, 'AC-11 copied 8-word sequence')
    else:
        report('qa-super', 'minor', '-', 'references/', 'reference texts not available locally – copy check skipped', 'AC-11')

ORDER = [('cls-version', check_cls_version), ('infra', check_infra), ('typeset', check_typeset),
         ('bidi', check_bidi), ('table', check_table), ('img', check_img), ('code', check_code), ('content', check_content)]

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('family', choices=[n for n, _ in ORDER] + ['super'])
    ap.add_argument('--pdf', default='build/main.pdf'); ap.add_argument('--log', default=None)
    ap.add_argument('--chapters', default='chapters', help='folder of chapter .tex files (tests use a fixture folder)')
    a = ap.parse_args()
    global CHAPTERS; CHAPTERS = a.chapters
    sample = Path('samples', Path(a.pdf).stem + '.tex')
    if sample.exists(): EXTRA_TEX.append(str(sample))
    a.log = a.log or str(Path(a.pdf).with_suffix('.log'))
    ran = []
    for name, fn in ORDER:
        if a.family in (name, 'super'):
            before = len(FINDINGS); fn(a); ran.append((name, len(FINDINGS) - before))
    sev_rank = {'blocker': 0, 'major': 1, 'minor': 2}
    for f in sorted(FINDINGS, key=lambda x: sev_rank[x[1]]):
        print(f'[{f[0]}] [{f[1]}] [page {f[2]}] [{f[3]}] "{f[4]}" -> {f[5]}')
    counts = {s: sum(1 for f in FINDINGS if f[1] == s) for s in sev_rank}
    print('-- ran: ' + ', '.join(f'{n} ({c})' for n, c in ran) + f' | chapters: {len(chapter_files())} files | pdf: {a.pdf}')
    print(f'== {a.family}: {counts["blocker"]} blocker, {counts["major"]} major, {counts["minor"]} minor')
    sys.exit(1 if counts['blocker'] or counts['major'] else 0)

if __name__ == '__main__':
    main()
