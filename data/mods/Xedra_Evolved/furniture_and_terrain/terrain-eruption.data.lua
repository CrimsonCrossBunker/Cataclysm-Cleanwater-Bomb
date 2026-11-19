local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_solid_fog",
    name = ccb.content.text("wall of fog"),
    looks_like = "fd_fog",
    description = ccb.content.text("A wall of swirling fog.  Despite its constant movement, it never spreads out or escapes the rough wall-shape it's in."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
}

-- use pillars, 't_column_obsidian', as a compliment.
ccb.content.define_terrain {
    id = "t_obsidian_wall",
    name = ccb.content.text("obsidian rock"),
    looks_like = "t_vitrified_wall",
    description = ccb.content.text("A rough wall of igneous stone.  It does not look like polished obsidian but you can see some resemblance."),
    symbol = "#",
    color = "light_gray",
    move_cost = 0,
    coverage = 100,
    roof = "t_obsidian_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "MINEABLE", "BLOCK_WIND" },
    bash = {
        minimum_strength = 120,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = {
            { item = "obsidian_rock", count = { 6, 12 } },
            { item = "material_rocksalt", count = { 0, 1 }, chance = 10 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_obsidian_floor",
    name = ccb.content.text("obsidian floor"),
    description = ccb.content.text("A relatively flat area of igneous rock.  Looks stable enough to be mined with the proper mining gear."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_vitrified_tile",
    connect_groups = { "OBSIDIANFLOOR", "INDOORFLOOR" },
    connects_to = "OBSIDIANFLOOR",
    move_cost = 2,
    roof = "t_obsidian_roof",
    flags = { "TRANSPARENT", "INDOORS", "COLLAPSES", "SUPPORTS_ROOF", "FLAT", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_column_obsidian",
    name = ccb.content.text("obsidian column"),
    looks_like = "t_vitrified_column",
    description = ccb.content.text("A natural column of igneous rock."),
    symbol = "1",
    color = "light_gray",
    move_cost = 0,
    coverage = 80,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "WALL", "PERMEABLE", "MINEABLE" },
    bash = {
        minimum_strength = 120,
        maximum_strength = 200,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_reb_cage",
        drops = { { item = "obsidian_rock", count = { 10, 22 } } },
    },
}

ccb.content.define_terrain {
    id = "t_obsidian_roof",
    name = ccb.content.text("obsidian roof"),
    description = ccb.content.text("A section of flat igneous rock."),
    looks_like = "t_vitrified_tile",
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_open_air",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_salamander_veins",
    name = ccb.content.text("salamander vein"),
    looks_like = "t_pillar",
    description = ccb.content.text("A vein of rare materials that appear during an eruption."),
    symbol = "1",
    color = "light_gray",
    move_cost = 0,
    coverage = 80,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "WALL", "PERMEABLE", "MINEABLE" },
    bash = {
        minimum_strength = 120,
        maximum_strength = 200,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_obsidian_floor",
        drops = {
            { item = "obsidian_rock", count = { 10, 22 } },
            { item = "copper", count = { 0, 750 }, chance = 80 },
            { item = "silver_small", count = { 0, 250 }, chance = 60 },
            { item = "gold_small", count = { 0, 100 }, chance = 40 },
            { item = "platinum_small", count = { 0, 25 }, chance = 20 },
            { item = "scrap_moon_tears", count = { 0, 10 }, chance = 10 },
        },
    },
}
