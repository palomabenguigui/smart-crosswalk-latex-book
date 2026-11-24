# Round 2 – Researcher report

**Agent:** Researcher (parallel agent, CLAUDE.md rule 1a). **Date:** 2026-11-24.
**Files written:**
- `data/rosenbloom2009_text_stats.csv` (new)
- `references/refs.bib`: 13 entries appended; the `note` of `fhwa2025mutcd` extended to §4I.06
- `references/VERIFICATION.md`: 14 rows (13 new plus a re-check of `fhwa2025mutcd`)
- `references/notes/*.md`: 13 new notes; `fhwa2025mutcd.md` extended

No other file was touched. Nothing was committed or pushed.

**Bibliography now:** 29 entries, **19 peer-reviewed**, 29/29 with a verification row. `biber --validate-datamodel` is clean
apart from the known `publisher` on `@article` warnings.

---

## Task A – Inventory of statistics printed in the flagship text (INC-003)

`data/rosenbloom2009_text_stats.csv` has **30 rows**. Every printed value was checked against the **rendered** pages
(pp. 389, 390, 391, 393, render scale 2.5). Recomputation uses Table 1/2 as transcribed and `data/recomputed.json`.
Values marked `*` in the CSV are new arithmetic, shown in the `note` column.

| Result | n | Statistics |
|---|---:|---|
| reproducible | 11 | N = 1392; gender counts and %; age 40–60 and 60+ %; 563 (40.4%); 76 (5.5%); 13.5%; gender χ² = 17.17; Table 2 significance stars; green-phase SD |
| **not reproducible** | 6 | age 94.3% (= D5); age χ² 1.02 (= D7); traffic Wald 6.06 not significant in the text (= D2); **traffic volume 456 veh/h**, **vehicles per red 15.6 (max 53)** and **pedestrian volume 166/h** (new, below) |
| not checkable | 13 | external statistics (Israeli CBS/NRSA, FHWA 2004), design facts, Hosmer–Lemeshow p = 0.65 (needs raw data), and the "no gender × group interaction" claim (no test statistic printed) |

### Candidate data issues D8+ (for the Leader; the PRD was not edited)
- **D8 – the traffic numbers in §2.2 contradict each other (p. 390).**
  - The cycle is 52.7 + 56.6 = 109.3 s, so there are about 32.9 cycles per hour.
  - At 15.6 vehicles per pedestrian red, that gives about **514 veh/h**. The paper prints **456 veh/h**, and 456/h would mean about 13.8 per red.
  - The maximum of 53 vehicles in one red is 8.7 SD above the mean (SD 4.32). On two lanes that is about 1,810 veh/h/lane, close to
    saturation flow, so it is a possible outlier or typo.
  - Consequence: the traffic-volume variable in Table 2 already has the D2 problem, and its descriptive basis is also inconsistent.
- **D9 – the pedestrian volume does not match the sample (p. 390).**
  - 1,392 valid observations over eight 1-hour sessions is **174 per hour**, not 166 (166 × 8 = 1,328).
  - Possible explanations, none stated in the paper: volume counted separately, sessions of unequal length, or exclusions.
- **D10 (low priority, interpretive) – fewer red arrivals than expected (p. 391).**
  - Red is 48.2% of the cycle, but only 40.4% of pedestrians "arrived on red". Uniform arrivals would give about 671, not 563 (z ≈ −5.8).
  - That is not an arithmetic error. It suggests platooned arrivals or an unstated definition of "arrived on red".
  - It matters for ch. 7: arrivals are not uniform, so the sensing layer should measure them, not assume them.
- **Minor (not proposed as a D-issue):**
  - The red-phase SD of 0.37 is too small for a mean of 52.7 if every red lasted exactly 52 or 53 s (that would require about 0.46).
    This is plausible only if durations were timed to fractions of a second.
  - The paper says no gender × group interaction was found but gives no test statistic, and the term is not in Table 2.

---

## Task B – Decision brief: evidence per component of the final concept

Read depth: **F** = full text read, **A** = abstract only, **M** = metadata/title only, **S** = standard or spec read in the relevant sections.

