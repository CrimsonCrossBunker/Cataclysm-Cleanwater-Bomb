# Railroads

This development Mod enables surface railroads, stations, bridges and level crossings.
Enable `railroads` when creating a world; the regional railway generator requires a
nonzero city size. Changes to generation affect new terrain, not stations already saved.

## Station connections

Both `Railway Station` and `railroad_station_city` declare railway entrances outside
the station footprint. Fixed `city_building` definitions accept the same `connections`
entries as fixed `overmap_special` definitions, including `point`, `terrain`,
`connection` and `from`. The `from` tile identifies the station side of an entrance.

An entrance using the region's `rail_connection` joins reachable existing rails.
Entrances placed before the regional network are included when it is generated.
If no route is reachable, a rail stub is retained; it does not imply a connected
network. Road connections retain their city or fallback target.

Station terrain excludes `GENERIC_LOOT`, preventing railway routes from replacing
the station footprint with ordinary tracks.

## Development status

The Mod remains intended for development. Overmap connection tests do not establish
continuous wheel alignment at station borders, safe driving through curves or
station-to-station travel. Station track alignment and interactive driving acceptance
are still required before treating it as ready for regular gameplay.

目前仍为开发用 Mod。车站联网只改变新生成的地形；旧存档中已生成的车站不会自动改造。
大地图线路接通不等于轨道车已能顺畅进出站，站口钢轨对齐和驾驶验收仍需完成。
