#!/usr/bin/env python3
"""make_figures.py – regenerates every Python figure (called by scripts/build.sh; checked by qa-code)."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import recompute_table2  # noqa: F401  (writes data/recomputed.json first)
import fig_crossing_by_gender, fig_odds_ratios, fig_relative_odds, fig_risk_heatmap, make_plan_figures

for mod in (fig_crossing_by_gender, fig_odds_ratios, fig_relative_odds, fig_risk_heatmap, make_plan_figures):
    print('[figures]', mod.make())
