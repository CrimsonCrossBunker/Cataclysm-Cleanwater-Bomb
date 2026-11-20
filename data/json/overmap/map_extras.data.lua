local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_crater",
    name = ccb.content.text("Crater"),
    description = ccb.content.text("There is a crater here."),
    generator = { method = "update_mapgen", id = "mx_crater" },
    z_levels = { 0, 0 },
    symbol = "o",
    color = "red",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_collegekids",
    name = ccb.content.text("College Kids"),
    description = ccb.content.text("Several corpses of college kids are here."),
    generator = { method = "update_mapgen", id = "mx_collegekids" },
    z_levels = { -1, 0 },
    symbol = "c",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_finalshowdown",
    name = ccb.content.text("Final Showdown"),
    description = ccb.content.text("Someone died fighting here."),
    generator = { method = "update_mapgen", id = "mx_finalshowdown" },
    z_levels = { -1, 0 },
    symbol = "f",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_dermatikvictim",
    name = ccb.content.text("Strange Corpse"),
    description = ccb.content.text("A strangely damaged corpse is here."),
    generator = { method = "update_mapgen", id = "mx_dermatikvictim" },
    z_levels = { -1, 0 },
    symbol = "f",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_dormant",
    name = ccb.content.text("Corpses"),
    description = ccb.content.text("There are a lot of dead corpses here."),
    generator = { method = "update_mapgen", id = "mx_dormant" },
    z_levels = { -7, 7 },
    symbol = "d",
    color = "light_red",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_drugdeal",
    name = ccb.content.text("Drug Deal"),
    description = ccb.content.text("Several corpses of drug dealers are here."),
    generator = { method = "update_mapgen", id = "mx_drugdeal" },
    z_levels = { -2, 0 },
    symbol = "d",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_roadworks",
    name = ccb.content.text("Roadworks"),
    description = ccb.content.text("Roadworks are here."),
    generator = { method = "map_extra_function", id = "mx_roadworks" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "yellow",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_mayhem",
    name = ccb.content.text("Road Mayhem"),
    description = ccb.content.text("Road mayhem is here."),
    generator = { method = "update_mapgen", id = "mx_mayhem" },
    z_levels = { 0, 0 },
    symbol = "M",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_mayhem_crash_start",
    name = ccb.content.text("Car Crash"),
    description = ccb.content.text("Car crash is here."),
    generator = { method = "update_mapgen", id = "mx_mayhem_crash_start" },
    z_levels = { 0, 0 },
    symbol = "M",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_roadblock",
    name = ccb.content.text("Roadblock (Police)"),
    description = ccb.content.text("This road is blocked by police."),
    generator = { method = "update_mapgen", id = "mx_roadblock" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "blue",
    visibility = "details",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_roadblock_mil",
    name = ccb.content.text("Roadblock (Military)"),
    description = ccb.content.text("This road is blocked by military."),
    generator = { method = "update_mapgen", id = "mx_roadblock_mil" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "red",
    visibility = "details",
    flags = { "MAN_MADE", "CLASSIC" },
}

-- Can't be true because it doesn't always place anything
ccb.content.define_map_extra {
    id = "mx_bandits_block",
    name = ccb.content.text("Roadblock (Bandits)"),
    description = ccb.content.text("This road is blocked by bandits."),
    generator = { method = "update_mapgen", id = "mx_bandits_block" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "red",
    visibility = "none",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_supplydrop",
    name = ccb.content.text("Supply Drop"),
    description = ccb.content.text("Several supply crates were dropped here."),
    generator = { method = "update_mapgen", id = "mx_airdrop" },
    z_levels = { 0, 0 },
    symbol = "C",
    color = "yellow",
    visibility = "details",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_military",
    name = ccb.content.text("Military", "Map Extra"),
    description = ccb.content.text("Several corpses of soldiers are here."),
    generator = { method = "update_mapgen", id = "mx_military" },
    z_levels = { -4, 5 },
    symbol = "m",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_helicopter",
    name = ccb.content.text("Helicopter Crash"),
    description = ccb.content.text("Helicopter crashed here."),
    generator = { method = "map_extra_function", id = "mx_helicopter" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "light_blue",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_science",
    name = ccb.content.text("Scientists"),
    description = ccb.content.text("Several corpses of scientists are here."),
    generator = { method = "update_mapgen", id = "mx_science" },
    z_levels = { -5, 0 },
    symbol = "s",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE" },
}

ccb.content.define_map_extra {
    id = "mx_portal",
    name = ccb.content.text("Portal"),
    description = ccb.content.text("Portal is here."),
    generator = { method = "update_mapgen", id = "mx_portal" },
    z_levels = { -5, 5 },
    symbol = "P",
    color = "magenta",
    visibility = "details",
    flags = { "PORTAL" },
}

ccb.content.define_map_extra {
    id = "mx_portal_in",
    name = ccb.content.text("Portal In"),
    description = ccb.content.text("Another portal is here."),
    generator = { method = "map_extra_function", id = "mx_portal_in" },
    z_levels = { -5, 5 },
    symbol = "P",
    color = "magenta",
    visibility = "details",
    flags = { "PORTAL" },
}

ccb.content.define_map_extra {
    id = "mx_exocrash_1",
    name = ccb.content.text("Crashed pod"),
    description = ccb.content.text("There is some kind of crashed metal pod here."),
    generator = { method = "update_mapgen", id = "mx_exodii_crash_big_1" },
    z_levels = { 0, 0 },
    symbol = "x",
    color = "light_gray",
    visibility = "details",
    flags = { "EXODII" },
}

ccb.content.define_map_extra {
    id = "mx_exocrash_2",
    name = ccb.content.text("Crashed pod"),
    description = ccb.content.text("There is some kind of crashed metal pod here."),
    generator = { method = "update_mapgen", id = "mx_exodii_crash_big_2" },
    z_levels = { 0, 0 },
    symbol = "x",
    color = "light_gray",
    visibility = "details",
    flags = { "EXODII" },
}

ccb.content.define_map_extra {
    id = "mx_golden_monoliths",
    name = ccb.content.text("Golden monoliths"),
    description = ccb.content.text("There are some strange metal formations here."),
    generator = { method = "update_mapgen", id = "mx_golden_monoliths_map" },
    z_levels = { 0, 0 },
    symbol = "x",
    color = "yellow",
    visibility = "same_tile",
    flags = { "YRAX" },
}

ccb.content.define_map_extra {
    id = "mx_lab_concourse_area",
    name = ccb.content.text("Start location concourse area"),
    description = ccb.content.text("There is a lanyard with an ID badge nearby."),
    generator = { method = "update_mapgen", id = "mx_lab_concourse_area_spawn" },
    z_levels = { 0, 0 },
    symbol = "F",
    color = "light_gray",
    visibility = "same_tile",
    flags = { "MAN_MADE" },
}

ccb.content.define_map_extra {
    id = "mx_house_spider",
    name = ccb.content.text("Spider Nest"),
    description = ccb.content.text("Spider nest is here."),
    generator = { method = "update_mapgen", id = "mx_basement_spider" },
    z_levels = { -1, -1 },
    symbol = "S",
    color = "yellow",
    visibility = "same_tile",
    flags = { "SPIDER" },
}

ccb.content.define_map_extra {
    id = "mx_house_wasp",
    name = ccb.content.text("Wasp Nest"),
    description = ccb.content.text("Wasp nest is here."),
    generator = { method = "update_mapgen", id = "mx_house_wasp" },
    z_levels = { 0, 10 },
    symbol = "W",
    color = "yellow",
    visibility = "same_tile",
    flags = { "WASP" },
}

ccb.content.define_map_extra {
    id = "mx_bugout",
    name = ccb.content.text("Lost Bugout Bag"),
    description = ccb.content.text("Someone lost a bugout bag here while fleeing."),
    generator = { method = "update_mapgen", id = "mx_bugout" },
    z_levels = { -1, 1 },
    symbol = "c",
    color = "light_red",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_spider",
    name = ccb.content.text("Spiders"),
    description = ccb.content.text("This area is covered with webs.  Probably spiders are nearby."),
    generator = { method = "update_mapgen", id = "mx_spider" },
    z_levels = { -2, 0 },
    symbol = "S",
    color = "yellow",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_Trapdoor_spider_den",
    name = ccb.content.text("Trapdoor Spiders"),
    description = ccb.content.text("Several trapdoor spider nests."),
    generator = { method = "update_mapgen", id = "mx_Trapdoor_spider_den" },
    z_levels = { -2, 0 },
}

ccb.content.define_map_extra {
    id = "mx_jabberwock",
    name = ccb.content.text("Jabberwock"),
    description = ccb.content.text("Jabberwock is nearby."),
    generator = { method = "update_mapgen", id = "mx_jabberwock" },
    z_levels = { -2, 5 },
    symbol = "J",
    color = "red",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_grove",
    name = ccb.content.text("Grove"),
    description = ccb.content.text("This area is covered with a single type of trees."),
    generator = { method = "map_extra_function", id = "mx_grove" },
    z_levels = { 0, 0 },
    symbol = "F",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_shrubbery",
    name = ccb.content.text("Shrubbery"),
    description = ccb.content.text("This area is covered with a single type of shrubs."),
    generator = { method = "map_extra_function", id = "mx_shrubbery" },
    z_levels = { 0, 0 },
    symbol = "s",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_clearcut",
    name = ccb.content.text("Clearcut"),
    description = ccb.content.text("Most trees in this area were uniformly cut down."),
    generator = { method = "update_mapgen", id = "mx_clearcut" },
    z_levels = { 0, 0 },
    symbol = ".",
    color = "brown",
    visibility = "details",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_pond",
    name = ccb.content.text("Pond"),
    description = ccb.content.text("Small pond is here."),
    generator = { method = "map_extra_function", id = "mx_pond" },
    z_levels = { 0, 0 },
    symbol = "p",
    color = "blue",
    visibility = "details",
    flags = { "CLASSIC", "WATER" },
}

ccb.content.define_map_extra {
    id = "mx_pond_forest",
    name = ccb.content.text("basin"),
    description = ccb.content.text("Small basin is here."),
    generator = { method = "update_mapgen", id = "mx_pond_forest" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC", "WATER" },
}

ccb.content.define_map_extra {
    id = "mx_pond_forest_2",
    copy_from = "mx_pond_forest",
    generator = { method = "update_mapgen", id = "mx_pond_forest_2" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC", "WATER" },
}

ccb.content.define_map_extra {
    id = "mx_trees",
    name = ccb.content.text("Stand of trees"),
    description = ccb.content.text("A copse of trees."),
    generator = { method = "update_mapgen", id = "mx_trees_map" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_trees2",
    copy_from = "mx_trees",
    generator = { method = "update_mapgen", id = "mx_trees2_map" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_blackberry_patch",
    name = ccb.content.text("Blackberry patch"),
    description = ccb.content.text("Blackberry bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_blackberry_patch" },
    symbol = "o",
    color = "light_green",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_strawberry_patch",
    name = ccb.content.text("Strawberry patch"),
    description = ccb.content.text("Strawberry bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_strawberry_patch" },
    symbol = "o",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_blueberry_patch",
    name = ccb.content.text("Blueberry patch"),
    description = ccb.content.text("Blueberry bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_blueberry_patch" },
    symbol = "o",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_raspberry_patch",
    name = ccb.content.text("Raspberry patch"),
    description = ccb.content.text("Raspberry bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_raspberry_patch" },
    symbol = "o",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_huckleberry_patch",
    name = ccb.content.text("Huckleberry patch"),
    description = ccb.content.text("Huckleberry bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_huckleberry_patch" },
    symbol = "o",
    color = "light_green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_hobblebush_patch",
    name = ccb.content.text("Hobblebush patch"),
    description = ccb.content.text("Hobblebush bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_hobblebush_patch" },
    symbol = "o",
    color = "brown",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_autumn_olive_patch",
    name = ccb.content.text("Autumn olive patch"),
    description = ccb.content.text("Autumn olive bushes have spread here."),
    generator = { method = "update_mapgen", id = "mx_autumn_olive_patch" },
    symbol = "o",
    color = "brown",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_knotweed_patch",
    name = ccb.content.text("Japanese knotweed patch"),
    description = ccb.content.text("Japanese knotweed shrubs have spread here."),
    generator = { method = "update_mapgen", id = "mx_knotweed_patch" },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_grass",
    name = ccb.content.text("Tall grass"),
    description = ccb.content.text("A meadow of tall grass."),
    generator = { method = "update_mapgen", id = "mx_grass_map" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_grass2",
    copy_from = "mx_grass",
    generator = { method = "update_mapgen", id = "mx_grass2_map" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_fallen_shed",
    name = ccb.content.text("Derelict shed"),
    description = ccb.content.text("A collapsed shed."),
    generator = { method = "update_mapgen", id = "mx_fallen_shed_map" },
    z_levels = { 0, 0 },
    symbol = "^",
    color = "dark_gray",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_clay_deposit",
    name = ccb.content.text("Clay Deposit"),
    description = ccb.content.text("Small clay deposit is here."),
    generator = { method = "update_mapgen", id = "mx_clay_deposit" },
    z_levels = { 0, 0 },
    symbol = "c",
    color = "brown",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_sand_patch",
    name = ccb.content.text("Sand patch"),
    description = ccb.content.text("Small patch of sand is here."),
    generator = { method = "update_mapgen", id = "mx_sand_patch" },
    z_levels = { 0, 0 },
    symbol = ".",
    color = "yellow",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_dead_vegetation",
    name = ccb.content.text("Dead Vegetation"),
    description = ccb.content.text("Dead vegetation is here."),
    generator = { method = "update_mapgen", id = "mx_dead_vegetation" },
    z_levels = { 0, 0 },
    symbol = ".",
    color = "brown",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_point_dead_vegetation",
    name = ccb.content.text("Dead Vegetation (Point)"),
    description = ccb.content.text("Dead vegetation is here."),
    generator = { method = "update_mapgen", id = "mx_point_dead_vegetation" },
    z_levels = { 0, 0 },
    symbol = ".",
    color = "brown",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_burned_ground",
    name = ccb.content.text("Burned Ground"),
    description = ccb.content.text("Burned ground is here."),
    generator = { method = "update_mapgen", id = "mx_burned_ground" },
    z_levels = { 0, 0 },
    symbol = ".",
    color = "light_gray",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_point_burned_ground",
    name = ccb.content.text("Burned Ground (Point)"),
    description = ccb.content.text("Burned ground is here."),
    generator = { method = "update_mapgen", id = "mx_point_burned_ground" },
    z_levels = { 0, 5 },
    symbol = ".",
    color = "light_gray",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_kelp_patch",
    name = ccb.content.text("Kelp Patch"),
    description = ccb.content.text("A patch of kelp."),
    generator = { method = "update_mapgen", id = "mx_kelp_patch" },
    z_levels = { -9, -9 },
    symbol = "~",
    color = "green",
    visibility = "same_tile",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_marloss_pilgrimage",
    name = ccb.content.text("Marloss Pilgrimage"),
    description = ccb.content.text("Marloss Pilgrimage is here."),
    generator = { method = "update_mapgen", id = "mx_marloss_pilgrimage" },
    z_levels = { 0, 0 },
    symbol = "F",
    color = "dark_gray",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_casings",
    name = ccb.content.text("Casings"),
    description = ccb.content.text("Several spent casings are here."),
    generator = { method = "map_extra_function", id = "mx_casings" },
    z_levels = { -5, 5 },
    symbol = "c",
    color = "dark_gray",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_looters",
    name = ccb.content.text("Looters"),
    description = ccb.content.text("Some looters gathering everything not nailed down."),
    generator = { method = "map_extra_function", id = "mx_looters" },
    z_levels = { -2, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_corpses",
    name = ccb.content.text("Corpses"),
    description = ccb.content.text("Some unfortunates from the billions lost in the Cataclysm."),
    generator = { method = "map_extra_function", id = "mx_corpses" },
    z_levels = { -5, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_nest_wasp",
    name = ccb.content.text("Wasp Nest"),
    description = ccb.content.text("A wasp nest."),
    generator = { method = "update_mapgen", id = "mx_nest_wasp" },
    z_levels = { 0, 9 },
    symbol = "W",
    color = "yellow",
    visibility = "details",
    flags = { "WASP" },
}

ccb.content.define_map_extra {
    id = "mx_nest_dermatik",
    name = ccb.content.text("Dermatik Nest"),
    description = ccb.content.text("A dermatik nest."),
    generator = { method = "update_mapgen", id = "mx_nest_dermatik" },
    z_levels = { 0, 0 },
    symbol = "D",
    color = "brown",
    visibility = "details",
    flags = { "WASP" },
}

ccb.content.define_map_extra {
    id = "mx_prison_bus",
    name = ccb.content.text("Prison Bus"),
    description = ccb.content.text("A prison bus."),
    generator = { method = "update_mapgen", id = "mx_prison_bus" },
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_mass_grave",
    name = ccb.content.text("Mass Grave"),
    description = ccb.content.text("A mass grave."),
    generator = { method = "update_mapgen", id = "mx_mass_grave" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "yellow",
    visibility = "details",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_mass_grave_jabberwock",
    name = ccb.content.text("Mass Grave"),
    description = ccb.content.text("A mass grave."),
    generator = { method = "update_mapgen", id = "mx_mass_grave_jabberwock" },
    z_levels = { 0, 0 },
    symbol = "X",
    color = "yellow",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_grave",
    name = ccb.content.text("Grave"),
    description = ccb.content.text("A grave."),
    generator = { method = "update_mapgen", id = "mx_grave" },
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

-- 撤销 PR #86231 — 恢复刀片陷阱地图元素
ccb.content.define_map_extra {
    id = "mx_city_trap",
    name = ccb.content.text("Zombie Trap"),
    description = ccb.content.text("Someone put up a trap against zombies here."),
    generator = { method = "update_mapgen", id = "mx_city_trap" },
    symbol = "I",
    color = "green",
    visibility = "details",
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_laststand",
    name = ccb.content.text("Last Stand"),
    description = ccb.content.text("Some people made a last stand against the zombies here."),
    generator = { method = "update_mapgen", id = "mx_laststand" },
    symbol = "X",
    color = "green",
    visibility = "same_tile",
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_fungal_zone",
    name = ccb.content.text("Fungal infestation"),
    description = ccb.content.text("Fungal-infested location."),
    generator = { method = "map_extra_function", id = "mx_fungal_zone" },
    symbol = "F",
    color = "yellow",
    visibility = "same_tile",
    z_levels = { 0, 0 },
    flags = { "FUNGAL" },
}

ccb.content.define_map_extra {
    id = "mx_reed",
    name = ccb.content.text("Reed"),
    description = ccb.content.text("Water vegetation."),
    generator = { method = "map_extra_function", id = "mx_reed" },
    z_levels = { 0, 0 },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_tidal_flat",
    name = ccb.content.text("Tidal Flat"),
    description = ccb.content.text("A tidal flat with oysters."),
    generator = { method = "update_mapgen", id = "mx_tidal_flat" },
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_riverside_boat",
    name = ccb.content.text("Boat"),
    description = ccb.content.text("A small boat."),
    generator = { method = "update_mapgen", id = "mx_riverside_boat" },
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_riverside_jetski",
    name = ccb.content.text("Jetski"),
    description = ccb.content.text("An abandoned jetski."),
    generator = { method = "update_mapgen", id = "mx_riverside_jetski" },
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_toxic_waste",
    name = ccb.content.text("Toxic waste"),
    description = ccb.content.text("Someone dumped some toxic waste here."),
    generator = { method = "update_mapgen", id = "mx_toxic_waste" },
    symbol = "D",
    color = "magenta",
    visibility = "same_tile",
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_prison_van",
    name = ccb.content.text("Prison Van"),
    description = ccb.content.text("A violent escape."),
    generator = { method = "update_mapgen", id = "mx_prison_van" },
    z_levels = { 0, 0 },
    flags = { "MAN_MADE", "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_beehive_natural",
    name = ccb.content.text("Beehive"),
    description = ccb.content.text("An ordinary beehive."),
    generator = { method = "update_mapgen", id = "mx_beehive_natural" },
    z_levels = { 0, 0 },
    flags = { "BEE" },
}

ccb.content.define_map_extra {
    id = "mx_worm_sign",
    name = ccb.content.text("Upturned Earth"),
    description = ccb.content.text("There is a lot of upturned earth here."),
    generator = { method = "update_mapgen", id = "mx_worm_sign" },
    z_levels = { 0, 0 },
    symbol = "o",
    color = "red",
    visibility = "same_tile",
}

ccb.content.define_map_extra {
    id = "mx_sandy_beach",
    name = ccb.content.text("Sandy beach"),
    description = ccb.content.text("A sandy beach."),
    generator = { method = "map_extra_function", id = "mx_sandy_beach" },
    z_levels = { 0, 0 },
    symbol = "~",
    color = "yellow",
    flags = { "CLASSIC" },
}

ccb.content.define_map_extra {
    id = "mx_XEDRA_serum_transport",
    name = ccb.content.text("Vanguard Truck"),
    description = ccb.content.text("A crashed Vanguard Pharmaceuticals truck."),
    generator = { method = "update_mapgen", id = "mx_XEDRA_serum_transport" },
    z_levels = { 0, 0 },
    symbol = "T",
    color = "yellow",
}
