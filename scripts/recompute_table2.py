#!/usr/bin/env python3
"""recompute_table2.py – reproduces the data checks of PRD §9 (D1–D5) from data/rosenbloom2009_table*.csv
and writes data/recomputed.json (the single source for every recomputed number quoted in the book, AC-14)."""
import csv, json, math
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
def rows(name):
    with open(ROOT / 'data' / name, encoding='utf-8') as f:
        return list(csv.DictReader(l for l in f if not l.startswith('#')))
def r2(x): return None if x is None else round(x, 6)   # keep precision; rounding happens where a number is shown
def p_wald(w):            # chi-square, 1 df
    return math.erfc(math.sqrt(w / 2))
def sig(x):               # p-values: 2 significant digits, never rounded to 0 (QA-19)
    return float(f'{x:.2g}')
def n0(v): return int(v) if v not in ('', None) else 0     # printed "–" -> 0 (inferred, QA-17)
def wilson(k, n, z=1.96):  # 95% Wilson interval for a proportion
    p = k / n; d = 1 + z * z / n; c = p + z * z / (2 * n); h = z * math.sqrt(p * (1 - p) / n + z * z / (4 * n * n))
    return [r2(100 * (c - h) / d), r2(100 * (c + h) / d)]
def chi2(table):          # Pearson chi-square, df
    R = [sum(r) for r in table]; C = [sum(c) for c in zip(*table)]; N = sum(R)
    x = sum((table[i][j] - R[i] * C[j] / N) ** 2 / (R[i] * C[j] / N) for i in range(len(R)) for j in range(len(C)) if R[i] * C[j])
    return r2(x), (len(R) - 1) * (len(C) - 1)

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
    rec['p_from_printed_wald'] = sig(p_wald(float(r['wald']))) if float(r['wald']) > 0 else None
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
    by_gender[g] = {'arrived_red': arr, 'crossed_red': int(r['red_red']), 'rate_pct': r2(100 * int(r['red_red']) / arr),
                    'wilson95_pct': wilson(int(r['red_red']), arr)}
out['table1']['by_gender_red_arrivals'] = by_gender
a, b_, c, d = by_gender['female']['crossed_red'], by_gender['female']['arrived_red'] - by_gender['female']['crossed_red'], \
              by_gender['male']['crossed_red'], by_gender['male']['arrived_red'] - by_gender['male']['crossed_red']
n = a + b_ + c + d
out['table1']['chi2_gender_recomputed'] = r2(n * (a * d - b_ * c) ** 2 / ((a + b_) * (c + d) * (a + c) * (b_ + d)))
fg = t1[('gender', 'female')]
out['table1']['female_pct_green_green_recomputed'] = r2(100 * int(fg['green_green']) / int(allr['green_green']))
out['table1']['age_20_40_pct_recomputed'] = r2(100 * int(t1[('age', '20-40')]['total']) / int(allr['total']))

# D7 – the printed age chi-square, chi2(2, N = 1392) = 1.02, cannot be reproduced from Table 1 (QA-15)
ages = [t1[('age', a)] for a in ('20-40', '40-60', '60+')]
v1 = chi2([[n0(a['green_green']), n0(a['red_green']), n0(a['red_red'])] for a in ages])
v2 = chi2([[n0(a['red_red']), n0(a['total']) - n0(a['red_red'])] for a in ages])
v3 = chi2([[n0(a['red_red']), n0(a['red_green'])] for a in ages])
exp_60_cross = r2(n0(ages[2]['total']) * int(allr['red_red']) / int(allr['total']))
out['table1']['age_chi2_variants'] = {'printed': [1.02, 2, 1392], 'phase_3x3': [v1[0], v1[1], 1392],
    'crossed_vs_not': [v2[0], v2[1], 1392], 'red_arrivals_only': [v3[0], v3[1], 563], 'expected_60plus_crossers': exp_60_cross}
T = out['table2']
out['issues'] = {
  'D1_exp_b_mismatch': {k: [T[k]['exp_b_printed'], T[k]['exp_b_recomputed']] for k in ('waiting', 'joining')},
  'D2_traffic_row': {'b_se_give': [T['traffic']['exp_b_recomputed'], T['traffic']['wald_recomputed']],
                     'ci_and_exp_b_imply_b': T['traffic']['b_implied_by_ci'],
                     'ci_and_exp_b_imply_se': T['traffic']['se_implied_by_ci'],
                     'p_from_printed_wald': T['traffic']['p_from_printed_wald']},
  'D4_separation': {'b': T['crossing']['b'], 'se': T['crossing']['se']},
  'D5_female_pct': [float(fg['printed_pct_green_green']), out['table1']['female_pct_green_green_recomputed']],
  'chi2_gender_check': [17.17, out['table1']['chi2_gender_recomputed']],
  'D7_age_chi2': out['table1']['age_chi2_variants'],
  'odds_reduction_pct_per_person': {'waiting_recomputed': r2(100 * (1 - math.exp(T['waiting']['b']))),
                                    'waiting_printed': r2(100 * (1 - float(T['waiting']['exp_b_printed']))),
                                    'joining_recomputed': r2(100 * (1 - math.exp(T['joining']['b']))),
                                    'joining_printed': r2(100 * (1 - float(T['joining']['exp_b_printed'])))}}
# context numbers derived by the authors from a cited source (who2023israel: 364 road deaths in 2021, pedestrians ≈ 27%)
out['context'] = {'israel_road_deaths_2021': 364, 'israel_pedestrian_share_pct': 27,
                  'israel_pedestrian_deaths_derived': r2(364 * 0.27)}
(ROOT / 'data' / 'recomputed.json').write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps(out['issues'], ensure_ascii=False, indent=1))
print('table1:', {k: v for k, v in out['table1'].items() if k != 'by_gender_red_arrivals'}, out['table1']['by_gender_red_arrivals'])
