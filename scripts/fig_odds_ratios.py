"""G2 – odds ratios of Table 2 of rosenbloom2009: as printed vs derived from the printed b and SE (PRD §9 D1–D2).
Log scale. The 5th predictor (b = −24.24, SE = 8,184.53, separation) has no interpretable OR and is omitted (D4).
For the traffic row the printed columns contradict each other: the figure marks a CONTRADICTION, not an error of one side (QA-03)."""
import csv, json
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, SIGNAL_AMBER, SIGNAL_RED, WHITE

LABELS = {'gender': 'מגדר', 'waiting': 'ממתינים בעת ההגעה', 'joining': 'מצטרפים אחרי ההגעה',
          'traffic': 'נפח התנועה במופע האדום'}
NOTE = {'waiting': 'אי-התאמה', 'joining': 'אי-התאמה', 'traffic': 'סתירה פנימית'}

def make():
    rows = {r['predictor_key']: r for r in csv.DictReader(
        l for l in open(ROOT / 'data/rosenbloom2009_table2.csv', encoding='utf-8') if not l.startswith('#'))}
    rec = json.loads((ROOT / 'data/recomputed.json').read_text(encoding='utf-8'))['table2']
    keys = ['gender', 'waiting', 'joining', 'traffic']
    fig, ax = plt.subplots(figsize=(TEXT_W, 62 * MM))
    for i, k in enumerate(keys):
        y = len(keys) - 1 - i; p = rows[k]
        ax.plot([float(p['ci_low']), float(p['ci_high'])], [y + 0.15] * 2, color=ASPHALT_LIGHT, linewidth=1.2)
        ax.plot(float(p['exp_b']), y + 0.15, 'o', mfc=WHITE, mec=ASPHALT_LIGHT, mew=1.3, ms=6)
        lo, hi = rec[k]['ci_recomputed']
        ax.plot([lo, hi], [y - 0.15] * 2, color=ASPHALT, linewidth=2.2, solid_capstyle='butt')
        ax.plot(rec[k]['exp_b_recomputed'], y - 0.15, 'D', mfc=SIGNAL_AMBER, mec=ASPHALT, mew=1.1, ms=6)
        if k in NOTE:
            ax.text(7.6, y, he(NOTE[k]), color=SIGNAL_RED, fontsize=7.5, va='center', ha='right', fontweight='bold')
    ax.axvline(1, color=ASPHALT, linewidth=0.8)
    ax.set_xscale('log'); ax.set_xlim(0.35, 8)
    ax.set_xticks([0.5, 1, 2, 4], ['0.5', '1', '2', '4']); ax.minorticks_off()
    ax.set_yticks(range(len(keys)), [he(LABELS[k]) for k in reversed(keys)])
    ax.yaxis.tick_right(); ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.tick_params(axis='y', length=0)
    ax.set_xlabel(he('יחס סיכויים לחצייה באדום (סולם לוגריתמי; 1 = ללא השפעה)'))
    ax.grid(axis='y', visible=False)
    h1, = ax.plot([], [], marker='o', mfc=WHITE, mec=ASPHALT_LIGHT, mew=1.3, ms=6, color=ASPHALT_LIGHT, linewidth=1.2)
    h2, = ax.plot([], [], marker='D', mfc=SIGNAL_AMBER, mec=ASPHALT, mew=1.1, ms=6, color=ASPHALT, linewidth=2.2)
    ax.legend([h1, h2], [he('כפי שפורסם (עמודות יחס הסיכויים ורווח הסמך)'), he('נגזר מ-b ו-SE שפורסמו')],
              loc='upper center', bbox_to_anchor=(0.5, 1.17), ncol=2, fontsize=7.6)
    return save(fig, 'g2-odds-ratios')

if __name__ == '__main__':
    print(make())
