local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "fema_road",
    vision_levels = "large_pavement",
    name = ccb.content.text("FEMA camp road"),
    color = "dark_gray",
    see_cost = "none",
    spawns = { group = "GROUP_ZOMBIE", population = { 6, 12 }, chance = 100 },
    travel_cost = "road",
    flags = { "LINEAR" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "fema_housing",
    vision_levels = "isolated_camp",
    name = ccb.content.text("FEMA camp housing"),
    symbol = "H",
    color = "blue",
    see_cost = "medium",
    spawns = { group = "GROUP_ZOMBIE", population = { 6, 12 }, chance = 100 },
    flags = { "SOURCE_FOOD", "RISK_EXTREME", "GENERIC_LOOT", "SOURCE_COOKING" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "fema_military_building",
    vision_levels = "isolated_building",
    name = ccb.content.text("FEMA camp outpost"),
    symbol = "M",
    color = "red",
    see_cost = "medium",
    spawns = { group = "GROUP_MIL_BASE", population = { 8, 14 }, chance = 100 },
    flags = { "RISK_EXTREME", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "fema_storage",
    vision_levels = "isolated_building",
    name = ccb.content.text("FEMA camp storage"),
    symbol = "S",
    color = "light_blue",
    see_cost = "medium",
    spawns = { group = "GROUP_VANILLA_DORMANT", population = { 3, 8 }, chance = 100 },
    flags = { "RISK_EXTREME", "GENERIC_LOOT", "SOURCE_COOKING", "SOURCE_FOOD" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "fema_entrance",
    vision_levels = "isolated_building",
    name = ccb.content.text("FEMA camp entrance checkpoint"),
    symbol = "S",
    color = "light_blue",
    see_cost = "medium",
    spawns = { group = "GROUP_MIL_BASE", population = { 6, 16 }, chance = 100 },
    flags = { "RISK_EXTREME" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "fema_bus",
    vision_levels = "large_pavement",
    name = ccb.content.text("FEMA camp bus stop"),
    symbol = "B",
    color = "dark_gray",
    see_cost = "medium",
    spawns = { group = "GROUP_VANILLA_DORMANT", population = { 6, 16 }, chance = 100 },
    flags = { "RISK_EXTREME" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    abstract = "shelter_abstract",
    symbol = "+",
    color = "white",
    vision_levels = "isolated_building",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "shelter", "shelter_unfinished" },
    name = ccb.content.text("evac shelter A-23"),
    copy_from = "shelter_abstract",
    flags = { "KNOWN_DOWN", "SOURCE_PEOPLE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "shelter_roof",
    name = ccb.content.text("evac shelter roof A-23"),
    copy_from = "shelter_abstract",
}

ccb.content.define_overmap_terrain {
    id = { "shelter_under", "shelter_under_unfinished" },
    name = ccb.content.text("evac shelter basement A-23"),
    copy_from = "shelter_abstract",
    flags = { "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = "lmoe",
    name = ccb.content.text("LMOE shelter"),
    symbol = "+",
    color = "red",
    vision_levels = "natural_outcropping",
    see_cost = "spaced_high",
    flags = { "KNOWN_DOWN", "SOURCE_PEOPLE", "SOURCE_SAFETY", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "lmoe_under",
    name = ccb.content.text("LMOE shelter"),
    vision_levels = "underground_dirt",
    symbol = "+",
    color = "red",
    see_cost = "full_high",
    spawns = { group = "GROUP_PREPPER_HOUSE", population = { 2, 12 }, chance = 50 },
    flags = { "KNOWN_UP", "SOURCE_PEOPLE", "SOURCE_SAFETY", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "lmoe_under_empty_prepperquest",
    name = ccb.content.text("LMOE shelter"),
    vision_levels = "underground_dirt",
    symbol = "+",
    color = "red",
    see_cost = "full_high",
    flags = { "KNOWN_UP", "SOURCE_PEOPLE", "SOURCE_SAFETY", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "cabin_prepper_shelter",
    name = ccb.content.text("LMOE shelter"),
    vision_levels = "underground_dirt",
    symbol = "+",
    color = "red",
    see_cost = "full_high",
    flags = { "KNOWN_DOWN", "RISK_HIGH", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "bunker",
    name = ccb.content.text("military bunker"),
    symbol = "B",
    color = "red",
    vision_levels = "isolated_building",
    see_cost = "full_high",
    flags = { "KNOWN_DOWN", "RISK_EXTREME", "SOURCE_WEAPON", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    id = "bunker_basement_1",
    name = ccb.content.text("military bunker"),
    symbol = "B",
    color = "red",
    vision_levels = "isolated_building",
    see_cost = "high",
    flags = { "KNOWN_UP", "RISK_EXTREME", "SOURCE_WEAPON", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    id = "bunker_roof",
    name = ccb.content.text("military bunker"),
    symbol = "B",
    color = "red",
    vision_levels = "isolated_building",
    see_cost = "none",
    flags = { "RISK_EXTREME", "SOURCE_WEAPON", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    id = { "outpost", "outpost_parking" },
    name = ccb.content.text("military outpost"),
    symbol = "M",
    color = "red",
    vision_levels = "isolated_building",
    see_cost = "high",
    extras = "build",
    flags = { "RISK_EXTREME", "SOURCE_WEAPON", "SOURCE_AMMO" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "outpost_roof" },
    name = ccb.content.text("military outpost roof"),
    symbol = "M",
    color = "red",
    vision_levels = "isolated_building",
    see_cost = "none",
    extras = "build",
}

ccb.content.define_overmap_terrain {
    id = { "silo_roof", "silo", "silo_1", "silo_2", "silo_3", "silo_4", "silo_finale" },
    name = ccb.content.text("missile silo"),
    symbol = "0",
    color = "red",
    vision_levels = "open_land",
    see_cost = "medium",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = {
        "ws_fire_lookout_tower_base", "ws_fire_lookout_tower_f1", "ws_fire_lookout_tower_f2",
        "ws_fire_lookout_tower_f3", "ws_fire_lookout_tower_f4", "ws_fire_lookout_tower_f5",
    },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("fire lookout tower"),
    symbol = "T",
    vision_levels = "isolated_tower",
    color = "red",
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "ws_survivor_bunker_f0", "ws_survivor_bunker_f-1" },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "blends_till_details",
    name = ccb.content.text("survivor's bunker"),
    symbol = "b",
    color = "green",
    flags = { "SOURCE_SAFETY", "SOURCE_PEOPLE" },
}

ccb.content.define_overmap_terrain {
    id = "ws_survivor_camp",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("survivor's camp"),
    symbol = "c",
    color = "brown",
    flags = { "SOURCE_SAFETY", "SOURCE_PEOPLE" },
}

ccb.content.define_overmap_terrain {
    id = {
        "helipad_nw", "helipad_ne", "helipad_sw", "helipad_se", "helipad2f_nw", "helipad2f_ne",
        "helipad2f_sw", "helipad2f_se", "helipad_roof_nw", "helipad_roof_ne", "helipad_roof_sw",
        "helipad_roof_se", "mil_base_7i",
    },
    name = ccb.content.text("military helipad"),
    vision_levels = "large_building",
    symbol = "H",
    color = "red",
    see_cost = "high",
    flags = { "SOURCE_FUEL", "SOURCE_GUN", "SOURCE_VEHICLES", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = {
        "mil_base_2d", "mil_base_2e", "mil_base_2f", "mil_base_2g", "mil_base_3d", "mil_base_3e",
        "mil_base_3f", "mil_base_3g", "mil_base_3h", "mil_base_5c", "mil_base_5d", "mil_base_5e",
        "mil_base_5g", "mil_base_5h", "mil_base_5i", "mil_base_6c", "mil_base_6d", "mil_base_6e",
        "mil_base_6i", "mil_base_7c", "mil_base_7d", "mil_base_7e", "mil_base_7f", "mil_base_8e",
    },
    name = ccb.content.text("military base"),
    vision_levels = "large_building",
    symbol = "M",
    color = "red",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "mil_base_1a", "mil_base_1c", "mil_base_1d", "mil_base_1e", "mil_base_1f", "mil_base_1h",
        "mil_base_1i", "mil_base_1j", "mil_base_2a", "mil_base_2b", "mil_base_2c", "mil_base_2h",
        "mil_base_2i", "mil_base_2j", "mil_base_2k", "mil_base_3a", "mil_base_3c", "mil_base_3j",
        "mil_base_3k", "mil_base_5k", "mil_base_6b", "mil_base_6k", "mil_base_7b", "mil_base_7k",
        "mil_base_8a", "mil_base_8c", "mil_base_8d", "mil_base_8i", "mil_base_8j",
    },
    name = ccb.content.text("military base"),
    vision_levels = "open_land",
    symbol = ",",
    color = "brown",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "mil_base_2d1", "mil_base_2e1", "mil_base_2f1", "mil_base_2g1", "mil_base_3d1", "mil_base_3e1",
        "mil_base_3f1", "mil_base_3g1", "mil_base_3h1", "mil_base_5c1", "mil_base_5d1", "mil_base_5e1",
        "mil_base_5g1", "mil_base_5h1", "mil_base_5i1", "mil_base_6c1", "mil_base_6d1", "mil_base_6e1",
        "mil_base_6i1", "mil_base_7c1", "mil_base_7d1", "mil_base_7e1", "mil_base_7f1", "mil_base_8e1",
        "mil_base_1b2", "mil_base_2b2", "mil_base_3b2", "mil_base_4b2", "mil_base_5b2", "mil_base_6b2",
        "mil_base_7b2", "mil_base_8b2", "mil_base_1g2", "mil_base_2g2", "mil_base_3g2", "mil_base_8g2",
        "mil_base_1k2", "mil_base_2k2", "mil_base_3k2", "mil_base_4k2", "mil_base_8k2",
    },
    name = ccb.content.text("military base roof"),
    symbol = "M",
    vision_levels = "roof_or_air",
    color = "red",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "mil_base_tunnels_a", "mil_base_tunnels_b", "mil_base_tunnels_c", "mil_base_tunnels_d",
        "mil_base_tunnels_e", "mil_base_tunnels_f", "mil_base_tunnels_g", "mil_base_tunnels_h",
        "mil_base_tunnels_i",
    },
    name = ccb.content.text("military base tunnels"),
    vision_levels = "underground_dirt",
    symbol = "M",
    color = "red",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "mil_base_1b", "mil_base_1g", "mil_base_1k", "mil_base_3b", "mil_base_4k", "mil_base_5b",
        "mil_base_8b", "mil_base_8g", "mil_base_8k", "mil_base_1b1", "mil_base_1g1", "mil_base_1k1",
        "mil_base_3b1", "mil_base_4k1", "mil_base_5b1", "mil_base_8b1", "mil_base_8g1", "mil_base_8k1",
    },
    name = ccb.content.text("military base watchtower"),
    vision_levels = "isolated_tower",
    symbol = "W",
    color = "dark_gray",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "mil_base_3i", "mil_base_3i1", "mil_base_3i2", "mil_base_3i3", "mil_base_3i4" },
    name = ccb.content.text("military base radio tower"),
    vision_levels = "isolated_tower",
    symbol = "X",
    color = "light_gray",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "mil_base_5a", "mil_base_6a", "mil_base_7a", "mil_base_6h", "mil_base_7h", "mil_base_8h",
        "mil_base_8f", "mil_base_6g", "mil_base_7g",
    },
    name = ccb.content.text("military base"),
    symbol = "_",
    vision_levels = "large_pavement",
    color = "dark_gray",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_mil_base_minefield",
    name = ccb.content.text("military base perimeter"),
    vision_levels = "open_land",
    color = "light_gray",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "mil_base_minefield_nw",
    copy_from = "generic_mil_base_minefield",
    symbol = "┌",
}

ccb.content.define_overmap_terrain {
    id = { "mil_base_minefield_s", "mil_base_minefield_n" },
    copy_from = "generic_mil_base_minefield",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = "mil_base_minefield_ne",
    copy_from = "generic_mil_base_minefield",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "mil_base_minefield_e", "mil_base_minefield_w" },
    copy_from = "generic_mil_base_minefield",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = "mil_base_minefield_se",
    copy_from = "generic_mil_base_minefield",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = "mil_base_minefield_sw",
    copy_from = "generic_mil_base_minefield",
    symbol = "└",
}

ccb.content.define_overmap_terrain {
    id = "mil_base_minefield_gate_right",
    copy_from = "generic_mil_base_minefield",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = "mil_base_minefield_gate_left",
    copy_from = "generic_mil_base_minefield",
    symbol = "┌",
}
