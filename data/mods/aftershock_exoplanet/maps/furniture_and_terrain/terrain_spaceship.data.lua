local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_afs_space_ship_hull_wall",
    name = ccb.content.text("starship hull"),
    description = ccb.content.text("A hull segment from a civilian starship.  Only sufficiently armored to defend against the vacuum and radiation of space, the only dangers you'd expect to find on the other side."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "WIRING", "BLOCK_WIND" },
    symbol = "#",
    color = "white",
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_broken_treads",
    name = ccb.content.text("broken treads"),
    description = ccb.content.text("A large set of broken and frozen over vehicle treads."),
    flags = { "NOITEM", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND", "TRANSPARENT", "SHORT" },
    symbol = "#",
    color = "white",
    move_cost = 5,
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 8 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_starcrane_control",
    name = ccb.content.text("THI-14 StarCrane instrument panel"),
    description = ccb.content.text("A large console, instrument panels and control surfaces.  You can fly the ship from here."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    move_cost = 0,
    coverage = 65,
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "TRANSPARENT", "SHORT" },
    symbol = "o",
    color = "white",
    examine_handler = "examine_t_afs_starcrane_control",
}

ccb.content.define_terrain {
    id = "t_afs_starcrane_control_deco",
    name = ccb.content.text("THI-14 StarCrane instrument panel"),
    description = ccb.content.text("A large console, instrument panels and control surfaces.  You can fly the ship from here."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    move_cost = 0,
    coverage = 65,
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "TRANSPARENT", "SHORT" },
    symbol = "o",
    color = "white",
}

ccb.content.define_terrain {
    id = "t_bay_ramp_control",
    name = ccb.content.text("cargo bay ramp control"),
    description = ccb.content.text("A large console used to lower and raise the cargo bay ramp.  The ramp needs to be retracted before you can take off."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    move_cost = 0,
    coverage = 65,
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "TRANSPARENT", "SHORT" },
    symbol = "o",
    color = "white",
    examine_handler = "examine_t_bay_ramp_control",
}

ccb.content.define_terrain {
    id = "t_afs_ship_retracted_bay_ramp",
    name = ccb.content.text("retracted bay ramp"),
    description = ccb.content.text("The closed cargo bay ramp of the ship.  It needs to be lowered before you can disembark."),
    roof = "t_metal_flat_roof",
    looks_like = "t_bridge",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
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
    id = "t_afs_ship_retracted_bay_ramp_air",
    copy_from = "t_afs_ship_retracted_bay_ramp",
}

