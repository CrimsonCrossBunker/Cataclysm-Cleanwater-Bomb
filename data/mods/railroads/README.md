# Railroads

This Mod enables surface railroads, stations, bridges, level crossings and motorized draisines.
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

## Playing

New stations have a pristine two-seat motorized draisine on one track, with its
fuel tank 70% full. The other track can contain disabled train cars. Track ends
can also spawn two-seat or six-seat draisines, each with the existing 40% chance.

Board the seat with vehicle controls, start the engine from the vehicle controls
menu, then drive using your configured controls. Curves follow the rails
automatically; choose a turn before entering a junction. Both draisines use gasoline.
Inspect the track ahead for wrecks or other obstacles, particularly at crossings.

创建世界时启用 `railroads`，城市大小应大于 0。新车站的一条轨道上必定生成无损、
无故障的双座机动轨道车，油箱有 70% 的汽油；另一条轨道可能有损坏的列车。
坐上带操纵装置的座位，在车辆控制菜单启动发动机，再按当前按键设置驾驶。
弯道会沿轨转向，道岔应提前选择转向；注意轨道上的残骸及平交道障碍物。
旧存档中已经生成的车站和轨道不会自动改造，需探索新区域或创建新世界。

## Acceptance and scope

Hidden native regression tests run with:

```sh
./tests/cata_test '[railroads]' --mods=railroads --rng-seed 3404 --order lex --drop-world
```

They cover station entrances in four rotations, both tracks and both draisines;
forward and reverse motion through curves, junctions, crossings and bridge ramps;
engine-driven motion and fuel use; actual vehicle spawning; regional generation;
and saving to disk, unloading, reloading and continuing to drive. Geometry tests
omit random wrecks to isolate the track layout. These checks do not replace manual
UI playtesting or establish that every random route is free of obstacles.

This is a foundation for rail travel. Train coupling, signals and automated dispatch
are outside its current scope. Unreachable station entrances retain a rail stub;
there is no guarantee that every terrain island has a route to the regional network.

原生回归已覆盖钢轨对齐、进出站、直行、转弯、道岔、倒车、铁路桥、平交道、
发动机与耗油、车辆和区域生成，以及磁盘保存读档后继续行驶。
目前提供基础铁路旅行，不包含列车编组、信号系统或自动调度。
地形阻隔可能使个别站口保留断头轨；随机残骸也可能需要玩家清理。
