local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_security_panel_locked",
    name = ccb.content.text("burnt out security override panel"),
    symbol = "e",
    description = ccb.content.text("A slim wall mounted metal panel covering an electronic interface to manually override nearby security systems."),
    color = "blue",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "cable", count = { 1, 2 } },
            { item = "plastic_chunk", count = { 1, 2 } },
            { item = "scrap", count = { 1, 2 } },
            { item = "mc_steel_chunk", count = { 0, 1 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_e_safe_c",
    name = ccb.content.text("safe"),
    looks_like = "f_safe_c",
    description = ccb.content.text("A small, heavy, and near-unbreachable metal box with an electronic lock.  This one isn't actually locked, just closed."),
    symbol = "X",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 30,
    required_strength = 14,
    max_volume = "250 L",
    flags = { "TRANSPARENT", "CONTAINER", "SEALED", "PLACE_ITEM", "MOUNTABLE" },
    open = "f_e_safe_o",
    builtin_examine = "open_safe",
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("screeching metal!"),
        failure_sound = ccb.content.text("whump!"),
        drops = {
            { item = "ch_steel_chunk", count = { 1, 5 } },
            { item = "scrap", count = { 1, 5 } },
            { item = "rock", count = { 1, 2 } },
        },
    },
}
