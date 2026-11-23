"""G2 – odds ratios of Table 2: as printed vs recomputed from b and SE (PRD §9, issues D1–D2). Log scale."""
import json, math
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, SIGNAL_AMBER, SIGNAL_RED
import csv

LABELS = {'gender': 'מגדר (גבר)', 'waiting': 'ממתינים בעת ההגעה', 'joining': 'מצטרפים אחרי ההגעה',
          'traffic': 'נפח התנועה במופע האדום'}

def make():
    rows = {r['predictor_key']: r for r in csv.DictReader(
        l for l in open(ROOT / 'data/rosenbloom2009_table2.csv', encoding='utf-8') if not l.startswith('#'))}
    rec = json.loads((ROOT / 'data/recomputed.json').read_text(encoding='utf-8'))['table2']
    keys = ['gender', 'waiting', 'joining', 'traffic']
    fig, ax = plt.subplots(figsize=(TEXT_W, 64 * MM))
    for i, k in enumerate(keys):
        y = len(keys) - 1 - i
        p = rows[k]
        # printed: hollow circle + thin line
        ax.plot([float(p['ci_low']), float(p['ci_high'])], [y + 0.14] * 2, color=ASPHALT_LIGHT, linewidth=1.2)
        ax.plot(float(p['exp_b']), y + 0.14, 'o', mfc='white', mec=ASPHALT_LIGHT, mew=1.3, ms=6)
        # recomputed: filled diamond + thick line
        lo, hi = rec[k]['ci_recomputed']
        ax.plot([lo, hi], [y - 0.14] * 2, color=SIGNAL_AMBER, linewidth=2.2, solid_capstyle='butt')
        ax.plot(rec[k]['exp_b_recomputed'], y - 0.14, 'D', color=ASPHALT, ms=5.5)
        if abs(float(p['exp_b']) - rec[k]['exp_b_recomputed']) > 0.02:
            ax.text(7.5, y, he('אי-התאמה'), color=SIGNAL_RED, fontsize=7.5, va='center', ha='right', fontweight='bold')
    ax.axvline(1, color=ASPHALT, linewidth=0.8)
    ax.set_xscale('log'); ax.set_xlim(0.35, 8)
    ax.set_xticks([0.5, 1, 2, 4], ['0.5', '1', '2', '4']); ax.minorticks_off()
    ax.set_yticks(range(len(keys)), [he(LABELS[k]) for k in reversed(keys)])
    ax.yaxis.tick_right(); ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.tick_params(axis='y', length=0)
    ax.set_xlabel(he('יחס סיכויים לחצייה באדום (סולם לוגריתמי; 1 = ללא השפעה)'))
    ax.grid(axis='y', visible=False)
    h1, = ax.plot([], [], 'o', mfc='white', mec=ASPHALT_LIGHT, mew=1.3, ms=6, color=ASPHALT_LIGHT, linestyle='-')
    h2, = ax.plot([], [], 'D', color=ASPHALT, ms=5.5, linestyle='-', linewidth=2.2, markerfacecolor=ASPHALT)
    h2.set_color(SIGNAL_AMBER); h2.set_markerfacecolor(ASPHALT); h2.set_markeredgecolor(ASPHALT)
    ax.legend([h1, h2], [he('כפי שפורסם במאמר'), he('מחושב מחדש מ-b ו-SE')], loc='upper center',
              bbox_to_anchor=(0.5, 1.16), ncol=2, fontsize=7.8)
    return save(fig, 'g2-odds-ratios')

if __name__ == '__main__':
    print(make())
