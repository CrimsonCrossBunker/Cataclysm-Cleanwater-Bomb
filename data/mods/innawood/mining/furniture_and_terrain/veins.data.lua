local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_bog_iron",
    name = ccb.content.text("bog iron"),
    description = ccb.content.text("A wet pit full of raw bog iron, suitable for bloomery refining if it was extracted properly."),
    symbol = "*",
    looks_like = "f_wreckage",
    color = "brown",
    move_cost = 6,
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
    id = "t_rock_coal",
    looks_like = "t_rockyobstacle",
    name = ccb.content.text("bituminous coal"),
    description = ccb.content.text("A vein of soft coal."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 3, 7 } }, { item = "coal_lump", charges = { 250, 500 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_halite",
    looks_like = "t_rock_smooth",
    name = ccb.content.text("halite"),
    description = ccb.content.text("A vein of salt."),
    symbol = "#",
    color = "white",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 3, 7 } }, { item = "material_rocksalt", count = { 1, 3 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_niter",
    name = ccb.content.text("niter"),
    description = ccb.content.text("A vein of saltpeter."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "material_niter", count = { 1, 3 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_brimstone",
    name = ccb.content.text("brimstone"),
    description = ccb.content.text("A vein of sulfur."),
    symbol = "#",
    color = "yellow",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_sulfur", count = { 1, 3 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_copper",
    looks_like = "t_rock_green",
    name = ccb.content.text("native copper"),
    description = ccb.content.text("A vein of copper."),
    symbol = "#",
    color = "light_red",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_copper", count = { 1, 3 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_silver",
    name = ccb.content.text("native silver"),
    description = ccb.content.text("A vein of silver."),
    symbol = "#",
    color = "white",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_silver", count = { 1, 2 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_gold",
    name = ccb.content.text("native gold"),
    description = ccb.content.text("A glittering vein of gold."),
    symbol = "#",
    color = "yellow",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 3, 7 } }, { item = "chunk_gold", count = { 1, 2 }, chance = 80 } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_aluminum",
    name = ccb.content.text("native aluminum"),
    description = ccb.content.text("A vein of aluminum."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_aluminum", count = { 1, 3 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_cassiterite",
    looks_like = "t_rock_wall",
    name = ccb.content.text("cassiterite"),
    description = ccb.content.text("A deposit of cassiterite."),
    symbol = "#",
    color = "brown",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_cassiterite", count = { 2, 4 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_galena",
    looks_like = "t_rock_red",
    name = ccb.content.text("galena"),
    description = ccb.content.text("A deposit of galena."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_galena", count = { 2, 4 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_hematite",
    looks_like = "t_rock_red",
    name = ccb.content.text("hematite"),
    description = ccb.content.text("A deposit of hematite."),
    symbol = "#",
    color = "brown",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_hematite", count = { 2, 4 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_feldspar",
    looks_like = "t_rock_blue",
    name = ccb.content.text("feldspar"),
    description = ccb.content.text("A deposit of feldspar."),
    symbol = "#",
    color = "brown",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_feldspar", count = { 2, 5 }, chance = 80 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_graphite",
    looks_like = "t_nether_glass_wall",
    name = ccb.content.text("graphite"),
    description = ccb.content.text("A deposit of graphite."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "MINEABLE" },
    roof = "t_rock_floor",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "rock", count = { 3, 7 } },
            { item = "chunk_graphite", count = { 2, 5 }, chance = 80 },
        },
    },
}
