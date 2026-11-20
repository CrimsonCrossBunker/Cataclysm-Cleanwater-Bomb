local ccb = require("ccb")

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
