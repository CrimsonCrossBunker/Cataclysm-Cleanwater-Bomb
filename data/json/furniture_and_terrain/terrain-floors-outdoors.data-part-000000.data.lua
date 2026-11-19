local ccb = require("ccb")

ccb.content.define_terrain {
    abstract = "t_natural_floor_abstract",
    name = ccb.content.text("dirt"),
    description = ccb.content.text("It's dirt.  Looks like some fine soil for tillage.  Could also be dug out for construction projects."),
    symbol = ".",
    color = "brown",
    move_cost = 2,
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
    id = "t_dirt",
    copy_from = "t_natural_floor_abstract",
    connect_groups = "DIRT",
    connects_to = {
        "DIRT",
        "CLAY",
        "SAND",
        "MUD",
        "DIRTMOUND",
        "CLAYMOUND",
        "SANDMOUND",
        "SANDGLASS",
        "CONCRETE",
    },
    extend = { flags = { "PLOWABLE" } },
}

ccb.content.define_terrain {
    id = "t_forestfloor",
    copy_from = "t_natural_floor_abstract",
    name = ccb.content.text("forest floor"),
    description = ccb.content.text("Covered in twigs and lots of brown, decaying leaves."),
    looks_like = "t_moss",
    extend = { flags = { "PLOWABLE" } },
}

ccb.content.define_terrain {
    id = "t_sand",
    name = ccb.content.text("sand"),
    description = ccb.content.text("A large area of fine sand that could be useful in a number of ways, if it was extracted properly."),
    symbol = ".",
    color = "yellow",
    move_cost = 3,
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
    id = "t_mud",
    name = ccb.content.text("mud"),
    description = ccb.content.text("An area of wet, slick mud."),
    symbol = ".",
    color = "brown",
    looks_like = "t_dirt",
    move_cost = 3,
    connect_groups = "MUD",
    connects_to = "MUD",
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
    id = "t_clay",
    name = ccb.content.text("clay"),
    description = ccb.content.text("A large area of malleable clay, suitable for kiln firing if it was extracted properly."),
    symbol = ".",
    color = "light_red",
    connect_groups = "CLAY",
    connects_to = { "CLAY", "CLAYMOUND" },
    move_cost = 2,
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
    id = "t_claymound",
    name = ccb.content.text("mound of clay"),
    description = ccb.content.text("A mound of clay soil."),
    looks_like = "t_dirtmound",
    symbol = "#",
    color = "brown",
    connect_groups = "CLAYMOUND",
    connects_to = "CLAYMOUND",
    move_cost = 5,
    flags = { "TRANSPARENT", "BURROWABLE" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 4,
        sound = ccb.content.text("thump!"),
        failure_sound = ccb.content.text("thud!"),
        terrain = "t_clay",
        drops = { { item = "clay_lump", count = { 6, 12 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sandmound",
    name = ccb.content.text("mound of sand"),
    description = ccb.content.text("A mound of sand."),
    looks_like = "t_dirtmound",
    symbol = "#",
    color = "brown",
    connect_groups = "SANDMOUND",
    connects_to = "SANDMOUND",
    move_cost = 5,
    flags = { "TRANSPARENT", "BURROWABLE" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 4,
        sound = ccb.content.text("thump!"),
        failure_sound = ccb.content.text("thud!"),
        terrain = "t_sand",
        drops = { { item = "material_sand", count = { 300, 600 } } },
    },
}

ccb.content.define_terrain {
    id = "t_glassed_sand",
    name = ccb.content.text("glassed sand"),
    description = ccb.content.text("A patch of sand with a crust of natural glass atop it from exposure to intense heat."),
    looks_like = "t_sand",
    symbol = "~",
    color = "brown",
    connect_groups = "SANDGLASS",
    connects_to = "SANDGLASS",
    move_cost = 3,
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT" },
    bash = {
        sound = ccb.content.text("crunch"),
        terrain = "t_sand",
        minimum_strength = 25,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_dirtmound",
    name = ccb.content.text("upturned dirt"),
    description = ccb.content.text("An area of loose dirt, not easily traversable.  If examined more closely, it's quite favorable for planting seeds and the like."),
    symbol = "#",
    color = "brown",
    connect_groups = "DIRTMOUND",
    connects_to = "DIRTMOUND",
    move_cost = 3,
    flags = { "TRANSPARENT", "DIGGABLE", "MOUNTABLE", "NOCOLLIDE", "PLANTABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
    },
    builtin_examine = "dirtmound",
}

ccb.content.define_terrain {
    id = "t_dirtmoundfloor",
    name = ccb.content.text("mound of upturned dirt"),
    description = ccb.content.text("A giant hill of dirt that looks like you could crawl inside for shelter."),
    looks_like = "t_dirtmound",
    symbol = "#",
    color = "brown",
    connect_groups = { "DIRT", "INDOORFLOOR" },
    connects_to = "DIRT",
    move_cost = 3,
    coverage = 40,
    flags = { "TRANSPARENT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        drops = { { item = "material_soil", count = { 100, 200 } } },
    },
}
