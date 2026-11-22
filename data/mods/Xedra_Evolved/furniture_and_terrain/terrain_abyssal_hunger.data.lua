local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_abyssal_flesh_wall",
    name = ccb.content.text("warped flesh wall"),
    description = ccb.content.text("Cold to the touch, the deformed flesh of this monstrous being churns as it perceives your presence."),
    symbol = "#",
    color = "magenta",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    looks_like = "t_nm_wall_flesh",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
}

ccb.content.define_terrain {
    id = "t_abyssal_flesh_floor",
    name = ccb.content.text("warped flesh floor"),
    description = ccb.content.text("Walking over the innards of this monstrous beast, you can feel it move underneath your feet."),
    symbol = ".",
    color = "magenta_white",
    move_cost = 1,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT" },
    looks_like = "t_nm_floor_flesh",
}

ccb.content.define_terrain {
    id = "t_abyssal_flesh_roof",
    name = ccb.content.text("warped flesh roof"),
    description = ccb.content.text("A section of flat, flesh-like rooftop."),
    symbol = ".",
    color = "magenta",
    move_cost = 2,
    flags = { "FLAT" },
}

ccb.content.define_terrain {
    id = "t_abyssal_brain",
    name = ccb.content.text("Abyssal Hunger's brain"),
    description = ccb.content.text("A gigantic mass of flesh similar to a brain."),
    symbol = "#",
    color = "magenta_red",
    move_cost = 0,
    coverage = 100,
    roof = "t_abyssal_flesh_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    looks_like = "t_concrete_wall_flesh",
}

ccb.content.define_furniture {
    id = "f_shard_location",
    name = ccb.content.text("shard-filled brain chunk"),
    description = ccb.content.text("A chunk of brain matter holding some shards akin to the one you are looking for.  Examine to pick one."),
    symbol = "S",
    color = "i_dark_gray",
    move_cost_mod = -1,
    coverage = 100,
    required_strength = -1,
    flags = { "NOCOLLIDE", "NO_PICKUP_ON_EXAMINE", "TRANSPARENT" },
}
