"""G4 – risk heat-map: 5x5 probability x impact grid, risk IDs (inherent P, I) from data/risks.csv.
Risk score R = P*I; critical zone R >= 12 is marked by BOTH a red tint and a hatch pattern (greyscale-safe, QA-01).
Numeric axes stay LTR (QA-04); Hebrew via figstyle.he() only."""
import csv
from collections import defaultdict
from matplotlib.patches import Rectangle, Patch
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, HAIRLINE, SIGNAL_RED, SIGNAL_AMBER, STRIPE_WHITE, WHITE

CRITICAL = 12      # R >= 12 critical
MEDIUM = 6         # 6 <= R < 12 medium

def make():
    rows = list(csv.DictReader((ROOT / 'data/risks.csv').open(encoding='utf-8')))
    cells = defaultdict(list)
    for r in rows:
        cells[(int(r['I']), int(r['P']))].append(r['id'])
    fig, ax = plt.subplots(figsize=(TEXT_W, 78 * MM))
    for i in range(1, 6):
        for p in range(1, 6):
            R = i * p
            if R >= CRITICAL:
                kw = dict(facecolor=SIGNAL_RED, alpha=0.30, hatch='////', edgecolor=SIGNAL_RED)
            elif R >= MEDIUM:
                kw = dict(facecolor=SIGNAL_AMBER, alpha=0.40, edgecolor=WHITE)
            else:
                kw = dict(facecolor=HAIRLINE, alpha=0.45, edgecolor=WHITE)
            ax.add_patch(Rectangle((i - 0.5, p - 0.5), 1, 1, linewidth=0.8, **kw))
            ax.add_patch(Rectangle((i - 0.5, p - 0.5), 1, 1, fill=False, edgecolor=WHITE, linewidth=1.2))
            ax.text(i + 0.44, p - 0.44, str(R), ha='right', va='bottom', fontsize=6.5, color=ASPHALT_LIGHT)
    for (i, p), ids in cells.items():
        for k, rid in enumerate(sorted(ids, key=lambda s: int(s[1:]))):
            dx = (k - (len(ids) - 1) / 2) * 0.4
            ax.text(i + dx, p + 0.04, rid, ha='center', va='center', fontsize=8.5, fontweight='bold', color=ASPHALT,
                    bbox=dict(boxstyle='round,pad=0.22', fc=WHITE, ec=ASPHALT, lw=0.8), zorder=6)
    ax.set_xlim(0.5, 5.5); ax.set_ylim(0.5, 5.5); ax.set_aspect('auto')
    ax.set_xticks(range(1, 6)); ax.set_yticks(range(1, 6)); ax.grid(False)
    ax.set_xlabel(he('חומרת ההשפעה (דרגות 1 עד 5)'))
    ax.set_ylabel(he('סבירות (דרגות 1 עד 5)'))
    ax.yaxis.tick_right(); ax.yaxis.set_label_position('right')
    ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.tick_params(length=0)
    handles = [Patch(facecolor=SIGNAL_RED, alpha=0.30, hatch='////', edgecolor=SIGNAL_RED, label=he(f'קריטי (R של {CRITICAL} ומעלה)')),
               Patch(facecolor=SIGNAL_AMBER, alpha=0.40, edgecolor=WHITE, label=he(f'בינוני (R בין {MEDIUM} ל-{CRITICAL - 1})')),
               Patch(facecolor=HAIRLINE, alpha=0.45, edgecolor=WHITE, label=he(f'נמוך (R עד {MEDIUM - 1})'))]
    ax.legend(handles=handles, loc='lower center', bbox_to_anchor=(0.5, 1.0), ncol=3, fontsize=7.5, handlelength=2.2)
    return save(fig, 'g4-risk-heatmap')

if __name__ == '__main__':
    print(make())
