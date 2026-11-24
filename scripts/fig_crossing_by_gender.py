"""G1 – red-light crossing rate among pedestrians who arrived on red, by gender, with 95% Wilson intervals
(from Table 1 of rosenbloom2009). Gender is a neutral category: no signal colour (QA-12)."""
import json
import matplotlib.patheffects as pe
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, WHITE

def make():
    rec = json.loads((ROOT / 'data/recomputed.json').read_text(encoding='utf-8'))['table1']
    g = rec['by_gender_red_arrivals']
    cats = [('נשים', g['female']), ('גברים', g['male'])]
    fig, ax = plt.subplots(figsize=(TEXT_W, 52 * MM))
    for x, (lab, d), col, hatch in zip(range(2), cats, (ASPHALT_LIGHT, ASPHALT), ('', '////')):
        ax.bar(x, d['rate_pct'], width=0.5, color=col, hatch=hatch, edgecolor=WHITE, linewidth=0)
        lo, hi = d['wilson95_pct']
        ax.errorbar(x, d['rate_pct'], yerr=[[d['rate_pct'] - lo], [hi - d['rate_pct']]], fmt='none', ecolor=ASPHALT,
                    elinewidth=1, capsize=4, zorder=5)
        # categorical axis is inverted: x - 0.3 is visually to the RIGHT of the bar, text extends rightwards
        ax.text(x - 0.3, d['rate_pct'], f"{d['rate_pct']:.1f}%", ha='left', va='center', fontsize=10,
                fontweight='bold', color=ASPHALT)
        ax.text(x, 1.0, he(f"{d['crossed_red']} מתוך {d['arrived_red']}"), ha='center', va='bottom', fontsize=7.5,
                color=WHITE, bbox=dict(boxstyle='round,pad=0.25', fc=ASPHALT, ec=WHITE, lw=0.6), zorder=6)
    overall = rec['crossed_red_pct_of_red_arrivals']
    ax.axhline(overall, color=ASPHALT, linewidth=1.1, linestyle=(0, (4, 3)), zorder=4,
               path_effects=[pe.Stroke(linewidth=3.2, foreground=WHITE), pe.Normal()])
    ax.text(0.985, overall + 0.6, he(f'ממוצע כלל המגיעים באדום: {overall:.1f}%'), ha='right', va='bottom',
            fontsize=7.5, color=ASPHALT, transform=ax.get_yaxis_transform(),
            path_effects=[pe.Stroke(linewidth=2.5, foreground=WHITE), pe.Normal()])
    ax.text(0.015, 0.97, he('קווי שגיאה: רווח סמך 95% (וילסון)'), ha='left', va='top', fontsize=7,
            color=ASPHALT_LIGHT, transform=ax.transAxes)
    ax.set_xticks([0, 1], [he(l) for l, _ in cats], fontsize=9.5)
    ax.tick_params(axis='x', length=0, pad=4)
    ax.set_ylabel(he('שיעור החוצים באדום (%)'))
    ax.set_ylim(0, 30); ax.set_xlim(-0.85, 1.5)
    ax.invert_xaxis()                       # categories in RTL reading order (categorical axis only)
    ax.yaxis.tick_right(); ax.yaxis.set_label_position('right')
    ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.grid(axis='x', visible=False)
    return save(fig, 'g1-crossing-by-gender')

if __name__ == '__main__':
    print(make())
