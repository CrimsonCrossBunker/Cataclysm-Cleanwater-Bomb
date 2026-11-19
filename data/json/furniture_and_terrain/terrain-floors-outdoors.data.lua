local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_grave",
    name = ccb.content.text("grave"),
    looks_like = "t_dirtmound",
    description = ccb.content.text("A dirt grave, with some grass growing on it.  At least some of the dead do actually rest in peace."),
    symbol = "#",
    color = "green",
    move_cost = 3,
    flags = { "TRANSPARENT", "DIGGABLE", "MOUNTABLE", "NOCOLLIDE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_dirt",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_grave_new",
    name = ccb.content.text("grave"),
    looks_like = "t_dirtmound",
    description = ccb.content.text("A fresh grave, covered with stones, either to keep something from digging it up or to keep one inside from digging out of it.  Or both.  Two planks mark this place of someone's eternal rest."),
    symbol = "#",
    color = "brown",
    move_cost = 3,
    flags = { "TRANSPARENT", "DIGGABLE", "MOUNTABLE", "NOCOLLIDE", "CONTAINER", "SEALED" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_dirt",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
    },
}

ccb.content.define_terrain {
    id = "t_rock_floor_no_roof",
    name = ccb.content.text("rock floor"),
    description = ccb.content.text("A relatively flat area of rock and stone.  Looks stable enough to be mined with the proper mining gear."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_rock_floor",
    connect_groups = "ROCKFLOOR",
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    roof = "t_open_air",
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_rubber_mulch",
    name = ccb.content.text("rubber mulch"),
    description = ccb.content.text("A large area mulched with shredded rubber.  It's a softer place to land than regular dirt."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 3,
    connect_groups = "MULCHFLOOR",
    connects_to = "MULCHFLOOR",
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
    id = "t_pavement",
    name = ccb.content.text("pavement"),
    connect_groups = "PAVEMENT",
    connects_to = "PAVEMENT",
    description = ccb.content.text("A segment of asphalt, slowly degrading from cracks, frost heaves, and lack of maintenance."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 10 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_pavement_y",
    name = ccb.content.text("yellow pavement"),
    connect_groups = { "PAVEMENT", "PAVEMENT_MARKING" },
    connects_to = "PAVEMENT_MARKING",
    description = ccb.content.text("Streaks of carefully aligned yellow paint mark the road to inform drivers not to cross.  No one is enforcing these rules anymore."),
    symbol = ".",
    color = "yellow",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 10 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_zebra",
    name = ccb.content.text("pedestrian crossing"),
    connect_groups = { "PAVEMENT", "PAVEMENT_ZEBRA" },
    connects_to = "PAVEMENT_ZEBRA",
    description = ccb.content.text("White polymer lines painted on the pavement which indicate places where pedestrians should cross the road."),
    symbol = ".",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 10 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sidewalk",
    name = ccb.content.text("sidewalk"),
    description = ccb.content.text("An area of common poured concrete, damaged by frost heaves and large cracks due to lack of maintenance."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_concrete",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    connect_groups = "CONCRETE",
    connects_to = "CONCRETE",
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 10 } } },
    },
}

