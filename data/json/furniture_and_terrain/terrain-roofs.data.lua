local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_open_air_rooved_outside",
    name = ccb.content.text("open air"),
    description = ccb.content.text("An area of open air."),
    symbol = " ",
    color = "i_cyan",
    move_cost = 2,
    roof = "t_flat_roof",
    flags = { "TRANSPARENT", "NO_FLOOR", "EMPTY_SPACE", "FREE_TO_EXAMINE" },
    builtin_examine = "ledge",
}

ccb.content.define_terrain {
    id = "t_open_air_rooved",
    name = ccb.content.text("open air"),
    description = ccb.content.text("An area of open air."),
    symbol = " ",
    color = "i_cyan",
    move_cost = 2,
    roof = "t_flat_roof",
    builtin_examine = "ledge",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NO_FLOOR", "INDOORS", "EMPTY_SPACE", "FREE_TO_EXAMINE" },
}

ccb.content.define_terrain {
    id = "t_open_air",
    name = ccb.content.text("open air"),
    description = ccb.content.text("An area of open air."),
    symbol = " ",
    color = "i_cyan",
    move_cost = 2,
    flags = { "TRANSPARENT", "NO_FLOOR", "EMPTY_SPACE", "FREE_TO_EXAMINE" },
    builtin_examine = "ledge",
}

