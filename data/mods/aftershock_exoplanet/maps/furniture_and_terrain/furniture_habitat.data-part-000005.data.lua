local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_security_panel",
    name = "security override panel",
    description = "A slim wall mounted metal panel covering an electronic interface to manually override nearby security systems.",
    symbol = "e",
    color = "blue",
    move_cost_mod = 1,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = "smash!",
        failure_sound = "whump.",
        drops = {
            {
                item = "cable",
                count = { 1, 2 },
            },
            {
                item = "plastic_chunk",
                count = { 1, 2 },
            },
            {
                item = "scrap",
                count = { 1, 2 },
            },
            {
                item = "mc_steel_chunk",
                count = { 0, 1 },
            },
        },
    },
    examine_handler = "w16b_tile_ex_aftershock_exoplanet_c0eeb92bea86",
}

ccb.content.define_furniture {
    id = "f_security_panel_10",
    name = "security override panel",
    copy_from = "f_security_panel",
    examine_handler = "w16b_tile_ex_aftershock_exoplanet_d6559b6d06f7",
}
