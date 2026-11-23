"""G1 – red-light crossing rate among pedestrians who arrived on red, by gender (from Table 1 of rosenbloom2009)."""
import json
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, SIGNAL_RED

def make():
    rec = json.loads((ROOT / 'data/recomputed.json').read_text(encoding='utf-8'))['table1']
    g = rec['by_gender_red_arrivals']
    cats = [('נשים', g['female']), ('גברים', g['male'])]
    fig, ax = plt.subplots(figsize=(TEXT_W, 58 * MM))
    xs = range(len(cats))
    # colour is NOT the only channel: hatch + direct value labels (PRD §3.3)
    for x, (lab, d), col, hatch in zip(xs, cats, (ASPHALT_LIGHT, SIGNAL_RED), ('', '////')):
        ax.bar(x, d['rate_pct'], width=0.52, color=col, hatch=hatch, edgecolor='white', linewidth=0)
        ax.text(x, d['rate_pct'] + 0.6, f"{d['rate_pct']:.1f}%", ha='center', va='bottom', fontsize=10,
                fontweight='bold', color=ASPHALT)
        # one line per text object: matplotlib applies the RTL mark only to the first line (INC-002)
        ax.text(x, 1.0, he(f"{d['crossed_red']} מתוך {d['arrived_red']}"), ha='center', va='bottom', fontsize=7.5,
                color='white', bbox=dict(boxstyle='round,pad=0.25', fc=ASPHALT, ec='none'))
    overall = rec['crossed_red_pct_of_red_arrivals']
    ax.axhline(overall, color=ASPHALT, linewidth=0.9, linestyle=(0, (4, 3)))
    ax.text(0.985, overall + 0.5, he(f'ממוצע כלל המגיעים באדום: {overall:.1f}%'), ha='right', va='bottom',
            fontsize=7.5, color=ASPHALT, transform=ax.get_yaxis_transform())
    ax.set_xticks(list(xs), [he(l) for l, _ in cats], fontsize=9.5)
    ax.tick_params(axis='x', length=0, pad=4)
    ax.set_ylabel(he('שיעור החוצים באדום (%)'))
    ax.set_ylim(0, 25); ax.set_xlim(-0.6, len(cats) - 0.4)
    ax.invert_xaxis()                       # RTL reading order: first category on the right
    ax.yaxis.tick_right(); ax.yaxis.set_label_position('right')
    ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.grid(axis='x', visible=False)
    return save(fig, 'g1-crossing-by-gender')

if __name__ == '__main__':
    print(make())