### 1. Adaptive red (core): sensing shortens the pedestrian red, prioritising a lone pedestrian
| Claim | Evidence (key, depth) | Strength |
|---|---|---|
| A longer wait or red raises red-light crossing | `vanhouten2007` (A): **minimum green manipulated from 30 to 120 s, compliance fell as it grew**, the only quasi-experiment. `zhu2021` (F): red time β = +0.061/s (≈ +6% odds per s, our derivation), time-to-green β = +0.072/s, n = 6,320. `guo2011` (A): hazard of violating rises with the wait, about half still obey at 50 s. `shah2024` (A): wait if remaining red < 50 s, cross almost at once if > 100 s. `xing2022` (F): longer red, more violations across 16 sites. `brosseau2013` (M) | **Strong and consistent** across 6 studies and 5 countries. Mostly observational, with one manipulated-timing study |
| A lone pedestrian is the high-risk case | `rosenbloom2009` (F); `zhu2021` (F): companion OR 0.579, each extra pedestrian OR 0.685; `fu2016` (A): children alone violated more; `shah2024` (A) | **Strong.** `zhu2021` replicates the flagship with 4.5× the sample |
| Violations cluster early in the wait | `xing2022` (F): survival drops fastest in the first 10 s; `shah2024` (A): about 35% cross at once | Moderate. Design implication: act early (on arrival), not just cap the maximum wait |
| Detector-driven signal operation is established and safe | `hughes2000` (A): passive curb detection reduced DON'T WALK starts and conflicts; `lenne2007` (A): detector-based "Dwell-on-Red" cut vehicle speeds by 9–28%; `fhwa2025mutcd` §4I.05–4I.06 (S): passive detection is allowed and may adjust clearance time; `tfl2015kerbside` (S); `trl2006ppr087` (F) | Strong for *feasibility*. **No study found that tests "shorten red for a detected lone pedestrian" directly.** That gap is the project's novelty and must be stated in the book |
| **Safe limits** (ch. 3) | `fhwa2025mutcd` §4I.06 (S): walking speed 3.5 ft/s, WALK ≥ 7 s (4 s allowed), buffer ≥ 2 s; `fhwa2008stm` (S): vehicle minimum green for driver expectancy 7–15 s on major arterials, 4–10 s on minor arterials, 2–10 s on local streets | US standard and guideline. **The Israeli standard is still not checked** |

### 2. Clearance-only countdown (MUTCD §4I.04)
| Claim | Evidence | Strength |
|---|---|---|
| The standard requires and defines it | `fhwa2025mutcd` §4I.04 (S) | Normative |
| It is understood and not harmful | `eccles2004` (A): fewer conflicts at 4 sites, pedestrians understood it | Moderate (US, before/after) |
| Off-the-shelf hardware exists | `current2023gtx` (F, specs checked on the render): 9-in digits, 8 W countdown, NEMA TS-2, conflict monitor | Product verified |

### 3. Social-control campaign
| Claim | Evidence | Strength |
|---|---|---|
| Others' behaviour shapes crossing | `lefkowitz1955` (A), `faria2010` (A), `zhou2009` (A), `zhu2021` (F): another violator in the same cycle OR 4.0, `pele2019` (A) | Strong that imitation exists |
| Framing: present waiting as the norm | `rosenbloom2009` §4.5 (F), `zhou2009` (A): tell people that crossing with a group is still unsafe and illegal, `hirschi1969` and `bandura1977` (theory) | Theory plus survey |
| **A campaign changes behaviour** | **No evaluation study found in this round** (not searched specifically) | **Gap.** Recommend a round-3 search for evaluated pedestrian-compliance campaigns, or present the campaign as the lowest-evidence component |

