# Regional seasons and snow

The climate station data drives two annual cycles wherever a world has a
regional climate. Station normals are interpolated into daily temperatures and
scaled to the world's configured calendar year. The air season uses a trailing
five-day mean and thresholds of 10 °C and 22 °C, adapted from the
[China Meteorological Administration's climate season standard](https://www.cma.gov.cn/zfxxgk/gknr/flfgbz/bz/202209/P020220921552240920203.pdf).
Between the thresholds, the interval from the coldest to the warmest time
of year is spring and the return interval is autumn. A location can skip a
season if its climate never meets the temperature threshold. This does not
change the saved calendar, month lengths, or the length of a configured year.

Vegetation sprites use a separate generic canopy model. Growing-degree days
above 5 °C drive budburst and full leaf. Cooling-degree days below 13 °C after
the warmest part of the year drive colour change and dormancy, with sustained
freezing marking dormancy as well. The four tile variants represent budding,
full leaf, colour change, and dormancy. Places with a minimum smoothed mean of
at least 16 °C keep the full-leaf variant. These are gameplay parameters for a
generic canopy. Individual species and weather events do not shift the dates.
The approach draws on the [USA National Phenology Network's spring indices](https://nps.usanpn.org/data/new_data_products)
and [research on temperature and vegetation phenology](https://harvardforest1.fas.harvard.edu/publications/pdfs/Seyednasrollah_GRL_2020.pdf).

The game tracks ground snow depth and liquid water equivalent in 768 m
weather cells. Cold precipitation adds fresh snow, warmer temperatures and
rain melt it, and dry windy air removes water by sublimation. The pack
settles toward denser snow and is capped at 80 cm. The approach is a
temperature-index approximation based on the
[USACE snowmelt model](https://www.hec.usace.army.mil/confluence/hmsdocs/hmstrm/snow-accumulation-and-melt/temperature-index-method),
[USACE snowpack properties](https://www.hec.usace.army.mil/confluence/hmsdocs/hmstrm/snow-accumulation-and-melt/snow-properties)
and [NOAA's operational snow model](https://www.weather.gov/media/owp/oh/hrl/docs/22snow17.pdf).
Weather history seeds previously untracked cells and catches up idle cells
for up to 28 game days. Saves with only a depth estimate water equivalent
from that depth. Medium snow starts at 25 cm and deep snow at 50 cm. These
two levels slow grounded creatures on exposed terrain.
