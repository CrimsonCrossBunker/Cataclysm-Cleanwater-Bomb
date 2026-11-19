local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_rubble_rockcandy",
    name = ccb.content.text("pile of rock candy rubble"),
    description = ccb.content.text("Pile of rock candy shards.  Useless?"),
    symbol = "^",
    color = "dark_gray",
    move_cost_mod = 6,
    max_volume = "750 L",
    required_strength = -1,
    flags = {
        "TRANSPARENT",
        "UNSTABLE",
        "ROUGH",
        "PLACE_ITEM",
        "MOUNTABLE",
        "CONTAINER",
        "SEALED",
        "ALLOW_FIELD_EFFECT",
        "SHORT",
        "RUBBLE",
    },
    builtin_examine = "rubble",
}

ccb.content.define_furniture {
    id = "f_candy_boulder_small",
    name = ccb.content.text("small rock candy boulder"),
    description = ccb.content.text("Blocking your path.  Should be easy to move.  It can be used as a primitive anvil."),
    symbol = "o",
    color = "dark_gray",
    move_cost_mod = 3,
    coverage = 30,
    required_strength = 10,
    crafting_pseudo_item = "boulder_anvil",
    flags = { "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "TINY" },
    bash = {
        minimum_strength = 16,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock_candy_chunk", count = { 1, 6 } } },
    },
}

ccb.content.define_furniture {
    id = "f_candy_boulder_medium",
    name = ccb.content.text("medium rock candy boulder"),
    description = ccb.content.text("Blocking your path.  It'll be a struggle to move.  It can be used as a primitive anvil."),
    symbol = "0",
    color = "dark_gray",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    crafting_pseudo_item = "boulder_anvil",
    flags = { "NOITEM", "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 32,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock_candy_chunk", count = { 5, 11 } } },
    },
}

ccb.content.define_furniture {
    id = "f_candy_boulder_large",
    name = ccb.content.text("large rock candy boulder"),
    description = ccb.content.text("Now how are you going to move this?"),
    symbol = "O",
    color = "dark_gray",
    move_cost_mod = -1,
    coverage = 65,
    required_strength = 32,
    flags = { "NOITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 64,
        maximum_strength = 160,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock_candy_chunk", count = { 10, 22 } }, { item = "sugar", count = { 3, 7 } } },
    },
}
