local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_ship_canopy",
    name = ccb.content.text("diamond-matrix canopy"),
    description = ccb.content.text("A massive near-unbreakable starship canopy.  Most nanofabricators would struggle to produce a replacement nowadays."),
    roof = "t_metal_flat_roof",
    looks_like = "t_reinforced_glass",
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    coverage = 100,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "TRANSPARENT",
        "TRANSPARENT_FLOOR",
        "NOITEM",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "OPENCLOSE_INSIDE",
        "BLOCK_WIND",
    },
}

ccb.content.define_terrain {
    id = "t_afs_ship_canopy_floor",
    name = ccb.content.text("diamond-matrix canopy (floor)"),
    description = ccb.content.text("A giant pane of diamond-matrix glass, angled to allow viewing beneath the ship's hull."),
    symbol = "o",
    looks_like = "t_glass_roof",
    color = "cyan",
    move_cost = 2,
    flags = { "TRANSPARENT", "TRANSPARENT_FLOOR", "SUPPORTS_ROOF", "INDOORS", "FLAT" },
}

ccb.content.define_terrain {
    id = "t_bay_rap_down",
    name = ccb.content.text("downward loading bay ramp"),
    description = ccb.content.text("A deployed loading bay ramp, leading downwards and out of the ship."),
    symbol = ">",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_DOWN" },
}

ccb.content.define_terrain {
    id = "t_bay_rap_up",
    name = ccb.content.text("loading bay ramp"),
    description = ccb.content.text("A deployed loading bay ramp, leading up into the ship."),
    symbol = "<",
    color = "white",
    move_cost = 2,
    flags = { "TRANSPARENT", "RAMP_UP" },
}

ccb.content.define_terrain {
    id = "t_ship_stairs_down",
    looks_like = "t_stairs_down",
    name = ccb.content.text("stairs"),
    description = ccb.content.text("A flight of stairs leading down and out of the ship."),
    symbol = ">",
    color = "yellow",
    move_cost = 2,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "GOES_DOWN", "INDOORS", "PLACE_ITEM", "SUPPORTS_ROOF" },
}

ccb.content.define_terrain {
    id = "t_ship_stairs_down_retracted",
    looks_like = "t_bridge",
    name = ccb.content.text("stairs"),
    description = ccb.content.text("A flight of stairs leading down and out of the ship."),
    symbol = ">",
    color = "yellow",
    move_cost = 2,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
}

