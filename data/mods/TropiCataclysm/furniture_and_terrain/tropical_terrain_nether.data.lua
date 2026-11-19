local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_alien_coral_a",
    name = ccb.content.text("alien coral"),
    description = ccb.content.text("A colony of alien organisms forming what appears to be some kind of rocky structure.  It looks sturdy as stone."),
    symbol = "#",
    color = "pink",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    flags = { "NOITEM", "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 32,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 35, 50 } }, { item = "sharp_rock", count = { 3, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_alien_coral_b",
    name = ccb.content.text("alien coral"),
    description = ccb.content.text("A colony of alien organisms forming what appears to be some kind of rocky structure.  It looks sturdy as stone."),
    symbol = "#",
    color = "light_green",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    flags = { "NOITEM", "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 32,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 35, 50 } }, { item = "sharp_rock", count = { 3, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_alien_coral_c",
    name = ccb.content.text("alien coral"),
    description = ccb.content.text("A colony of alien organisms forming what appears to be some kind of rocky structure.  It looks sturdy as stone."),
    symbol = "#",
    color = "cyan",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    flags = { "NOITEM", "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 32,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 35, 50 } }, { item = "sharp_rock", count = { 3, 7 } } },
    },
}

ccb.content.define_furniture {
    id = "f_alien_sponge",
    name = ccb.content.text("alien sponge"),
    description = ccb.content.text("This looks like some kind of alien sponge.  It has a bluish color and seems sturdy as a rock."),
    symbol = "*",
    color = "light_blue",
    move_cost_mod = 6,
    coverage = 45,
    required_strength = 16,
    flags = { "NOITEM", "TRANSPARENT", "MINEABLE", "UNSTABLE", "MOUNTABLE", "SHORT" },
    bash = {
        minimum_strength = 32,
        maximum_strength = 80,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("thump."),
        drops = { { item = "rock", count = { 35, 50 } }, { item = "sharp_rock", count = { 3, 7 } } },
    },
}

ccb.content.define_terrain {
    id = "t_alien_anemone",
    name = ccb.content.text("alien polyp"),
    description = ccb.content.text("This is an alien creature resembling some kind of cnidarian like a hydra or anemone.  Probably not a good idea to touch or step on it."),
    symbol = "*",
    color = "light_red",
    move_cost = 8,
    coverage = 40,
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE_ASH", "THIN_OBSTACLE", "PLACE_ITEM", "SHARP" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_dirt",
        drops = { { item = "cnidarian", chance = 50, count = { 1, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_alien_chrinoid",
    name = ccb.content.text("alien lily"),
    description = ccb.content.text("This is an alien creature resembling some kind of sea lily.  Its feathery arms spread open like palm tree to catch the aero plankton in the area."),
    symbol = "*",
    color = "magenta",
    move_cost = 8,
    coverage = 40,
    flags = { "TRANSPARENT", "CONTAINER", "FLAMMABLE_ASH", "THIN_OBSTACLE", "PLACE_ITEM" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 30,
        sound = ccb.content.text("crunch."),
        failure_sound = ccb.content.text("brush."),
        terrain = "t_dirt",
        drops = { { item = "echinoderm", chance = 50, count = { 1, 4 } } },
    },
}
