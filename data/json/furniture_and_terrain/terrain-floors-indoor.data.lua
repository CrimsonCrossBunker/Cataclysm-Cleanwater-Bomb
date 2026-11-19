local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_thconc_floor",
    name = ccb.content.text("concrete floor"),
    description = ccb.content.text("A bare and cold concrete floor that can support a roof, could still insulate from the outdoors but roof collapse is possible if supporting walls are broken down."),
    symbol = ".",
    color = "cyan",
    move_cost = 2,
    roof = "t_concrete_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
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
    id = "t_thconc_y",
    name = ccb.content.text("concrete floor"),
    description = ccb.content.text("A bare and cold concrete floor with a streak of yellow paint, could still insulate from the outdoors but roof collapse is possible if supporting walls are broken down."),
    symbol = ".",
    color = "yellow",
    looks_like = "t_pavement_y",
    move_cost = 2,
    roof = "t_concrete_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
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
    id = "t_thconc_r",
    name = ccb.content.text("concrete floor"),
    description = ccb.content.text("A bare and cold concrete floor with a streak of red paint, could still insulate from the outdoors but roof collapse is possible if supporting walls are broken down."),
    symbol = ".",
    color = "red",
    looks_like = "t_floor_red",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    move_cost = 2,
    roof = "t_concrete_roof",
    copy_from = "t_thconc_floor",
}

ccb.content.define_terrain {
    id = "t_thconc_warning",
    name = ccb.content.text("concrete floor"),
    description = ccb.content.text("A bare and cold concrete floor with painted stripes of black and yellow, could still insulate from the outdoors but roof collapse is possible if supporting walls are broken down."),
    symbol = ".",
    color = "dark_gray",
    looks_like = "t_thconc_warning",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    move_cost = 2,
    roof = "t_concrete_roof",
    copy_from = "t_thconc_floor",
}

