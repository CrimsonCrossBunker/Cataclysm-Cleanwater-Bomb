local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nuclear_reactor",
    name = ccb.content.text("nuclear reactor core"),
    description = "",
    symbol = "R",
    color = "light_green",
    move_cost = 0,
    flags = { "TRANSPARENT", "CONTAINER", "REDUCE_SCENT", "PERMEABLE", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_foamcrete_wall",
    name = ccb.content.text("foamcrete wall"),
    description = ccb.content.text("A lightweight wall made from unreinforced foamcrete.  Not nearly as resilient as a real wall, but it will block sight and the elements nonetheless."),
    symbol = "#",
    color = "white",
    looks_like = "t_rock_wall",
    move_cost = 0,
    coverage = 100,
    roof = "t_foamcrete_floor",
    flags = { "NOITEM", "SUPPORTS_ROOF", "DESTROY_ITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 15,
        maximum_strength = 40,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("thump!"),
        terrain = "t_null",
    },
}

ccb.content.define_terrain {
    id = "t_foamcrete_floor",
    name = ccb.content.text("foamcrete floor"),
    description = ccb.content.text("A relatively flat slab of unreinforced foamcrete."),
    symbol = ".",
    color = "light_blue",
    looks_like = "t_rock_floor",
    move_cost = 2,
    roof = "t_open_air",
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 30,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_wall_clearcrete_alarm",
    looks_like = "t_wall_glass",
    name = ccb.content.text("clearcrete wall"),
    description = ccb.content.text("A barrier made of clearcrete, perfect for greenhouses but looks extremely fragile.  It is most definitely not fragile, and it's probably alarmed in the event of a breach."),
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    roof = "t_clearcrete_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "TRANSPARENT",
        "ALARMED",
        "NOITEM",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "BLOCK_WIND",
        "NO_SHOOT",
    },
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("a cross between steel bending and stone shattering!"),
        failure_sound = ccb.content.text("whunk!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_floor",
        drops = { { item = "clearcrete_chunk", count = { 42, 84 } } },
    },
}

ccb.content.define_terrain {
    id = "t_foamcrete_wall_seal",
    name = ccb.content.text("foamcrete wall"),
    description = ccb.content.text("Automatically deployed by the ship to block breaches and seal off damaged sections, this foamcrete wall is a temporary solution at best."),
    symbol = "#",
    color = "white",
    looks_like = "t_rock_wall",
    move_cost = 0,
    coverage = 100,
    roof = "t_foamcrete_floor",
    flags = { "NOITEM", "SUPPORTS_ROOF", "DESTROY_ITEM", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 15,
        maximum_strength = 40,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("thump!"),
        terrain = "t_null",
    },
}

ccb.content.define_terrain {
    id = "t_foamcrete_floor_seal",
    name = ccb.content.text("foamcrete floor"),
    description = ccb.content.text("Automatically deployed by the ship to block breaches and seal off damaged sections, this foamcrete floor is a temporary solution at best."),
    symbol = ".",
    color = "light_blue",
    looks_like = "t_rock_floor",
    move_cost = 2,
    roof = "t_flat_roof",
    flags = { "TRANSPARENT", "FLAT", "ROAD", "SUPPORTS_ROOF" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 30,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_hard_vacuum",
    name = ccb.content.text("hard vacuum"),
    symbol = " ",
    color = "black",
    description = ccb.content.text("The cold inhospitable vacuum of space.  Going this way without an EVA pack will end in either a slow cold death as your life support fades or a slow hot death as you drop into the planet's atmosphere."),
    move_cost = 1000,
    light_emitted = 420,
    flags = { "DESTROY_ITEM" },
}
