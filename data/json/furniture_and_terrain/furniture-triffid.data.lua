local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_glowingbulb",
    name = ccb.content.text("illuminating plant bulb"),
    description = ccb.content.text("A small plant grows among the roots here, its green, onion-like bulb illuminating the area around it."),
    symbol = "!",
    color = "brown",
    move_cost_mod = 6,
    required_strength = -1,
    light_emitted = 15,
    light_color = { 0, 120, 0 },
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
    id = "f_brambles",
    name = ccb.content.text("brambles"),
    symbol = "#",
    background_color = "brown",
    description = ccb.content.text("A wall of tangled roots blocks the path here, you'd have destroy it to get past."),
    move_cost_mod = -1,
    coverage = 60,
    required_strength = -1,
    flags = { "TRANSPARENT", "BLOCKSDOOR", "SHORT", "THIN_OBSTACLE" },
    bash = {
        minimum_strength = 10,
        maximum_strength = 60,
        sound = ccb.content.text("smash"),
        failure_sound = ccb.content.text("whump."),
        drops = { { item = "splinter", count = { 10, 15 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_furniture {
    id = "f_midden",
    name = ccb.content.text("composting midden"),
    description = ccb.content.text("A hole has been dug into the roots here, and a pretty unpleasant smell emits from it."),
    symbol = "O",
    background_color = "brown",
    move_cost_mod = 3,
    coverage = 35,
    required_strength = -1,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "SHORT", "MOUNTABLE" },
}
