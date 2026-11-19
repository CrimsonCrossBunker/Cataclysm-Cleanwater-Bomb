local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_cellphone_booster",
    name = ccb.content.text("cell phone signal booster"),
    description = ccb.content.text("A specialized piece of equipment that receives phone signals and amplifies them to reach further destinations with more clarity.  Now that there's no longer signals for them to boost, they're only good for parts."),
    symbol = ":",
    color = "white",
    move_cost_mod = -2,
    required_strength = 10,
    flags = { "TRANSPARENT", "PLACE_ITEM", "ALLOW_ON_OPEN_AIR" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 10,
        sound = ccb.content.text("whack!"),
        failure_sound = ccb.content.text("womp!"),
        drops = {
            { item = "e_scrap", count = { 1, 6 } },
            { item = "plastic_chunk", count = { 1, 2 } },
            { item = "scrap", count = { 1, 6 } },
            { item = "antenna", count = { 1, 2 } },
        },
    },
    deconstruct = {
        drops = {
            { item = "scrap", count = { 4, 6 } },
            { item = "plastic_chunk", count = { 1, 2 } },
            { item = "circuit", count = 1 },
            { item = "cable", count = { 4, 5 } },
            { item = "power_supply", chance = 50 },
            { item = "antenna", count = 2 },
            { item = "pipe", count = 1 },
            { item = "amplifier", count = 1 },
        },
    },
}

ccb.content.define_furniture {
    id = "f_small_satellite_dish",
    name = ccb.content.text("satellite dish"),
    description = ccb.content.text("A small sheet metal disc designed to receive radio waves from orbital satellites.  Satellites that will assuredly continue to orbit, with nothing to broadcast."),
    symbol = "(",
    color = "light_gray",
    move_cost_mod = -2,
    required_strength = 10,
    flags = { "TRANSPARENT", "NOITEM" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 10,
        sound = ccb.content.text("whack!"),
        failure_sound = ccb.content.text("womp!"),
        drops = {
            { item = "scrap", count = { 4, 6 } },
            { item = "plastic_chunk", count = { 4, 12 } },
            { item = "cable", count = { 4, 5 } },
            { item = "pipe", count = { 1, 4 } },
            { item = "power_supply", chance = 50 },
        },
    },
}

ccb.content.define_furniture {
    id = "f_chimney",
    name = ccb.content.text("chimney crown"),
    description = ccb.content.text("The top of a brick chimney, the opening is stained black with soot.  Definitely too narrow to fit in."),
    symbol = "#",
    color = "red",
    move_cost_mod = 2,
    coverage = 35,
    required_strength = -1,
    flags = { "MINEABLE" },
    deconstruct = { drops = { { item = "sheet_metal", count = 2 }, { item = "brick", count = 30 } } },
    bash = {
        minimum_strength = 15,
        maximum_strength = 25,
        sound = ccb.content.text("whack!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "brick", count = { 5, 30 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_furniture {
    id = "f_TV_antenna",
    name = ccb.content.text("TV antenna"),
    description = ccb.content.text("A simple metal antenna to increase the reception of non-cable television broadcasts.  Almost wholly obsolete for years, only being good for parts isn't new for this item."),
    symbol = "#",
    color = "light_gray",
    move_cost_mod = 2,
    required_strength = 8,
    flags = { "TRANSPARENT" },
    deconstruct = {
        drops = {
            { item = "pipe", count = 6 },
            { item = "lc_steel_chunk", count = 2 },
            { item = "cable", count = 4 },
        },
    },
    bash = {
        minimum_strength = 6,
        maximum_strength = 10,
        sound = ccb.content.text("clang!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "pipe", count = { 1, 6 } },
            { item = "scrap", count = { 2, 6 } },
            { item = "cable", count = { 1, 3 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_vent_pipe",
    name = ccb.content.text("vent pipe"),
    description = ccb.content.text("A sort of chimney spout for a building's internal ventilation system, this can be used for circulation, venting fumes, and other such functions."),
    symbol = "|",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    deconstruct = { drops = { { item = "pipe", count = 2 }, { item = "lc_steel_chunk", count = 2 } } },
    bash = {
        minimum_strength = 10,
        maximum_strength = 15,
        sound = ccb.content.text("whack!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "pipe", count = { 1, 2 } }, { item = "scrap", count = { 1, 3 } } },
    },
}

ccb.content.define_furniture {
    id = "f_wind_vane",
    name = ccb.content.text("wind vane"),
    description = ccb.content.text("A metal fin that swivels around a central pivot, indicating the direction of prevailing wind."),
    symbol = ">",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 10,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    deconstruct = {
        drops = {
            { item = "pipe", count = 1 },
            { item = "pipe_fittings", count = 1 },
            { item = "lc_wire", count = 4 },
            { item = "sheet_metal_small", count = 2 },
        },
    },
    bash = {
        minimum_strength = 10,
        maximum_strength = 15,
        sound = ccb.content.text("whack!"),
        failure_sound = ccb.content.text("whump!"),
        drops = { { item = "scrap", count = { 1, 3 } }, { item = "sheet_metal_small", count = { 0, 1 } } },
    },
}

ccb.content.define_furniture {
    id = "f_roof_turbine_vent",
    name = ccb.content.text("roof turbine vent"),
    description = ccb.content.text("A rotary wind turbine that will catch the wind and pull out air from inside.  It is most commonly used for improving air circulation, particularly in poorly-ventilated areas like attics."),
    symbol = "&",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    deconstruct = {
        drops = { { item = "sheet_metal_small", count = 6 }, { item = "lc_steel_chunk", count = 2 } },
    },
    bash = {
        minimum_strength = 8,
        maximum_strength = 12,
        sound = ccb.content.text("whack!"),
        failure_sound = ccb.content.text("clang!"),
        drops = { { item = "sheet_metal_small", count = { 1, 5 } }, { item = "scrap", count = { 3, 6 } } },
    },
}