ccb.content.define_terrain {
    id = "t_gutter",
    description = ccb.content.text("Channels water from the roof towards the ground, it looks flimsy."),
    name = ccb.content.text("rain gutter"),
    symbol = "#",
    looks_like = "t_metal_floor",
    color = "white",
    move_cost = 3,
    flags = { "TRANSPARENT", "THIN_OBSTACLE", "MOUNTABLE", "TINY", "AUTO_WALL_SYMBOL", "UNSTABLE" },
    connect_groups = "RAILING",
    connects_to = "RAILING",
    deconstruct = { terrain = "t_flat_roof", drops = { { item = "scrap_aluminum", count = 12 } } },
    bash = {
        minimum_strength = 5,
        maximum_strength = 12,
        sound = ccb.content.text("clang!"),
        failure_sound = ccb.content.text("clang."),
        terrain = "t_flat_roof",
        drops = { { item = "scrap_aluminum", count = { 4, 7 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gutter_drop",
    name = ccb.content.text("gutter drop"),
    description = ccb.content.text("A spot in the gutter where the water flows into a downspout.  It looks flimsy.  You may be able to climb down here."),
    symbol = "o",
    looks_like = "t_gutter",
    color = "white",
    move_cost = 3,
    flags = {
        "TRANSPARENT",
        "THIN_OBSTACLE",
        "MOUNTABLE",
        "TINY",
        "AUTO_WALL_SYMBOL",
        "UNSTABLE",
        "CLIMBABLE",
    },
    connect_groups = "RAILING",
    connects_to = "RAILING",
    deconstruct = { terrain = "t_flat_roof", drops = { { item = "scrap_aluminum", count = 12 } } },
    bash = {
        minimum_strength = 5,
        maximum_strength = 12,
        sound = ccb.content.text("clang!"),
        failure_sound = ccb.content.text("clang."),
        terrain = "t_flat_roof",
        drops = { { item = "scrap_aluminum", count = { 4, 7 } } },
    },
}

-- 撤销 PR #84430 — 恢复排水管可攀爬
ccb.content.define_terrain {
    id = "t_gutter_downspout",
    name = ccb.content.text("downspout"),
    description = ccb.content.text("A length of gutter running from the roof to the ground, you could place a container underneath it to collect rainwater.  It looks flimsy.  You may be able to climb up here."),
    symbol = "|",
    looks_like = "t_chainfence_posts",
    color = "white",
    move_cost = 3,
    trap = "tr_downspout_funnel",
    flags = { "TRANSPARENT", "THIN_OBSTACLE", "UNSTABLE", "CLIMBABLE" },
    deconstruct = { terrain = "t_flat_roof", drops = { { item = "scrap_aluminum", count = 12 } } },
    bash = {
        minimum_strength = 5,
        maximum_strength = 12,
        sound = ccb.content.text("clang!"),
        failure_sound = ccb.content.text("clang."),
        terrain = "t_dirt",
        drops = { { item = "scrap_aluminum", count = { 4, 7 } } },
    },
}

ccb.content.define_terrain {
    id = "t_flat_roof",
    name = ccb.content.text("flat roof"),
    description = ccb.content.text("A flat, gray section of rooftop."),
    symbol = ".",
    looks_like = "t_concrete",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_tar_flat_roof",
    name = ccb.content.text("tar paper flat roof"),
    description = ccb.content.text("A flat, gray section of rooftop covered with tar paper."),
    looks_like = "t_flat_roof",
    symbol = ".",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE", "FLAT" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_shingle_flat_roof",
    name = ccb.content.text("shingle flat roof"),
    description = ccb.content.text("A flat section of rooftop covered with shingles."),
    looks_like = "t_flat_roof",
    symbol = ".",
    color = "green",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE", "FLAT" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_thatch_roof",
    name = ccb.content.text("thatched roof"),
    description = ccb.content.text("A section of roof made out of straw."),
    looks_like = "t_flat_roof",
    symbol = ".",
    color = "yellow",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_metal_flat_roof",
    name = ccb.content.text("metal flat roof"),
    description = ccb.content.text("A section of flat, sheet metal rooftop."),
    looks_like = "t_flat_roof",
    symbol = ".",
    color = "light_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_tile_flat_roof",
    name = ccb.content.text("tile flat roof"),
    description = ccb.content.text("A section of flat, tiled rooftop."),
    looks_like = "t_flat_roof",
    symbol = ".",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "FLAMMABLE" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

-- TODO: Should break when you step on it if there's no supporting terrain below, might want some warning akin to examine_action ledge
ccb.content.define_terrain {
    id = "t_glass_roof",
    name = ccb.content.text("skylight"),
    description = ccb.content.text("A giant sheet of glass inserted into the roof to let light pass through."),
    symbol = "o",
    looks_like = "t_linoleum_white",
    color = "cyan",
    move_cost = 2,
    flags = { "TRANSPARENT", "TRANSPARENT_FLOOR" },
    bash = {
        minimum_strength = 3,
        maximum_strength = 6,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_skylight_frame",
        drops = { { item = "glass_shard", count = { 21, 29 } } },
    },
}

ccb.content.define_terrain {
    id = "t_rock_roof",
    name = ccb.content.text("rock roof"),
    description = ccb.content.text("A section of flat natural rock."),
    looks_like = "t_rock_floor",
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_drystone_roof",
    name = ccb.content.text("drystone roof"),
    description = ccb.content.text("A section of sturdy rooftop made of tightly-fitted stone tiles without mortar."),
    looks_like = "t_rock_roof",
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
    bash = {
        minimum_strength = 48,
        maximum_strength = 80,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
        drops = {
            { item = "field_stone", count = { 500, 800 } },
            { item = "rock", count = { 200, 400 } },
            { item = "pebble", count = { 100, 200 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_warped_roof",
    name = ccb.content.text("warped roof"),
    description = ccb.content.text("A section of flat, stone-like rooftop.  It is patterned with grooves and lines that constantly shift."),
    symbol = ".",
    color = "magenta",
    move_cost = 2,
    flags = { "FLAT" },
}

ccb.content.define_terrain {
    id = "t_roof_paper",
    name = ccb.content.text("flat roof"),
    description = ccb.content.text("A flat surface made of ambiguous pulpy matter, covered in sticky wasp saliva."),
    symbol = ".",
    looks_like = "t_paper",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_roof_paper_hard",
    name = ccb.content.text("flat roof"),
    description = ccb.content.text("A flat surface made of hardened, ambiguous pulpy matter, covered in sticky wasp saliva."),
    symbol = ".",
    looks_like = "t_paper",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT" },
    bash = {
        minimum_strength = 25,
        maximum_strength = 150,
        minimum_strength_supported = 40,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 15,
        failure_volume = 10,
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_concrete_roof",
    name = ccb.content.text("concrete roof"),
    description = ccb.content.text("A flat section of concrete rooftop."),
    symbol = ".",
    looks_like = "t_thconc_floor",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_wood_roof",
    name = ccb.content.text("wooden roof"),
    description = ccb.content.text("A flat section of wooden rooftop."),
    looks_like = "t_floor",
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE", "FLAT" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_wood_treated_roof",
    name = ccb.content.text("treated wooden roof"),
    description = ccb.content.text("A flat section of flame-resistant wooden rooftop."),
    looks_like = "t_floor",
    symbol = ".",
    color = "brown",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "FLAT" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_metal_roof",
    name = ccb.content.text("metal roof"),
    description = ccb.content.text("A high-quality and sturdy section of metallic rooftop."),
    symbol = ".",
    looks_like = "t_scrap_floor",
    color = "dark_gray",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 200,
        maximum_strength = 500,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_metal_roof_red",
    name = ccb.content.text("red metal roof"),
    description = ccb.content.text("A sturdy section of metallic rooftop, painted red for visibility and weather resistance."),
    symbol = ".",
    looks_like = "t_metal_roof",
    color = "red",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 200,
        maximum_strength = 500,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_metal_roof_sloped",
    name = ccb.content.text("sloped metal roof"),
    description = ccb.content.text("A high-quality and sturdy section of metallic rooftop that is slightly sloped toward some point."),
    symbol = ".",
    looks_like = "t_scrap_floor",
    color = "dark_gray",
    move_cost = 4,
    flags = { "TRANSPARENT", "UNSTABLE" },
    bash = {
        minimum_strength = 200,
        maximum_strength = 500,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_log_sod_roof",
    name = ccb.content.text("sod roof"),
    description = ccb.content.text("A section of rooftop made out of sod."),
    looks_like = "t_flat_roof",
    symbol = ".",
    color = "green",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 210,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_brick_roof",
    name = ccb.content.text("brick roof"),
    description = ccb.content.text("A section of brick rooftop."),
    symbol = ".",
    color = "red",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 48,
        maximum_strength = 80,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_canvas_roof",
    name = ccb.content.text("canvas roof"),
    description = ccb.content.text("A section of canvas rooftop."),
    symbol = ".",
    color = "blue",
    move_cost = 2,
    flags = { "TRANSPARENT", "FLAMMABLE_HARD" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 8,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        terrain = "t_null",
        bash_below = false,
    },
}

ccb.content.define_terrain {
    id = "t_treetop",
    name = ccb.content.text("treetop"),
    description = ccb.content.text("The upper branches of a tree.  There's just enough room to perch here."),
    symbol = "#",
    color = { "light_green", "green", "yellow_yellow", "brown" },
    move_cost = 8,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "UNSTABLE", "CLIMBABLE", "SINGLE_SUPPORT" },
}

ccb.content.define_terrain {
    id = "t_treetop_evergreen",
    name = ccb.content.text("treetop"),
    description = ccb.content.text("The upper branches of a tree.  There's just enough room to perch here."),
    symbol = "#",
    color = { "green" },
    move_cost = 8,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "UNSTABLE", "SINGLE_SUPPORT" },
}

ccb.content.define_terrain {
    id = "t_treetop_dead",
    name = ccb.content.text("dead treetop"),
    description = ccb.content.text("The bare upper branches of a dead tree.  There's just enough room to perch here."),
    symbol = "#",
    color = "brown",
    move_cost = 8,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "UNSTABLE", "SINGLE_SUPPORT" },
}

ccb.content.define_terrain {
    id = "t_treetop_giant_fern",
    name = ccb.content.text("giant fern top"),
    description = ccb.content.text("The top of some unearthly gigantic fern.  There is enough room to perch up here, but only just."),
    symbol = "#",
    color = "red",
    move_cost = 8,
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "UNSTABLE", "SINGLE_SUPPORT" },
}
