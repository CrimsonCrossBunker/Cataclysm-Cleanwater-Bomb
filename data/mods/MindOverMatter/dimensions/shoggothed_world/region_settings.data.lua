local ccb = require("ccb")

ccb.content.define_region_settings_ravine {
    id = "default_mom_shoggothed_world",
    copy_from = "default",
    num_ravines = 30,
    ravine_width = 2,
    ravine_range = 35,
    ravine_depth = -3,
    bottom_terrain = "mom_shoggothed_world_ravine_floor",
}

ccb.content.define_region_settings_terrain_furniture {
    id = "mom_shoggothed_world",
    copy_from = "default",
    replacements = { "mom_shoggothed_world_t_region_groundcover" },
}

ccb.content.define_region_terrain_furniture {
    id = "mom_shoggothed_world_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = { { id = "t_dirt_cracked", weight = 250 }, { id = "t_dirt", weight = 1 } },
}
