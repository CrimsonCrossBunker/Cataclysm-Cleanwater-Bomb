local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "corpse_surface",
    name = ccb.content.text("monster corpse"),
    vision_levels = "natural_outcropping",
    copy_from = "corpse_bowels_empty_edge",
    flags = { "RISK_HIGH", "REQUIRES_PREDECESSOR" },
    symbol = "T",
}

ccb.content.define_overmap_terrain {
    id = {
        "corpse_bowels_neck_right", "corpse_bowels_neck_left", "corpse_bowels_neck_edge_center",
        "corpse_bowels_rcorner", "corpse_bowels_lcorner", "corpse_bowels_empty_edge",
    },
    vision_levels = "underground_dirt",
    name = ccb.content.text("monster corpse bowels"),
    symbol = "O",
    color = "light_red",
    see_cost = "full_high",
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = { "corpse_bowels_mid" },
    vision_levels = "underground_dirt",
    name = ccb.content.text("monster corpse bowels"),
    symbol = "O",
    color = "light_red",
    see_cost = "full_high",
    flags = { "RISK_HIGH", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_tentacle",
    copy_from = "corpse_bowels_empty_edge",
    name = ccb.content.text("monster corpse tentacle"),
    symbol = "|",
    color = "light_blue",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_tentacle_entry",
    copy_from = "corpse_bowels_empty_edge",
    name = ccb.content.text("monster corpse tentacle"),
    symbol = "M",
    color = "blue",
    flags = { "RISK_HIGH", "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_tentacle_surface_entry",
    copy_from = "corpse_bowels_empty_edge",
    vision_levels = "natural_outcropping",
    name = ccb.content.text("monster corpse"),
    symbol = "M",
    color = "blue",
    flags = { "RISK_HIGH", "KNOWN_DOWN", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_bowels_tentacle_edge",
    copy_from = "corpse_bowels_empty_edge",
    color = "red",
    symbol = "E",
}

ccb.content.define_overmap_terrain {
    id = { "corpse_neck", "corpse_neck_center" },
    copy_from = "corpse_bowels_empty_edge",
    name = ccb.content.text("monster corpse neck"),
    color = "red",
    symbol = "N",
}

ccb.content.define_overmap_terrain {
    id = {
        "corpse_head", "corpse_brain", "corpse_under_brain", "corpse_head_edge", "corpse_head_fin",
        "corpse_head_lcorner", "corpse_head_rcorner", "corpse_head_neck_l", "corpse_head_neck_r",
        "corpse_head_neck_center", "corpse_head_neck_l_decap", "corpse_head_neck_r_decap",
        "corpse_head_neck_center_decap",
    },
    copy_from = "corpse_bowels_empty_edge",
    name = ccb.content.text("monster corpse head"),
    color = "red",
    symbol = "H",
}
