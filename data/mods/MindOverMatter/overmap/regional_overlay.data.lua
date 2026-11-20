local ccb = require("ccb")

ccb.content.define_region_settings_map_extras {
    id = "default",
    copy_from = "default",
    add_extras = { "phavian_lab_lot", "phavian_lab_interior" },
}

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = {
        { extra = "mx_alien_grass", weight = 25 },
        { extra = "mx_alien_grass_2", weight = 25 },
        { extra = "mx_alien_grass_3", weight = 25 },
        { extra = "mx_alien_grass_4", weight = 25 },
        { extra = "mx_alien_grass_5", weight = 25 },
        { extra = "mx_alien_grove", weight = 15 },
        { extra = "mx_fear_hawk_copse", weight = 5 },
        { extra = "mx_glass_and_crystal", weight = 30 },
        { extra = "mx_phavian_science", weight = 5 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = {
        { extra = "mx_alien_grass", weight = 25 },
        { extra = "mx_alien_grass_2", weight = 25 },
        { extra = "mx_alien_grass_3", weight = 25 },
        { extra = "mx_alien_grass_4", weight = 25 },
        { extra = "mx_alien_grass_5", weight = 25 },
        { extra = "mx_alien_grove", weight = 15 },
        { extra = "mx_fear_hawk_copse", weight = 10 },
        { extra = "mx_nether_pond", weight = 25 },
        { extra = "mx_glass_and_crystal", weight = 30 },
        { extra = "mx_phavian_science", weight = 3 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest",
    copy_from = "forest",
    add_extras = {
        { extra = "mx_alien_grass", weight = 15 },
        { extra = "mx_alien_grass_2", weight = 15 },
        { extra = "mx_alien_grass_3", weight = 15 },
        { extra = "mx_alien_grass_4", weight = 15 },
        { extra = "mx_alien_grass_5", weight = 15 },
        { extra = "mx_alien_grove", weight = 15 },
        { extra = "mx_fear_hawk_copse", weight = 3 },
        { extra = "mx_nether_pond", weight = 8 },
        { extra = "mx_glass_and_crystal", weight = 20 },
        { extra = "mx_phavian_science", weight = 3 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field",
    copy_from = "field",
    add_extras = {
        { extra = "mx_alien_grass", weight = 15 },
        { extra = "mx_alien_grass_2", weight = 15 },
        { extra = "mx_alien_grass_3", weight = 15 },
        { extra = "mx_alien_grass_4", weight = 15 },
        { extra = "mx_alien_grass_5", weight = 15 },
        { extra = "mx_alien_grove", weight = 15 },
        { extra = "mx_fear_hawk_copse", weight = 1 },
        { extra = "mx_nether_pond", weight = 25 },
        { extra = "mx_glass_and_crystal", weight = 25 },
        { extra = "mx_phavian_science", weight = 6 },
    },
}

ccb.content.define_map_extra_collection {
    id = "agricultural",
    copy_from = "agricultural",
    add_extras = {
        { extra = "mx_alien_grass", weight = 15 },
        { extra = "mx_alien_grass_2", weight = 15 },
        { extra = "mx_alien_grass_3", weight = 15 },
        { extra = "mx_alien_grass_4", weight = 15 },
        { extra = "mx_alien_grass_5", weight = 15 },
        { extra = "mx_alien_grove", weight = 15 },
        { extra = "mx_nether_pond", weight = 25 },
        { extra = "mx_glass_and_crystal", weight = 25 },
        { extra = "mx_phavian_science", weight = 3 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road",
    copy_from = "road",
    add_extras = {
        { extra = "mx_alien_grass", weight = 15 },
        { extra = "mx_alien_grass_2", weight = 15 },
        { extra = "mx_alien_grass_3", weight = 15 },
        { extra = "mx_alien_grass_4", weight = 15 },
        { extra = "mx_alien_grass_5", weight = 15 },
        { extra = "mx_alien_grove", weight = 15 },
        { extra = "mx_nether_pond", weight = 25 },
        { extra = "mx_glass_and_crystal", weight = 25 },
        { extra = "mx_phavian_science", weight = 30 },
    },
}

ccb.content.define_map_extra_collection {
    id = "build",
    copy_from = "build",
    add_extras = { { extra = "mx_phavian_science", weight = 5 } },
}

ccb.content.define_map_extra_collection {
    id = "subway",
    copy_from = "subway",
    add_extras = {
        { extra = "mx_alien_grass_3", weight = 15 },
        { extra = "mx_nether_pond", weight = 25 },
        { extra = "mx_glass_and_crystal", weight = 25 },
        { extra = "mx_phavian_science", weight = 8 },
    },
}

ccb.content.define_map_extra_collection {
    id = "lab_subway",
    copy_from = "lab_subway",
    add_extras = {
        { extra = "mx_alien_grass_3", weight = 15 },
        { extra = "mx_nether_pond", weight = 25 },
        { extra = "mx_glass_and_crystal", weight = 25 },
        { extra = "mx_phavian_science", weight = 8 },
    },
}

ccb.content.define_map_extra_collection {
    id = "phavian_lab_lot",
    chance = 3,
    extras = {
        { extra = "mx_helicopter", weight = 15 },
        { extra = "mx_military", weight = 65 },
        { extra = "mx_collegekids", weight = 1 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_crater", weight = 180 },
        { extra = "mx_alien_grass", weight = 25 },
        { extra = "mx_alien_grass_2", weight = 25 },
        { extra = "mx_alien_grass_3", weight = 25 },
        { extra = "mx_alien_grass_4", weight = 25 },
        { extra = "mx_alien_grass_5", weight = 25 },
        { extra = "mx_alien_grove", weight = 25 },
        { extra = "mx_nether_pond", weight = 50 },
        { extra = "mx_portal_in", weight = 30 },
        { extra = "mx_point_burned_ground", weight = 100 },
        { extra = "mx_casings", weight = 30 },
        { extra = "mx_exocrash_1", weight = 1 },
        { extra = "mx_exocrash_2", weight = 1 },
    },
}

ccb.content.define_map_extra_collection {
    id = "phavian_lab_interior",
    chance = 2,
    extras = {
        { extra = "mx_crater", weight = 15000 },
        { extra = "mx_point_burned_ground", weight = 6250 },
        { extra = "mx_portal", weight = 3750 },
        { extra = "mx_glass_and_crystal", weight = 2500 },
        { extra = "mx_nether_pond", weight = 2500 },
        { extra = "mx_portal_in", weight = 2000 },
        { extra = "mx_casings", weight = 1500 },
        { extra = "mx_alien_grass", weight = 1250 },
        { extra = "mx_alien_grass_2", weight = 1250 },
        { extra = "mx_alien_grass_3", weight = 1250 },
        { extra = "mx_alien_grass_4", weight = 1250 },
        { extra = "mx_alien_grass_5", weight = 1250 },
        { extra = "mx_military", weight = 250 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}
