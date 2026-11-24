local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_fvat_empty",
    name = ccb.content.text("fermenting vat"),
    looks_like = "f_standing_tank",
    description = ccb.content.text("A sealable vat for fermenting vinegar and various alcoholic brews."),
    symbol = "O",
    color = "brown",
    move_cost_mod = -1,
    required_strength = -1,
    flags = { "NOITEM", "SEALED", "TRANSPARENT", "FLAMMABLE", "CONTAINER", "DONT_REMOVE_ROTTEN" },
    builtin_examine = "fvat_empty",
    deconstruct = {
        drops = {
            { item = "2x4", count = 14 },
            { item = "nail", charges = { 6, 12 } },
            { item = "sheet_metal_small", count = { 4, 10 } },
            { item = "scrap", count = { 5, 10 } },
        },
    },
    bash = {
        minimum_strength = 3,
        maximum_strength = 45,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "2x4", count = { 4, 8 } },
            { item = "nail", charges = { 4, 8 } },
            { item = "sheet_metal_small", count = { 2, 6 } },
            { item = "scrap", count = { 5, 10 } },
            { item = "splinter", count = 1 },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_bulletin",
    name = ccb.content.text("bulletin board"),
    description = ccb.content.text("A crude approximation of a 'real' bulletin board.  Good for pinning various notices for other survivors to read."),
    symbol = "6",
    color = "blue",
    move_cost_mod = -1,
    coverage = 75,
    required_strength = -1,
    flags = { "FLAMMABLE", "ORGANIC", "TRANSPARENT" },
    max_volume = "120 ml",
    builtin_examine = "bulletin_board",
    deconstruct = {
        drops = {
            { item = "stick", count = 6 },
            { item = "string_36", count = 1 },
            { item = "birchbark", count = { 2, 6 } },
        },
    },
    bash = {
        minimum_strength = 3,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        drops = {
            { item = "stick", count = { 0, 3 } },
            { item = "birchbark", count = { 2, 4 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_construction {
    id = "constr_innawood_bulletin",
    group = "build_innawood_bulletin_board",
    category = "FURN",
    required_skills = { { "fabrication", 0 } },
    duration = "20 m",
    components = {
        { { "stick", 6 }, { "stick_long", 3 } },
        { { "string_36", 1 }, { "cordage_36", 1 } },
        { { "birchbark", 6 }, { "willowbark", 6 }, { "tanbark", 6 }, { "alder_bark", 6 } },
    },
    pre_checks = "check_empty",
    post_terrain = "f_bulletin",
}
