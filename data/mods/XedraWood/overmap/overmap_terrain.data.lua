local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "xedrawood_scenario_wise_one_hut" },
    name = ccb.content.text("dwelling"),
    copy_from = "cabin_7",
}

ccb.content.define_overmap_terrain {
    id = { "xedrawood_scenario_wise_one_hut_roof" },
    copy_from = "cabin_roof_7",
}

ccb.content.define_overmap_terrain {
    id = "forest_tomb",
    name = ccb.content.text("ancient tomb"),
    symbol = "T",
    color = "brown",
    looks_like = "cemetery_small",
    see_cost = "spaced_high",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = "forest_tomb_roof",
    copy_from = "forest_tomb",
    name = ccb.content.text("ancient tomb roof"),
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "forest_tomb_bottom",
    copy_from = "forest_tomb",
    name = ccb.content.text("ancient tomb depths"),
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = { "xedrawood_ancient_temple", "xedrawood_ancient_temple_above", "xedrawood_ancient_temple_above2" },
    copy_from = "highland_crossroads_temple",
}

ccb.content.define_overmap_terrain {
    id = "ancient_road",
    copy_from = "highland_road",
}

ccb.content.define_overmap_terrain {
    id = "ruined_tower_basement",
    symbol = "T",
    color = "c_blue",
    see_cost = "high",
    flags = { "KNOWN_UP" },
    looks_like = "magic_academy_basement",
    vision_levels = "underground_dirt",
    travel_cost = "basement",
}

ccb.content.define_overmap_terrain {
    id = "ruined_tower_ground",
    name = ccb.content.text("ruined tower"),
    symbol = "T",
    color = "c_blue",
    looks_like = "lake_retreat_ground",
    see_cost = "high",
    vision_levels = "isolated_tower",
    travel_cost = "structure",
}

ccb.content.define_overmap_terrain {
    id = { "ruined_tower_z1", "ruined_tower_z2", "ruined_tower_z3", "ruined_tower_z4", "ruined_tower_z5" },
    name = ccb.content.text("ruined tower"),
    symbol = "T",
    color = "blue",
    looks_like = "lake_retreat_z1",
    see_cost = "all_clear",
    vision_levels = "isolated_tower",
    travel_cost = "roof",
}

ccb.content.define_overmap_terrain {
    id = "pillar_of_flesh",
    name = ccb.content.text("pillar of flesh"),
    vision_levels = "natural_outcropping",
    copy_from = "corpse_bowels_empty_edge",
    looks_like = "corpse_surface",
    flags = { "RISK_HIGH" },
    symbol = "T",
}

ccb.content.define_overmap_terrain {
    id = "temple_of_flesh",
    copy_from = "corpse_bowels_empty_edge",
    vision_levels = "natural_outcropping",
    name = ccb.content.text("temple of flesh"),
    symbol = "M",
    color = "blue",
    looks_like = "corpse_tentacle_surface_entry",
    flags = { "RISK_HIGH", "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = {
        "corpse_bowels_neck_right", "corpse_bowels_neck_left", "corpse_bowels_neck_edge_center",
        "corpse_bowels_rcorner", "corpse_bowels_lcorner", "corpse_bowels_empty_edge",
    },
    vision_levels = "underground_dirt",
    name = ccb.content.text("cathedral of flesh narthex"),
    symbol = "O",
    color = "light_red",
    see_cost = "full_high",
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = { "corpse_bowels_mid" },
    vision_levels = "underground_dirt",
    name = ccb.content.text("cathedral of flesh narthex"),
    symbol = "O",
    color = "light_red",
    see_cost = "full_high",
    flags = { "RISK_HIGH", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_tentacle",
    copy_from = "corpse_bowels_empty_edge",
    name = ccb.content.text("cathedral of flesh transept"),
    symbol = "|",
    color = "light_blue",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_tentacle_entry",
    copy_from = "corpse_bowels_empty_edge",
    name = ccb.content.text("cathedral of flesh transept"),
    symbol = "M",
    color = "blue",
    flags = { "RISK_HIGH", "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = "corpse_tentacle_surface_entry",
    copy_from = "corpse_bowels_empty_edge",
    vision_levels = "natural_outcropping",
    name = ccb.content.text("cathedral of flesh"),
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
    name = ccb.content.text("cathedral of flesh nave"),
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
    name = ccb.content.text("cathedral of flesh sanctuary"),
    color = "red",
    symbol = "H",
}

ccb.content.define_overmap_terrain {
    id = {
        "hollow_village1", "hollow_village2", "hollow_village3", "hollow_village4", "hollow_village5",
        "hollow_village6", "hollow_village7", "hollow_village8", "hollow_village9",
    },
    name = ccb.content.text("small village"),
    vision_levels = "hollow_village",
    symbol = "v",
    color = "red",
    see_cost = "high",
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = {
        "hollow_village_zomb_1", "hollow_village_zomb_2", "hollow_village_zomb_3",
        "hollow_village_zomb_4", "hollow_village_zomb_5", "hollow_village_zomb_6",
        "hollow_village_zomb_7", "hollow_village_zomb_8", "hollow_village_zomb_9",
    },
    name = ccb.content.text("overrun village"),
    vision_levels = "zombie_village",
    symbol = "v",
    color = "red",
    see_cost = "high",
    flags = { "RISK_HIGH" },
}