### 4. Rejected Alternative 1 – red-phase countdown
| Direction | Evidence |
|---|---|
| **For A1** (be fair) | `lipovac2013jte` (A): fewer violators with a countdown, especially women, over-40s and slow walkers; `lipovac2013` (M, TLDR only) |
| **Against A1** | `fhwa2025mutcd` §4I.04 (S): a countdown during red is not allowed; `fu2016` (A): a red-phase countdown **increased** children's violations and running; `xing2022` (F): having a red countdown was **not** related to violation rate across 16 sites; `shah2024` (A): pedestrians decide by the *remaining* red, so showing a long remaining red may trigger crossing (our inference) |
| **Verdict for ch. 6** | The evidence is **mixed**, and A1 conflicts with the standard. A2 acts on the cause (long and lone waits) and keeps a standard-compliant countdown. The decision matrix should score A1 lower on "regulatory compliance" and "evidence robustness", not claim it fails outright |

---

## Task C – Sources for chapters 2, 3 and 5
- **ch. 2 (open-access numbers on waiting):**
  - `zhu2021`: accepted manuscript, full text. Odds ratios plus 18.5% violation among 6,320.
  - `xing2022`: open access, full text. 881 of about 4,590.
  - `shah2024`: open access, abstract numbers only. 50 s and 100 s thresholds, 35% immediate.
- **ch. 3 (requirements):**
  - `tfl2015kerbside`: detect within 500 ms, ≥ 10 lux, zone 2.4–10 m × 1–5 m, mounting 3–4.5 m, fault modes.
  - `fhwa2025mutcd` §4I.04–4I.06 and `fhwa2008stm` Table 5-3 for timing floors.
  - `current2023gtx` for display specs.
- **ch. 5 (products, technical comparison):**
  - Countdown head: `current2023gtx` (Current/GE GTX City PS7-CFF1-VLA).
  - Kerbside detector: `agd2024agd645` (AGD645, stereo vision, 10 × 3 m, 8 W).
  - Technology classes: `trl2006ppr087` (infrared, microwave, video, mats, radar: advantages and drawbacks) and `hughes2000` (field results).

---

## New entries (13)
| Key | Type | Theme | Peer-rev. | Read depth | DOI / URL |
|---|---|---|---|---|---|
| `zhu2021` | article | B1 wait/red; social | y | **Full** (accepted manuscript; manuscript pages) | 10.1016/j.trf.2020.11.001 |
| `xing2022` | article | B1; B4 | y | **Full** (PMC) | 10.3390/ijerph192114420 |
| `shah2024` | article | B1 | y | Abstract (OA, but site blocked) | 10.1016/j.trip.2024.101035 |
| `guo2011` | article | B1 | y | Abstract | 10.1080/15389588.2010.518652 |
| `vanhouten2007` | article | B1/B2 (manipulated minimum green) | y | Abstract | 10.3141/2002-10 |
| `pele2019` | article | B1; social (first mover) | y | Abstract + preprint skim | 10.3390/safety5040079 |
| `lenne2007` | article | B2 detector-based phasing | y | Abstract | 10.1016/j.aap.2006.11.006 |
| `lipovac2013jte` | article | B4 (for A1) | y | Abstract | 10.1061/(ASCE)TE.1943-5436.0000491 |
| `trl2006ppr087` | report | B2/C detector technologies | n (grey) | **Full** | https://www.trl.co.uk/Uploads/TRL/Documents/PPR087.pdf |
| `fhwa2008stm` | manual | B3 safe limits | n (guideline) | Ch. 5 | https://ops.fhwa.dot.gov/publications/fhwahop08024/chapter5.htm |
| `tfl2015kerbside` | manual (spec) | C ch. 3/5 | n | **Full** | https://foi.tfl.gov.uk/FOI-1297-2021/Kerbside%20Detector%20Requirement%20Specification%20v1.0%20-%20final.pdf |
| `agd2024agd645` | manual (datasheet) | C ch. 5 detector | n | **Full**, rendered | https://agd-systems.com/content/uploads/2024/12/AGD645DS-ISS1.pdf |
| `current2023gtx` | manual (datasheet) | C ch. 5 countdown head | n | **Full**, rendered | https://images.salsify.com/images/ibnta6ijl8mkup3q5yfb/TRAF289-GTX-City-PS7-CFF1-VLA-Pedestrian-Signal-Spec-Sheet.pdf |

