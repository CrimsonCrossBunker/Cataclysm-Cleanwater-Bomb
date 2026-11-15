# Regional loot in North America

New loot rolls on the real North America map use the jurisdiction at the
location being generated. Saved items, classic procedural worlds and the
Massachusetts item groups retain their original IDs. The three public
regional entry points are `guns_common-XX-YY`,
`ammo_common_boxed-XX-YY` and `mags_common-XX-YY` (for example `-US-TX`,
`-CA-ON` or `-MX-CMX`). Other civilian shelf, case, carry and hunting groups
use shared profiles. Ordinary Mexican civilian shelves use a deliberately
small legal-stock approximation, including in building templates adapted
from US gun stores. Military stock has its own item groups.

Edit `north_america_loot.json` to assign a jurisdiction to a profile and
adjust regional inventory or police clothing. Regenerate the item groups
with `python tools/generate_regional_loot.py`. These inputs describe game
stock, including conservative models for restricted firearm categories,
discarded exceptions and approximate weights. They do not model municipal
rules, acquisition or use requirements, each individual handgun roster,
or legacy ownership exceptions. The apparel sets approximate duty
uniforms with existing sprites and clothing variants.

Sources consulted for the November 2026 stock snapshot:

- US: [ATF state and territory firearm laws, 36th edition](https://www.atf.gov/firearms/tools-and-services-firearms-industry/state-laws-and-published-ordinances-firearms),
  [Colorado SB25-003](https://www.leg.colorado.gov/bills/sb25-003),
  [Illinois 720 ILCS 5/24-1.10](https://www.ilga.gov/ftp/ilcs/Ch%200720/Act%200005/072000050K24-1.10.html),
  [Vermont § 4021](https://legislature.vermont.gov/statutes/section/13/085/04021),
  [Rhode Island's 2026 sales restriction](https://governor.ri.gov/press-releases/governor-mckee-signs-bill-banning-sale-assault-weapons),
  [Virginia § 18.2-309.1](https://law.lis.virginia.gov/vacodeupdates/title18.2/section18.2-309.1/)
  and [Oregon HB4145](https://olis.oregonlegislature.gov/liz/2026R1/Measures/Overview/HB4145).
  Oregon uses ordinary inventory for the snapshot before the deferred provisions.
- Canada: federal [firearm classes](https://rcmp.ca/en/firearms/classes-firearms/classes-firearms-canada)
  and [magazine categories](https://rcmp.ca/en/firearms/classes-firearms/maximum-permitted-magazine-capacity).
  Provincial measures such as [Québec's hunting and registration rules](https://www.quebec.ca/en/tourism-recreation-sport/sporting-and-outdoor-activities/sport-hunting/weapons-ammunition-gear)
  do not provide separate magazine profiles. Duty and special-unit references
  are the [RCMP shirt rollout](https://rcmp.ca/en/news/2025/09/rcmp-rolling-out-new-uniform-shirts-across-canada),
  [Emergency Response Team](https://rcmp.ca/en/bc/police-services/emergency-response-team)
  and [Royal Canadian Navy Naval Boarding Party](https://www.canada.ca/en/navy/corporate/fleet-units/specialized-units/nbp.html).
- Mexico: the federal [Ley Federal de Armas de Fuego y Explosivos](https://www.diputados.gob.mx/LeyesBiblio/pdf/LFAFE.pdf),
  especially Articles 9–11, supplies the shared civilian profile. The
  [Guardia Nacional FERI announcement](https://www.gob.mx/guardianacional/prensa/guardia-nacional-pasa-revista-de-entrada-a-la-fuerza-especial-de-reaccion-e-intervencion-feri)
  and [Secretaría de Marina](https://www.gob.mx/semar/prensa/la-secretaria-de-marina-armada-de-mexico-informa-sobre-accidente-que-sufrio-paracaidista-naval-durante-desfile-civico-militar-2019)
  supply the special-unit names.

The published jurisdiction layer is derived from public-domain [Natural
Earth 1:10m Admin 1 States and Provinces](https://www.naturalearthdata.com/downloads/10m-cultural-vectors/10m-admin-1-states-provinces/)
v5.1.2 in the same projection as the terrain atlas. Regenerate it with
`python tools/generate_north_america_jurisdictions.py ne_10m_admin_1_states_provinces.zip data/raw/north_america.jurisdictions`.
