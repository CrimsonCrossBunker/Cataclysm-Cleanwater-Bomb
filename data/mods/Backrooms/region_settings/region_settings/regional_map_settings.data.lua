local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "backrooms",
    chance = 30,
    extras = {
        { extra = "mx_teleporter_node", weight = 5000 },
        { extra = "mx_casings", weight = 2500 },
        { extra = "mx_corpses", weight = 2500 },
        { extra = "mx_autodoc_room", weight = 1250 },
        { extra = "mx_collegekids", weight = 1250 },
        { extra = "mx_spider", weight = 1000 },
        { extra = "mx_nest_dermatik_backrooms", weight = 1000 },
        { extra = "mx_science", weight = 1000 },
        { extra = "mx_crater", weight = 500 },
        { extra = "mx_nest_wasp_backrooms", weight = 500 },
        { extra = "mx_house_wasp", weight = 500 },
        { extra = "mx_pond", weight = 500 },
        { extra = "mx_military", weight = 500 },
        { extra = "mx_drugdeal", weight = 500 },
        { extra = "mx_supplydrop", weight = 500 },
        { extra = "mx_portal", weight = 150 },
        { extra = "mx_portal_in", weight = 150 },
        { extra = "mx_helicopter", weight = 50 },
        { extra = "mx_jabberwock", weight = 1 },
    },
}

ccb.content.define_region_settings_map_extras {
    id = "default_backrooms",
    copy_from = "default",
    extras = { "backrooms" },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = {
        { id = "t_carpet_backrooms", weight = 500 },
        { id = "t_carpet_backrooms_light", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub",
    terrain = "t_region_shrub",
    terrain_choices = {
        { id = "t_backroom_wall", weight = 1 },
        { id = "t_carpet_backrooms_light", weight = 1 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_shrub_plains",
    terrain = "t_region_shrub_plains",
    terrain_choices = { { id = "t_region_shrub", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_urban",
    terrain = "t_region_groundcover_urban",
    terrain_choices = { { id = "t_carpet_backrooms", weight = 2 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_forest",
    terrain = "t_region_groundcover_forest",
    terrain_choices = { { id = "t_carpet_backrooms", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    terrain_choices = { { id = "t_carpet_backrooms", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_tree",
    terrain = "t_region_tree",
    terrain_choices = { { id = "t_wall_b", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_barren",
    terrain = "t_region_groundcover_barren",
    terrain_choices = { { id = "t_carpet_red", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower",
    furniture = "f_region_flower",
    furniture_choices = {
        { id = "f_rack_coat", weight = 1 },
        { id = "f_sign_warning", weight = 1 },
        { id = "f_sign", weight = 1 },
    },
}

ccb.content.define_region_settings_terrain_furniture {
    id = "default_backrooms",
    copy_from = "default",
    replacements = {
        "default_t_region_groundcover",
        "default_t_region_shrub",
        "default_t_region_shrub_plains",
        "default_t_region_groundcover_urban",
        "default_t_region_groundcover_forest",
        "default_t_region_groundcover_swamp",
        "default_t_region_tree",
        "default_t_region_groundcover_barren",
        "default_f_region_flower",
    },
}

ccb.content.define_region_settings_forest_mapgen {
    id = "default_backrooms",
    copy_from = "default",
    biomes = {},
}
