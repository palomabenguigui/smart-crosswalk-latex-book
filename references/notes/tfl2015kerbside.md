# tfl2015kerbside – Transport for London (2015), *Kerbside Pedestrian Detector … Requirement Specification* v1.0

**Read:** Full text (11 pp., released under FOI-1297-2021). The cover says "Version 0.1", but the history table and footers say v1.0 final, 3 Sept. 2015.

## Requirements (own words, §4, pp. 8–10)
- The detector must sense people **waiting** in the kerbside wait-to-cross area, stationary or moving. It is used to **cancel a demand**
  when the waiting pedestrian has gone ("call cancel").
- It must work down to **10 lux** and at night, must not detect vehicles, and must reject shadows.
- Zone: width X between **2.4 and 10 m**, depth Y between **1 and 5 m**. Must-detect, may-detect and must-not-detect zones are configurable.
- **Detect within 500 ms** of a pedestrian entering the zone. Voltage-free output. Defined fault modes: output goes to high impedance
  within 3 s, and normal operation resumes within 5 s after power returns.
- Mounting: on a signal pole at **3.0–4.5 m**. Multiple units where the zone is wider than 4.5 m.

## Use
ch. 3: a ready-made, verifiable template for the sensing requirements (REQ IDs with targets: lux, latency, zone, fault behaviour).
ch. 5: shows that kerbside presence detection is an established, procured product class.