Also: `fhwa2025mutcd` was re-checked and extended to §4I.06 (pp. 722–724).

## Tried and dropped
| Candidate | Why |
|---|---|
| Marić et al. 2021, *Transp. Res. Procedia* 55, 1720–1728 (10.1016/j.trpro.2021.07.164) | Metadata ✓ and it is a red-countdown study, but the abstract gives **no results** and the OA PDF on ScienceDirect returns 403. Nothing citable beyond the title. Candidate for library retrieval |
| Signal Timing Manual, 2nd ed. (NCHRP 812, 10.17226/22097) | Crossref metadata ✓, but nap.edu returns 403. The 1st edition (2008) was cited instead, and its superseded status is recorded |
| Lin, Cheng & Chang (TRB 2022 paper, attap.umd.edu) | Conference preprint; peer-reviewed publication not confirmed |
| Leotek 16-inch pedestrian module spec sheets (leotek.com, old.leotek.com) | One URL returned HTML instead of the PDF, the other failed |
| VicRoads TCS 027 Puffin walk-detector specification | Returned an HTML stub |
| TST iCross sheet (trafficltd.com.au) | Opened, but it is a **rebadged AGD645** (same type-approval reference and patent), so it is redundant. Mentioned in the `agd2024agd645` note |
| AGD645 brochure 2018 (third-party blob host) | Superseded by the manufacturer's 2024 data sheet. Its specs differ (temperature range, output) |
| Hamed 2001 (*Safety Science* 38, 63–82); Tiwari et al. 2007 (TR-F 10, 77–89) | Found and verified on Crossref but not needed. Available for round 3 (Hamed is cited by the flagship) |
| Chen, Xing & Cao 2017 (CIVEJ) | Found only on SlideShare; original not opened |
| Israeli signal-timing standard | Still not found (gov.il blocks automated access). **Open action for a human with a browser** |

## Source → chapter map (round-2 additions)
| Chapter | Sources |
|---|---|
| 1 Introduction (pivot story) | `vanhouten2007`, `zhu2021` (the wait is the lever), `fu2016`, `fhwa2025mutcd` |
| 2 Problem in numbers | `zhu2021`, `xing2022`, `shah2024`, `guo2011`; flagship D8–D10 if accepted |
| 3 Requirements | `fhwa2025mutcd` §4I.04–4I.06, `fhwa2008stm`, `tfl2015kerbside`, `current2023gtx`, `agd2024agd645` |
| 4 Literature | waiting theme: `vanhouten2007`, `zhu2021`, `guo2011`, `shah2024`, `xing2022`; social: `zhu2021`, `pele2019`; countdown: `lipovac2013jte`, `xing2022`; inventory → cautionbox (D8–D10 candidates) |
| 5 Market and products | `current2023gtx`, `agd2024agd645`, `trl2006ppr087`, `tfl2015kerbside` |
| 6 Alternatives | A1: `lipovac2013jte` vs `fu2016`/`xing2022`/`fhwa2025mutcd`; A2: `vanhouten2007`, `zhu2021`, `hughes2000`, `lenne2007`; A3: campaign sources (evidence gap) |
| 7 Architecture | `tfl2015kerbside` (zones, latency), `agd2024agd645` (edge processing, privacy), `xing2022` (act early in the wait), `fhwa2025mutcd` §4I.06 para 08 |
| 9 Risks | `fhwa2008stm` (minimum green, rear-end risk), `current2023gtx` and MUTCD §4I.04 para 09 (countdown timing integration), `trl2006ppr087` (detection errors) |

## Open actions
1. The Leader decides whether D8–D10 enter PRD §9.
2. Full texts via the library: `vanhouten2007` (the key causal study), `lipovac2013jte` (was the display during red?), `shah2024`, and Marić 2021.
3. The Israeli signal-timing standard and Israeli countdown practice (browser needed).
4. Campaign-effect evaluations (gap for component 3).
5. Manuscript vs journal pages for `zhu2021`: cite sections or label the pages as manuscript pages.
