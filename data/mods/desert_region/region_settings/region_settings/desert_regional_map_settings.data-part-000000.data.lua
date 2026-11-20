local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest",
    chance = 120,
    extras = {
        { extra = "mx_helicopter", weight = 1 },
        { extra = "mx_military", weight = 8 },
        { extra = "mx_science", weight = 20 },
        { extra = "mx_collegekids", weight = 25 },
        { extra = "mx_drugdeal", weight = 8 },
        { extra = "mx_supplydrop", weight = 8 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_fallen_shed", weight = 30 },
        { extra = "mx_nest_wasp", weight = 50 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_mass_grave", weight = 5 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    chance = 120,
    extras = {
        { extra = "mx_clay_deposit", weight = 6250 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_corpses", weight = 1500 },
        { extra = "mx_collegekids", weight = 1250 },
        { extra = "mx_science", weight = 1000 },
        { extra = "mx_drugdeal", weight = 1000 },
        { extra = "mx_fallen_shed", weight = 1000 },
        { extra = "mx_supplydrop", weight = 500 },
        { extra = "mx_crater", weight = 500 },
        { extra = "mx_military", weight = 400 },
        { extra = "mx_mass_grave", weight = 250 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_exocrash_1", weight = 50 },
        { extra = "mx_exocrash_2", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    chance = 120,
    extras = {
        { extra = "mx_helicopter", weight = 5 },
        { extra = "mx_military", weight = 25 },
        { extra = "mx_science", weight = 50 },
        { extra = "mx_drugdeal", weight = 20 },
        { extra = "mx_supplydrop", weight = 25 },
        { extra = "mx_portal", weight = 8 },
        { extra = "mx_crater", weight = 20 },
        { extra = "mx_portal_in", weight = 7 },
        { extra = "mx_fallen_shed", weight = 10 },
        { extra = "mx_clay_deposit", weight = 140 },
        { extra = "mx_casings", weight = 60 },
        { extra = "mx_corpses", weight = 80 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field",
    chance = 140,
    extras = {
        { extra = "mx_helicopter", weight = 2 },
        { extra = "mx_military", weight = 4 },
        { extra = "mx_science", weight = 10 },
        { extra = "mx_collegekids", weight = 30 },
        { extra = "mx_drugdeal", weight = 30 },
        { extra = "mx_supplydrop", weight = 40 },
        { extra = "mx_portal", weight = 10 },
        { extra = "mx_crater", weight = 150 },
        { extra = "mx_portal_in", weight = 10 },
        { extra = "mx_fallen_shed", weight = 200 },
        { extra = "mx_casings", weight = 200 },
        { extra = "mx_corpses", weight = 30 },
        { extra = "mx_mass_grave", weight = 50 },
        { extra = "mx_grave", weight = 50 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road",
    chance = 75,
    extras = {
        { extra = "mx_helicopter", weight = 10 },
        { extra = "mx_military", weight = 50 },
        { extra = "mx_science", weight = 400 },
        { extra = "mx_collegekids", weight = 500 },
        { extra = "mx_roadblock", weight = 830 },
        { extra = "mx_roadblock_mil", weight = 170 },
        { extra = "mx_bandits_block", weight = 800 },
        { extra = "mx_drugdeal", weight = 300 },
        { extra = "mx_supplydrop", weight = 100 },
        { extra = "mx_portal", weight = 50 },
        { extra = "mx_crater", weight = 100 },
        { extra = "mx_portal_in", weight = 40 },
        { extra = "mx_roadworks", weight = 1000 },
        { extra = "mx_mayhem", weight = 500 },
        { extra = "mx_casings", weight = 1000 },
        { extra = "mx_corpses", weight = 300 },
        { extra = "mx_prison_bus", weight = 150 },
        { extra = "mx_prison_van", weight = 10 },
        { extra = "mx_exocrash_1", weight = 5 },
        { extra = "mx_exocrash_2", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road_nesw_manhole_desert",
    chance = 20,
    extras = { { extra = "mx_city_trap", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "build",
    chance = 90,
    extras = {
        { extra = "mx_bugout", weight = 20 },
        { extra = "mx_house_spider", weight = 40 },
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_collegekids", weight = 15 },
        { extra = "mx_portal", weight = 5 },
        { extra = "mx_crater", weight = 60 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_point_burned_ground", weight = 5 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_looters", weight = 10 },
        { extra = "mx_corpses", weight = 30 },
    },
}

ccb.content.define_map_extra_collection {
    id = "marloss",
    chance = 20,
    extras = { { extra = "mx_marloss_pilgrimage", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "subway",
    chance = 75,
    extras = {
        { extra = "mx_military", weight = 5 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_drugdeal", weight = 5 },
        { extra = "mx_casings", weight = 10 },
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
        { extra = "mx_point_burned_ground", weight = 100 },
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
        { extra = "mx_point_burned_ground", weight = 6250 },
        { extra = "mx_portal_in", weight = 2000 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_military", weight = 250 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "river",
    chance = 3,
    extras = { { extra = "mx_reed", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "lake_shore",
    chance = 2,
    extras = { { extra = "mx_reed", weight = 100 } },
}
