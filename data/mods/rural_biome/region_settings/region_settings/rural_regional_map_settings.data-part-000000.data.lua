local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest_ruralbiome",
    chance = 20,
    extras = {
        { extra = "mx_helicopter", weight = 4 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_grass", weight = 20 },
        { extra = "mx_grass2", weight = 40 },
        { extra = "mx_fallen_shed", weight = 30 },
        { extra = "mx_spider", weight = 200 },
        { extra = "mx_nest_wasp", weight = 100 },
        { extra = "mx_grove", weight = 500 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_pond", weight = 125 },
        { extra = "mx_pond_forest", weight = 125 },
        { extra = "mx_pond_forest_2", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_mass_grave", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick_ruralbiome",
    chance = 30,
    extras = {
        { extra = "mx_blackberry_patch", weight = 65000 },
        { extra = "mx_grove", weight = 25000 },
        { extra = "mx_shrubbery", weight = 25000 },
        { extra = "mx_point_dead_vegetation", weight = 25000 },
        { extra = "mx_point_burned_ground", weight = 25000 },
        { extra = "mx_clearcut", weight = 6250 },
        { extra = "mx_pond", weight = 6250 },
        { extra = "mx_pond_forest", weight = 6250 },
        { extra = "mx_pond_forest_2", weight = 6250 },
        { extra = "mx_clay_deposit", weight = 6250 },
        { extra = "mx_knotweed_patch", weight = 5000 },
        { extra = "mx_beehive_natural", weight = 1500 },
        { extra = "mx_nest_wasp", weight = 1250 },
        { extra = "mx_spider", weight = 1000 },
        { extra = "mx_grass2", weight = 1000 },
        { extra = "mx_grass", weight = 500 },
        { extra = "mx_fallen_shed", weight = 200 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water_ruralbiome",
    chance = 22,
    extras = {
        { extra = "mx_helicopter", weight = 4 },
        { extra = "mx_portal", weight = 3 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_portal_in", weight = 3 },
        { extra = "mx_fallen_shed", weight = 5 },
        { extra = "mx_spider", weight = 200 },
        { extra = "mx_grass", weight = 20 },
        { extra = "mx_grass2", weight = 20 },
        { extra = "mx_pond", weight = 125 },
        { extra = "mx_grove", weight = 500 },
        { extra = "mx_shrubbery", weight = 500 },
        { extra = "mx_clearcut", weight = 125 },
        { extra = "mx_clay_deposit", weight = 125 },
        { extra = "mx_point_dead_vegetation", weight = 500 },
        { extra = "mx_point_burned_ground", weight = 500 },
        { extra = "mx_nest_dermatik", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field_ruralbiome",
    chance = 7,
    extras = {
        { extra = "mx_helicopter", weight = 3 },
        { extra = "mx_portal", weight = 1 },
        { extra = "mx_crater", weight = 15 },
        { extra = "mx_portal_in", weight = 1 },
        { extra = "mx_point_dead_vegetation", weight = 50 },
        { extra = "mx_grass", weight = 700 },
        { extra = "mx_grass2", weight = 350 },
        { extra = "mx_trees", weight = 100 },
        { extra = "mx_trees2", weight = 80 },
        { extra = "mx_Trapdoor_spider_den", weight = 4 },
        { extra = "mx_fallen_shed", weight = 5 },
        { extra = "mx_pond", weight = 20 },
        { extra = "mx_point_burned_ground", weight = 50 },
        { extra = "mx_nest_wasp", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road_ruralbiome",
    chance = 75,
    extras = {
        { extra = "mx_helicopter", weight = 25 },
        { extra = "mx_roadblock", weight = 15 },
        { extra = "mx_roadblock_mil", weight = 5 },
        { extra = "mx_bandits_block", weight = 80 },
        { extra = "mx_supplydrop", weight = 1 },
        { extra = "mx_portal", weight = 5 },
        { extra = "mx_crater", weight = 200 },
        { extra = "mx_portal_in", weight = 4 },
        { extra = "mx_roadworks", weight = 100 },
        { extra = "mx_mayhem", weight = 50 },
        { extra = "mx_casings", weight = 100 },
        { extra = "mx_prison_bus", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "build_ruralbiome",
    chance = 90,
    extras = {
        { extra = "mx_house_spider", weight = 40 },
        { extra = "mx_house_wasp", weight = 60 },
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
    id = "marloss_ruralbiome",
    chance = 20,
    extras = { { extra = "mx_marloss_pilgrimage", weight = 100 } },
}

ccb.content.define_map_extra_collection {
    id = "subway_ruralbiome",
    chance = 75,
    extras = { { extra = "mx_portal", weight = 7 }, { extra = "mx_portal_in", weight = 3 } },
}
