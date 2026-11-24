# fhwa2025mutcd – FHWA, *MUTCD*, 11th edition with Revision 1 (Dec. 2025), Part 4, §4I.04–4I.05, pp. 718–719

**Read:** The Part 4 PDF of the current edition (FHWA states the 11th edition with Revision 1 is current;
the 2009 edition's §4E.07 holds the same countdown rule).

## Key provisions (own words)
- §4I.04 (p. 718): a countdown display is **required** where the pedestrian change (clearance) interval is longer than 7 s,
  and optional where it is 7 s or less.
- The countdown is shown **only during the flashing DON'T WALK (change) interval**. It may not run during the WALK interval.
  After zero it stays dark until the next change interval (pp. 718–719).
- Numbers are Portland orange on black, at least 6 in. high (9 in. when the pedestrian enters more than 100 ft from the display),
  next to the DON'T WALK hand (p. 719).
- §4I.05 (p. 719): pedestrian detectors may be push buttons or **passive detection** devices that sense a pedestrian
  waiting in a position that shows intent to cross. Some can also track the pedestrian across the road to adjust timing.

## Why it matters for the project (flag for the Leader)
- The project's core feature, **a countdown of the time left on red** (PRD §1), is **not** the countdown the US standard
  allows. The MUTCD countdown runs during clearance, not during the red wait. The book must say this openly.
  The red-wait countdown is a design choice outside the US standard (and an Israeli standard should be checked).
  This affects ch. 3 (constraints), ch. 5 (market: off-the-shelf US heads do not do this), ch. 6 and ch. 9 (regulatory risk).
- §4I.05 gives a standards basis for the curb-sensing component (ch. 3, 7).

## Added in round 2 – §4I.06 Pedestrian Intervals and Signal Phases (pp. 722–724)
- Pedestrian clearance should allow a walking speed of **3.5 ft/s** (about 1.07 m/s) to the far side or a median wide enough to wait on.
  Up to 4 ft/s may be used where an extended push-button press gives slower people more time, and **passive detection may adjust clearance
  time automatically** to the actual walking speed (para 08, p. 723).
- Slower walkers or wheelchair users who use the crossing routinely call for a speed below 3.5 ft/s (para 10).
- **WALK should be at least 7 s**, and **4 s** is allowed where volumes and users permit (paras 11–12, p. 724).
- After the flashing DON'T WALK, a steady DON'T WALK **buffer of at least 2 s** comes before conflicting traffic is released.
  Change plus buffer must be at least the computed clearance time (para 04, p. 722).
- **Use (ch. 3):** these are the hard floors that the adaptive-red controller may never cut. It may shorten only the *red wait*
  (the vehicle green), never WALK, clearance or buffer. Pair with `fhwa2008stm` for vehicle minimum green.
