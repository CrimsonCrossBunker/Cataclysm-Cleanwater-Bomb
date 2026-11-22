local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_cryo_storage_o",
    name = ccb.content.text("unlocked cryogenic storage unit"),
    looks_like = "f_console",
    description = ccb.content.text("A small cabinet used to store objects for indefinite periods of time.  Forceful opening has interrupted the cryogenic process, so whatever is inside must be recovered quickly."),
    symbol = "9",
    color = "blue",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = 25,
    flags = { "ALARMED", "PLACE_ITEM", "CONTAINER" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 145,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 2, 8 } },
            { item = "plastic_chunk", count = { 20, 40 } },
            { item = "mc_steel_chunk", count = { 0, 3 } },
            { item = "cable", count = { 24, 47 } },
            { item = "RAM", count = { 0, 2 } },
            { item = "e_scrap", count = { 10, 20 } },
            { item = "circuit", count = { 2, 5 } },
            { item = "amplifier", count = { 0, 1 } },
            { item = "small_lcd_screen", count = 1 },
            { item = "power_supply", count = { 2, 5 } },
            { item = "scrap_copper", count = { 0, 2 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_ev_charger",
    name = ccb.content.text("automated charging station"),
    looks_like = "f_console",
    description = ccb.content.text("An automated charging console for electric vehicles."),
    symbol = "9",
    color = "blue",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = 25,
    flags = { "SEALED", "ALARMED", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 7,
        maximum_strength = 30,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        furniture = "f_ev_charger_o",
    },
}

ccb.content.define_furniture {
    id = "f_ev_charger_o",
    name = ccb.content.text("broken automated charging station"),
    looks_like = "f_console_broken",
    description = ccb.content.text("An automated charging console for electric vehicles.  It's broken.  This is not a good thing."),
    symbol = "9",
    color = "dark_gray",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = 20,
    flags = { "BLOCKSDOOR" },
    bash = {
        minimum_strength = 5,
        maximum_strength = 45,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 2, 8 } },
            { item = "plastic_chunk", count = { 20, 40 } },
            { item = "mc_steel_chunk", count = { 0, 3 } },
            { item = "cable", count = { 24, 47 } },
            { item = "RAM", count = { 0, 2 } },
            { item = "e_scrap", count = { 10, 20 } },
            { item = "circuit", count = { 2, 5 } },
            { item = "amplifier", count = { 0, 1 } },
            { item = "small_lcd_screen", count = 1 },
            { item = "power_supply", count = { 2, 5 } },
            { item = "scrap_copper", count = { 0, 2 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_cryo_storage_l",
    name = "cryogenic storage unit",
    description = "A small cabinet used to store objects for indefinite periods of time.  Maintaining cryogenic storage is expensive, so whatever is stowed inside is likely to be valuable.",
    looks_like = "f_console",
    symbol = "9",
    color = "blue",
    coverage = 40,
    move_cost_mod = -1,
    required_strength = 25,
    flags = { "SEALED", "PLACE_ITEM", "CONTAINER", "NO_SPOIL" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 145,
        sound = "metal screeching!",
        failure_sound = "clang!",
        drops = {
            {
                item = "scrap",
                count = { 2, 8 },
            },
            {
                item = "plastic_chunk",
                count = { 20, 40 },
            },
            {
                item = "mc_steel_chunk",
                count = { 0, 3 },
            },
            {
                item = "cable",
                count = { 24, 47 },
            },
            {
                item = "RAM",
                count = { 0, 2 },
            },
            {
                item = "e_scrap",
                count = { 10, 20 },
            },
            {
                item = "circuit",
                count = { 2, 5 },
            },
            {
                item = "amplifier",
                count = { 0, 1 },
            },
            { item = "small_lcd_screen", count = 1 },
            {
                item = "power_supply",
                count = { 2, 5 },
            },
            {
                item = "scrap_copper",
                count = { 0, 2 },
            },
        },
    },
    examine_handler = "w16b_tile_ex_aftershock_exoplanet_48d2ac0397b2",
}
