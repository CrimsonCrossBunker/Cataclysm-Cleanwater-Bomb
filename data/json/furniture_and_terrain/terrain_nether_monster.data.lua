local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nm_floor_bone",
    name = ccb.content.text("bone floor"),
    description = ccb.content.text("An impossibly hard, impregnable bone structure covers the internals of the beast."),
    symbol = ".",
    color = "magenta_white",
    move_cost = 1,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT" },
}

ccb.content.define_terrain {
    id = "t_nm_wall_bone",
    name = ccb.content.text("bone wall"),
    description = ccb.content.text("An amazingly durable, impregnable wall of bone stands before you, forming the outer shell of the eldritch monster."),
    symbol = "#",
    color = "magenta_white",
    move_cost = 0,
    coverage = 100,
    looks_like = "t_concrete_wall",
    roof = "t_nm_floor_bone",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
}

-- TODO: perhaps make player unable to bash these
ccb.content.define_terrain {
    id = "t_nm_wall_teeth",
    name = ccb.content.text("monster teeth"),
    description = ccb.content.text("A fractal array of uncountable, bristling teeth that seem impossibly sharp, even at a conceptual level.  An iridescent haze surrounds it, as if light itself cannot help but be separated in their presence.  You surmise you could extract some for your own use, if you had an appropriate tool to remove them from the wall they're imbedded in."),
    symbol = "^",
    color = "white",
    move_cost = 0,
    coverage = 100,
    looks_like = "t_concrete_wall",
    roof = "t_nm_floor_bone",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
}

ccb.content.define_terrain {
    id = "t_nm_floor_flesh",
    name = ccb.content.text("flesh floor"),
    description = ccb.content.text("Walking over the innards of this monstrous beast, you can still feel movement underneath your feet."),
    symbol = ".",
    color = "magenta_white",
    move_cost = 1,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT" },
    looks_like = "t_thconc_floor_flesh",
}

ccb.content.define_terrain {
    id = "t_nm_wall_flesh",
    name = ccb.content.text("flesh wall"),
    description = ccb.content.text("Warm to the touch, the tainted flesh of this monstrous being still twitches."),
    symbol = "#",
    color = "magenta_red",
    move_cost = 0,
    coverage = 100,
    roof = "t_nm_floor_flesh",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    looks_like = "t_concrete_wall_flesh",
    bash = {
        minimum_strength = 20,
        maximum_strength = 30,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_nm_floor_flesh",
        drops = { { item = "meat_tainted", count = { 2, 10 } } },
    },
}

ccb.content.define_terrain {
    id = "t_nm_wall_cartilage",
    name = ccb.content.text("flesh wall"),
    description = ccb.content.text("A thick wall of fleshy cartilage.  With the proper tools, you could smash right through it."),
    symbol = "#",
    color = "magenta",
    move_cost = 0,
    coverage = 100,
    roof = "t_nm_floor_flesh",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    looks_like = "t_nm_wall_flesh",
    bash = {
        minimum_strength = 15,
        maximum_strength = 25,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_nm_floor_flesh",
    },
}

--  is spawning monsters on bashing/destruction of terrain possible?
ccb.content.define_terrain {
    id = "t_nm_wall_flesh_pupating",
    name = ccb.content.text("flesh wall"),
    description = ccb.content.text("This section of flesh seems hollowed out.  You can see silky, translucent larvae wriggling inside, consuming flesh at a prodigious pace."),
    symbol = "#",
    color = "yellow_red",
    move_cost = 0,
    coverage = 100,
    roof = "t_nm_floor_flesh",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    looks_like = "t_concrete_wall_flesh",
    bash = {
        minimum_strength = 5,
        maximum_strength = 15,
        sound = ccb.content.text("splorch!"),
        failure_sound = ccb.content.text("splorch!"),
        terrain = "t_nm_floor_flesh",
        drops = { { item = "meat_tainted", count = { 2, 10 } } },
    },
}

ccb.content.define_terrain {
    id = "t_nm_ichor_sh",
    name = ccb.content.text("monster hemolymph"),
    description = ccb.content.text("A shallow stream of glowing yellow ichor streaks through the beast.  Peering into it, you can see dark shadows moving under the surface."),
    symbol = "~",
    color = "yellow",
    looks_like = "t_water_sh",
    light_emitted = 15,
    light_color = { 135, 150, 0 },
    move_cost = 8,
    flags = { "TRANSPARENT", "LIQUID", "NO_SCENT", "SWIMMABLE", "SHALLOW_WATER" },
}

ccb.content.define_terrain {
    id = "t_nm_cartilage",
    name = ccb.content.text("cartilage"),
    description = ccb.content.text("A thin, transparent cartilage webbing."),
    symbol = "#",
    color = "white",
    move_cost = 0,
    roof = "t_nm_floor_flesh",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "BLOCK_WIND", "NOITEM" },
    looks_like = "fd_web",
    bash = {
        sound = ccb.content.text("Riiiiip!"),
        terrain = "t_nm_floor_flesh",
        minimum_strength = 5,
        maximum_strength = 10,
    },
}

ccb.content.define_terrain {
    id = "t_nm_brain",
    name = ccb.content.text("nether brain"),
    description = ccb.content.text("An oozing pile of wrinkled, decomposing flesh."),
    symbol = "#",
    color = "magenta_red",
    move_cost = 0,
    coverage = 100,
    roof = "t_nm_floor_flesh",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "MINEABLE", "BLOCK_WIND" },
    looks_like = "t_concrete_wall_flesh",
    bash = {
        minimum_strength = 10,
        maximum_strength = 20,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_nm_floor_flesh",
        drops = { { item = "meat_tainted", count = { 2, 10 } } },
    },
}
