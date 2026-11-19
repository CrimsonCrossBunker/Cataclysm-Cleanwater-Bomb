local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "faction_base_camp_0",
    vision_levels = "always_full",
    name = ccb.content.text("camp survey"),
    symbol = "+",
    color = "white",
    see_cost = "none",
    flags = { "NO_ROTATE", "SOURCE_PEOPLE", "SHOULD_NOT_SPAWN" },
    travel_cost = "field",
}

ccb.content.define_overmap_terrain {
    id = { "faction_base_camp_new_0" },
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("survivor camp"),
    delete = { flags = { "NO_ROTATE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_base_camp_1", "faction_base_camp_2", "faction_base_camp_3", "faction_base_camp_4",
        "faction_base_camp_5", "faction_base_camp_6", "faction_base_camp_7", "faction_base_camp_8",
        "faction_base_camp_9", "faction_base_camp_10", "faction_base_camp_11", "faction_base_camp_12",
        "faction_base_camp_13", "faction_base_camp_14",
    },
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("survivor camp"),
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_base_camp_15", "faction_base_camp_16", "faction_base_camp_17", "faction_base_camp_18",
        "faction_base_camp_19", "faction_base_camp_20",
    },
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("survivor base"),
}

ccb.content.define_overmap_terrain {
    id = "faction_base_farm_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("farm survey"),
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = { "faction_base_farm_1", "faction_base_farm_2", "faction_base_farm_3", "faction_base_farm_4" },
    copy_from = "faction_base_farm_0",
    name = ccb.content.text("farm"),
}

ccb.content.define_overmap_terrain {
    id = "faction_base_garage_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("garage survey"),
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_base_garage_1", "faction_base_garage_2", "faction_base_garage_3",
        "faction_base_garage_4", "faction_base_garage_5", "faction_base_garage_6",
    },
    copy_from = "faction_base_garage_0",
    name = ccb.content.text("garage"),
}

ccb.content.define_overmap_terrain {
    id = "faction_base_kitchen_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("kitchen survey"),
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_base_kitchen_1", "faction_base_kitchen_2", "faction_base_kitchen_3",
        "faction_base_kitchen_4", "faction_base_kitchen_5", "faction_base_kitchen_6",
        "faction_base_kitchen_7", "faction_base_kitchen_8",
    },
    copy_from = "faction_base_kitchen_0",
    name = ccb.content.text("kitchen"),
}

ccb.content.define_overmap_terrain {
    id = "faction_hide_site_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("hide site"),
    extend = { flags = { "SHOULD_NOT_SPAWN" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_wall_level_N_0", "faction_wall_level_E_0", "faction_wall_level_S_0",
        "faction_wall_level_W_0",
    },
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("trench"),
    symbol = "X",
    color = "light_gray",
    extend = { flags = { "SHOULD_NOT_SPAWN" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_wall_level_N_1", "faction_wall_level_E_1", "faction_wall_level_S_1",
        "faction_wall_level_W_1",
    },
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("spiked trench"),
    symbol = "X",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_workshop_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("fabrication workshop survey"),
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_workshop_2_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("fabrication workshop 2 survey"),
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_blacksmith_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("blacksmith survey"),
    color = "i_dark_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "faction_base_blacksmith_1", "faction_base_blacksmith_2", "faction_base_blacksmith_3",
        "faction_base_blacksmith_4", "faction_base_blacksmith_5", "faction_base_blacksmith_6",
        "faction_base_blacksmith_7", "faction_base_blacksmith_8", "faction_base_blacksmith_9",
        "faction_base_blacksmith_10", "faction_base_blacksmith_11", "faction_base_blacksmith_12",
    },
    copy_from = "faction_base_blacksmith_0",
    name = ccb.content.text("blacksmith shop"),
}

ccb.content.define_overmap_terrain {
    id = "faction_base_livestock_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("livestock survey"),
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_livestock_2_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("livestock survey 2"),
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_storehouse_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("store house survey"),
    color = "cyan",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_storehouse_2_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("store house survey 2"),
    color = "cyan",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_saltworks_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("saltworks survey"),
    color = "red",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_canteen_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("canteen survey"),
    color = "i_green",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_canteen_2_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("canteen survey 2"),
    color = "i_green",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_farm_2_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("farm survey 2"),
    color = "i_brown",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_garage_2_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("garage survey 2"),
    color = "i_light_gray",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_helipad_garage_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("military helipad garage"),
    color = "red",
    delete = { flags = { "SOURCE_PEOPLE" } },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_lightindustry_workshop_0",
    copy_from = "faction_base_camp_0",
    name = ccb.content.text("light industries workshop survey"),
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_e1",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base entrance"),
    symbol = "M",
    color = "white",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_e2",
    copy_from = "faction_base_mansion_e1",
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t1",
    vision_levels = "always_full",
    see_cost = "none",
    name = ccb.content.text("mansion base swimming pool"),
    symbol = "M",
    color = "blue",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t2",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base bedrooms"),
    symbol = "M",
    color = "light_green",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t3",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base???"),
    symbol = "M",
    color = "white",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t4",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base kitchen"),
    symbol = "M",
    color = "pink",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t5",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base library"),
    symbol = "M",
    color = "brown",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t6",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base bedroom"),
    symbol = "M",
    color = "light_green",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_t7",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base living rooms"),
    symbol = "M",
    color = "green",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_c1",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base swimming pool"),
    symbol = "M",
    color = "blue",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_c2",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base bar"),
    symbol = "M",
    color = "magenta",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_c3",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base living rooms"),
    symbol = "M",
    color = "green",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_c4",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base bedroom"),
    symbol = "M",
    color = "light_green",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "faction_base_mansion_c5",
    vision_levels = "always_full",
    see_cost = "full_high",
    name = ccb.content.text("mansion base kitchen"),
    symbol = "M",
    color = "pink",
    flags = { "SOURCE_PEOPLE", "NO_ROTATE" },
}
