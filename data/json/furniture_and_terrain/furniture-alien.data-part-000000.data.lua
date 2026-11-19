local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_alien_tendril",
    name = ccb.content.text("glowing tendril"),
    description = ccb.content.text("A willowy tendril growing from the floor, gently waving back and forth.  A faint light spills from it."),
    symbol = "i",
    color = "blue",
    move_cost_mod = 4,
    coverage = 10,
    light_emitted = 15,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 8,
        maximum_strength = 20,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump!"),
        furniture = "f_alien_scar",
        drops = { { item = "fetid_goop", count = { 3, 5 }, chance = 100 } },
    },
}

ccb.content.define_furniture {
    id = "f_alien_anemone",
    name = ccb.content.text("wafting anemone"),
    description = ccb.content.text("A fleshy white protuberance growing from the floor, with a cluster of tendrils protruding from it.  It looks almost exactly like a sea anemone, even waving gently as though underwater."),
    symbol = "V",
    color = "white",
    move_cost_mod = 6,
    coverage = 30,
    required_strength = -1,
    light_emitted = 3,
    flags = { "TRANSPARENT" },
    emissions = { "emit_hot_air_migo_seep" },
    bash = {
        minimum_strength = 13,
        maximum_strength = 26,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump!"),
        furniture = "f_alien_scar",
        drops = { { item = "fetid_goop", count = { 3, 7 }, chance = 100 } },
    },
}

-- TODO: Make a custom toxic gas emission that is not visible to the player
ccb.content.define_furniture {
    id = "f_alien_gasper",
    name = ccb.content.text("gasping tube"),
    description = ccb.content.text("A meaty green stalactite with a thickened hide like that of a starfish, extending from the floor to the ceiling.  In the center is a series of ports somewhat like mouths, from which pour bursts of a vile-smelling gas."),
    symbol = "{",
    color = "green",
    move_cost_mod = 6,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_migo_atmosphere", "emit_hot_air_migo_blast" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 60,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump!"),
        furniture = "f_alien_scar",
        drops = { { item = "fetid_goop", count = { 15, 25 }, chance = 100 } },
    },
}

-- TODO: Make a custom toxic gas emission that is not visible to the player
ccb.content.define_furniture {
    id = "f_alien_zapper",
    name = ccb.content.text("twitching frond"),
    description = ccb.content.text("A spine resembling moth antennae juts from the ground, swaying gently in the air.  Every so often, a cascade of energy arcs along it and discharges into the ceiling."),
    symbol = "F",
    color = "light_blue",
    move_cost_mod = 4,
    coverage = 20,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_glimmer", "emit_shock_burst" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 60,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump!"),
        furniture = "f_alien_scar",
    },
}

-- TODO: Make a custom toxic gas emission that is not visible to the player
ccb.content.define_furniture {
    id = "f_alien_scar",
    name = ccb.content.text("scarred lump"),
    description = ccb.content.text("A pile of nondescript alien flesh, twitching and belching strange gases out of injured orifices."),
    symbol = "{",
    color = "green",
    move_cost_mod = 6,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    emissions = { "emit_hot_air_migo_seep", "emit_shock_burst" },
    bash = {
        minimum_strength = 250,
        maximum_strength = 600,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("splat!"),
        drops = { { item = "fetid_goop", count = { 6, 13 }, chance = 100 } },
    },
}

ccb.content.define_furniture {
    id = "f_alien_pod",
    name = ccb.content.text("slimy pod"),
    description = ccb.content.text("A slick, translucent pod suspended on a thin stalk.  It is covered in a thick mucus, obscuring whatever is floating in the gel-like substance inside."),
    symbol = "0",
    color = "magenta",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 25,
        maximum_strength = 60,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "fetid_goop", count = { 5, 10 }, chance = 100 } },
    },
}

ccb.content.define_furniture {
    id = "f_alien_pod_organ",
    name = ccb.content.text("organ pod"),
    description = ccb.content.text("A translucent pod suspended on a thin stalk.  Inside you can see the dimly outlined shape of human organs, floating in some kind of preservative goo."),
    symbol = "0",
    color = "yellow",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    light_emitted = 3,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 25,
        maximum_strength = 60,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump."),
    },
}

ccb.content.define_furniture {
    id = "f_alien_pod_resin",
    name = ccb.content.text("resin pod"),
    description = ccb.content.text("A translucent pod suspended on a thin stalk.  Inside is a clean, clear, resinous-looking fluid.  You could fairly easily tear it from the stalk and take it with you."),
    symbol = "0",
    color = "light_blue",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    flags = { "TRANSPARENT", "EASY_DECONSTRUCT" },
    deconstruct = { drops = { { item = "alien_pod_resin", count = { 6, 8 } } } },
    bash = {
        minimum_strength = 25,
        maximum_strength = 60,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump."),
    },
}

ccb.content.define_furniture {
    id = "f_alien_table",
    name = ccb.content.text("fleshy altar"),
    description = ccb.content.text("This pulsing protuberance juts from the floor, its sides covered in scaled, oozing skin.  The surface is flat, but undulates softly.  A handful of unidentifiable appendages reach from the sides, suggesting a sort of nightmarish living Autodoc."),
    symbol = "n",
    color = "pink",
    move_cost_mod = -1,
    coverage = 40,
    required_strength = -1,
    light_emitted = 12,
    flags = { "TRANSPARENT" },
    bash = {
        minimum_strength = 45,
        maximum_strength = 60,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("whump."),
        furniture = "f_alien_scar",
    },
}

ccb.content.define_furniture {
    id = "f_scrap_antenna",
    name = ccb.content.text("scrap antenna"),
    looks_like = "t_radio_tower",
    description = ccb.content.text("This contraption looks like some sort of cobbled-together transmitter or receiver antenna.  It consists of a number of mismatched blinking lights, spinning servos, and dangling wires connected to a hefty metal box."),
    symbol = "d",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = 11,
    flags = { "NOITEM", "BLOCKSDOOR" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 150,
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 8, 12 } },
            { item = "pipe", count = { 0, 3 } },
            { item = "pipe_fittings", count = { 0, 3 } },
            { item = "sheet_metal", count = { 1, 2 } },
            { item = "sheet_metal_small", count = { 2, 10 } },
            { item = "antenna", count = { 0, 1 } },
            { item = "exodii_module", count = { 0, 1 } },
            { item = "exodii_motor", count = { 0, 1 } },
            { item = "cable", count = { 0, 2 } },
            { item = "scrap_copper", count = { 2, 12 } },
        },
    },
}
