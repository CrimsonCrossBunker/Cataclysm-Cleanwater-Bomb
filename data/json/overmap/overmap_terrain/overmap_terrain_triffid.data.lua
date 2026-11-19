local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = "triffid_grove",
    name = ccb.content.text("triffid grove"),
    copy_from = "generic_forest",
    vision_levels = "unusual_structure",
    symbol = "T",
    color = "light_red",
    see_cost = "high",
    monster_density = 2,
    flags = { "KNOWN_UP", "KNOWN_DOWN", "RISK_EXTREME", "REQUIRES_PREDECESSOR" },
}

ccb.content.define_overmap_terrain {
    vision_levels = "underground_dirt",
    id = {
        "triffid_roots", "triffid_rootss", "triffid_rootsn", "triffid_rootse", "triffid_rootsw",
        "triffid_rootsen", "triffid_rootsnw", "triffid_rootssw", "triffid_rootsse",
    },
    name = ccb.content.text("triffid roots"),
    symbol = "T",
    color = "light_red",
    see_cost = "full_high",
    monster_density = 2,
    spawns = { group = "GROUP_TRIFFID", population = { 40, 45 }, chance = 80 },
    flags = { "KNOWN_UP", "KNOWN_DOWN", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "triffid_finale",
    vision_levels = "underground_dirt",
    name = ccb.content.text("triffid heart"),
    symbol = "T",
    color = "red",
    see_cost = "full_high",
    monster_density = 2,
    spawns = { group = "GROUP_TRIFFID_HEARTGUARDS", population = { 50, 60 }, chance = 80 },
    flags = { "KNOWN_UP", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = { "triffid_grove_z3", "triffid_grove_z2" },
    vision_levels = "unusual_structure",
    name = ccb.content.text("triffid grove trunk"),
    symbol = "T",
    color = "light_red",
    see_cost = "full_high",
    flags = { "KNOWN_UP", "KNOWN_DOWN", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "triffid_grove_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("triffid grove roof"),
    symbol = "T",
    color = "light_red",
    see_cost = "none",
    flags = { "KNOWN_DOWN", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "triffid_field",
    vision_levels = "unusual_structure",
    name = ccb.content.text("vibrant field"),
    copy_from = "generic_forest",
    symbol = ".",
    color = "green",
    see_cost = "spaced_high",
    monster_density = 2,
    flags = { "REQUIRES_PREDECESSOR" },
}
