local ccb = require("ccb")

ccb.content.define_region_terrain_furniture {
    id = "default_t_region_groundcover_swamp",
    copy_from = "default_t_region_groundcover_swamp",
    terrain = "t_region_groundcover_swamp",
    add_terrain_choices = { { id = "t_horn_moss", weight = 10 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_water_plant",
    copy_from = "default_f_region_water_plant",
    furniture = "f_region_water_plant",
    add_furniture_choices = { { id = "f_barnacle_weed", weight = 1 }, { id = "f_golden_reed", weight = 1 } },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_flower",
    copy_from = "default_f_region_flower",
    furniture = "f_region_flower",
    add_furniture_choices = {
        { id = "f_kampuch", weight = 30 },
        { id = "f_olieribos", weight = 30 },
        { id = "f_barnacle_weed", weight = 13 },
        { id = "f_dragonail", weight = 17 },
        { id = "f_moly", weight = 17 },
        { id = "f_flowering_fern", weight = 3 },
        { id = "f_funnelcap", weight = 17 },
        { id = "f_sojourners_palm", weight = 3 },
        { id = "f_platonic_flower", weight = 7 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_weed",
    copy_from = "default_f_region_weed",
    furniture = "f_region_weed",
    add_furniture_choices = {
        { id = "f_whiskflower", weight = 100 },
        { id = "f_kampuch", weight = 17 },
        { id = "f_olieribos", weight = 17 },
        { id = "f_glowing_mushroom", weight = 33 },
        { id = "f_dragonail", weight = 17 },
        { id = "f_moly", weight = 17 },
        { id = "f_flowering_fern", weight = 3 },
        { id = "f_funnelcap", weight = 17 },
        { id = "f_sojourners_palm", weight = 7 },
        { id = "f_platonic_flower", weight = 7 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_plain",
    copy_from = "default_f_region_plain",
    furniture = "f_region_plain",
    add_furniture_choices = {
        { id = "f_dragonail", weight = 17 },
        { id = "f_moly", weight = 17 },
        { id = "f_flowering_fern", weight = 3 },
        { id = "f_olieribos", weight = 30 },
        { id = "f_sojourners_palm", weight = 3 },
        { id = "f_whiskflower", weight = 120 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest",
    copy_from = "default_f_region_forest",
    furniture = "f_region_forest",
    add_furniture_choices = {
        { id = "f_platonic_flower", weight = 6 },
        { id = "f_kampuch", weight = 20 },
        { id = "f_flowering_fern", weight = 3 },
        { id = "f_funnelcap", weight = 8 },
        { id = "f_sojourners_palm", weight = 3 },
        { id = "f_whiskflower", weight = 60 },
    },
}

ccb.content.define_region_terrain_furniture {
    id = "default_f_region_forest_dense",
    copy_from = "default_f_region_forest_dense",
    furniture = "f_region_forest_dense",
    add_furniture_choices = {
        { id = "f_platonic_flower", weight = 12 },
        { id = "f_kampuch", weight = 30 },
        { id = "f_flowering_fern", weight = 3 },
        { id = "f_funnelcap", weight = 17 },
        { id = "f_sojourners_palm", weight = 3 },
        { id = "f_whiskflower", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = { { extra = "mx_catoblepas_lair", weight = 1 } },
}

ccb.content.define_region_settings_forest_mapgen {
    id = "default",
    copy_from = "default",
    add_biomes = { "biome_forest_thick_default" },
}

ccb.content.define_forest_biome_mapgen {
    id = "biome_forest_thick_default",
    copy_from = "biome_forest_thick_default",
    extend_terrains = {
        "druid_ritual_home_z0",
        "mystic_glade_nw",
        "mystic_glade_ne",
        "mystic_glade_sw",
        "mystic_glade_se",
    },
}