ccb.content.define_terrain {
    id = "t_landing_stair_control",
    name = ccb.content.text("landing stair control"),
    description = ccb.content.text("A wall mounted control panel for the ship's landing stairs.  Traditionally, its poorly seen for the ship's captain to disembark using the cargo bay ramp instead of these stairs."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    flags = { "NOITEM", "SUPPORTS_ROOF", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    move_cost = 0,
    coverage = 65,
    color = "white",
    examine_handler = "examine_t_landing_stair_control",
}

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

ccb.content.define_terrain {
    id = "t_afs_gun_ship_engine_console",
    name = ccb.content.text("Iblis Interplanetary Drive Console"),
    looks_like = "t_console",
    description = ccb.content.text("The control panel for the engines and generators that power the drive.  It would likely render the ship irrecoverable but it might do some damage to any robots near or in the ship if you set the engines to overload."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    examine_handler = "examine_t_afs_gun_ship_engine_console",
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
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

ccb.content.define_terrain {
    id = "t_afs_gun_ship_engine_console_burnt",
    name = ccb.content.text("Iblis Interplanetary Drive Console"),
    looks_like = "t_console",
    description = ccb.content.text("The engine has been overloaded and burnt out."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        terrain = "t_metal_floor",
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "afs_circuitry_1", count = { 1, 7 } },
            { item = "afs_circuitry_2", count = { 0, 2 } },
            { item = "afs_heat_2_salvage", count = { 0, 1 } },
            { item = "afs_material_1", count = { 8, 12 } },
        },
    },
    examine_handler = "examine_t_afs_gun_ship_engine_console_burnt",
}

ccb.content.define_terrain {
    id = "t_afs_gun_ship_navigation_console",
    name = ccb.content.text("Iblis Interplanetary Navigation Console"),
    looks_like = "t_console",
    description = ccb.content.text("The control panel for navigation.  Useless here on the ground but in space the only way to plot long distance travel."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
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

ccb.content.define_terrain {
    id = "t_gunnery_ai",
    name = ccb.content.text("Wraitheon Gunnery AI"),
    looks_like = "t_console",
    description = ccb.content.text("The display screen for interacting with the gunnery ai is blank, there's no telling right now if the ai module survived the crash or not from here."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        terrain = "t_metal_floor",
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "afs_circuitry_1", count = { 4, 16 } },
            { item = "afs_circuitry_2", count = { 1, 6 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "ai_module", count = { 0, 1 } },
            { item = "afs_heat_2_salvage", count = { 0, 1 } },
            { item = "afs_energy_storage_2", count = { 1, 6 } },
            { item = "afs_energy_storage_4", count = { 0, 1 } },
            { item = "afs_material_1", count = { 12, 18 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_command_console",
    name = ccb.content.text("command console"),
    looks_like = "t_console",
    description = ccb.content.text("The display screen for interacting with the ships command and control console is dead.  Normally the ship's AI runs most systems but there is no way to know whether it survived."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        terrain = "t_metal_floor",
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "afs_circuitry_1", count = { 4, 16 } },
            { item = "afs_circuitry_2", count = { 1, 6 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "ai_module", count = { 0, 1 } },
            { item = "afs_heat_2_salvage", count = { 0, 1 } },
            { item = "afs_energy_storage_2", count = { 1, 6 } },
            { item = "afs_energy_storage_4", count = { 0, 1 } },
            { item = "afs_material_1", count = { 12, 18 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_cell_entrance_console",
    name = ccb.content.text("Prisoner Cell Console"),
    looks_like = "t_console",
    description = ccb.content.text("The control panel for the prisoner cell.  Might be able to open and close cell grating."),
    symbol = "0",
    color = "green_red",
    move_cost = 0,
    coverage = 80,
    flags = { "NOITEM", "SEALED", "REDUCE_SCENT", "PERMEABLE" },
    bash = {
        minimum_strength = 70,
        maximum_strength = 400,
        sound = ccb.content.text("metal screeching!"),
        terrain = "t_metal_floor",
        failure_sound = ccb.content.text("clang!"),
        drops = {
            { item = "afs_circuitry_1", count = { 4, 16 } },
            { item = "afs_circuitry_2", count = { 1, 6 } },
            { item = "afs_circuitry_3", count = { 0, 1 } },
            { item = "afs_heat_1", count = { 0, 1 } },
            { item = "afs_energy_storage_1", count = { 1, 6 } },
            { item = "afs_material_1", count = { 12, 18 } },
        },
    },
    examine_handler = "examine_t_cell_entrance_console",
}

ccb.content.define_terrain {
    id = "t_afs_augustmoon_diamond_glass",
    name = ccb.content.text("diamond-matrix glass"),
    description = ccb.content.text("The diamond cubic lattice distorts distant light sources into eight pointed stars.  The galactic core is visible through the glass, but no spacer would ever give it more than a passing glance."),
    roof = "t_metal_flat_roof",
    looks_like = "t_reinforced_glass",
    symbol = "#",
    color = "light_cyan",
    move_cost = 0,
    coverage = 100,
    bash = {
        minimum_strength = 4000,
        maximum_strength = 8000,
        sound = ccb.content.text("whump!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_afs_augustmoon_diamond_glass",
    },
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = {
        "TRANSPARENT",
        "NOITEM",
        "WALL",
        "NO_SCENT",
        "AUTO_WALL_SYMBOL",
        "OPENCLOSE_INSIDE",
        "BLOCK_WIND",
    },
}

ccb.content.define_terrain {
    id = "t_afs_augustmoon_hull_wall",
    name = ccb.content.text("Port Augustmoon hull"),
    description = ccb.content.text("The ancient hull of Port Augustmoon, spun into orbit several lifetimes ago."),
    roof = "t_metal_flat_roof",
    copy_from = "t_wall_metal",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "AUTO_WALL_SYMBOL", "BLOCK_WIND" },
    symbol = "#",
    bash = {
        minimum_strength = 4000,
        maximum_strength = 8000,
        sound = ccb.content.text("whump!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_afs_augustmoon_hull_wall",
    },
    color = "white",
}

ccb.content.define_terrain {
    id = "t_open_air_bay",
    copy_from = "t_open_air",
}

ccb.content.define_terrain {
    id = "t_afs_escapepod_g",
    name = ccb.content.text("escape pod guidance system"),
    description = ccb.content.text("The rudimentary descent guidance system and easy-use control console of an escape pod.  It apparently broke during the descent."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    color = "white",
    copy_from = "t_afs_space_ship_hull_wall",
    deconstruct = {
        terrain = "t_afs_space_ship_hull_wall",
        drops = {
            { item = "afs_circuitry_3", count = { 1, 2 } },
            { item = "afs_circuitry_2", count = { 4, 8 } },
            { item = "cable", count = { 1, 2 } },
            { item = "small_lcd_screen", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 4 } },
            { item = "afs_energy_storage_2", count = { 1, 2 } },
            { item = "afs_energy_storage_3", count = { 0, 1 } },
            { item = "plastic_chunk", count = { 1, 2 } },
            { item = "afs_material_2", count = { 0, 2 } },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 40,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "cable", count = { 1, 2 } },
            { item = "plastic_chunk", count = { 6, 10 } },
            { item = "afs_energy_storage_2", count = { 0, 2 } },
            { item = "afs_energy_storage_2", count = { 1, 2 } },
            { item = "afs_circuitry_1", count = { 0, 2 } },
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_escapepod_g_shipboard",
    name = ccb.content.text("escape pod guidance system"),
    description = ccb.content.text("The rudimentary descent guidance system and easy-use control console of an escape pod.  Can be activated to launch the pod."),
    roof = "t_metal_flat_roof",
    looks_like = "t_intercom",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    color = "white",
    copy_from = "t_afs_space_ship_hull_wall",
    examine_handler = "examine_escape_pod_guidance",
}

ccb.content.define_terrain {
    id = "t_escape_pod_floor",
    name = ccb.content.text("escape pod floor"),
    description = ccb.content.text("A relatively flat slab of heat-treated metal, designed to withstand the crushing pressure of space and the searing heat of reentry."),
    symbol = ".",
    color = "light_gray",
    looks_like = "t_rock_floor",
    move_cost = 2,
    roof = "t_open_air",
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        terrain = "t_null",
        minimum_strength = 75,
        maximum_strength = 400,
        minimum_strength_supported = 30,
        bash_below = true,
    },
}

ccb.content.define_terrain {
    id = "t_afs_space_ship_hatch_l",
    name = ccb.content.text("locked starship hatch"),
    description = ccb.content.text("An armored and airtight spaceship hatch.  Its locked shut, and can only be opened from a control panel."),
    roof = "t_metal_flat_roof",
    symbol = "+",
    color = "light_red",
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "DOOR" },
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_energy_storage_2", count = { 0, 2 } },
            { item = "afs_circuitry_1", count = { 0, 2 } },
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_spaceship_sink",
    name = ccb.content.text("sink"),
    looks_like = "f_sink",
    description = ccb.content.text("A stainless steel kitchen sink.  Its connected to the ships water supply."),
    symbol = "&",
    color = "light_gray",
    move_cost = 6,
    coverage = 40,
    flags = { "TRANSPARENT", "THIN_OBSTACLE" },
    liquid_source = { item = "water_clean", minimum_temperature = 18 },
    builtin_examine = "water_source",
}

ccb.content.define_terrain {
    id = "t_afs_space_ship_hatch_c",
    name = ccb.content.text("closed starship hatch"),
    description = ccb.content.text("An armored and airtight spaceship hatch.  A side mounted lever allows for its manual operation."),
    roof = "t_metal_flat_roof",
    symbol = "+",
    color = "light_red",
    open = "t_afs_space_ship_hatch_o",
    connect_groups = "WALL",
    connects_to = "WALL",
    rotates_to = "INDOORFLOOR",
    flags = { "NOITEM", "DOOR" },
    copy_from = "t_door_metal_lab_c",
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_energy_storage_2", count = { 0, 2 } },
            { item = "afs_circuitry_1", count = { 0, 2 } },
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

ccb.content.define_terrain {
    id = "t_afs_space_ship_hatch_o",
    name = ccb.content.text("open starship hatch"),
    description = ccb.content.text("An armored and airtight spaceship hatch.  A side mounted lever allows for its manual operation."),
    roof = "t_metal_flat_roof",
    close = "t_afs_space_ship_hatch_c",
    copy_from = "t_door_metal_lab_o",
    symbol = "'",
    color = "light_red",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "TRANSPARENT", "FLAT", "ROAD" },
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "afs_energy_storage_2", count = { 0, 2 } },
            { item = "afs_circuitry_1", count = { 0, 2 } },
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}

-- Entrance card for the barracks locker room.  Low security access.
ccb.content.define_terrain {
    id = "t_card_locker_room",
    name = ccb.content.text("Locker room card reader"),
    description = ccb.content.text("This is a smartcard reader.  Bold lettering proclaims that this controls access to the locker room.  You could swipe an appropriate crew ID card near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "AFS_CS_LOCKER_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 2,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for the barracks armory.  High security access.
ccb.content.define_terrain {
    id = "t_card_armory_room",
    name = ccb.content.text("Armory card reader"),
    description = ccb.content.text("This is a smartcard reader.  Bold lettering proclaims that this controls access to the armory.  You could swipe an appropriate crew ID card near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "AFS_CS_LOCKER_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 2,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for the barracks armory.  Medium security access.
ccb.content.define_terrain {
    id = "t_card_exobay_room",
    name = ccb.content.text("Exobay card reader"),
    description = ccb.content.text("This is a smartcard reader.  Bold lettering proclaims that this controls access to the exosuit bay.  You could swipe an appropriate crew ID card near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "AFS_CS_EXOBAY_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 2,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

ccb.content.define_terrain {
    id = "t_augustmoon_shuttle_console",
    name = ccb.content.text("Shuttle Guidance Console"),
    description = ccb.content.text("The simplified guidance interface of a drone shuttle.  Activating it will transport you to Port Augustmoon."),
    symbol = "6",
    looks_like = "t_afs_shuttlepod_g",
    color = "light_blue",
    move_cost = 0,
    coverage = 50,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "NOITEM", "INDOORS" },
    examine_handler = "examine_t_augustmoon_shuttle_console",
}

ccb.content.define_terrain {
    id = "t_intermodal_crate_scripted_source",
    name = ccb.content.text("intermodal shipping crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit.  Any items placed inside will be taken with you to and from Port Augustmoon."),
    symbol = "O",
    background_color = "brown",
    move_cost = 0,
    coverage = 60,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT", "SMALL_HIDE" },
}

ccb.content.define_terrain {
    id = "t_intermodal_crate_scripted_destination",
    name = ccb.content.text("intermodal shipping crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit."),
    symbol = "O",
    background_color = "brown",
    move_cost = 0,
    coverage = 60,
    flags = { "TRANSPARENT", "CONTAINER", "PLACE_ITEM", "MOUNTABLE", "SHORT", "SMALL_HIDE" },
}

ccb.content.define_terrain {
    id = "t_intermodal_crate",
    name = ccb.content.text("intermodal shipping crate"),
    description = ccb.content.text("A sealed metal crate used to ferry cargo to and from orbit."),
    symbol = "O",
    background_color = "brown",
    move_cost = 0,
    coverage = 60,
    flags = { "TRANSPARENT", "MOUNTABLE", "SHORT", "SMALL_HIDE", "PLACE_ITEM", "CONTAINER" },
}

ccb.content.define_terrain {
    id = "t_afs_shuttlepod_g",
    name = ccb.content.text("shuttle pod guidance system"),
    description = ccb.content.text("The complex controls of a shuttlepod.  Doesn't seem to be working right now."),
    roof = "t_metal_flat_roof",
    looks_like = "f_console_broken",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "SUPPORTS_ROOF", "WALL", "NO_SCENT", "BLOCK_WIND" },
    symbol = "o",
    color = "white",
    copy_from = "t_afs_space_ship_hull_wall",
    deconstruct = {
        terrain = "t_afs_space_ship_hull_wall",
        drops = {
            { item = "afs_circuitry_3", count = { 1, 2 } },
            { item = "afs_circuitry_2", count = { 4, 8 } },
            { item = "cable", count = { 1, 2 } },
            { item = "small_lcd_screen", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 4 } },
            { item = "afs_energy_storage_2", count = { 1, 2 } },
            { item = "afs_energy_storage_3", count = { 0, 1 } },
            { item = "plastic_chunk", count = { 1, 2 } },
            { item = "afs_material_2", count = { 0, 2 } },
        },
    },
    bash = {
        minimum_strength = 30,
        maximum_strength = 40,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_null",
        drops = {
            { item = "cable", count = { 1, 2 } },
            { item = "plastic_chunk", count = { 6, 10 } },
            { item = "afs_energy_storage_2", count = { 0, 2 } },
            { item = "afs_energy_storage_2", count = { 1, 2 } },
            { item = "afs_circuitry_1", count = { 0, 2 } },
            { item = "afs_material_2", count = { 1, 2 } },
            { item = "afs_material_1", count = { 2, 12 } },
            { item = "scrap", count = { 6, 24 } },
        },
    },
}
