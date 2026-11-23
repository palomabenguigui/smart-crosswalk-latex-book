"""figstyle.py – shared matplotlib setup: bundled Noto fonts, Hebrew labels, deterministic vector PDF."""
from pathlib import Path
import matplotlib
matplotlib.use('pdf')
import matplotlib.pyplot as plt
from matplotlib import font_manager
from palette import ASPHALT, ASPHALT_LIGHT, HAIRLINE

ROOT = Path(__file__).resolve().parent.parent
for fam in ('NotoSansHebrew', 'NotoSans'):
    for f in (ROOT / 'fonts' / fam).glob('*.otf'):
        font_manager.fontManager.addfont(str(f))
plt.rcParams.update({
    'font.family': ['Noto Sans Hebrew', 'Noto Sans'],   # per-glyph fallback: Hebrew font has no digits/Latin
    'font.size': 8.5, 'axes.titlesize': 9, 'axes.labelsize': 8.5,
    'axes.edgecolor': ASPHALT_LIGHT, 'axes.labelcolor': ASPHALT, 'xtick.color': ASPHALT, 'ytick.color': ASPHALT,
    'axes.spines.top': False, 'axes.spines.right': False, 'axes.grid': True, 'grid.color': HAIRLINE,
    'grid.linewidth': 0.5, 'axes.axisbelow': True, 'pdf.fonttype': 42, 'svg.hashsalt': 'smartcross',
    'legend.frameon': False,
})
MM = 1 / 25.4
TEXT_W = 138 * MM            # text block width (PRD §6.3)

RLM = '\u200F'
def he(s: str) -> str:
    """Hebrew (or mixed) label in LOGICAL order with an RTL base direction.
    matplotlib >= 3.11 shapes and reorders Hebrew itself; python-bidi's get_display() would reverse it a
    second time (INC-002). The leading RLM makes numbers/parentheses sit on the correct side.
    Use ONE line per text object: matplotlib applies the RTL base direction only to the first line."""
    return '\n'.join(RLM + line for line in s.split('\n'))

def save(fig, name: str):
    out = ROOT / 'figures' / f'{name}.pdf'
    fig.savefig(out, metadata={'CreationDate': None, 'ModDate': None, 'Producer': 'smartcross', 'Creator': 'smartcross'},
                bbox_inches='tight', pad_inches=0.02)
    plt.close(fig)
    return out
