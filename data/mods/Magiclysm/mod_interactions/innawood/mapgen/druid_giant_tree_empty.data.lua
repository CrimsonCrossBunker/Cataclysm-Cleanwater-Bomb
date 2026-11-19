local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "druid_giant_tree_empty_z0" },
    name = ccb.content.text("great tree"),
    symbol = "F",
    color = "green",
    looks_like = "triffid_grove",
    vision_levels = "blends_till_outlines",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "druid_giant_tree_empty_z1", "druid_giant_tree_empty_z2", "druid_giant_tree_empty_z3" },
    name = ccb.content.text("great tree"),
    symbol = "F",
    color = "green",
    looks_like = "triffid_grove_z2",
    vision_levels = "blends_till_outlines",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "druid_giant_tree_empty_crown_nw", "druid_giant_tree_empty_crown_n",
        "druid_giant_tree_empty_crown_ne", "druid_giant_tree_empty_crown_w",
        "druid_giant_tree_empty_crown", "druid_giant_tree_empty_crown_e",
        "druid_giant_tree_empty_crown_sw", "druid_giant_tree_empty_crown_s",
        "druid_giant_tree_empty_crown_se",
    },
    name = ccb.content.text("great tree"),
    symbol = "F",
    color = "green",
    looks_like = "forest",
    vision_levels = "blends_till_outlines",
    see_cost = "high",
}
