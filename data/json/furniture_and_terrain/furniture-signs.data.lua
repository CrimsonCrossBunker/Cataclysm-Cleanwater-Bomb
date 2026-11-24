local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_bulletin",
    name = ccb.content.text("bulletin board"),
    description = ccb.content.text("A wide wooden frame with a sheet of corkboard inside.  Good for pinning various notices for other survivors to read."),
    symbol = "6",
    color = "blue",
    move_cost_mod = -1,
    coverage = 75,
    required_strength = -1,
    flags = { "FLAMMABLE", "ORGANIC", "TRANSPARENT", "FREE_TO_EXAMINE" },
    max_volume = "120 ml",
    builtin_examine = "bulletin_board",
    deconstruct = { drops = { { item = "2x4", count = 4 }, { item = "nail", charges = { 4, 8 } } } },
    bash = {
        minimum_strength = 3,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 4, 6 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_sign",
    name = ccb.content.text("sign"),
    symbol = "P",
    description = ccb.content.text("A simple signpost made of wood.  Basically two planks alongside each other nailed to another plank that holds them up."),
    color = "brown",
    builtin_examine = "sign",
    move_cost_mod = 1,
    coverage = 35,
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_ASH",
        "ORGANIC",
        "MOUNTABLE",
        "SIGN",
        "SIGN_ALWAYS",
        "FREE_TO_EXAMINE",
    },
    deconstruct = { drops = { { item = "2x4", count = 3 }, { item = "nail", charges = { 2, 5 } } } },
    bash = {
        minimum_strength = 6,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "2x4", count = { 1, 2 } },
            { item = "nail", charges = { 2, 4 } },
            { item = "splinter", count = 2 },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_sign_warning",
    name = ccb.content.text("warning sign"),
    symbol = "P",
    description = ccb.content.text("A triangular signpost painted white with a red border.  Designed to easily catch the eye, signs of this nature seldom display anything but bad news."),
    color = "red",
    builtin_examine = "sign",
    looks_like = "f_sign",
    move_cost_mod = 1,
    coverage = 35,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC", "MOUNTABLE", "SIGN", "SIGN_ALWAYS" },
    deconstruct = { drops = { { item = "2x4", count = 3 }, { item = "nail", charges = { 2, 5 } } } },
    bash = {
        minimum_strength = 6,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "2x4", count = { 1, 2 } },
            { item = "nail", charges = { 2, 4 } },
            { item = "splinter", count = 2 },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_bulletin_evac",
    name = ccb.content.text("evac shelter info board"),
    looks_like = "f_bulletin",
    description = ccb.content.text("A wide wooden frame surrounding a sheet of cork, on to which a number of full-page notices have been neatly tacked.  Most seem to provide emergency information, or instructions now woefully outdated considering the state of things, but a map pointing to the nearest refugee center catches your eye.  You should take a closer look."),
    symbol = "6",
    color = "blue",
    move_cost_mod = -1,
    coverage = 75,
    required_strength = -1,
    flags = { "FLAMMABLE", "ORGANIC", "TRANSPARENT", "FREE_TO_EXAMINE", "EASY_DECONSTRUCT" },
    max_volume = "120 ml",
    deconstruct = {
        furniture = "f_bulletin",
        drops = { { item = "paper", count = 4 } },
    },
    bash = {
        minimum_strength = 3,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "2x4", count = { 0, 3 } },
            { item = "nail", charges = { 4, 6 } },
            { item = "splinter", count = { 1, 4 } },
            { item = "flyer_evac", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    examine_handler = "examine_f_bulletin_evac",
}

-- 36x36 inch aluminum sign on 7 feet U-channel post (post weight is 3 pound per foot, but we don't really have any sort of beams, so pipe is used instead), mounted using 2 bolts
ccb.content.define_furniture {
    id = "f_sign_stop",
    name = ccb.content.text("stop sign"),
    symbol = "P",
    description = ccb.content.text("An octagonal red sign on a long metal pole, marked with the word STOP."),
    color = "red",
    builtin_examine = "sign",
    move_cost_mod = 1,
    coverage = 10,
    rotates_to = "PAVEMENT",
    required_strength = -1,
    flags = { "TRANSPARENT", "NO_SELF_CONNECT" },
    deconstruct = {
        drops = {
            { item = "sheet_aluminum", count = 2 },
            { item = "pipe", count = 4 },
            { item = "nuts_bolts", count = 2 },
        },
    },
    bash = {
        minimum_strength = 10,
        maximum_strength = 20,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
    },
}
