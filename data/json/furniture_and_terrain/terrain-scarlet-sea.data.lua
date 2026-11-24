local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_scarlet_light",
    symbol = ".",
    looks_like = "t_utility_light",
    name = ccb.content.text("scarlet light"),
    roof = "t_null",
    color = "red",
    light_color = { 110, 0, 0 },
    light_emitted = 30,
    description = ccb.content.text("A red lamp on rods protruding from the ground.  Hard to directly look at without eye protection."),
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_water_sh_scarlet",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    flags = { "TRANSPARENT", "WALL" },
}

ccb.content.define_terrain {
    id = "t_water_sh_scarlet",
    name = ccb.content.text("scarlet water"),
    description = ccb.content.text("The water, if you can call it that, isn't very deep here.  It's difficult to tell if the water is tinted, or if it's reflecting the dim, scarlet sky.  With a watertight container, you could gather it."),
    symbol = " ",
    color = "black",
    move_cost = 3,
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "SHALLOW_WATER" },
    connect_groups = "WATER",
    connects_to = "WATER",
    liquid_source = { item = "water_clean_scarlet", minimum_temperature = 2.2 },
    builtin_examine = "water_source",
}

ccb.content.define_terrain {
    id = "t_water_sh_scarlet_wave",
    name = ccb.content.text("scarlet water"),
    description = ccb.content.text("The water, if you can call it that, isn't too deep here.  It's difficult to tell if the water is tinted, or if it's reflecting the dim, scarlet sky.  With a watertight container, you could gather it."),
    symbol = " ",
    color = "black",
    move_cost = 5,
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "SHALLOW_WATER" },
    connect_groups = "WATER",
    connects_to = "WATER",
    liquid_source = { item = "water_clean_scarlet", minimum_temperature = 2.2 },
    builtin_examine = "water_source",
    emissions = { "emit_scarlet_sea_wave" },
}

ccb.content.define_terrain {
    id = "t_sand_scarlet",
    name = ccb.content.text("scarlet glass"),
    description = ccb.content.text("What first appears to be scarlet-tinged sand is in fact dark, volcanic glass, covered in small pits and eroded curves, giving it a flowing appearance.  Gentle flecks of red and yellow minerals dot its exterior."),
    symbol = ".",
    color = "yellow",
    looks_like = "t_sand",
    move_cost = 1,
    connect_groups = "SAND",
    connects_to = { "SAND", "SANDMOUND", "SANDGLASS" },
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_scarlet",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk"),
    description = ccb.content.text("A dark gray obelisk.  Despite its solid appearance, the face of it seems to slightly ripple, as if it were sand, loosely suspended in space."),
    symbol = "A",
    color = "dark_gray",
    light_color = { 110, 0, 0 },
    light_emitted = 200,
    examine_handler = "examine_t_nl_obelisk_scarlet",
}

ccb.content.define_terrain {
    id = "t_nl_scrap_wall_scarlet",
    name = ccb.content.text("scrap metal spire"),
    looks_like = "t_scrap_wall",
    description = ccb.content.text("This great spire of twisted metal is held together by fraying wires and large bolts.  It looks like you could climb it."),
    symbol = "-",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_nl_scrap_floor",
    flags = {
        "NOITEM",
        "SUPPORTS_ROOF",
        "WALL",
        "REDUCE_SCENT",
        "AUTO_WALL_SYMBOL",
        "MINEABLE",
        "BLOCK_WIND",
        "CLIMBABLE",
    },
    bash = {
        minimum_strength = 80,
        maximum_strength = 200,
        sound = ccb.content.text("metal crying!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_broken_metal_floor",
        drops = { { item = "steel_chunk", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_scrap_scaffolding_scarlet",
    name = ccb.content.text("mass of climbable metal"),
    description = ccb.content.text("A mass of jagged metal, climbing into the sky.  It looks sharp, but also sturdy enough to climb."),
    symbol = "H",
    color = "dark_gray",
    move_cost = 2,
    flags = {
        "TRANSPARENT",
        "GOES_UP",
        "GOES_DOWN",
        "PLACE_ITEM",
        "DIFFICULT_Z",
        "SINGLE_SUPPORT",
        "SHARP",
        "ROUGH",
    },
    bash = {
        minimum_strength = 20,
        maximum_strength = 150,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = { { item = "pipe", count = { 10, 46 } }, { item = "pipe_fittings", count = { 10, 55 } } },
    },
}
