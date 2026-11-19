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
