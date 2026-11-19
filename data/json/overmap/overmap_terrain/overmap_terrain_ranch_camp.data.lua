local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "ranch_camp_1",
    vision_levels = "open_land",
    name = ccb.content.text("ranch field"),
    symbol = "┌",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "ranch_camp_2", "ranch_camp_3", "ranch_camp_4", "ranch_camp_5", "ranch_camp_6", "ranch_camp_7",
        "ranch_camp_8", "ranch_camp_74", "ranch_camp_74_roof", "ranch_camp_79", "ranch_camp_80",
    },
    name = ccb.content.text("ranch field"),
    symbol = "─",
    vision_levels = "open_land",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "ranch_camp_9", "ranch_camp_69" },
    name = ccb.content.text("ranch field"),
    vision_levels = "open_land",
    symbol = "┐",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "ranch_camp_10", "ranch_camp_18", "ranch_camp_19", "ranch_camp_27", "ranch_camp_28",
        "ranch_camp_36", "ranch_camp_37", "ranch_camp_45", "ranch_camp_46", "ranch_camp_54",
        "ranch_camp_55", "ranch_camp_57_roof", "ranch_camp_63", "ranch_camp_64", "ranch_camp_72",
    },
    name = ccb.content.text("ranch field"),
    vision_levels = "open_land",
    symbol = "│",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "ranch_camp_11", "ranch_camp_12", "ranch_camp_13", "ranch_camp_14", "ranch_camp_15",
        "ranch_camp_16", "ranch_camp_20", "ranch_camp_21", "ranch_camp_22", "ranch_camp_23",
        "ranch_camp_24", "ranch_camp_25", "ranch_camp_26", "ranch_camp_29", "ranch_camp_30",
        "ranch_camp_31", "ranch_camp_32", "ranch_camp_33", "ranch_camp_34", "ranch_camp_35",
        "ranch_camp_38", "ranch_camp_39", "ranch_camp_40", "ranch_camp_41", "ranch_camp_42",
        "ranch_camp_43", "ranch_camp_44", "ranch_camp_47", "ranch_camp_48", "ranch_camp_49",
        "ranch_camp_50", "ranch_camp_51", "ranch_camp_52", "ranch_camp_53", "ranch_camp_56",
        "ranch_camp_58", "ranch_camp_59", "ranch_camp_60", "ranch_camp_61", "ranch_camp_62",
        "ranch_camp_65", "ranch_camp_70", "ranch_camp_71",
    },
    name = ccb.content.text("ranch field"),
    vision_levels = "open_land",
    symbol = "#",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_17",
    vision_levels = "single_water",
    name = ccb.content.text("pond"),
    symbol = "P",
    color = "blue",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_57",
    vision_levels = "isolated_tower",
    name = ccb.content.text("silo"),
    symbol = "#",
    color = "i_brown",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_57_silo",
    vision_levels = "isolated_tower",
    name = ccb.content.text("silo"),
    symbol = "│",
    color = "brown",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_57_silocap",
    vision_levels = "isolated_tower",
    name = ccb.content.text("silo cap"),
    symbol = "│",
    color = "brown",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_65_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("barn roof"),
    symbol = "#",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_66",
    vision_levels = "isolated_building",
    name = ccb.content.text("barn"),
    symbol = "#",
    color = "i_brown",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_66_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("barn roof"),
    symbol = "#",
    color = "i_brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_67",
    vision_levels = "isolated_building",
    name = ccb.content.text("garage"),
    symbol = "O",
    color = "white",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_67_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("garage roof"),
    symbol = "O",
    color = "white",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_68",
    vision_levels = "isolated_building",
    name = ccb.content.text("ranch"),
    symbol = "v",
    color = "light_green",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_68_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("ranch roof"),
    symbol = "v",
    color = "light_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "ranch_camp_75", "ranch_camp_75_roof", "ranch_camp_81" },
    vision_levels = "open_land",
    name = ccb.content.text("ranch field"),
    symbol = "┘",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_76",
    vision_levels = "large_pavement",
    name = ccb.content.text("lot"),
    symbol = "O",
    color = "dark_gray",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "ranch_camp_77",
    copy_from = "road_abstract",
    symbol = "│",
    extras = "road",
}

ccb.content.define_overmap_terrain {
    id = { "ranch_camp_73", "ranch_camp_78" },
    vision_levels = "open_land",
    name = ccb.content.text("ranch field"),
    symbol = "└",
    color = "brown",
    see_cost = "none",
}
