local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "turret",
    durability = 400,
    damage_modifier = 80,
    location = "on_roof",
    categories = { "warfare" },
    requirements = { install = { duration = "100 s" }, removal = { duration = "50 s" } },
    flags = { "TURRET" },
    variants = { { symbols = "t", broken_symbols = "#" } },
}

-- This item is used as base for turrets generated at runtime. m249 is random 'safe' choice, actual item is set at runtime in vpart_info::finalize.
-- Generated at runtime
ccb.content.define_vehicle_part {
    id = "turret_generic",
    copy_from = "turret",
    item = "m249",
    looks_like = "mounted_m249",
    color = "magenta",
    broken_color = "magenta",
    breaks_into = {
        { item = "scrap", count = 6 },
        { item = "ch_steel_chunk", count = 5 },
        { item = "ch_steel_lump", count = 2 },
    },
    requirements = {},
}
