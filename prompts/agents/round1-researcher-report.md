# Round 1 – Researcher report

**Agent:** Researcher (parallel agent, CLAUDE.md rule 1a). **Date:** 2026-11-24.
**Files written:** `references/refs.bib` (15 entries appended), `references/VERIFICATION.md` (15 rows appended),
`references/notes/*.md` (15 notes). Nothing else was edited, committed or pushed.

## Result vs AC-09 / AC-22
| Measure | Target | Now |
|---|---|---|
| Entries in `refs.bib` | ≥ 12 | **16** (1 existing + 15 new) |
| Peer-reviewed | ≥ 8 | **11** (10 journal articles + 1 IEEE conference paper) |
| Entries with a verification row | 100% | **16/16** |

## Method
- **Journal articles:** each DOI was resolved through `https://doi.org/<doi>` with CSL-JSON content negotiation (Crossref).
  Title, authors, year, venue, volume/issue and pages were compared with the bib entry.
  Abstracts came from OpenAlex or PubMed where available.
- **Books:** Open Library edition records, looked up by ISBN.
- **Official sources:** opened the WHO and FHWA pages and PDFs directly. The WHO Israel numbers were checked
  against a **rendered image** of the page (INC-000 rule).
- Candidates were found through the Crossref search API, not from memory. Every bib field comes from an opened record.

## Entries
| Key | Type | Theme | Peer-rev. | DOI / URL |
|---|---|---|---|---|
| `rosenbloom2009` | article | flagship | y | 10.1016/j.trf.2009.05.002 (verified earlier) |
| `keegan2003` | article | 1 countdown | y | 10.1016/S0965-8564(03)00061-2 |
| `eccles2004` | article | 1 countdown | y | 10.3141/1878-05 |
| `lipovac2013` | article | 1 countdown | y | 10.1016/j.trf.2013.07.002 |
| `fu2016` | article | 1 countdown (+ alone vs. with companions) | y | 10.1016/j.aap.2016.05.017 |
| `lefkowitz1955` | article | 2 social influence (imitation) | y | 10.1037/h0042000 |
| `zhou2009` | article | 2 social influence (conformity) | y | 10.1016/j.aap.2009.01.007 |
| `faria2010` | article | 2 social influence (following) | y | 10.1093/beheco/arq141 |
| `brosseau2013` | article | 2/3 waiting time and violations | y | 10.1016/j.trf.2013.09.010 |
| `hughes2000` | article | 3 curb detection (field) | y | 10.3141/1705-06 |
| `wickramasinghe2020` | inproceedings | 3 curb detection (camera, waiting time) | y | 10.1109/ICTer51097.2020.9325479 |
| `hirschi1969` | book | 4 theory: social control | n | ISBN 0520019016 (openlibrary.org/isbn/0520019016) |
| `bandura1977` | book | 4 theory: social learning | n | ISBN 0138167516 (openlibrary.org/isbn/0138167516) |
| `who2023` | book (WHO report) | 5 global statistics | n | https://www.who.int/publications/i/item/9789240086517 |
| `who2023israel` | online (WHO country profile) | 5 Israeli statistics | n | https://cdn.who.int/media/docs/default-source/country-profiles/road-safety/road-safety-2023-isr.pdf |
| `fhwa2025mutcd` | manual (standard) | 5 countdown and detector standard | n | https://mutcd.fhwa.dot.gov/kno_11th_Editionr1.htm (Part 4 PDF, §4I.04–4I.05, pp. 718–719) |

## Read depth – what the Writer may cite
| Depth | Keys | Rule for the Writer |
|---|---|---|
| Abstract read | eccles2004, fu2016, lefkowitz1955, zhou2009, faria2010, hughes2000, wickramasinghe2020 | Cite the findings listed in the note |
| Full document read | who2023israel, fhwa2025mutcd (relevant sections) | Cite with page numbers |
| Landing page only | who2023 | Only the landing-page facts in the note |
| **Metadata only** (abstract paywalled: ScienceDirect 403) | keegan2003, lipovac2013, brosseau2013 | Cite only at **title level**. The notes give a Semantic Scholar TLDR for keegan/lipovac, marked **unconfirmed**. Get the full text from the library before quoting any number |
| Edition record + use in flagship | hirschi1969, bandura1977 | Cite as the theory origin, as `rosenbloom2009` does (p. 390, 392–393) |