ccb.content.define_terrain {
    id = "t_thconc_floor_no_roof",
    name = ccb.content.text("concrete floor"),
    description = ccb.content.text("A bare and cold concrete floor."),
    looks_like = "t_thconc_floor",
    symbol = ".",
    color = "cyan",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    connect_groups = "CONCRETE",
    connects_to = "CONCRETE",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 100,
        maximum_strength = 400,
        minimum_strength_supported = 150,
        drops = {
            { item = "rock", count = { 5, 10 } },
            { item = "scrap", count = { 5, 8 } },
            { item = "rebar", count = { 0, 2 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_strconc_floor_no_roof",
    name = ccb.content.text("reinforced concrete floor"),
    description = ccb.content.text("An extremely resilient floor made from carefully placed rebar and poured concrete, capable of providing protection from the elements.  As for the matching roof, it still requires supporting walls, otherwise it may very well cave in."),
    looks_like = "t_strconc_floor",
    symbol = ".",
    color = "cyan",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    connect_groups = "CONCRETE",
    connects_to = "CONCRETE",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 150,
        maximum_strength = 400,
        minimum_strength_supported = 200,
        drops = {
            { item = "rock", count = { 10, 22 } },
            { item = "scrap", count = { 10, 12 } },
            { item = "rebar", count = { 0, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_concrete",
    name = ccb.content.text("concrete"),
    description = ccb.content.text("A newer segment of poured concrete with surface finishes for aesthetics and resistance to freeze-thaw cycles."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_pavement",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    connect_groups = "CONCRETE",
    connects_to = "CONCRETE",
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 15 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_concrete_y",
    name = ccb.content.text("concrete"),
    description = ccb.content.text("A newer segment of poured concrete with surface finishes for aesthetics and resistance to freeze-thaw cycles.  Covered with a streak of yellow paint."),
    symbol = ".",
    color = "yellow",
    looks_like = "t_pavement_y",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD", "MINEABLE" },
    connect_groups = "CONCRETE",
    connects_to = "CONCRETE",
    bash = {
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "rock", count = { 2, 15 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_floor_noroof",
    name = ccb.content.text("wooden floor"),
    description = ccb.content.text("A wooden floor created from boards, packed tightly together and nailed down.  Common on patios."),
    symbol = ".",
    color = "brown",
    looks_like = "t_floor",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT", "ROAD" },
    connect_groups = "WOODFLOOR",
    connects_to = "WOODFLOOR",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = {
            { item = "splinter", count = { 2, 32 } },
            { item = "2x4", count = { 0, 8 } },
            { item = "nail", charges = { 5, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_floor_wooden_gangway",
    name = ccb.content.text("wooden floor gangway"),
    description = ccb.content.text("A wooden gangway bridging a short gap.  Sturdy enough to act as a floor, but not sufficient to support additional flooring."),
    symbol = ".",
    color = "brown",
    looks_like = "t_floor",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = {
            { item = "splinter", count = { 2, 32 } },
            { item = "2x4", count = { 0, 8 } },
            { item = "nail", charges = { 5, 10 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_metal_floor_no_roof",
    name = ccb.content.text("metal floor"),
    looks_like = "t_metal_floor",
    description = ccb.content.text("High-quality and tough checkered metal flooring to reduce the risk of slips and falls."),
    symbol = ".",
    color = "light_cyan",
    connect_groups = "METALFLOOR",
    connects_to = "METALFLOOR",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 200,
        maximum_strength = 500,
        minimum_strength_supported = 200,
        drops = {
            { item = "lc_steel_lump", count = { 1, 4 } },
            { item = "lc_steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_floor_metal_gangway",
    name = ccb.content.text("metal floor gangway"),
    looks_like = "t_metal_floor",
    description = ccb.content.text("A metal gangway bridging a short gap.  Sturdy enough to act as a floor, but not sufficient to support additional flooring."),
    symbol = ".",
    color = "light_cyan",
    connect_groups = "METALFLOOR",
    connects_to = "METALFLOOR",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 200,
        maximum_strength = 500,
        minimum_strength_supported = 200,
        drops = {
            { item = "lc_steel_lump", count = { 1, 4 } },
            { item = "lc_steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_linoleum_white_no_roof",
    name = ccb.content.text("linoleum tile"),
    looks_like = "t_linoleum_white",
    description = ccb.content.text("A section of flooring made out of a tough, rubbery material.  Colored a simple white."),
    symbol = ".",
    color = "white",
    connect_groups = "LINOLEUM",
    connects_to = "LINOLEUM",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "splinter", count = { 2, 8 } }, { item = "nail", charges = { 5, 10 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_linoleum_gray_no_roof",
    name = ccb.content.text("linoleum tile"),
    looks_like = "t_linoleum_gray",
    description = ccb.content.text("A section of flooring made out of a tough, gray, rubbery material."),
    symbol = ".",
    color = "light_gray",
    connect_groups = "LINOLEUM",
    connects_to = "LINOLEUM",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = { { item = "splinter", count = { 2, 8 } }, { item = "nail", charges = { 5, 10 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_dirtfloor_no_roof",
    name = ccb.content.text("dirt floor"),
    description = ccb.content.text("A floor consisting of finely mixed earth that has been tamped down."),
    symbol = ".",
    color = "brown",
    connect_groups = "DIRT",
    connects_to = "DIRT",
    move_cost = 2,
    looks_like = "t_dirtfloor",
    flags = { "TRANSPARENT", "FLAT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_gelatinous_groundcover",
    name = ccb.content.text("gelatinous ground"),
    description = ccb.content.text("An incursion of a large area of otherworldly substrate, it feels like walking on hardened gelatin."),
    symbol = ".",
    color = "pink",
    move_cost = 5,
    flags = { "TRANSPARENT", "FLAT" },
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
    id = "t_orifice",
    name = ccb.content.text("orifice"),
    description = ccb.content.text("A large round orifice, with trails of fresh and dried-up strange green liquid with a strongly acidic odor covering its inner sides."),
    symbol = "O",
    color = "green",
    looks_like = "t_pit",
    move_cost = 0,
    roof = "t_rock_floor",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL" },
}

ccb.content.define_terrain {
    id = "t_elevator_no_roof",
    name = ccb.content.text("elevator"),
    description = ccb.content.text("An elevator section of the flight deck."),
    symbol = ".",
    color = "dark_gray",
    looks_like = "t_elevator",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ELEVATOR" },
}

ccb.content.define_terrain {
    id = "t_deck_coating_no_roof",
    name = ccb.content.text("deck coating"),
    description = ccb.content.text("A thick metal hull coating, covered with a military-grade epoxy mix.  Used for runways, and can't be melted by jet engine nozzles."),
    symbol = ".",
    looks_like = "t_pavement",
    color = "dark_gray",
    connect_groups = "METALFLOOR",
    connects_to = "METALFLOOR",
    move_cost = 2,
    flags = { "FLAT", "ROAD", "TRANSPARENT" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 500,
        maximum_strength = 1000,
        minimum_strength_supported = 200,
        drops = {
            { item = "ch_steel_lump", count = { 1, 4 } },
            { item = "ch_steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_deck_coating_no_roof_y",
    name = ccb.content.text("yellow deck coating"),
    description = ccb.content.text("A thick metal hull covering, covered with a military-grade epoxy mix and painted yellow."),
    copy_from = "t_deck_coating_no_roof",
    looks_like = "t_pavement_y",
    flags = { "FLAT", "ROAD", "TRANSPARENT" },
    symbol = ".",
    color = "yellow",
}

ccb.content.define_terrain {
    id = "t_deck_coating_no_roof_r",
    name = ccb.content.text("red deck coating"),
    description = ccb.content.text("A thick metal hull covering, covered with a military-grade epoxy mix, and painted red."),
    copy_from = "t_deck_coating_no_roof",
    looks_like = " ",
    flags = { "FLAT", "ROAD", "TRANSPARENT" },
    symbol = ".",
    color = "red",
}

ccb.content.define_terrain {
    id = "t_deck_coating_no_roof_w",
    name = ccb.content.text("white deck coating"),
    description = ccb.content.text("A thick metal hull covering, covered with a military-grade epoxy mix and painted white."),
    copy_from = "t_deck_coating_no_roof",
    looks_like = " ",
    flags = { "FLAT", "ROAD", "TRANSPARENT" },
    symbol = ".",
    color = "white",
}

ccb.content.define_terrain {
    id = "t_stone_masonry_floor",
    name = ccb.content.text("stone masonry floor"),
    description = ccb.content.text("A floor of carefully cut and laid stones, joined with mortar."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_rock_floor",
    connect_groups = { "INDOORFLOOR", "ROCKFLOOR" },
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "SUPPORTS_ROOF", "INDOORS", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_stone_masonry_floor_balcony",
    name = ccb.content.text("stone masonry floor"),
    description = ccb.content.text("A floor of carefully cut and laid stones, joined with mortar."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_rock_floor",
    connect_groups = "ROCKFLOOR",
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_stone_road",
    name = ccb.content.text("cobblestone road"),
    description = ccb.content.text("Stone blocks carefully laid to create a durable road surface.  Moss and grass grow in the gaps between the stones."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_stone_masonry_floor",
    connect_groups = "ROCKFLOOR",
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_grate",
    name = ccb.content.text("metal grate"),
    description = ccb.content.text("A walkway that can be used as a protective covering over drains, or even as a filter."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT" },
}

ccb.content.define_terrain {
    id = "t_floor_red",
    name = ccb.content.text("red floor"),
    description = ccb.content.text("A red section of flooring."),
    symbol = ".",
    color = "red",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
}

ccb.content.define_terrain {
    id = "t_floor_green",
    name = ccb.content.text("green floor"),
    description = ccb.content.text("A green section of flooring."),
    symbol = ".",
    color = "green",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
}

ccb.content.define_terrain {
    id = "t_floor_blue",
    name = ccb.content.text("blue floor"),
    description = ccb.content.text("A blue section of flooring."),
    symbol = ".",
    color = "blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
}
