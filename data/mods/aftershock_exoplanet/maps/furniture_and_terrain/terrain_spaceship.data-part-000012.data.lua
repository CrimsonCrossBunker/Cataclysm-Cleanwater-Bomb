local ccb = require("ccb")

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