## Tried and dropped (or not used)
| Candidate | Why |
|---|---|
| Israel CBS road-accident pages (cbs.gov.il, he/en) | Connection timeout or "page not found". Could not be opened, so dropped |
| Israel National Road Safety Authority (gov.il) | HTTP 403. Dropped. Replaced by `who2023israel`, whose data are cleared by the Israeli national focal point |
| ITF/OECD *Road Safety Annual Report 2023*, Israel profile (10.1787/8654c572-en; itf-oecd.org PDF) | Crossref record found, but the landing page and PDF return 403, so the Israel content could not be checked. Dropped |
| WHO GSRRS 2023 full PDF (iris.who.int bitstream) | Returned an HTML stub, not the PDF. Landing page used instead (`who2023`) |
| MUTCD 2009 edition, §4E.07 (opened, HTML) | Superseded. FHWA marks the 11th edition with Revision 1 (Dec. 2025) as current, so that edition was cited instead |
| Schattler et al. 2007, TRR 2002 (10.3141/2002-13); Washburn et al. 2006 (Emerald chapter); Arhin & Noel 2007 (IEEE ITSC) | Found on Crossref; not needed for the count. Available for round 2 |
| Dollár et al. 2012, IEEE TPAMI 34(4) (10.1109/TPAMI.2011.155); Bhuvaneshwar & Mirchandani 2004 (IEEE ITSC) | Found on Crossref; generic vision surveys, not needed. Available for round 2 |
| Bandura 1969/1986; Hirschi 2004; Hirschi & Gottfredson 1994 (cited by flagship) | Not searched. One original per theory was enough |

## Findings the Leader should know (affect the book's argument)
1. **Standards conflict (important).** MUTCD §4I.04 (pp. 718–719) allows the countdown **only during the flashing DON'T WALK
   clearance interval** and never during WALK. The project's core feature, *time left on red* (PRD §1), is therefore
   **not** a standard US countdown. Chapters 3, 5, 6 and 9 should present it as a deliberate non-standard design with a regulatory risk.
   The Israeli standard was not checked (no Israeli source could be opened).
2. **Mixed evidence on countdowns.** `fu2016` found that a countdown during red **increased** early starts and running among children,
   and recommends blanking the last seconds. `eccles2004` found no harm (clearance countdown).
   `lipovac2013` reportedly found fewer violators (TLDR, unconfirmed). This suits a critical literature matrix (ch. 4)
   and gives a design rule plus a risk (ch. 7, 9).
3. **Imitation vs. restraint.** `lefkowitz1955` and `faria2010` show that pedestrians copy someone who crosses. `rosenbloom2009` (p. 393) did **not**
   find this; the waiting group restrained them. A good critical point for ch. 4, also linked to the first-mover idea in ch. 7.
4. **Curb sensing works in the field.** `hughes2000` reports fewer starts on DON'T WALK and fewer conflicts with passive detectors.
   MUTCD §4I.05 explicitly allows passive detection. `wickramasinghe2020` shows that camera-based counting and waiting-time
   estimation is feasible but only moderately accurate.
5. **Israeli statistic for ch. 1/2:** WHO profile, 364 reported road deaths in 2021, of which pedestrians ≈ 27% (order per
   footnote 1, checked on the rendered page). The ≈ 98 pedestrian deaths figure is **our derivation** and must be labelled as such.

## Source → chapter map (PRD §4)
| Chapter | Sources |
|---|---|
| 1 Introduction and background | who2023, who2023israel, rosenbloom2009 |
| 2 Problem, question, goals | who2023israel, rosenbloom2009, brosseau2013 (waiting time, title level) |
| 3 Requirements | fhwa2025mutcd (countdown and detector rules), hughes2000 (detection accuracy) |
| 4 Literature review | Theory: hirschi1969, bandura1977. Countdown: keegan2003, eccles2004, lipovac2013, fu2016. Social: lefkowitz1955, zhou2009, faria2010, brosseau2013. Sensing: hughes2000, wickramasinghe2020 |
| 5 Market and products | fhwa2025mutcd (standard countdown heads), hughes2000 (infrared/microwave detectors), wickramasinghe2020 (camera) |
| 6 Alternatives and decision matrix | eccles2004, fu2016, lipovac2013, hughes2000, wickramasinghe2020 |
| 7 Architecture and innovation | hughes2000, fhwa2025mutcd §4I.05, wickramasinghe2020 (privacy of cameras), fu2016 (blank the last seconds), zhou2009 and lefkowitz1955 (campaign layer) |
| 8 Work plan | none |
| 9 Risks | fhwa2025mutcd (regulatory), fu2016 (early starts), hughes2000 and wickramasinghe2020 (false or missed detection) |
| 10 Summary | none new |

## Open actions
- Full text of keegan2003, lipovac2013, brosseau2013 via the library, to lift them from title-level citation.
- An Israeli official source (CBS or National Road Safety Authority) and the Israeli traffic-signal standard, via a browser
  (both blocked automated access).
- `biber --tool --validate-datamodel`: the only remaining warnings are `publisher` on `@article`. That matches the existing
  `rosenbloom2009` convention and is harmless; the Leader may strip the field if wanted.
