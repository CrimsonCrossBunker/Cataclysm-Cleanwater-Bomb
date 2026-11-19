local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_string_dimension_pump",
    name = ccb.content.text("humming fluid pump"),
    looks_like = "t_machinery_heavy",
    description = ccb.content.text("A large tank connected to several pumps, driven by some unseen mechanism."),
    symbol = "0",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 80,
    required_strength = 14,
    flags = { "TRANSPARENT", "NOITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 150,
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 8, 16 } },
            { item = "pipe", count = { 3, 6 } },
            { item = "55gal_drum", count = { 0, 1 } },
            { item = "sheet_metal_small", count = { 5, 10 } },
            { item = "pipe_fittings", count = { 3, 6 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_string_dimension_pylon",
    name = ccb.content.text("humming column"),
    description = ccb.content.text("A floor-to-ceiling cylinder wrapped neatly and tightly in thick copper wire.  It has no markings, but the cables connected to the base suggest that it generates or receives some kind of power."),
    symbol = "O",
    color = "red",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = -1,
    flags = { "NOITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 400,
        explosive = 25,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 4, 16 } },
            { item = "ch_steel_chunk", count = { 1, 6 } },
            { item = "plutonium", count = { 0, 3 } },
            { item = "lead", count = { 12, 18 } },
            { item = "sheet_metal_small", count = { 10, 30 } },
            { item = "scrap_copper", count = { 12, 37 } },
            { item = "e_scrap", count = { 10, 20 } },
            { item = "string_dimension_computer", count = { 0, 1 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_string_dimension_pylon_inert",
    name = ccb.content.text("inert column"),
    description = ccb.content.text("A floor-to-ceiling cylinder wrapped neatly and tightly in thick copper wire.  It has no markings, but the cables connected to the base suggest that it generates or receives some kind of power.  Perhaps it once worked, but it is now still and silent."),
    symbol = "O",
    color = "red",
    move_cost_mod = -1,
    coverage = 50,
    required_strength = -1,
    flags = { "NOITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 4, 16 } },
            { item = "ch_steel_chunk", count = { 1, 6 } },
            { item = "plutonium", count = { 0, 3 } },
            { item = "lead", count = { 12, 18 } },
            { item = "sheet_metal_small", count = { 10, 30 } },
            { item = "scrap_copper", count = { 12, 37 } },
            { item = "e_scrap", count = { 10, 20 } },
            { item = "string_dimension_computer", count = { 0, 1 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_vent_inert",
    description = ccb.content.text("A metal vent on the floor."),
    copy_from = "f_vent_cold_air2_stream",
    symbol = "~",
    color = "light_gray",
}

ccb.content.define_furniture {
    id = "f_string_dimension_housing_imploded",
    name = ccb.content.text("imploded clump of metal"),
    description = ccb.content.text("An extremely dense ball of imploded metal."),
    symbol = "#",
    color = "dark_gray",
    move_cost_mod = -1,
    required_strength = -1,
    coverage = 100,
    flags = { "NOITEM", "BLOCKSDOOR" },
}

ccb.content.define_furniture {
    id = "f_tall_vent_pipe",
    looks_like = "f_vent_pipe",
    name = ccb.content.text("tall vent pipe"),
    description = ccb.content.text("A thick pipe for some sort of ventilation system.  It looks sturdy enough to climb."),
    symbol = "|",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT", "CLIMBABLE", "ALLOW_ON_OPEN_AIR" },
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
    id = "f_string_nuclear_fuel_cell",
    name = ccb.content.text("lead tube"),
    looks_like = "t_machinery_heavy",
    description = ccb.content.text("A massive lead tube covered in otherworldly symbols that you do not understand."),
    symbol = "|",
    color = "light_gray",
    coverage = 80,
    move_cost_mod = 6,
    max_volume = "800 L",
    required_strength = -1,
    flags = { "SEALED", "REDUCE_SCENT", "PERMEABLE", "CONTAINER", "FLAMMABLE" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 45,
        explosive = 10,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        furniture = "f_reactor_meltdown",
        drops = {
            { item = "scrap", count = { 4, 16 } },
            { item = "mc_steel_chunk", count = { 1, 6 } },
            { item = "uranium", count = { 10, 50 } },
            { item = "uran_cell", charges = { 10, 150 } },
            { item = "plutonium", count = { 0, 20 } },
            { item = "lead", count = { 12, 18 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_utility_shelf_string_warped",
    name = ccb.content.text("warped utility shelf"),
    symbol = "{",
    description = ccb.content.text("What was once a simple heavy-duty plastic and metal shelving unit has been cleaved into three pieces, now mysteriously floating in space in a stair-like pattern, disconnected entirely from each another."),
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 55,
    required_strength = -1,
    flags = { "PLACE_ITEM", "BLOCKSDOOR", "EASY_DECONSTRUCT", "TRANSPARENT", "SMALL_HIDE" },
    deconstruct = {
        drops = {
            { item = "sheet_metal_small", count = { 4, 6 } },
            { item = "plastic_chunk", count = { 2, 12 } },
            { item = "pipe", count = { 4, 8 } },
        },
    },
    max_volume = "1500 L",
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 4, 8 } },
            { item = "plastic_chunk", count = { 1, 6 } },
            { item = "sheet_metal_small", count = { 1, 4 } },
            { item = "pipe", count = 1 },
        },
    },
}

ccb.content.define_furniture {
    id = "f_metal_crate_o_string_warped",
    name = ccb.content.text("glowing metal crate"),
    description = ccb.content.text("While this box certainly resembles a large storage crate, its panels are impossibly thin planes of magenta light."),
    symbol = "X",
    color = "magenta",
    move_cost_mod = 5,
    coverage = 80,
    required_strength = -1,
    light_emitted = 40,
    light_color = { 255, 0, 255 },
    max_volume = "1000 L",
    flags = { "CONTAINER", "PLACE_ITEM", "NO_SIGHT", "HIDE_PLACE", "BLOCKSDOOR", "MOUNTABLE", "SMALL_HIDE" },
}
