local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk0"),
    description = ccb.content.text("Obelisk"),
    looks_like = "f_machinery_old",
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_0",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_1",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk1"),
    description = ccb.content.text("Obelisk"),
    symbol = "A",
    color = "blue",
    examine_handler = "examine_t_nl_obelisk_1",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_2",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk2"),
    description = ccb.content.text("Obelisk"),
    symbol = "A",
    color = "yellow",
    examine_handler = "examine_t_nl_obelisk_2",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_3",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Obelisk3"),
    description = ccb.content.text("Obelisk"),
    symbol = "A",
    color = "red",
    examine_handler = "examine_t_nl_obelisk_3",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_boiler",
    name = ccb.content.text("Obelisk"),
    description = ccb.content.text("A tall, drab grey, metallic pillar covered in swirling patterns.  You could Examine it closer to try and discern the shapes."),
    looks_like = "f_machinery_old",
    symbol = "A",
    color = "green",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_boiler",
}

ccb.content.define_terrain {
    id = "t_nl_obelisk_mission_water_cooler",
    name = ccb.content.text("Obelisk"),
    description = ccb.content.text("A tall, cerulean-blue, metallic pillar covered in swirling patterns.  You could Examine it closer to try and discern the shapes."),
    symbol = "A",
    color = "cyan",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_obelisk_mission_water_cooler",
}

ccb.content.define_terrain {
    id = "t_nl_mission_water_cooler",
    name = ccb.content.text("bulbous water tank"),
    description = ccb.content.text("This would almost look like an earthly water cooler, except the base is made up of cobbled together scrap metal, and the tank is a clouded fishbowl of green liquid.  Where the tap would be is a very thin, sharp spike, which feeds a dribble-tube that might flow into the tank itself."),
    symbol = "W",
    color = "blue",
    looks_like = "f_water_purifier",
    coverage = 70,
    move_cost = -1,
    flags = { "NOITEM", "NO_SCENT", "BLOCK_WIND" },
    examine_handler = "examine_t_nl_mission_water_cooler",
}

ccb.content.define_terrain {
    id = "t_nl_door_l",
    name = ccb.content.text("mysterious locked door"),
    looks_like = "t_door_metal_locked",
    description = ccb.content.text("A dark door of twisted metal, etched with symbols and writing that you can't piece together.  It appears to be locked."),
    symbol = "$",
    color = "blue",
    move_cost = -1,
    coverage = 100,
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "NOITEM",
        "CONNECT_WITH_WALL",
        "BLOCK_WIND",
        "SUPPORTS_ROOF",
        "LOCKED",
        "REDUCE_SCENT",
        "BARRICADABLE_DOOR",
        "DOOR",
    },
    prying = {
        result = "t_nl_door_o",
        message = ccb.content.text("With great effort, you pry open the door."),
        prying = {
            difficulty = 22,
            prying_level = 3,
            noisy = true,
            failure = ccb.content.text("You pry, but it seems like your tools will give out before the door does."),
        },
    },
    oxytorch = {
        result = "t_nl_scrap_floor",
        duration = "5 m",
        byproducts = { { item = "steel_plate", count = { 0, 1 } }, { item = "steel_chunk", count = { 3, 8 } } },
    },
    builtin_examine = "locked_object",
}

ccb.content.define_terrain {
    id = "t_nl_door_c",
    name = ccb.content.text("mysterious closed door"),
    looks_like = "t_door_metal_c",
    description = ccb.content.text("A dark door of twisted metal, etched with symbols and writing that you can't piece together."),
    symbol = "$",
    color = "blue",
    move_cost = -1,
    coverage = 100,
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "NOITEM",
        "CONNECT_WITH_WALL",
        "BLOCK_WIND",
        "SUPPORTS_ROOF",
        "REDUCE_SCENT",
        "BARRICADABLE_DOOR",
        "DOOR",
    },
    open = "t_nl_door_o",
}

ccb.content.define_terrain {
    id = "t_nl_door_o",
    name = ccb.content.text("mysterious open door"),
    looks_like = "t_door_metal_o",
    description = ccb.content.text("A dark door of twisted metal, etched with symbols and writing that you can't piece together.  It has been swung open."),
    symbol = "/",
    color = "blue",
    move_cost = 2,
    coverage = 20,
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "CONNECT_WITH_WALL",
        "BLOCK_WIND",
        "SUPPORTS_ROOF",
        "REDUCE_SCENT",
        "BARRICADABLE_DOOR",
        "OPENCLOSE_INSIDE",
        "TRANSPARENT",
        "FLAT",
        "ROAD",
    },
    close = "t_nl_door_c",
}

ccb.content.define_terrain {
    id = "t_nl_archway",
    name = ccb.content.text("mysterious archway"),
    looks_like = "t_nl_door_o",
    description = ccb.content.text("A heavy metal archway, etched with alien symbols."),
    symbol = "/",
    color = "blue",
    move_cost = 2,
    coverage = 20,
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "CONNECT_WITH_WALL", "SUPPORTS_ROOF", "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nl_archway_scarlet",
    name = ccb.content.text("mysterious archway"),
    looks_like = "t_nl_door_o",
    description = ccb.content.text("A heavy metal archway, etched with alien symbols."),
    symbol = "/",
    color = "blue",
    move_cost = 2,
    coverage = 20,
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "CONNECT_WITH_WALL", "SUPPORTS_ROOF", "TRANSPARENT", "FLAT", "ROAD" },
    emissions = { "emit_scarlet_sea_gas" },
}

