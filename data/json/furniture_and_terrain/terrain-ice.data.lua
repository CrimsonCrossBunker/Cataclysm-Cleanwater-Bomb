local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_ice_sh_thin",
    name = ccb.content.text("thin ice"),
    description = ccb.content.text("A thin layer of ice covering shallow water.  It may not support much weight."),
    symbol = "/",
    color = "light_cyan",
    move_cost = 4,
    trap = "tr_thin_ice",
    builtin_examine = "thin_ice",
    connect_groups = "ICE",
    connects_to = "ICE",
    bash = {
        minimum_strength = 3,
        maximum_strength = 6,
        sound = ccb.content.text("crack!"),
        terrain = "t_water_sh",
    },
    flags = { "THIN_ICE", "TRANSPARENT", "FLAT", "PHASE_BACK", "SWIM_UNDER" },
}

ccb.content.define_terrain {
    id = "t_ice_sh_thick",
    name = ccb.content.text("thick ice"),
    description = ccb.content.text("A solid sheet of thick ice covering shallow water.  It should support weight."),
    symbol = "/",
    color = "cyan",
    move_cost = 2,
    trap = "tr_thick_ice",
    connect_groups = "ICE",
    connects_to = "ICE",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crack!"),
        terrain = "t_water_sh",
    },
    flags = { "THICK_ICE", "TRANSPARENT", "FLAT", "PHASE_BACK", "SWIM_UNDER" },
}

ccb.content.define_terrain {
    id = "t_ice_dp_thin",
    name = ccb.content.text("thin ice"),
    description = ccb.content.text("A thin layer of ice covering deep water.  It may break under weight."),
    symbol = "/",
    color = "light_cyan",
    move_cost = 4,
    trap = "tr_thin_ice",
    builtin_examine = "thin_ice",
    connect_groups = "ICE",
    connects_to = "ICE",
    bash = {
        minimum_strength = 3,
        maximum_strength = 6,
        sound = ccb.content.text("crack!"),
        terrain = "t_water_dp",
    },
    flags = { "THIN_ICE", "TRANSPARENT", "FLAT", "PHASE_BACK", "SWIM_UNDER" },
}

ccb.content.define_terrain {
    id = "t_ice_dp_thick",
    name = ccb.content.text("thick ice"),
    description = ccb.content.text("A thick sheet of ice covering deep water.  It should support weight, but danger remains below."),
    symbol = "/",
    color = "cyan",
    move_cost = 2,
    trap = "tr_thick_ice",
    connect_groups = "ICE",
    connects_to = "ICE",
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crack!"),
        terrain = "t_water_dp",
    },
    flags = { "THICK_ICE", "TRANSPARENT", "FLAT", "PHASE_BACK", "SWIM_UNDER" },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_terrain {
    id = "t_pseudo_phase",
    name = ccb.content.text_without_extraction("pseudo phase"),
    description = ccb.content.text_without_extraction("Placeholder terrain representing the original tile for PHASE_BACK behavior.  Should not be seen in-game."),
    symbol = ".",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "PSEUDO" },
}