ccb.content.define_terrain {
    id = "t_thconc_y_olight",
    name = ccb.content.text("concrete floor"),
    description = ccb.content.text("A bare and cold concrete floor with a streak of yellow paint and a still-functioning light attached to the ceiling above, could still insulate from the outdoors but roof collapse is possible if supporting walls are broken down."),
    symbol = ".",
    color = "yellow",
    light_emitted = 120,
    looks_like = "t_thconc_y",
    move_cost = 2,
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    roof = "t_concrete_roof",
    copy_from = "t_thconc_floor",
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_thconc_y",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_thconc_floor_olight",
    name = ccb.content.text("concrete floor, overhead light"),
    description = ccb.content.text("A bare and cold concrete floor with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "white",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_concrete_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_thconc_floor",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_floor_olight",
    name = ccb.content.text("wooden floor, overhead light"),
    description = ccb.content.text("Interlocking wooden tiles that are more than likely treated against fire, with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "white",
    connect_groups = { "INDOORFLOOR", "WOODFLOOR" },
    connects_to = "WOODFLOOR",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_wood_roof",
    looks_like = "t_floor",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_floor",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_brick_floor",
    name = ccb.content.text("brick floor"),
    description = ccb.content.text("A relatively flat area made of tightly placed bricks.  Can support a roof."),
    symbol = ".",
    color = "light_red",
    connect_groups = { "BRICKFLOOR", "INDOORFLOOR" },
    connects_to = "BRICKFLOOR",
    move_cost = 2,
    roof = "t_brick_roof",
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
    id = "t_dirtfloor_olight",
    name = ccb.content.text("dirt floor, overhead light"),
    description = ccb.content.text("A floor consisting of finely mixed earth that has been tamped down, with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "brown",
    connect_groups = { "DIRT", "INDOORFLOOR" },
    connects_to = "DIRT",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_shingle_flat_roof",
    looks_like = "t_dirtfloor",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "DIGGABLE" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_dirtfloor",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_metal_floor_olight",
    name = ccb.content.text("metal floor, with overhead light"),
    description = ccb.content.text("High-quality and tough checkered metal flooring to reduce the risk of slips and falls, with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "light_cyan",
    connect_groups = { "INDOORFLOOR", "METALFLOOR" },
    connects_to = "METALFLOOR",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_metal_roof",
    flags = { "TRANSPARENT", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_metal_floor",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_strconc_floor_olight",
    name = ccb.content.text("strong concrete floor, overhead light"),
    description = ccb.content.text("An extremely resilient floor made from carefully placed rebar and poured concrete, with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "white",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_concrete_roof",
    looks_like = "t_thconc_floor_olight",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "ROAD" },
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_strconc_floor",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_linoleum_gray_floor_olight",
    name = ccb.content.text("gray linoleum floor, overhead light"),
    description = ccb.content.text("Linoleum flooring with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "white",
    connect_groups = { "INDOORFLOOR", "LINOLEUM" },
    connects_to = "LINOLEUM",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_flat_roof",
    looks_like = "t_linoleum_gray",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_linoleum_gray",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_linoleum_whitefloor_olight",
    name = ccb.content.text("white linoleum floor, overhead light"),
    description = ccb.content.text("Linoleum flooring with a still-functioning light attached to the ceiling above."),
    symbol = ".",
    color = "white",
    connect_groups = { "INDOORFLOOR", "LINOLEUM" },
    connects_to = "LINOLEUM",
    move_cost = 2,
    light_emitted = 120,
    roof = "t_flat_roof",
    looks_like = "t_linoleum_white",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 4,
        maximum_strength = 12,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        volume = 16,
        failure_volume = 10,
        terrain = "t_linoleum_white",
        drops = { { item = "glass_shard", count = { 8, 16 } } },
    },
    shoot = {
        chance_to_hit = 0,
        reduce_damage = { 0, 0 },
        reduce_damage_laser = { 0, 0 },
        destroy_damage = { 2, 8 },
    },
}

ccb.content.define_terrain {
    id = "t_ov_smreb_cage",
    name = ccb.content.text("small rebar roof cage"),
    description = ccb.content.text("A series of structural supports crafted from rebar in order to allow the pouring of concrete for a more stable floor and roof support."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 4,
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES" },
    bash = {
        sound = ccb.content.text("SCRRRASH!"),
        terrain = "t_null",
        minimum_strength = 100,
        maximum_strength = 400,
        minimum_strength_supported = 150,
        drops = { { item = "scrap", count = { 5, 8 } }, { item = "rebar", count = { 0, 2 } } },
    },
}

ccb.content.define_terrain {
    id = "t_strconc_floor",
    name = ccb.content.text("reinforced concrete floor"),
    description = ccb.content.text("An extremely resilient floor made from carefully placed rebar and poured concrete, capable of providing protection from the elements.  It can support a roof, but that still requires supporting walls, otherwise it may very well cave in."),
    symbol = ".",
    color = "cyan",
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    move_cost = 2,
    roof = "t_concrete_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
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
    id = "t_strconc_floor_glimmer",
    name = ccb.content.text("fractured concrete floor"),
    description = ccb.content.text("Thin strands of violet light shimmer in the air above this concrete floor, like cracks upon a pane of glass.  It can support a roof."),
    looks_like = "t_strconc_floor",
    symbol = ".",
    color = "cyan",
    connect_groups = { "CONCRETE", "INDOORFLOOR" },
    connects_to = "CONCRETE",
    emissions = { "emit_plasma_continuously" },
    move_cost = 2,
    roof = "t_concrete_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    trap = "tr_glimmer_floor",
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
    id = "t_ov_reb_cage",
    name = ccb.content.text("rebar roof cage"),
    description = ccb.content.text("A network of architecturally sound rebar in order to support a floor and roof support, looks like it's missing the poured concrete."),
    symbol = ".",
    color = "dark_gray",
    move_cost = 4,
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES" },
    bash = {
        sound = ccb.content.text("SCRRRASH!"),
        terrain = "t_null",
        minimum_strength = 100,
        maximum_strength = 400,
        minimum_strength_supported = 150,
        drops = { { item = "scrap", count = { 10, 12 } }, { item = "rebar", count = { 0, 4 } } },
    },
}

ccb.content.define_terrain {
    id = "t_strconc_floor_halfway",
    name = ccb.content.text("half-built reinforced concrete floor"),
    description = ccb.content.text("An unfinished construction of rebar and poured concrete; the floor hasn't been smoothed and the roof support isn't quite filled in yet."),
    symbol = ".",
    color = "cyan",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = {
            { item = "rock", count = { 5, 11 } },
            { item = "scrap", count = { 10, 12 } },
            { item = "rebar", count = { 0, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_rock_floor",
    name = ccb.content.text("rock floor"),
    description = ccb.content.text("A relatively flat area of rock and stone.  Looks stable enough to be mined with the proper mining gear.  Can support a roof."),
    symbol = ".",
    color = "light_gray",
    connect_groups = { "INDOORFLOOR", "ROCKFLOOR" },
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    roof = "t_rock_roof",
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
    id = "t_marble_floor",
    name = ccb.content.text("marble floor"),
    description = ccb.content.text("A smooth and flat flooring made of marble tiles.  Beautiful and expensive.  Can support a roof."),
    looks_like = "t_rock_floor",
    symbol = ".",
    color = "light_gray",
    connect_groups = { "INDOORFLOOR", "MARBLEFLOOR" },
    connects_to = "MARBLEFLOOR",
    move_cost = 2,
    roof = "t_rock_roof",
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
    id = "t_floor_warped",
    name = ccb.content.text("warped stone floor"),
    description = ccb.content.text("A rough stone floor.  Its patterns constantly shift as if your mind can't quite understand what it's really seeing.  Can support a roof."),
    symbol = ".",
    color = "magenta",
    connect_groups = { "INDOORFLOOR", "ROCKFLOOR" },
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    roof = "t_warped_roof",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_floor_warped_light",
    looks_like = "t_floor_warped",
    name = ccb.content.text("warped stone floor"),
    description = ccb.content.text("A rough stone floor.  Its patterns constantly shift as if your mind can't quite understand what it's really seeing.  Can support a roof."),
    symbol = ".",
    color = "magenta",
    connect_groups = { "INDOORFLOOR", "ROCKFLOOR" },
    connects_to = "ROCKFLOOR",
    move_cost = 2,
    light_emitted = 50,
    roof = "t_warped_roof",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_highland_mosaic",
    name = ccb.content.text("mosaic floor"),
    copy_from = "t_marble_floor",
    looks_like = "t_floor_blue",
    description = ccb.content.text("A mosaic floor made from colored stones arranged into fanciful patterns."),
}

ccb.content.define_terrain {
    id = "t_highland_bronze_floor",
    name = ccb.content.text("bronze steps"),
    copy_from = "t_marble_floor",
    looks_like = "t_metal_floor",
    description = ccb.content.text("Large steps made of bronze, stained green with age, that lead up to nothing."),
}

ccb.content.define_terrain {
    id = "t_highland_bronze_floor_inactive",
    name = ccb.content.text("bronze steps"),
    copy_from = "t_marble_floor",
    looks_like = "t_metal_floor",
    description = ccb.content.text("Large steps made of bronze, stained green with age, that lead up to nothing."),
}

ccb.content.define_terrain {
    id = "t_metal_floor",
    name = ccb.content.text("metal floor"),
    description = ccb.content.text("High-quality and tough checkered metal flooring to reduce the risk of slips and falls.  Can support a roof."),
    symbol = ".",
    color = "light_cyan",
    connect_groups = { "INDOORFLOOR", "METALFLOOR" },
    connects_to = "METALFLOOR",
    move_cost = 2,
    roof = "t_metal_roof",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
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
    id = "t_broken_metal_floor",
    name = ccb.content.text("broken metal floor"),
    description = ccb.content.text("Something has cratered this metal flooring.  It will be difficult to move things across."),
    symbol = ".",
    color = "light_cyan",
    move_cost = 2,
    roof = "t_metal_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "INDOORS" },
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
    id = "t_floor",
    name = ccb.content.text("floor"),
    description = ccb.content.text("Interlocking wooden tiles that are more than likely treated against fire, with wooden posts and beams that can support a roof."),
    symbol = ".",
    color = "cyan",
    connect_groups = { "INDOORFLOOR", "WOODFLOOR" },
    connects_to = "WOODFLOOR",
    move_cost = 2,
    comfort = 1,
    roof = "t_wood_treated_roof",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
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
    id = "t_floor_primitive",
    name = ccb.content.text("primitive floor"),
    description = ccb.content.text("A timber floor and supports that can support a roof."),
    symbol = ".",
    color = "brown",
    looks_like = "t_dirtfloor",
    move_cost = 2,
    roof = "t_log_sod_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        drops = {
            { item = "log", count = { 0, 1 } },
            { item = "stick", count = { 1, 4 } },
            { item = "splinter", count = { 1, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_floor_rotted",
    looks_like = "t_floor",
    name = ccb.content.text("rotten floor"),
    description = ccb.content.text("What would have once been a sturdy wooden floor is now a half-rotten wreck.  You're not sure how safe walking on this would be."),
    symbol = ".",
    color = "cyan",
    connect_groups = { "INDOORFLOOR", "WOODFLOOR" },
    connects_to = "WOODFLOOR",
    move_cost = 2,
    comfort = 1,
    roof = "t_wood_treated_roof",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
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
    id = "t_scrap_floor",
    name = ccb.content.text("simple metal floor"),
    description = ccb.content.text("A crudely welded-together metal floor with steel trusses and supporting girders.  Can support a roof."),
    symbol = ".",
    color = "cyan",
    move_cost = 2,
    roof = "t_metal_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 400,
        sound = ccb.content.text("SMASH!"),
        terrain = "t_null",
        minimum_strength_supported = 100,
        drops = { { item = "lc_steel_chunk", count = { 5, 11 } } },
    },
}

ccb.content.define_terrain {
    id = "t_floor_waxed",
    name = ccb.content.text("waxed floor"),
    description = ccb.content.text("Hardwood flooring that has been treated with chemicals to improve slip resistance and sliding, commonly for recreational sports.  It can support a roof."),
    symbol = ".",
    color = "light_red",
    connect_groups = { "INDOORFLOOR", "WOODFLOOR" },
    connects_to = "WOODFLOOR",
    move_cost = 2,
    comfort = 1,
    roof = "t_wood_treated_roof",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
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
    id = "t_dirtfloor",
    name = ccb.content.text("dirt floor"),
    description = ccb.content.text("A floor consisting of finely mixed earth that has been tamped down.  It can support a roof."),
    symbol = ".",
    color = "brown",
    connect_groups = { "DIRT", "INDOORFLOOR" },
    connects_to = "DIRT",
    move_cost = 2,
    roof = "t_shingle_flat_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 1,
        maximum_strength = 6,
        volume = 8,
        failure_volume = 8,
        drops = { { item = "material_soil", count = { 1, 2 } } },
    },
}

-- Redundant version of t_dirtfloor
ccb.content.define_terrain {
    id = "t_dirtfloor_thatchroof",
    name = ccb.content.text("dirt floor"),
    description = ccb.content.text("A floor consisting of finely mixed earth that has been tamped down.  It can support a roof."),
    symbol = ".",
    color = "brown",
    looks_like = "t_dirtfloor",
    connect_groups = { "DIRT", "INDOORFLOOR" },
    connects_to = "DIRT",
    move_cost = 2,
    roof = "t_thatch_roof",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 5,
        maximum_strength = 15,
        volume = 8,
        failure_volume = 8,
        drops = { { item = "splinter", count = { 2, 8 } }, { item = "straw_pile", count = { 5, 10 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
}

ccb.content.define_terrain {
    id = "t_utility_light",
    name = ccb.content.text("utility light"),
    description = ccb.content.text("An industrial floodlight set up to illuminate the surroundings.  Smashing it doesn't seem like it'd produce any worthwhile salvage."),
    symbol = ".",
    color = "white",
    connect_groups = { "INDOORFLOOR", "WOODFLOOR" },
    connects_to = "WOODFLOOR",
    move_cost = 2,
    roof = "t_flat_roof",
    light_emitted = 240,
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_HARD",
        "SUPPORTS_ROOF",
        "COLLAPSES",
        "INDOORS",
        "FLAT",
        "ROAD",
        "MINEABLE",
    },
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
    id = "t_floor_wax",
    name = ccb.content.text("wax floor"),
    description = ccb.content.text("A floor section made entirely out of wax."),
    symbol = ".",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "INDOORS", "FLAT" },
}

ccb.content.define_terrain {
    id = "t_elevator",
    name = ccb.content.text("elevator"),
    description = ccb.content.text("The interior section of an elevator."),
    symbol = ".",
    color = "magenta",
    move_cost = 2,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "INDOORS", "TRANSPARENT", "FLAT", "ELEVATOR" },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base",
    name = ccb.content.text("carpet"),
    description = ccb.content.text("Base carpet!"),
    symbol = ".",
    color = "red",
    connect_groups = { "CARPET", "INDOORFLOOR" },
    connects_to = "CARPET",
    move_cost = 2,
    comfort = 1,
    roof = "t_flat_roof",
    flags = {
        "TRANSPARENT",
        "FLAMMABLE_HARD",
        "SUPPORTS_ROOF",
        "COLLAPSES",
        "INDOORS",
        "FLAT",
        "RUG",
        "EASY_DECONSTRUCT",
    },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_floor",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
            { item = "nail", charges = { 1, 3 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_red",
    copy_from = "t_carpet_base",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet.  Can support a roof."),
    color = "red",
    deconstruct = {
        drops = { { item = "r_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_yellow",
    copy_from = "t_carpet_base",
    name = ccb.content.text("yellow carpet"),
    description = ccb.content.text("Soft yellow carpet.  Can support a roof."),
    color = "yellow",
    deconstruct = {
        drops = { { item = "y_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_green",
    copy_from = "t_carpet_base",
    name = ccb.content.text("green carpet"),
    description = ccb.content.text("Soft green carpet.  Can support a roof."),
    color = "green",
    deconstruct = {
        drops = { { item = "g_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_purple",
    copy_from = "t_carpet_base",
    name = ccb.content.text("purple carpet"),
    description = ccb.content.text("Soft purple carpet.  Can support a roof."),
    color = "magenta",
    deconstruct = {
        drops = { { item = "p_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor",
    },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_wood",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_floor_noroof",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
            { item = "nail", charges = { 1, 3 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_wood_red",
    copy_from = "t_carpet_base_wood",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet on a wooden floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = {
        terrain = "t_floor_noroof",
        drops = { { item = "r_carpet", charges = 1 }, { item = "nail", charges = 5 } },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_wood_yellow",
    copy_from = "t_carpet_base_wood",
    name = ccb.content.text("yellow carpet"),
    description = ccb.content.text("Soft yellow carpet on a wooden floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = {
        terrain = "t_floor_noroof",
        drops = { { item = "y_carpet", charges = 1 }, { item = "nail", charges = 5 } },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_wood_green",
    copy_from = "t_carpet_base_wood",
    name = ccb.content.text("green carpet"),
    description = ccb.content.text("Soft green carpet on a wooden floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = {
        terrain = "t_floor_noroof",
        drops = { { item = "g_carpet", charges = 1 }, { item = "nail", charges = 5 } },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_wood_purple",
    copy_from = "t_carpet_base_wood",
    name = ccb.content.text("purple carpet"),
    description = ccb.content.text("Soft purple carpet on a wooden floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = {
        terrain = "t_floor_noroof",
        drops = { { item = "p_carpet", charges = 1 }, { item = "nail", charges = 5 } },
    },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_concrete",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_thconc_floor",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_concrete_red",
    copy_from = "t_carpet_base_concrete",
    name = ccb.content.text("industrial red carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a red color on a concrete floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = { drops = { { item = "r_carpet", charges = 1 } }, terrain = "t_thconc_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_concrete_yellow",
    copy_from = "t_carpet_base_concrete",
    name = ccb.content.text("industrial yellow carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a yellow color on a concrete floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = { drops = { { item = "y_carpet", charges = 1 } }, terrain = "t_thconc_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_concrete_green",
    copy_from = "t_carpet_base_concrete",
    name = ccb.content.text("industrial green carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a green color on a concrete floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = { drops = { { item = "g_carpet", charges = 1 } }, terrain = "t_thconc_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_concrete_purple",
    copy_from = "t_carpet_base_concrete",
    name = ccb.content.text("industrial purple carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a purple color on a concrete floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = { drops = { { item = "p_carpet", charges = 1 } }, terrain = "t_thconc_floor" },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_metal",
    copy_from = "t_carpet_base",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "RUG", "EASY_DECONSTRUCT" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_metal_floor",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_metal_red",
    copy_from = "t_carpet_base_metal",
    name = ccb.content.text("bunker red carpet"),
    description = ccb.content.text("Firm, low-pile, totally non-flammable carpet in a red color, with an insulation layer beneath on a metal floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = { drops = { { item = "r_carpet", charges = 1 } }, terrain = "t_metal_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_metal_yellow",
    copy_from = "t_carpet_base_metal",
    name = ccb.content.text("bunker yellow carpet"),
    description = ccb.content.text("Firm, low-pile, totally non-flammable carpet in a yellow color, with an insulation layer beneath on a metal floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = { drops = { { item = "y_carpet", charges = 1 } }, terrain = "t_metal_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_metal_green",
    copy_from = "t_carpet_base_metal",
    name = ccb.content.text("bunker green carpet"),
    description = ccb.content.text("Firm, low-pile, totally non-flammable carpet in a green color, with an insulation layer beneath on a metal floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = { drops = { { item = "g_carpet", charges = 1 } }, terrain = "t_metal_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_metal_purple",
    copy_from = "t_carpet_base_metal",
    name = ccb.content.text("bunker carpet purple"),
    description = ccb.content.text("Firm, low-pile, totally non-flammable carpet in a purple color, with an insulation layer beneath on a metal floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = { drops = { { item = "p_carpet", charges = 1 } }, terrain = "t_metal_floor" },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_strconcrete",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_strconc_floor",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_strconcrete_red",
    copy_from = "t_carpet_base_strconcrete",
    name = ccb.content.text("industrial red carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a red color on a reinforced concrete floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = { drops = { { item = "r_carpet", charges = 1 } }, terrain = "t_strconc_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_strconcrete_yellow",
    copy_from = "t_carpet_base_strconcrete",
    name = ccb.content.text("industrial yellow carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a yellow color on a reinforced concrete floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = { drops = { { item = "y_carpet", charges = 1 } }, terrain = "t_strconc_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_strconcrete_green",
    copy_from = "t_carpet_base_strconcrete",
    name = ccb.content.text("industrial green carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a green color on a reinforced concrete floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = { drops = { { item = "g_carpet", charges = 1 } }, terrain = "t_strconc_floor" },
}

ccb.content.define_terrain {
    id = "t_carpet_strconcrete_purple",
    copy_from = "t_carpet_base_strconcrete",
    name = ccb.content.text("industrial purple carpet"),
    description = ccb.content.text("Firm, low-pile, high-durability carpet in a purple color on a reinforced concrete floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = { drops = { { item = "p_carpet", charges = 1 } }, terrain = "t_strconc_floor" },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_rock",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_rock_floor",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_rock_red",
    copy_from = "t_carpet_base_rock",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet on a natural rock floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = {
        drops = { { item = "r_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_rock_floor",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_rock_yellow",
    copy_from = "t_carpet_base_rock",
    name = ccb.content.text("yellow carpet"),
    description = ccb.content.text("Soft yellow carpet on a natural rock floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = {
        drops = { { item = "y_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_rock_floor",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_rock_green",
    copy_from = "t_carpet_base_rock",
    name = ccb.content.text("green carpet"),
    description = ccb.content.text("Soft green carpet on a natural rock floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = {
        drops = { { item = "g_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_rock_floor",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_rock_purple",
    copy_from = "t_carpet_base_rock",
    name = ccb.content.text("purple carpet"),
    description = ccb.content.text("Soft purple carpet on a natural rock floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = {
        drops = { { item = "p_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_rock_floor",
    },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_primitive",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_floor_primitive",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
            { item = "nail", charges = { 1, 3 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_primitive_red",
    copy_from = "t_carpet_base_primitive",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet on a timber floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = {
        drops = { { item = "r_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor_primitive",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_primitive_yellow",
    copy_from = "t_carpet_base_primitive",
    name = ccb.content.text("yellow carpet"),
    description = ccb.content.text("Soft yellow carpet on a timber floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = {
        drops = { { item = "y_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor_primitive",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_primitive_green",
    copy_from = "t_carpet_base_primitive",
    name = ccb.content.text("green carpet"),
    description = ccb.content.text("Soft green carpet on a timber floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = {
        drops = { { item = "g_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor_primitive",
    },
}

ccb.content.define_terrain {
    id = "t_carpet_primitive_purple",
    copy_from = "t_carpet_base_primitive",
    name = ccb.content.text("purple carpet"),
    description = ccb.content.text("Soft purple carpet on a timber floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = {
        drops = { { item = "p_carpet", charges = 1 }, { item = "nail", charges = 5 } },
        terrain = "t_floor_primitive",
    },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_linoleum_gray",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_linoleum_gray",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
            { item = "nail", charges = { 1, 3 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_gray_red",
    copy_from = "t_carpet_base_linoleum_gray",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet on a gray linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = { drops = { { item = "r_carpet", charges = 1 } }, terrain = "t_linoleum_gray" },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_gray_yellow",
    copy_from = "t_carpet_base_linoleum_gray",
    name = ccb.content.text("yellow carpet"),
    description = ccb.content.text("Soft yellow carpet on a gray linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = { drops = { { item = "y_carpet", charges = 1 } }, terrain = "t_linoleum_gray" },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_gray_green",
    copy_from = "t_carpet_base_linoleum_gray",
    name = ccb.content.text("green carpet"),
    description = ccb.content.text("Soft green carpet on a gray linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = { drops = { { item = "g_carpet", charges = 1 } }, terrain = "t_linoleum_gray" },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_gray_purple",
    copy_from = "t_carpet_base_linoleum_gray",
    name = ccb.content.text("purple carpet"),
    description = ccb.content.text("Soft purple carpet on a gray linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = { drops = { { item = "p_carpet", charges = 1 } }, terrain = "t_linoleum_gray" },
}

ccb.content.define_terrain {
    abstract = "t_carpet_base_linoleum_white",
    copy_from = "t_carpet_base",
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_linoleum_white",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_white_red",
    copy_from = "t_carpet_base_linoleum_white",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet on a white linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_red",
    color = "red",
    deconstruct = { drops = { { item = "r_carpet", charges = 1 } }, terrain = "t_linoleum_white" },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_white_yellow",
    copy_from = "t_carpet_base_linoleum_white",
    name = ccb.content.text("yellow carpet"),
    description = ccb.content.text("Soft yellow carpet on a white linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_yellow",
    color = "yellow",
    deconstruct = { drops = { { item = "y_carpet", charges = 1 } }, terrain = "t_linoleum_white" },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_white_green",
    copy_from = "t_carpet_base_linoleum_white",
    name = ccb.content.text("green carpet"),
    description = ccb.content.text("Soft green carpet on a white linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_green",
    color = "green",
    deconstruct = { drops = { { item = "g_carpet", charges = 1 } }, terrain = "t_linoleum_white" },
}

ccb.content.define_terrain {
    id = "t_carpet_linoleum_white_purple",
    copy_from = "t_carpet_base_linoleum_white",
    name = ccb.content.text("purple carpet"),
    description = ccb.content.text("Soft purple carpet on a white linoleum floor.  Can support a roof."),
    looks_like = "t_carpet_purple",
    color = "magenta",
    deconstruct = { drops = { { item = "p_carpet", charges = 1 } }, terrain = "t_linoleum_white" },
}

ccb.content.define_terrain {
    id = "t_linoleum_white",
    name = ccb.content.text("linoleum tile"),
    description = ccb.content.text("A section of flooring made out of a tough, rubbery material.  Colored a simple white.  Can support a roof."),
    symbol = ".",
    color = "white",
    connect_groups = { "INDOORFLOOR", "LINOLEUM" },
    connects_to = "LINOLEUM",
    move_cost = 2,
    roof = "t_flat_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
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
    id = "t_linoleum_gray",
    name = ccb.content.text("linoleum tile"),
    roof = "t_flat_roof",
    description = ccb.content.text("A section of flooring made out of a tough, gray, rubbery material.  Can support a roof."),
    symbol = ".",
    color = "light_gray",
    connect_groups = { "INDOORFLOOR", "LINOLEUM" },
    connects_to = "LINOLEUM",
    move_cost = 2,
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
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
    id = "t_floor_waxed_y",
    name = ccb.content.text("painted waxed floor"),
    description = ccb.content.text("This section of wax flooring has been painted yellow.  Can support a roof."),
    symbol = ".",
    color = "yellow",
    connect_groups = { "INDOORFLOOR", "WOODFLOOR" },
    connects_to = "WOODFLOOR",
    move_cost = 2,
    roof = "t_flat_roof",
    bash = {
        minimum_strength = 50,
        maximum_strength = 400,
        minimum_strength_supported = 100,
        terrain = "t_null",
        sound = ccb.content.text("SMASH!"),
        drops = { { item = "splinter", count = { 2, 8 } }, { item = "nail", charges = { 5, 10 } } },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_rad_platform",
    looks_like = "t_blue_floor",
    name = ccb.content.text("radiation platform"),
    description = ccb.content.text("A dual-purpose platform that exposes items placed on it to a radioactive source by temporarily hoisting the radioactive material stored within, while also safely containing all objects to avoid contaminating its surroundings.  Operated from an external console."),
    symbol = "0",
    color = "light_blue",
    move_cost = 100,
    flags = { "TRANSPARENT", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 50,
        maximum_strength = 400,
        terrain = "t_pit",
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "scrap", count = { 4, 16 } },
            { item = "lc_steel_chunk", count = { 1, 6 } },
            { item = "cobalt_60", count = { 1, 5 } },
            { item = "lead", count = { 12, 18 } },
        },
    },
    deconstruct = {
        terrain = "t_pit",
        drops = {
            { item = "cable", count = { 3, 6 } },
            { item = "cobalt_60", count = { 2, 10 } },
            { item = "scrap", count = { 8, 16 } },
            { item = "sheet_metal", count = { 5, 10 } },
            { item = "lead", count = { 12, 18 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_junk_floor",
    name = ccb.content.text("junk metal floor"),
    looks_like = "t_scrap_floor",
    description = ccb.content.text("A simple roof of rusty scrap metal bolted and wire-tied to a makeshift frame.  Very fashionable in post-apocalyptic shantytowns.  Hope you like the sound of rain on corrugated metal.  Can support a roof."),
    symbol = "#",
    color = "dark_gray",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT" },
    bash = {
        minimum_strength = 30,
        maximum_strength = 200,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_dirt",
        drops = { { item = "pipe", count = { 1, 2 } }, { item = "scrap", count = { 1, 40 } } },
    },
}

ccb.content.define_terrain {
    id = "t_sidewalk_roof_canvas",
    name = ccb.content.text("sidewalk"),
    description = ccb.content.text("An area of common poured concrete, damaged by frost heaves and large cracks due to lack of maintenance, covered by a canvas floor.  May support a roof."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_sidewalk",
    move_cost = 2,
    roof = "t_canvas_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "FLAT", "ROAD", "MINEABLE" },
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

-- for caverns and other natural underground formations.
ccb.content.define_terrain {
    id = "t_dirt_underground",
    name = ccb.content.text("dirt"),
    description = ccb.content.text("It's dirt.  Looks like some fine soil for tillage.  Could also be dug out for construction projects.  Can support a roof."),
    symbol = ".",
    color = "brown",
    connect_groups = { "DIRT", "INDOORFLOOR" },
    connects_to = "DIRT",
    move_cost = 2,
    looks_like = "t_dirt",
    roof = "t_rock_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD", "PLOWABLE", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

-- for caverns and other natural underground formations.
ccb.content.define_terrain {
    id = "t_sand_underground",
    name = ccb.content.text("sand"),
    description = ccb.content.text("A large area of fine sand that could be useful in a number of ways, if it was extracted properly."),
    symbol = ".",
    color = "yellow",
    looks_like = "t_sand",
    connect_groups = { "INDOORFLOOR", "SAND" },
    connects_to = "SAND",
    move_cost = 3,
    roof = "t_rock_roof",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

-- for caverns and other natural underground formations.
ccb.content.define_terrain {
    id = "t_mud_underground",
    name = ccb.content.text("mud"),
    looks_like = "t_dirt",
    description = ccb.content.text("An area of wet, slick mud."),
    symbol = ".",
    color = "brown",
    move_cost = 3,
    roof = "t_rock_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "SUPPORTS_ROOF", "INDOORS", "FLAT", "DIGGABLE" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

-- for caverns and other natural underground formations.
ccb.content.define_terrain {
    id = "t_moss_underground",
    name = ccb.content.text("moss"),
    looks_like = "t_grass",
    roof = "t_rock_roof",
    description = ccb.content.text("A patch of moist, spongy moss."),
    symbol = ".",
    color = "light_green",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "SUPPORTS_ROOF", "INDOORS" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 40,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

-- for caverns and other natural underground formations.
ccb.content.define_terrain {
    id = "t_clay_underground",
    name = ccb.content.text("clay"),
    description = ccb.content.text("A large area of malleable clay, suitable for kiln firing if it was extracted properly."),
    symbol = ".",
    color = "light_red",
    connect_groups = { "CLAY", "INDOORFLOOR" },
    connects_to = "CLAY",
    move_cost = 2,
    roof = "t_rock_roof",
    flags = { "TRANSPARENT", "DIGGABLE", "FLAT", "SUPPORTS_ROOF", "INDOORS" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 50,
        maximum_strength = 100,
        minimum_strength_supported = 100,
        bash_below = true,
    },
}

-- for caverns and other natural underground formations.
ccb.content.define_terrain {
    id = "t_claymound_underground",
    name = ccb.content.text("mound of clay"),
    description = ccb.content.text("A mound of clay soil."),
    symbol = "#",
    color = "brown",
    connect_groups = { "CLAY", "INDOORFLOOR" },
    connects_to = "CLAY",
    move_cost = 5,
    roof = "t_rock_roof",
    flags = { "TRANSPARENT", "BURROWABLE", "SUPPORTS_ROOF", "INDOORS" },
    bash = {
        minimum_strength = 2,
        maximum_strength = 4,
        sound = ccb.content.text("splosh!"),
        failure_sound = ccb.content.text("splosh!"),
        terrain = "t_water_dp",
        drops = { { item = "clay_lump", count = { 6, 12 } } },
    },
}

-- I don't know, charcoal breaking sounds? Onomatopoeia is outside my skillset!
ccb.content.define_terrain {
    id = "t_floor_burnt",
    name = ccb.content.text("burnt floor"),
    description = ccb.content.text("Whatever this floor used to be made of, it's little more than charred remains now."),
    symbol = ".",
    looks_like = "t_dirtfloor",
    color = "dark_gray",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "COLLAPSES", "INDOORS" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("twang!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_null",
    },
}

ccb.content.define_terrain {
    id = "t_floor_paper",
    name = ccb.content.text("paper floor"),
    description = ccb.content.text("A floor made of ambiguous pulpy matter, covered in sticky wasp saliva.  It has, or at least had, a roof of similar a material."),
    symbol = ".",
    looks_like = "t_dirt",
    color = "white",
    move_cost = 2,
    roof = "t_roof_paper",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_null",
    },
}

ccb.content.define_terrain {
    id = "t_floor_paper_noroof",
    name = ccb.content.text("paper floor"),
    description = ccb.content.text("A floor made of ambiguous pulpy matter, covered in sticky wasp saliva."),
    symbol = ".",
    looks_like = "t_dirt",
    color = "white",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "INDOORS", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_open_air",
    },
}

ccb.content.define_terrain {
    id = "t_floor_paper_hard",
    name = ccb.content.text("hard paper floor"),
    description = ccb.content.text("A hardened cardboard floor made of chewed-up trees and resin mixed with wasp saliva.  It has, or at least had, a roof of a similar material."),
    symbol = ".",
    looks_like = "t_floor_paper",
    color = "light_gray",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "INDOORS", "FLAT" },
    bash = {
        minimum_strength = 15,
        maximum_strength = 150,
        minimum_strength_supported = 30,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 10,
        failure_volume = 6,
        terrain = "t_open_air",
    },
}

-- TODO: Should break when you step on it if there's no supporting terrain below, might want some warning akin to examine_action ledge
ccb.content.define_terrain {
    id = "t_floor_brood_wasp",
    name = ccb.content.text("paper brood cap"),
    description = ccb.content.text("A thin paper floor, protecting the pupating wasp larva until it's ready to emerge."),
    looks_like = "t_floor_paper",
    symbol = ".",
    color = "white",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "FLAMMABLE_ASH", "INDOORS", "NO_FLOOR" },
    bash = {
        minimum_strength = 1,
        maximum_strength = 6,
        sound = ccb.content.text("rrrrip!"),
        failure_sound = ccb.content.text("slap!"),
        volume = 8,
        failure_volume = 4,
        terrain = "t_open_air",
    },
}

-- Actually, this is a thin membrane of bullshit to keep wasp eggs levitating.
-- Why do we want eggs to levitate??
ccb.content.define_terrain {
    id = "t_floor_brood_fake",
    name = ccb.content.text("open air"),
    description = ccb.content.text("An area of open air."),
    symbol = " ",
    looks_like = "t_open_air",
    color = "i_cyan",
    move_cost = 2,
    flags = { "TRANSPARENT" },
    builtin_examine = "ledge",
}

ccb.content.define_terrain {
    id = "t_greenhouse",
    name = ccb.content.text("greenhouse"),
    description = ccb.content.text("A greenhouse that allows planting year round."),
    symbol = "#",
    color = "green",
    connect_groups = "GREENHOUSE",
    connects_to = "GREENHOUSE",
    move_cost = 3,
    flags = { "INDOORS", "TRANSPARENT", "PLOWABLE" },
    roof = "t_glass_roof",
    bash = {
        minimum_strength = 3,
        maximum_strength = 6,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "glass_shard", count = { 21, 29 } } },
    },
}

ccb.content.define_terrain {
    id = "t_greenhouse_tilled",
    name = ccb.content.text("plantable greenhouse"),
    description = ccb.content.text("A greenhouse that allows planting year round.  It has been prepared for planting crops inside."),
    symbol = "#",
    color = "green",
    connect_groups = "GREENHOUSE",
    connects_to = "GREENHOUSE",
    move_cost = 3,
    flags = { "INDOORS", "TRANSPARENT", "PLANTABLE" },
    builtin_examine = "dirtmound",
    roof = "t_glass_roof",
    bash = {
        minimum_strength = 3,
        maximum_strength = 6,
        sound = ccb.content.text("glass breaking!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_dirt",
        drops = { { item = "glass_shard", count = { 21, 29 } } },
    },
}

ccb.content.define_terrain {
    id = "t_carpet_red_outdoor",
    copy_from = "t_carpet_base",
    looks_like = "t_carpet_red",
    name = ccb.content.text("red carpet"),
    description = ccb.content.text("Soft red carpet laying directly on the dirt."),
    color = "red",
    flags = { "TRANSPARENT", "FLAMMABLE_HARD", "SUPPORTS_ROOF", "COLLAPSES", "INDOORS", "FLAT", "RUG" },
    bash = {
        sound = ccb.content.text("SMASH!"),
        terrain = "t_dirt",
        minimum_strength = 5,
        maximum_strength = 15,
        minimum_strength_supported = 100,
        drops = {
            { item = "sheet_cotton", count = { 1, 2 } },
            { item = "cotton_patchwork", count = { 2, 4 } },
            { item = "nail", charges = { 1, 3 } },
        },
    },
}
