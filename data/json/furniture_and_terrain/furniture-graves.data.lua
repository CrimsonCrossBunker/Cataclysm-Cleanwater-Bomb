local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_slab",
    name = ccb.content.text("stone slab"),
    description = ccb.content.text("A slab of heavy stone, with a reasonably flat surface."),
    symbol = "n",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = 12,
    crafting_pseudo_item = "boulder_anvil",
    flags = {
        "PLACE_ITEM",
        "BLOCKSDOOR",
        "TRANSPARENT",
        "ALLOW_FIELD_EFFECT",
        "MOUNTABLE",
        "SHORT",
        "MINEABLE",
    },
    bash = {
        minimum_strength = 20,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 2, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_highland_sarcophagus",
    name = ccb.content.text("stone sarcophagus"),
    description = ccb.content.text("A large stone coffin, adorned with reliefs depicting figures in various poses of mourning.  The lid is firmly sealed, and the interior is inaccessible."),
    symbol = "n",
    looks_like = "f_slab",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = 12,
    crafting_pseudo_item = "boulder_anvil",
    flags = {
        "TRANSPARENT",
        "CONTAINER",
        "SEALED",
        "PLACE_ITEM",
        "MOUNTABLE",
        "TRANSPARENT",
        "ALLOW_FIELD_EFFECT",
    },
    bash = {
        minimum_strength = 20,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        furniture = "f_highland_sarcophagus_o",
        drops = { { item = "rock", count = { 2, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_highland_sarcophagus_o",
    name = ccb.content.text("broken stone sarcophagus"),
    description = ccb.content.text("A large stone coffin, adorned with reliefs depicting figures in various poses of mourning.  Its been desecrated and looted."),
    symbol = "n",
    looks_like = "f_slab",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 30,
    required_strength = 12,
    crafting_pseudo_item = "boulder_anvil",
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "TRANSPARENT", "ALLOW_FIELD_EFFECT" },
    bash = {
        minimum_strength = 20,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 2, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_imperial_sarcophagus",
    name = ccb.content.text("royal sarcophagus"),
    description = ccb.content.text("An army of ossified figures marches across the four sides of this massive stone coffin, their procession led by a regal figure whose features are obscured by a veil.  The lid is firmly sealed, and whatever lies within is inaccessible."),
    copy_from = "f_highland_sarcophagus",
    light_emitted = 120,
    color = "yellow",
    bash = {
        minimum_strength = 20,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        furniture = "f_imperial_sarcophagus_o",
        drops = { { item = "rock", count = { 2, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_imperial_sarcophagus_o",
    name = ccb.content.text("broken royal sarcophagus"),
    description = ccb.content.text("Pieces of the stone reliefs are scattered across the floor, and the lid has been shattered to allow access to the interior."),
    copy_from = "f_highland_sarcophagus_o",
    color = "yellow",
    bash = {
        minimum_strength = 20,
        maximum_strength = 40,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        furniture = "f_imperial_sarcophagus_o",
        drops = {
            { item = "rock", count = { 12, 40 } },
            { item = "silver_small", count = { 4, 12 } },
            { item = "gold_small", count = { 4, 12 } },
        },
    },
}

ccb.content.define_furniture {
    id = "f_grave_head",
    name = ccb.content.text("headstone"),
    description = ccb.content.text("A large slab of stone, engraved with information on the deceased individual buried beneath.  While only a solemn reminder of the uncountable losses of the Cataclysm, a proper final resting place grants an odd sense of peace."),
    symbol = "_",
    color = "light_gray",
    move_cost_mod = 0,
    required_strength = -1,
    crafting_pseudo_item = "boulder_anvil",
    flags = {
        "MINEABLE",
        "TRANSPARENT",
        "SHORT",
        "NOCOLLIDE",
        "ALLOW_FIELD_EFFECT",
        "MOUNTABLE",
        "PLACE_ITEM",
    },
    bash = {
        minimum_strength = 50,
        maximum_strength = 150,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("thump!"),
        drops = { { item = "rock", count = { 2, 4 } } },
    },
}

ccb.content.define_furniture {
    id = "f_grave_stone",
    name = ccb.content.text("gravestone"),
    description = ccb.content.text("An upright slab of stone with information engraved on the face about whoever lies beneath.  While only a solemn reminder of the countless casualties of the Cataclysm, a proper final resting place grants an odd sense of peace."),
    symbol = "^",
    color = "light_gray",
    move_cost_mod = 2,
    coverage = 50,
    required_strength = -1,
    crafting_pseudo_item = "boulder_anvil",
    flags = { "MINEABLE", "NOITEM", "TRANSPARENT", "MOUNTABLE", "ROUGH", "PLACE_ITEM" },
    bash = {
        minimum_strength = 60,
        maximum_strength = 160,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("thump!"),
        drops = { { item = "rock", count = { 8, 14 } } },
    },
}

ccb.content.define_furniture {
    id = "f_grave_stone_old",
    name = ccb.content.text("worn gravestone"),
    description = ccb.content.text("An aged and eroded gravestone, damaged to the point of rendering the inscription illegible.  Whoever's buried here was probably lucky enough to pass before all this chaos began."),
    symbol = "^",
    color = "dark_gray",
    move_cost_mod = 2,
    coverage = 50,
    required_strength = -1,
    flags = { "MINEABLE", "NOITEM", "TRANSPARENT", "MOUNTABLE", "ROUGH", "PLACE_ITEM", "UNSTABLE" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 120,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("thump!"),
        drops = { { item = "rock", count = { 5, 10 } } },
    },
}

ccb.content.define_furniture {
    id = "f_grave_monument",
    name = ccb.content.text("obelisk"),
    description = ccb.content.text("A magnificent carved statue with an engraved plaque fixed to the base.  It serves to honor the passing of somebody significant, something one wishes was still a practical goal."),
    symbol = "$",
    color = "black_white",
    move_cost_mod = -1,
    coverage = 55,
    required_strength = -1,
    flags = { "MINEABLE", "NOITEM" },
    bash = {
        minimum_strength = 80,
        maximum_strength = 180,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("thunk!"),
        drops = { { item = "rock", count = { 18, 30 } } },
    },
}

ccb.content.define_furniture {
    id = "f_battlefield_cross",
    name = ccb.content.text("battlefield cross"),
    description = ccb.content.text("A makeshift memorial marker, made of a service rifle - buried in the dirt, or nestled in a pair of boots - with a helmet perched on the stock.  A small way to honor the dead."),
    symbol = "(",
    color = "dark_gray",
    move_cost_mod = 0,
    coverage = 20,
    required_strength = -1,
    flags = { "EASY_DECONSTRUCT", "TRANSPARENT", "MOUNTABLE" },
    deconstruct = {
        drops = {
            { group = "modular_m4a1", count = 1, charges = 0 },
            { item = "helmet_army", count = 1, damage = { 0, 3 } },
            { item = "boots_combat", count = { 0, 1 }, damage = { 0, 3 } },
        },
    },
    bash = {
        minimum_strength = 1,
        maximum_strength = 4,
        sound = ccb.content.text("thump."),
        failure_sound = ccb.content.text("whack."),
        drops = {
            { group = "modular_m4a1", count = 1, charges = 0 },
            { item = "helmet_army", count = 1, damage = { 0, 3 } },
            { item = "boots_combat", count = { 0, 1 }, damage = { 0, 3 } },
        },
    },
}
