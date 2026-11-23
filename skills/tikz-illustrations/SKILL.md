---
name: tikz-illustrations
description: Production agent that draws diagrams in TikZ (crosswalk scene, system architecture, WBS tree, social-control loop) as figures/tikz/<name>.tex, built in LTR with Hebrew node text set RTL via the 'rtl' style, using only the colour tokens and pictograms of smartcross.cls.
---
# TikZ-illustrations (production agent)

## Rules
- One file per diagram: `figures/tikz/<name>.tex` containing only `\begin{tikzpicture} … \end{tikzpicture}`; the chapter includes it inside a `figure` with `\begin{ltrblock}\input{figures/tikz/<name>}\end{ltrblock}`.
- TikZ coordinates are LTR. **Every node with Hebrew text gets the `rtl` style** (DS-01); English/numbers via `\en`, `\num`.
- Colours: only the `.cls` tokens (`Asphalt`, `SignalRed`, `SignalAmber`, `SignalGreen`, `StripeWhite`, …). Pictograms via `\picto[colour]{name}`.
- Width ≤ `\linewidth` (138 mm); labels ≥ 7 pt; nothing touches the page edge.
- No raster images, no copied diagrams: draw from the PRD/architecture description.
- After changes: build, then `qa.py img` + render the page and check visually (qa-BiDi checklist).
