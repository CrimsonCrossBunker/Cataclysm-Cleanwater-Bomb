local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_nl_pipe_plant",
    name = ccb.content.text("pipe plant"),
    description = ccb.content.text("This looks like a squat collection of reeds.  Upon closer inspection, they are almost identical in shape to plumbing pipes, just made of a wood-like material."),
    symbol = "!",
    color = "brown",
    move_cost_mod = 0,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "splinter", count = { 3, 5 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_nl_climbing_vine",
    name = ccb.content.text("climbing vines"),
    description = ccb.content.text("This floor-to-ceiling collection of vines is twisted and gnarled, like fraying, loose wires.  Its surface has a plastic sheen."),
    symbol = "!",
    color = "red",
    move_cost_mod = 6,
    required_strength = -1,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "ORGANIC" },
    bash = {
        minimum_strength = 6,
        maximum_strength = 30,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "splinter", count = { 3, 5 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_nl_powerbox",
    name = ccb.content.text("utility box"),
    description = ccb.content.text("This looks like a rusted metal utility box, painted dark green.  It's made up of two rectangular metal pieces, welded together in the center.  The weld itself has an organic, twisting pattern.  You cannot see what is inside, if anything."),
    symbol = "X",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 100,
    required_strength = 14,
    mass = "272 kg",
    max_volume = "250 L",
    flags = { "CONTAINER", "SEALED" },
    oxytorch = { result = "f_nl_powerbox_o", duration = "14 seconds" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("screeching metal!"),
        failure_sound = ccb.content.text("whump!"),
        drops = {
            { item = "nl_flesh_powerbox", count = { 1, 5 } },
            { item = "ch_steel_chunk", count = { 1, 5 } },
            { item = "ch_steel_chunk", count = { 1, 5 } },
            { item = "scrap", count = { 1, 5 } },
            { item = "rock", count = { 1, 2 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_nl_powerbox_o",
    name = ccb.content.text("open utility box"),
    description = ccb.content.text("This looks like a rusted metal utility box, painted dark green.  Its two rectangular metal pieces have been opened up.  The interior is made up of oily, fleshy meat, with interspersed wires.  Nestled in the center is a rectangular depression, with connections for some sort of electronics."),
    symbol = "X",
    color = "light_gray",
    move_cost_mod = -1,
    coverage = 100,
    required_strength = 14,
    mass = "272 kg",
    max_volume = "250 L",
    flags = { "CONTAINER", "SEALED", "PLACE_ITEM" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 200,
        sound = ccb.content.text("screeching metal!"),
        failure_sound = ccb.content.text("whump!"),
        drops = {
            { item = "nl_flesh_powerbox", count = { 1, 5 } },
            { item = "ch_steel_chunk", count = { 1, 5 } },
            { item = "ch_steel_chunk", count = { 1, 5 } },
            { item = "scrap", count = { 1, 5 } },
            { item = "rock", count = { 1, 2 } },
        },
    },
}
