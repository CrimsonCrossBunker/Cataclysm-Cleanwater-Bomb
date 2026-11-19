local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_evac_center",
    vision_levels = "large_building",
    name = ccb.content.text("refugee center"),
    see_cost = "full_high",
    flags = { "SOURCE_PEOPLE" },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_fence",
    vision_levels = "open_land",
    see_cost = "low",
    name = ccb.content.text("fence"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "evac_center_7", "evac_center_8", "evac_center_9", "evac_center_12", "evac_center_13",
        "evac_center_14", "evac_center_17", "evac_center_18", "evac_center_19",
    },
    copy_from = "generic_evac_center",
    symbol = "┼",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "evac_center_7_z1", "evac_center_8_z1", "evac_center_9_z1", "evac_center_12_z1",
        "evac_center_13_z1", "evac_center_14_z1", "evac_center_17_z1", "evac_center_18_z1",
        "evac_center_19_z1", "evac_center_12_z2", "evac_center_13_z2", "evac_center_14_z2",
    },
    name = ccb.content.text("refugee center roof"),
    vision_levels = "roof_or_air",
    symbol = "┼",
    color = "white",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "refctr_field",
    see_cost = "none",
    name = ccb.content.text("field"),
    looks_like = "field",
    vision_levels = "open_land",
    symbol = ",",
    color = "brown",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "refctr_fence_NW",
    copy_from = "generic_fence",
    symbol = "┌",
}

ccb.content.define_overmap_terrain {
    id = { "refctr_fence_h", "refctr_fence_entrance_L", "refctr_fence_entrance_R" },
    copy_from = "generic_fence",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = "refctr_fence_NE",
    copy_from = "generic_fence",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = "refctr_fence_v",
    copy_from = "generic_fence",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = "refctr_fence_SE",
    copy_from = "generic_fence",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = "refctr_fence_SW",
    copy_from = "generic_fence",
    symbol = "└",
}
