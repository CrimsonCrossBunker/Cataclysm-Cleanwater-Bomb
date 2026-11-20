local ccb = require("ccb")

ccb.content.define_region_settings_ravine {
    id = "default_portal_storm_dungeon",
    copy_from = "default",
    num_ravines = 50,
    ravine_width = 2,
    ravine_range = 15,
    ravine_depth = -9,
}

ccb.content.define_region_settings_terrain_furniture {
    id = "default_portal_storm_dungeon",
    copy_from = "default",
    replacements = { "portal_storm_dungeon_t_region_groundcover" },
}

ccb.content.define_region_terrain_furniture {
    id = "portal_storm_dungeon_t_region_groundcover",
    terrain = "t_region_groundcover",
    terrain_choices = { { id = "t_open_air", weight = 1 } },
}

ccb.content.define_region_settings_map_extras {
    id = "portal_storm_dungeon_extras",
    extras = { "default_portal_storm_dungeon_extras" },
}

ccb.content.define_map_extra_collection {
    id = "default_portal_storm_dungeon_extras",
    chance = 15,
    extras = {
        { extra = "mx_portal_cracked_mirror", weight = 1 },
        { extra = "mx_portal_ingress", weight = 1 },
        { extra = "mx_portal_distortion_item", weight = 1 },
    },
}
