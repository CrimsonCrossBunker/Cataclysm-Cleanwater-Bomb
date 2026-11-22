local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_e_safe_l",
    name = "safe",
    description = "A small, heavy, and near-unbreachable metal box with an electronic lock.  With a hacking tool and the right skills you might be able to crack it.",
    looks_like = "f_e_safe_c",
    symbol = "X",
    color = "light_gray",
    max_volume = "250 L",
    coverage = 30,
    move_cost_mod = -1,
    required_strength = 14,
    flags = { "TRANSPARENT", "CONTAINER", "SEALED", "PLACE_ITEM", "MOUNTABLE" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = "screeching metal!",
        failure_sound = "whump!",
        drops = {
            {
                item = "ch_steel_chunk",
                count = { 1, 5 },
            },
            {
                item = "scrap",
                count = { 1, 5 },
            },
            {
                item = "rock",
                count = { 1, 2 },
            },
        },
    },
    oxytorch = { result = "f_e_safe_o", duration = "14 seconds" },
    examine_handler = "w16b_tile_ex_aftershock_exoplanet_6524a6a6b6d3",
}
