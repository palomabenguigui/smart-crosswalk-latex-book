"""G3 – relative odds of crossing on red vs number of people already waiting (OR^k), printed vs recomputed OR.
The paper reports no intercept, so absolute probabilities cannot be drawn (PRD §3.7, D6)."""
import json, math
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, SIGNAL_AMBER

def make():
    rec = json.loads((ROOT / 'data/recomputed.json').read_text(encoding='utf-8'))['table2']['waiting']
    b, se, printed = rec['b'], rec['se'], float(rec['exp_b_printed'])
    ks = list(range(0, 9))
    fig, ax = plt.subplots(figsize=(TEXT_W, 60 * MM))
    lo = [math.exp((b - 1.96 * se) * k) for k in ks]; hi = [math.exp((b + 1.96 * se) * k) for k in ks]
    ax.fill_between(ks, lo, hi, color=SIGNAL_AMBER, alpha=0.25, linewidth=0, label=he('רווח סמך 95% (מחושב)'))
    ax.plot(ks, [math.exp(b * k) for k in ks], color=ASPHALT, linewidth=2, marker='D', ms=4,
            label=he(f'מחושב מחדש: יחס סיכויים {math.exp(b):.2f} לכל ממתין'))
    ax.plot(ks, [printed ** k for k in ks], color=ASPHALT_LIGHT, linewidth=1.3, linestyle=(0, (4, 3)), marker='o',
            ms=4, mfc='white', label=he(f'לפי הערך שפורסם: {printed:.2f} לכל ממתין'))
    ax.set_xlabel(he('מספר האנשים שכבר ממתינים על המדרכה בעת ההגעה'))
    ax.set_ylabel(he('סיכויי חצייה יחסיים (מגיע יחיד = 1)'))
    ax.set_ylim(0, 1.05); ax.set_xlim(-0.2, 8.2); ax.set_xticks(ks)
    ax.invert_xaxis()                      # RTL reading direction
    ax.yaxis.tick_right(); ax.yaxis.set_label_position('right')
    ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.legend(loc='upper right', fontsize=7.6, bbox_to_anchor=(0.62, 1.0))
    return save(fig, 'g3-relative-odds')

if __name__ == '__main__':
    print(make())
