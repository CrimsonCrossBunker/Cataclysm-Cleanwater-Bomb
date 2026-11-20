local ccb = require("ccb")

ccb.content.define_region_settings_ravine {
    id = "highland_ravines",
    copy_from = "default",
    num_ravines = 15,
    ravine_width = 3,
    ravine_range = 45,
    ravine_depth = -3,
}

ccb.content.define_region_settings_terrain_furniture {
    id = "highland",
    copy_from = "default",
    replacements = { "highland_t_region_groundcover", "default_t_region_groundcover" },
}

ccb.content.define_region_terrain_furniture {
    id = "highland_t_region_groundcover",
    terrain = "t_highland_groundcover",
    terrain_choices = {
        { id = "t_grass", weight = 2 },
        { id = "t_grass_dead", weight = 1 },
        { id = "t_dirt", weight = 1 },
        { id = "t_grass_long", weight = 2 },
    },
}
