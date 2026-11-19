local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "robofachq_roof_a0", "robofachq_roof_a3" },
    vision_levels = "roof_or_air",
    see_cost = "all_clear",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "robofachq_meteorology0", "robofachq_meteorology1", "robofachq_meteorology2",
        "robofachq_meteorology3", "robofachq_meteorology_roof0", "robofachq_meteorology_roof1",
        "robofachq_meteorology_roof2", "robofachq_meteorology_roof3",
    },
    vision_levels = "large_building",
    name = ccb.content.text("meteorology station"),
    symbol = "m",
    color = "yellow",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "robofachq_surface_road0", "robofachq_surface_road1", "robofachq_surface_road2",
        "robofachq_surface_road3",
    },
    copy_from = "road_abstract",
    name = ccb.content.text("meteorology station"),
    symbol = "─",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "robofachq_rock", "robofachq_roof_e" },
    -- NO_I18N
    name = "A buggy non-place",
    vision_levels = "underground_stone",
    looks_like = "empty_rock",
    symbol = "%",
    color = "dark_gray",
    see_cost = "full_high",
    flags = { "NO_ROTATE", "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = {
        "robofachq_roof_a1", "robofachq_roof_a2", "robofachq_surface_entrance",
        "robofachq_surface_car_entrance", "robofachq_surface_a3", "robofachq_surface_b0",
        "robofachq_surface_b1", "robofachq_surface_b2", "robofachq_surface_b3", "robofachq_foyer1",
        "robofachq_foyer2", "robofachq_foyer4", "robofachq_exe_a0", "robofachq_exe_a1",
        "robofachq_exe_a2", "robofachq_exe_a3", "robofachq_exe_b0", "robofachq_exe_b1",
        "robofachq_exe_b2", "robofachq_exe_b3", "robofachq_hab_a0", "robofachq_hab_a1",
        "robofachq_hab_a2", "robofachq_hab_a3", "robofachq_hab_b0", "robofachq_hab_b1",
        "robofachq_hab_b2", "robofachq_hab_b3", "robofachq_sub_a0", "robofachq_sub_a1",
        "robofachq_sub_a2", "robofachq_sub_a3", "robofachq_res_a0", "robofachq_res_a1",
        "robofachq_res_a2", "robofachq_res_a3", "robofachq_res_b0", "robofachq_res_b1",
        "robofachq_res_b2", "robofachq_res_b3", "robofachq_ai_a0", "robofachq_ai_a1",
        "robofachq_ai_a2", "robofachq_ai_a3", "robofachq_ai_b0", "robofachq_ai_b1", "robofachq_ai_b2",
        "robofachq_ai_b3", "robofachq_aiutl_a0", "robofachq_aiutl_a1", "robofachq_aiutl_a2",
        "robofachq_aiutl_a3", "robofachq_aiutl_b0", "robofachq_aiutl_b1", "robofachq_aiutl_b2",
        "robofachq_aiutl_b3",
    },
    vision_levels = "large_building",
    name = ccb.content.text("hub 01"),
    symbol = "0",
    color = "light_blue",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "robofachq_surface_parking",
    vision_levels = "large_pavement",
    name = ccb.content.text("hub 01 parking space"),
    symbol = "0",
    color = "light_blue",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = { "robofachq_subcc_a0", "robofachq_subcc_a1", "robofachq_subcc_a2", "robofachq_subcc_a3" },
    vision_levels = "underground_stone",
    name = ccb.content.text("subway C&C"),
    symbol = "S",
    color = "yellow",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = { "robofachq_subline_a0", "robofachq_subline_a1", "robofachq_subline_a2", "robofachq_subline_a3" },
    vision_levels = "underground_stone",
    name = ccb.content.text("hidden terminal"),
    symbol = "s",
    color = "light_blue",
    see_cost = "full_high",
}