ccb.content.define_terrain {
    id = "t_ship_stairs_up",
    looks_like = "t_stairs_up",
    name = ccb.content.text("stairs"),
    description = ccb.content.text("A flight of stairs leading up and into the ship."),
    symbol = "<",
    color = "yellow",
    move_cost = 2,
    connect_groups = "INDOORFLOOR",
    flags = { "SUPPORTS_ROOF", "TRANSPARENT", "GOES_UP", "INDOORS", "PLACE_ITEM" },
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_hull_wall",
    name = ccb.content.text("starship hull"),
    description = ccb.content.text("A hull segment from a combat rated civilian starship.  Provides some defense against weapons fire."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    symbol = "#",
    color = "white",
    bash = {
        minimum_strength = 350,
        maximum_strength = 800,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 2, 4 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_gunship_refrigeration_unit",
    name = ccb.content.text("gunship refrigeration unit"),
    description = ccb.content.text("A refrigeration unit for a gunship.  Unlikely to be working."),
    roof = "t_metal_flat_roof",
    copy_from = "t_metal_floor",
    flags = { "SUPPORTS_ROOF" },
    symbol = "O",
    color = "white",
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 2, 4 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_locker_wall",
    name = ccb.content.text("gunship locker"),
    description = ccb.content.text("A locker built into the hull of a ship.  May contain equipment."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    flags = { "SUPPORTS_ROOF", "CONTAINER", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    symbol = "#",
    color = "white",
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 2, 4 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_ruined_hull_wall",
    name = ccb.content.text("ruined hull"),
    description = ccb.content.text("This patch of hull has more holes in it than an ancient terran cheese.  It may provide some cover or it might get shot through."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    looks_like = "f_plane_wreckage",
    flags = { "NOITEM", "SUPPORTS_ROOF", "TRANSPARENT", "PERMEABLE" },
    symbol = "#",
    color = "white",
    bash = {
        minimum_strength = 20,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 0, 2 } },
            { item = "afs_material_1", count = { 2, 8 } },
            { item = "scrap", count = { 3, 17 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_hull_hatch_c",
    name = ccb.content.text("closed starship hatch"),
    description = ccb.content.text("A closed hatch in the wall of a spaceship."),
    roof = "t_metal_flat_roof",
    looks_like = "t_afs_space_ship_hatch_c",
    copy_from = "t_wall_metal",
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "BLOCK_WIND" },
    symbol = "#",
    color = "white",
    open = "t_afs_gun_ship_hull_hatch_o",
    bash = {
        minimum_strength = 150,
        maximum_strength = 500,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_metal_floor",
        drops = {
            { item = "afs_material_2", count = { 2, 4 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_hull_hatch_o",
    name = ccb.content.text("gunship hull"),
    description = ccb.content.text("An open hatch in the wall of a spaceship."),
    roof = "t_metal_flat_roof",
    flags = { "SUPPORTS_ROOF" },
    move_cost = 2,
    symbol = "_",
    color = "white",
    close = "t_afs_gun_ship_hull_hatch_c",
    looks_like = "t_afs_space_ship_hatch_o",
    bash = {
        minimum_strength = 150,
        maximum_strength = 500,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_metal_floor",
        drops = {
            { item = "afs_material_2", count = { 2, 4 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_prison_grate",
    name = ccb.content.text("prison grating"),
    description = ccb.content.text("A detention wall made up of crisscrossed stainless steel bars.  There doesn't appear to be a lock on the bars, maybe look for a computer nearby?"),
    symbol = "+",
    looks_like = "t_bars",
    color = "cyan",
    move_cost = 0,
    roof = "t_metal_roof",
    hacksaw = {
        result = "t_mdoor_frame",
        duration = "35 minutes",
        message = ccb.content.text("You finish cutting the metal."),
        byproducts = { { item = "pipe", count = 12 } },
    },
    flags = { "TRANSPARENT", "NOITEM", "PERMEABLE", "CONNECT_WITH_WALL", "THIN_OBSTACLE", "SUPPORTS_ROOF" },
    oxytorch = {
        result = "t_mdoor_frame",
        duration = "5 minutes",
        byproducts = {
            { item = "steel_plate", count = { 0, 1 } },
            { item = "mc_steel_chunk", count = { 3, 8 } },
        },
    },
    bash = {
        minimum_strength = 45,
        maximum_strength = 210,
        minimum_strength_blocked = 55,
        maximum_strength_blocked = 240,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_mdoor_frame",
        drops = {
            { item = "mc_steel_chunk", count = { 1, 4 } },
            { item = "scrap", count = { 3, 12 } },
            { item = "hinge", count = { 1, 2 } },
        },
    },
}

-- Unlocked
ccb.content.define_terrain {
    id = "t_prison_grate_r",
    name = ccb.content.text("retracted prison grating"),
    description = ccb.content.text("A floor and ceiling where you can see that bars can come out of each side to meet in the middle."),
    symbol = "o",
    looks_like = "t_metal_floor",
    color = "cyan",
    connect_groups = "METALFLOOR",
    connects_to = "METALFLOOR",
    move_cost = 2,
    roof = "t_metal_roof",
    flags = { "TRANSPARENT", "INDOORS", "FLAT", "ROAD" },
    bash = {
        sound = ccb.content.text("thump"),
        terrain = "t_null",
        minimum_strength = 200,
        maximum_strength = 500,
        minimum_strength_supported = 200,
        drops = {
            { item = "ch_steel_lump", count = { 1, 4 } },
            { item = "ch_steel_chunk", count = { 3, 12 } },
            { item = "scrap", count = { 9, 36 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_shelving",
    name = ccb.content.text("storage board"),
    symbol = "#",
    looks_like = "f_cupboard",
    description = ccb.content.text("The wall-mounted, steel and plastic storage solution of tomorrow."),
    color = "blue",
    move_cost = 0,
    coverage = 55,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "FLAT_SURF" },
    connect_groups = "COUNTER",
    connects_to = "COUNTER",
    rotates_to = "INDOORFLOOR",
    bash = {
        minimum_strength = 8,
        maximum_strength = 30,
        sound = ccb.content.text("smash!"),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_metal_floor",
        drops = {
            { item = "scrap", count = { 2, 8 } },
            { item = "polycarbonate_sheet", count = { 1, 3 } },
            { item = "rigid_plastic_sheet", count = { 0, 1 } },
            { item = "plastic_chunk", count = { 2, 16 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_view_port",
    name = ccb.content.text("view port"),
    description = ccb.content.text("A thick, round window surrounded with a strong metal frame.  It's sealed closed."),
    looks_like = "t_porthole",
    symbol = "o",
    color = "light_gray",
    move_cost = 0,
    roof = "t_metal_flat_roof",
    flags = {
        "TRANSPARENT",
        "NOITEM",
        "CONNECT_WITH_WALL",
        "THIN_OBSTACLE",
        "BLOCK_WIND",
        "REDUCE_SCENT",
        "WINDOW",
        "SUPPORTS_ROOF",
    },
    bash = {
        minimum_strength = 50,
        maximum_strength = 75,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_metal_floor",
        drops = {
            { item = "afs_material_1", chance = 55 },
            { item = "ch_steel_chunk", count = { 1, 4 } },
            { item = "scrap", count = { 1, 5 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_ship_floor_heated",
    name = ccb.content.text("starship corridor"),
    description = ccb.content.text("Large metal plates with access panels to the conduits hiding beneath."),
    looks_like = "t_metal_floor",
    light_emitted = 120,
    symbol = ".",
    color = "light_cyan",
    move_cost = 2,
    roof = "t_metal_roof",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
    emissions = { "afs_emit_AC" },
}

ccb.content.define_terrain {
    id = "t_ship_floor_heated_low_light",
    name = ccb.content.text("starship corridor"),
    description = ccb.content.text("Large metal plates with access panels to the conduits hiding beneath."),
    looks_like = "t_metal_floor",
    light_emitted = 1,
    symbol = ".",
    color = "light_cyan",
    move_cost = 2,
    roof = "t_metal_roof",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
    emissions = { "afs_emit_AC" },
}

ccb.content.define_terrain {
    id = "t_ship_bay_heated",
    name = ccb.content.text("starship loading bay"),
    description = ccb.content.text("A great slab of carbide, printed as a single piece.  It could withstand centuries of abuse, and indeed it has done so."),
    looks_like = "t_metal_floor",
    symbol = ".",
    color = "light_cyan",
    move_cost = 2,
    roof = "t_metal_roof",
    flags = { "TRANSPARENT", "INDOORS", "SUPPORTS_ROOF", "FLAT", "ROAD" },
    emissions = { "afs_emit_AC" },
}

ccb.content.define_terrain {
    id = "t_starcrane_engine",
    name = ccb.content.text("VENTR aerospike"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("One of eight powerful aerospike engines that allow the StarCrane to reach orbit."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
}

ccb.content.define_terrain {
    id = "t_starcrane_nacelle",
    name = ccb.content.text("StarCrane nacelle"),
    description = ccb.content.text("Twin nacelles house independent reactors and fuel supply units.  Hundreds of thousands of StarCranes were built during the 22nd century, and back then you could easily swap a malfunctioning nacelle for a new one in a matter of hours."),
    symbol = "^",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_engine",
    name = ccb.content.text("Iblis Interplanetary Drive"),
    looks_like = "t_plut_generator",
    description = ccb.content.text("The housing and guts of an Interplanetary drive engine.  It is plastered with warning signs.  If it's not working you could probably try to break into it for parts."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
        explosive = 100,
        sound = ccb.content.text("metal screeching!"),
        terrain = "t_metal_floor",
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "afs_circuitry_1", count = { 4, 16 } },
            { item = "afs_circuitry_2", count = { 1, 6 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "afs_heat_2_salvage", count = { 0, 1 } },
            { item = "afs_energy_storage_2", count = { 1, 6 } },
            { item = "afs_energy_storage_4", count = { 0, 1 } },
            { item = "afs_material_1", count = { 12, 18 } },
        },
    },
}
