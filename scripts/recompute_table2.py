#!/usr/bin/env python3
"""recompute_table2.py – reproduces the data checks of PRD §9 (D1–D5) from data/rosenbloom2009_table*.csv
and writes data/recomputed.json (the single source for every recomputed number quoted in the book, AC-14)."""
import csv, json, math
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
def rows(name):
    with open(ROOT / 'data' / name, encoding='utf-8') as f:
        return list(csv.DictReader(l for l in f if not l.startswith('#')))
def r2(x): return None if x is None else round(x, 2)
def p_wald(w):            # chi-square, 1 df
    return math.erfc(math.sqrt(w / 2))

out = {'source': 'rosenbloom2009', 'table2': {}, 'table1': {}, 'issues': {}, 'quoted_in_book': {}}
for r in rows('rosenbloom2009_table2.csv'):
    b, se = float(r['b']), float(r['se_b'])
    rec = {'b': b, 'se': se, 'exp_b_printed': r['exp_b'] or None,
           'exp_b_recomputed': r2(math.exp(b)) if abs(b) < 20 else None,
           'ci_recomputed': [r2(math.exp(b - 1.96 * se)), r2(math.exp(b + 1.96 * se))] if abs(b) < 20 else None,
           'wald_recomputed': r2((b / se) ** 2), 'wald_printed': float(r['wald'])}
    if r['ci_low']:
        lo, hi = float(r['ci_low']), float(r['ci_high'])
        b_impl = (math.log(lo) + math.log(hi)) / 2; se_impl = (math.log(hi) - math.log(lo)) / 3.92
        rec.update(b_implied_by_ci=r2(b_impl), se_implied_by_ci=r2(se_impl),
                   exp_b_implied_by_ci=r2(math.exp(b_impl)))
    rec['p_from_printed_wald'] = round(p_wald(float(r['wald'])), 4) if float(r['wald']) > 0 else None
    out['table2'][r['predictor_key']] = rec

t1 = {(r['group'], r['category']): r for r in rows('rosenbloom2009_table1.csv')}
allr = t1[('all', 'all')]
arrivals_red = int(allr['red_green']) + int(allr['red_red'])
out['table1'] = {
    'observations': int(allr['total']), 'arrived_red': arrivals_red,
    'arrived_red_pct': r2(100 * arrivals_red / int(allr['total'])),
    'crossed_red': int(allr['red_red']),
    'crossed_red_pct_of_all': r2(100 * int(allr['red_red']) / int(allr['total'])),
    'crossed_red_pct_of_red_arrivals': r2(100 * int(allr['red_red']) / arrivals_red)}
by_gender = {}
for g in ('female', 'male'):
    r = t1[('gender', g)]; arr = int(r['red_green']) + int(r['red_red'])
    by_gender[g] = {'arrived_red': arr, 'crossed_red': int(r['red_red']), 'rate_pct': r2(100 * int(r['red_red']) / arr)}
out['table1']['by_gender_red_arrivals'] = by_gender
a, b_, c, d = by_gender['female']['crossed_red'], by_gender['female']['arrived_red'] - by_gender['female']['crossed_red'], \
              by_gender['male']['crossed_red'], by_gender['male']['arrived_red'] - by_gender['male']['crossed_red']
n = a + b_ + c + d
out['table1']['chi2_gender_recomputed'] = r2(n * (a * d - b_ * c) ** 2 / ((a + b_) * (c + d) * (a + c) * (b_ + d)))
fg = t1[('gender', 'female')]
out['table1']['female_pct_green_green_recomputed'] = r2(100 * int(fg['green_green']) / int(allr['green_green']))
out['table1']['age_20_40_pct_recomputed'] = r2(100 * int(t1[('age', '20-40')]['total']) / int(allr['total']))

T = out['table2']
out['issues'] = {
  'D1_exp_b_mismatch': {k: [T[k]['exp_b_printed'], T[k]['exp_b_recomputed']] for k in ('waiting', 'joining')},
  'D2_traffic_row': {'b_se_give': [T['traffic']['exp_b_recomputed'], T['traffic']['wald_recomputed']],
                     'ci_and_exp_b_imply_b': T['traffic']['b_implied_by_ci'],
                     'ci_and_exp_b_imply_se': T['traffic']['se_implied_by_ci'],
                     'p_from_printed_wald': T['traffic']['p_from_printed_wald']},
  'D4_separation': {'b': T['crossing']['b'], 'se': T['crossing']['se']},
  'D5_female_pct': [float(fg['printed_pct_green_green']), out['table1']['female_pct_green_green_recomputed']],
  'chi2_gender_check': [17.17, out['table1']['chi2_gender_recomputed']]}
(ROOT / 'data' / 'recomputed.json').write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps(out['issues'], ensure_ascii=False, indent=1))
print('table1:', {k: v for k, v in out['table1'].items() if k != 'by_gender_red_arrivals'}, out['table1']['by_gender_red_arrivals'])
