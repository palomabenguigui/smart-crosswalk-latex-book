"""G3 – relative odds of crossing on red vs number of people already waiting (OR^k), printed vs derived OR.
The paper reports neither the intercept nor the range of 'people waiting', so: no absolute probabilities, and the curve
is drawn solid only for 0–3 people and dashed (illustrative extrapolation) for 4–5 (QA-02). Numeric axis LTR (QA-04)."""
import json, math
from figstyle import plt, he, save, TEXT_W, MM, ROOT
from palette import ASPHALT, ASPHALT_LIGHT, SIGNAL_AMBER, SIGNAL_AMBER_DARK, WHITE

def make():
    rec = json.loads((ROOT / 'data/recomputed.json').read_text(encoding='utf-8'))['table2']['waiting']
    b, se, printed = rec['b'], rec['se'], float(rec['exp_b_printed'])
    ks = [x / 10 for x in range(0, 51)]; K = list(range(0, 6))
    fig, ax = plt.subplots(figsize=(TEXT_W, 54 * MM))
    ax.fill_between(ks, [math.exp((b - 1.96 * se) * k) for k in ks], [math.exp((b + 1.96 * se) * k) for k in ks],
                    color=SIGNAL_AMBER, alpha=0.45, linewidth=0.8, edgecolor=SIGNAL_AMBER_DARK, hatch='....',
                    label=he('רווח סמך 95% (נגזר מ-b ו-SE)'))
    for seg, style in ((range(0, 4), '-'), (range(3, 6), (0, (2, 2)))):
        ax.plot(list(seg), [math.exp(b * k) for k in seg], color=ASPHALT, linewidth=2, linestyle=style, marker='D', ms=4,
                label=he(f'נגזר מ-b: {math.exp(b):.2f} לכל ממתין') if style == '-' else None)
        ax.plot(list(seg), [printed ** k for k in seg], color=ASPHALT_LIGHT, linewidth=1.3, linestyle=(0, (5, 3)),
                marker='o', ms=4, mfc=WHITE, label=he(f'לפי הערך שפורסם: {printed:.2f} לכל ממתין') if style == '-' else None)
    ax.axvspan(3.5, 5.2, color=ASPHALT_LIGHT, alpha=0.08, linewidth=0)
    ax.text(4.35, 0.93, he('המחשה בלבד:'), ha='center', va='top', fontsize=7, color=ASPHALT_LIGHT)
    ax.text(4.35, 0.85, he('טווח הממתינים לא דווח'), ha='center', va='top', fontsize=7, color=ASPHALT_LIGHT)
    ax.set_xlabel(he('מספר האנשים שכבר ממתינים על המדרכה בעת ההגעה'))
    ax.set_ylabel(he('סיכויי חצייה יחסיים (מגיע יחיד = 1)'))
    ax.set_ylim(0, 1.05); ax.set_xlim(-0.2, 5.2); ax.set_xticks(K)
    ax.yaxis.tick_right(); ax.yaxis.set_label_position('right')
    ax.spines['left'].set_visible(False); ax.spines['right'].set_visible(True)
    ax.legend(loc='lower center', fontsize=7.4, bbox_to_anchor=(0.5, 1.0), ncol=2)
    return save(fig, 'g3-relative-odds')

if __name__ == '__main__':
    print(make())
