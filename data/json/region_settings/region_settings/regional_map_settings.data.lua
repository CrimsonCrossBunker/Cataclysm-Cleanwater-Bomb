local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest",
    chance = 40,
    extras = {
        { extra = "mx_blackberry_patch", weight = 450 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_strawberry_patch", weight = 180 },
        { extra = "mx_blueberry_patch", weight = 180 },
        { extra = "mx_raspberry_patch", weight = 180 },
        { extra = "mx_huckleberry_patch", weight = 180 },
        { extra = "mx_hobblebush_patch", weight = 180 },
        { extra = "mx_autumn_olive_patch", weight = 180 },
        { extra = "mx_grove", weight = 500 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_spider", weight = 200 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_pond", weight = 125 },
        { extra = "mx_pond_forest", weight = 125 },
        { extra = "mx_pond_forest_2", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_knotweed_patch", weight = 120 },
        { extra = "mx_nest_wasp", weight = 50 },
        { extra = "mx_grass2", weight = 40 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_fallen_shed", weight = 30 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_collegekids", weight = 20 },
        { extra = "mx_grass", weight = 20 },
        { extra = "mx_science", weight = 5 },
        { extra = "mx_toxic_waste", weight = 10 },
        { extra = "mx_military", weight = 8 },
        { extra = "mx_drugdeal", weight = 8 },
        { extra = "mx_mass_grave", weight = 5 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_helicopter", weight = 1 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_beehive_natural", weight = 20 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    chance = 30,
    extras = {
        { extra = "mx_blackberry_patch", weight = 22500 },
        { extra = "mx_grove", weight = 25000 },
        { extra = "mx_shrubbery", weight = 25000 },
        { extra = "mx_point_dead_vegetation", weight = 25000 },
        { extra = "mx_point_burned_ground", weight = 25000 },
        { extra = "mx_strawberry_patch", weight = 7500 },
        { extra = "mx_blueberry_patch", weight = 7500 },
        { extra = "mx_raspberry_patch", weight = 7500 },
        { extra = "mx_huckleberry_patch", weight = 7500 },
        { extra = "mx_hobblebush_patch", weight = 7500 },
        { extra = "mx_autumn_olive_patch", weight = 7500 },
        { extra = "mx_clearcut", weight = 6250 },
        { extra = "mx_pond", weight = 6250 },
        { extra = "mx_pond_forest", weight = 6250 },
        { extra = "mx_pond_forest_2", weight = 6250 },
        { extra = "mx_clay_deposit", weight = 6250 },
        { extra = "mx_knotweed_patch", weight = 5000 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_corpses", weight = 1500 },
        { extra = "mx_beehive_natural", weight = 1500 },
        { extra = "mx_nest_wasp", weight = 1250 },
        { extra = "mx_spider", weight = 1000 },
        { extra = "mx_collegekids", weight = 1000 },
        { extra = "mx_drugdeal", weight = 1000 },
        { extra = "mx_grass2", weight = 1000 },
        { extra = "mx_fallen_shed", weight = 1000 },
        { extra = "mx_toxic_waste", weight = 750 },
        { extra = "mx_grass", weight = 500 },
        { extra = "mx_military", weight = 400 },
        { extra = "mx_science", weight = 250 },
        { extra = "mx_mass_grave", weight = 250 },
        { extra = "mx_mass_grave_jabberwock", weight = 5 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_exocrash_1", weight = 50 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_exocrash_2", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    chance = 20,
    extras = {
        { extra = "mx_pond", weight = 240 },
        { extra = "mx_spider", weight = 200 },
        { extra = "mx_clay_deposit", weight = 140 },
        { extra = "mx_knotweed_patch", weight = 140 },
        { extra = "mx_nest_dermatik", weight = 75 },
        { extra = "mx_point_dead_vegetation", weight = 60 },
        { extra = "mx_science", weight = 15 },
        { extra = "mx_military", weight = 25 },
        { extra = "mx_drugdeal", weight = 20 },
        { extra = "mx_fallen_shed", weight = 10 },
        { extra = "mx_casings", weight = 60 },
        { extra = "mx_corpses", weight = 80 },
        { extra = "mx_grass2", weight = 20 },
        { extra = "mx_grass", weight = 10 },
        { extra = "mx_toxic_waste", weight = 10 },
        { extra = "mx_portal", weight = 8 },
        { extra = "mx_portal_in", weight = 7 },
        { extra = "mx_helicopter", weight = 5 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_beehive_natural", weight = 25 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field",
    chance = 6,
    extras = {
        { extra = "mx_grass", weight = 3500 },
        { extra = "mx_grass2", weight = 3500 },
        { extra = "mx_trees2", weight = 800 },
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_trees", weight = 500 },
        { extra = "mx_knotweed_patch", weight = 250 },
        { extra = "mx_fallen_shed", weight = 200 },
        { extra = "mx_sand_patch", weight = 200 },
        { extra = "mx_casings", weight = 200 },
        { extra = "mx_pond", weight = 150 },
        { extra = "mx_nest_wasp", weight = 50 },
        { extra = "mx_mass_grave", weight = 50 },
        { extra = "mx_mass_grave_jabberwock", weight = 1 },
        { extra = "mx_grave", weight = 50 },
        { extra = "mx_supplydrop", weight = 4 },
        { extra = "mx_Trapdoor_spider_den", weight = 40 },
        { extra = "mx_collegekids", weight = 30 },
        { extra = "mx_drugdeal", weight = 30 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_finalshowdown", weight = 20 },
        { extra = "mx_dermatikvictim", weight = 10 },
        { extra = "mx_worm_sign", weight = 20 },
        { extra = "mx_toxic_waste", weight = 10 },
        { extra = "mx_portal", weight = 10 },
        { extra = "mx_portal_in", weight = 10 },
        { extra = "mx_science", weight = 10 },
        { extra = "mx_military", weight = 4 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
        { extra = "mx_golden_monoliths", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "ocean_bed",
    chance = 30,
    extras = { { extra = "mx_kelp_patch", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "ocean_shore",
    chance = 1,
    extras = { { extra = "mx_sandy_beach", weight = 100 }, { extra = "mx_tidal_flat", weight = 5 } },
}

ccb.content.define_map_extra_collection {
    id = "road",
    chance = 100,
    extras = {
        { extra = "mx_helicopter", weight = 1 },
        { extra = "mx_military", weight = 10 },
        { extra = "mx_science", weight = 10 },
        { extra = "mx_collegekids", weight = 500 },
        { extra = "mx_roadblock", weight = 830 },
        { extra = "mx_roadblock_mil", weight = 170 },
        { extra = "mx_bandits_block", weight = 400 },
        { extra = "mx_drugdeal", weight = 100 },
        { extra = "mx_supplydrop", weight = 5 },
        { extra = "mx_portal", weight = 50 },
        { extra = "mx_portal_in", weight = 40 },
        { extra = "mx_roadworks", weight = 1000 },
        { extra = "mx_mayhem", weight = 500 },
        { extra = "mx_casings", weight = 1000 },
        { extra = "mx_corpses", weight = 300 },
        { extra = "mx_prison_bus", weight = 150 },
        { extra = "mx_prison_van", weight = 10 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
        { extra = "mx_XEDRA_serum_transport", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "park",
    chance = 600,
    extras = { { extra = "mx_fungal_zone", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "road_nesw_manhole",
    chance = 20,
    extras = { { extra = "mx_city_trap", weight = 1 }, { extra = "mx_laststand", weight = 1 } },
}

-- mx_city_trap 引用已恢复 — 撤销 PR #86231
ccb.content.define_map_extra_collection {
    id = "build",
    chance = 90,
    extras = {
        { extra = "mx_bugout", weight = 10 },
        { extra = "mx_house_spider", weight = 40 },
        { extra = "mx_house_wasp", weight = 30 },
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 7 },
        { extra = "mx_collegekids", weight = 15 },
        { extra = "mx_dormant", weight = 30 },
        { extra = "mx_portal", weight = 5 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_point_burned_ground", weight = 5 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_looters", weight = 10 },
        { extra = "mx_corpses", weight = 30 },
    },
}

ccb.content.define_map_extra_collection {
    id = "marloss",
    chance = 60,
    extras = { { extra = "mx_marloss_pilgrimage", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "subway",
    chance = 100,
    extras = {
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_drugdeal", weight = 5 },
        { extra = "mx_casings", weight = 10 },
        { extra = "mx_dormant", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "lab_subway",
    chance = 25,
    extras = {
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 15 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_portal_in", weight = 3 },
    },
}

ccb.content.define_map_extra_collection {
    id = "research_facility_lot",
    chance = 3,
    extras = {
        { extra = "mx_helicopter", weight = 15 },
        { extra = "mx_military", weight = 65 },
        { extra = "mx_collegekids", weight = 1 },
        { extra = "mx_portal", weight = 200 },
        { extra = "mx_crater", weight = 180 },
        { extra = "mx_portal_in", weight = 30 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "research_facility_interior",
    chance = 2,
    extras = {
        { extra = "mx_crater", weight = 15000 },
        { extra = "mx_portal", weight = 5000 },
        { extra = "mx_portal_in", weight = 2000 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_military", weight = 250 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "river",
    chance = 1,
    extras = {
        { extra = "mx_null", weight = 66 },
        { extra = "mx_riverside_boat", weight = 1 },
        { extra = "mx_riverside_jetski", weight = 1 },
        { extra = "mx_reed", weight = 33 },
    },
}

ccb.content.define_map_extra_collection {
    id = "lake_shore",
    chance = 2,
    extras = { { extra = "mx_reed", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "agricultural",
    chance = 38,
    extras = {
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_casings", weight = 200 },
        { extra = "mx_nest_wasp", weight = 50 },
        { extra = "mx_mass_grave", weight = 50 },
        { extra = "mx_mass_grave_jabberwock", weight = 2 },
        { extra = "mx_grave", weight = 50 },
        { extra = "mx_supplydrop", weight = 2 },
        { extra = "mx_Trapdoor_spider_den", weight = 40 },
        { extra = "mx_collegekids", weight = 30 },
        { extra = "mx_drugdeal", weight = 30 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_portal", weight = 10 },
        { extra = "mx_portal_in", weight = 10 },
        { extra = "mx_science", weight = 5 },
        { extra = "mx_military", weight = 4 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
    },
}
