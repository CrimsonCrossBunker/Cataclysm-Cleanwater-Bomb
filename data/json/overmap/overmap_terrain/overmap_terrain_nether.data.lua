local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "nether_glass", "nether_glass_deep", "nether_glass_impassable", "nether_glass_imperial_road" },
    vision_levels = "always_full",
    name = ccb.content.text("abyss"),
    symbol = " ",
    color = "black",
    see_cost = "opaque",
    flags = { "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "void_spider_lair",
    vision_levels = "always_full",
    name = ccb.content.text("abyssal cavern"),
    symbol = " ",
    color = "black",
    see_cost = "opaque",
    flags = { "RISK_EXTREME", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "default_portal_storm_dungeon_overmap",
    copy_from = "nether_glass_impassable",
    name = ccb.content.text("somewhere"),
    symbol = ".",
    travel_cost = "basement",
    looks_like = "nether_glass",
    color = "black",
    see_cost = "none",
    extras = "default_portal_storm_dungeon_extras",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "portal_storm_dungeon_teleporter",
    copy_from = "nether_glass_impassable",
    name = ccb.content.text("elsewhere"),
    symbol = "T",
    travel_cost = "basement",
    looks_like = "nether_glass",
    color = "black",
    see_cost = "none",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}