ccb.content.define_terrain {
    id = "t_nl_safehouse_door_metal_corrugated_o",
    name = ccb.content.text("open corrugated metal door"),
    description = ccb.content.text("A thin, frameless door made of corrugated steel, flimsily attached to the wall.  You think it could be smashed down with a bit of effort, with no risk to the surrounding structure."),
    symbol = "'",
    looks_like = "t_door_metal_o",
    color = "cyan",
    move_cost = 2,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    close = "t_nl_safehouse_door_metal_corrugated_c",
    oxytorch = {
        result = "t_nl_metal_floor",
        duration = "24 seconds",
        byproducts = {
            { item = "scrap", count = { 4, 8 } },
            { item = "steel_plate" },
            { item = "hinge", count = { 1, 3 } },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_metal_floor",
        drops = {
            { item = "scrap", count = { 4, 8 } },
            { item = "steel_plate", chance = 75 },
            { item = "hinge", count = { 1, 3 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_safehouse_door_metal_corrugated_c",
    name = ccb.content.text("closed corrugated metal door"),
    description = ccb.content.text("A thin, frameless door made of corrugated steel, flimsily attached to the wall.  You think it could be smashed down with a bit of effort, with no risk to the surrounding structure"),
    symbol = "+",
    looks_like = "t_door_metal_c",
    color = "cyan",
    move_cost = 0,
    coverage = 95,
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "DOOR", "BLOCK_WIND" },
    open = "t_nl_safehouse_door_metal_corrugated_o",
    oxytorch = {
        result = "t_nl_metal_floor",
        duration = "24 seconds",
        byproducts = {
            { item = "scrap", count = { 4, 8 } },
            { item = "steel_plate" },
            { item = "hinge", count = { 1, 3 } },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_metal_floor",
        drops = {
            { item = "scrap", count = { 4, 8 } },
            { item = "steel_plate", chance = 75 },
            { item = "hinge", count = { 1, 3 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_metal_wall",
    name = ccb.content.text("metallic wall"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A durable wall of ordinary looking sheet metal, at first.  Staring closer, the welds and joins seem to form strange fractal patterns."),
    symbol = "-",
    color = "cyan",
    move_cost = 0,
    coverage = 100,
    roof = "t_nl_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    oxytorch = {
        result = "t_nl_broken_metal_floor",
        duration = "24 seconds",
        byproducts = {
            { item = "steel_plate", count = { 2, 3 } },
            { item = "steel_chunk", count = { 12, 20 } },
        },
    },
    bash = {
        minimum_strength = 150,
        maximum_strength = 400,
        sound = ccb.content.text("metal wailing!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_broken_metal_floor",
        drops = {
            { item = "steel_lump", count = { 1, 4 } },
            { item = "steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_safehouse_metal_wall",
    name = ccb.content.text("metallic wall"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A durable wall of sheet metal, unnaturally hard and cool to the touch.  It seems to lack any rivets, welds, or other connections."),
    symbol = "-",
    color = "cyan",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "NO_SCENT", "BLOCK_WIND" },
}

ccb.content.define_terrain {
    id = "t_nl_safehouse_metal_wall_wired",
    name = ccb.content.text("metallic wall"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A durable wall of sheet metal, unnaturally hard and cool to the touch.  It is covered in removable panels, which conceal well-organized pipes and wires.  Otherwise, the wall itself lacks any rivets, welds, or other connections."),
    symbol = "-",
    color = "cyan",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "NO_SCENT", "BLOCK_WIND", "WIRED_WALL" },
}

ccb.content.define_terrain {
    id = "t_nl_safehouse_metal_wall_wired_destructable",
    name = ccb.content.text("metallic wall"),
    looks_like = "t_wall_metal",
    description = ccb.content.text("A durable wall of sheet metal.  It is covered in removable panels, which conceal well-organized pipes and wires.  It also has several obvious rivet points that make it look like it could be removed with a bit of effort, with no risk to the surrounding structure."),
    symbol = "-",
    color = "cyan",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND", "WIRED_WALL" },
    oxytorch = {
        result = "t_nl_metal_floor",
        duration = "24 seconds",
        byproducts = {
            { item = "steel_plate", count = { 2, 3 } },
            { item = "steel_chunk", count = { 12, 20 } },
        },
    },
    bash = {
        minimum_strength = 150,
        maximum_strength = 400,
        sound = ccb.content.text("metal wailing!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_metal_floor",
        drops = {
            { item = "steel_lump", count = { 1, 4 } },
            { item = "steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_metal_wall_border",
    name = ccb.content.text("metallic wall"),
    copy_from = "t_nl_metal_wall",
    description = ccb.content.text("A durable wall of ordinary looking sheet metal, at first.  Staring closer, the welds and joins seem to form strange fractal patterns."),
    symbol = "-",
    color = "cyan",
    connect_groups = "WALL",
    connects_to = "WALL",
    bash = {
        minimum_strength = 150,
        maximum_strength = 400,
        sound = ccb.content.text("metal wailing!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_mist",
        drops = {
            { item = "steel_lump", count = { 1, 4 } },
            { item = "steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_scrap_wall",
    name = ccb.content.text("scrap metal wall"),
    looks_like = "t_scrap_wall",
    description = ccb.content.text("A relatively simple wall made of cobbled-together scrap metal.  The wires and bolts holding it together seem to be in just slightly different configurations whenever you look back at it."),
    symbol = "-",
    color = "dark_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_nl_roof",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "REDUCE_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
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
    id = "t_nl_metal_floor",
    name = ccb.content.text("metallic floor"),
    description = ccb.content.text("Diamond-treaded metallic flooring.  Something seems off about the diamond tread; you keep imagining that the bumps spell out words, but when you look closer they're in very ordinary patterns."),
    symbol = ".",
    color = "light_cyan",
    connect_groups = "METALFLOOR",
    connects_to = "METALFLOOR",
    looks_like = "t_metal_floor",
    move_cost = 2,
    roof = "t_nl_roof",
    flags = { "TRANSPARENT", "INDOORS", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_nl_broken_metal_floor",
        minimum_strength = 200,
        maximum_strength = 500,
        minimum_strength_supported = 200,
        drops = { { item = "steel_chunk", count = { 2, 4 } }, { item = "scrap", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_nl_broken_metal_floor",
    name = ccb.content.text("broken metal floor"),
    description = ccb.content.text("Something has cratered this metal flooring.  It will be difficult to move things across.  Through the cracks and dents emanates a faint eery glow."),
    symbol = ".",
    color = "light_cyan",
    move_cost = 2,
    roof = "t_nl_roof",
    flags = { "TRANSPARENT", "INDOORS" },
    looks_like = "t_broken_metal_floor",
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_nl_chasm",
        minimum_strength = 200,
        maximum_strength = 500,
        minimum_strength_supported = 200,
        drops = {
            { item = "steel_lump", count = { 1, 4 } },
            { item = "steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_scrap_floor",
    name = ccb.content.text("scrap metal floor"),
    description = ccb.content.text("A floor assembled from various scraps of metal.  Though their placement seems random, you keep seeing spots where they form faces."),
    symbol = ".",
    color = "cyan",
    move_cost = 2,
    roof = "t_nl_roof",
    looks_like = "t_scrap_floor",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 400,
        sound = ccb.content.text("SMASH!"),
        terrain = "t_nl_chasm",
        minimum_strength_supported = 100,
        drops = { { item = "steel_chunk", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_nl_catwalk",
    name = ccb.content.text("catwalk"),
    description = ccb.content.text("This catwalk extends over a deep chasm of swirling shadow."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 2,
    roof = "t_nl_roof",
    flags = { "TRANSPARENT", "INDOORS" },
    looks_like = "t_metal_floor",
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_nl_chasm",
        minimum_strength = 100,
        maximum_strength = 200,
        minimum_strength_supported = 100,
        drops = {
            { item = "steel_lump", count = { 1, 4 } },
            { item = "steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_nl_roof",
    name = ccb.content.text("swirling metal roof"),
    description = ccb.content.text("A section of sturdy metal roofing that seems to swirl and twist with an unfamiliar, ever-shifting pattern."),
    symbol = ".",
    looks_like = "t_metal_roof",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_nl_gates_mech_control",
    name = ccb.content.text("rotary lever"),
    description = ccb.content.text("A heavy-duty metal lever with two settings."),
    symbol = "6",
    color = "red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_nl_metal_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_nl_stairs_up",
    looks_like = "t_stairs_up",
    name = ccb.content.text("mysterious stairs"),
    description = ccb.content.text("A tightly wound spiral staircase vanishing into the depths above."),
    symbol = "<",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_UP", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_nl_stairs_up_false",
    looks_like = "t_nl_stairs_up",
    name = ccb.content.text("mysterious stairs"),
    description = ccb.content.text("A tightly wound spiral staircase going up.  However, it stops at the ceiling, perfectly flush with it, as if it were supposed to go up, but couldn't."),
    symbol = "<",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_nl_stairs_down",
    looks_like = "t_stairs_down",
    name = ccb.content.text("mysterious stairs"),
    description = ccb.content.text("A tightly wound spiral staircase vanishing into the depths below."),
    symbol = ">",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_DOWN", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_nl2_obelisk_altaros",
    copy_from = "t_nl_obelisk_0",
    name = ccb.content.text("Strange Obelisk"),
    description = ccb.content.text("A dark gray obelisk.  Despite its solid appearance, the face of it seems to slightly ripple, as if it were sand, loosely suspended in space.  The depths of the ripples scream with an eerie, green fluorescence."),
    symbol = "A",
    color = "dark_gray",
    light_color = { 220, 255, 200 },
    light_emitted = 200,
    examine_handler = "examine_t_nl2_obelisk_altaros",
}
