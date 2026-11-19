local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_elevator_control_off",
    name = ccb.content.text("powerless controls"),
    description = ccb.content.text("The control face for an elevator.  It's currently unpowered."),
    symbol = "6",
    color = "light_gray",
    move_cost = 0,
    coverage = 50,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "NOITEM", "INDOORS" },
    bash = {
        minimum_strength = 40,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_metal_floor",
        drops = {
            { item = "processor", chance = 25 },
            { item = "RAM", count = { 0, 2 }, chance = 50 },
            { item = "cable", count = { 1, 2 }, chance = 50 },
            { item = "small_lcd_screen", chance = 25 },
            { item = "e_scrap", count = { 1, 4 }, chance = 50 },
            { item = "circuit", count = { 0, 2 }, chance = 50 },
            { item = "power_supply", chance = 25 },
            { item = "amplifier", chance = 25 },
            { item = "plastic_chunk", count = { 4, 10 }, chance = 50 },
            { item = "scrap", count = { 2, 6 }, chance = 50 },
        },
    },
}

ccb.content.define_terrain {
    copy_from = "t_elevator_control_off",
    symbol = ".",
    color = "dark_gray",
    id = "t_elevator_control_off_no_roof",
    roof = "t_null",
    flags = { "NOITEM" },
}

ccb.content.define_terrain {
    id = "t_pedestal_wyrm",
    name = ccb.content.text("dark pedestal"),
    description = ccb.content.text("A dark stone pedestal covered in ancient, unintelligible symbols.  Looks ominous."),
    symbol = "&",
    color = "dark_gray",
    move_cost = 0,
    coverage = 50,
    flags = { "TRANSPARENT", "MOUNTABLE", "PERMEABLE", "MINEABLE", "SEALED" },
    builtin_examine = "pedestal_wyrm",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 2, 5 } } },
    },
}

ccb.content.define_terrain {
    id = "t_pedestal_temple",
    name = ccb.content.text("light pedestal"),
    description = ccb.content.text("A light stone pedestal covered in ancient, unintelligible symbols."),
    symbol = "&",
    color = "white",
    move_cost = 0,
    coverage = 50,
    flags = { "TRANSPARENT", "MOUNTABLE", "PERMEABLE", "MINEABLE" },
    builtin_examine = "pedestal_temple",
    bash = {
        minimum_strength = 100,
        maximum_strength = 400,
        sound = ccb.content.text("crash!"),
        failure_sound = ccb.content.text("whump!"),
        terrain = "t_rock_floor",
        drops = { { item = "rock", count = { 2, 5 } } },
    },
}

ccb.content.define_terrain {
    id = "t_switch_rg",
    name = ccb.content.text("yellow switch"),
    description = ccb.content.text("A yellow switch.  Should you activate it?"),
    symbol = "6",
    color = "yellow",
    move_cost = 0,
    flags = { "TRANSPARENT", "PERMEABLE" },
    builtin_examine = "fswitch",
}

ccb.content.define_terrain {
    id = "t_switch_gb",
    name = ccb.content.text("cyan switch"),
    description = ccb.content.text("A cyan switch.  Should you activate it?"),
    symbol = "6",
    color = "cyan",
    move_cost = 0,
    flags = { "TRANSPARENT", "PERMEABLE" },
    builtin_examine = "fswitch",
}

ccb.content.define_terrain {
    id = "t_switch_rb",
    name = ccb.content.text("purple switch"),
    description = ccb.content.text("A purple switch.  Should you activate it?"),
    symbol = "6",
    color = "magenta",
    move_cost = 0,
    flags = { "TRANSPARENT", "PERMEABLE" },
    builtin_examine = "fswitch",
}

ccb.content.define_terrain {
    id = "t_switch_even",
    name = ccb.content.text("checkered switch"),
    description = ccb.content.text("A checkered switch.  Should you activate it?"),
    symbol = "6",
    color = "white",
    move_cost = 0,
    flags = { "TRANSPARENT", "PERMEABLE" },
    builtin_examine = "fswitch",
}

-- just a copy of aftershock nuclear reactor
ccb.content.define_terrain {
    id = "t_nuclear_reactor",
    name = ccb.content.text("nuclear reactor core"),
    description = ccb.content.text("A naval A1B reactor, used in Gerald R. Ford-class aircraft carriers.  It can produce enough steam to generate 125 megawatts of energy."),
    symbol = "R",
    color = "light_green",
    move_cost = 0,
    flags = { "TRANSPARENT", "CONTAINER", "REDUCE_SCENT", "PERMEABLE", "PLACE_ITEM" },
}

-- Entrance card for Anduril Industries IVAS testing warehouse
ccb.content.define_terrain {
    id = "t_card_office_warehouse_anduril",
    name = ccb.content.text("Anduril Industries card reader"),
    description = ccb.content.text("A badge scanner.  It has the logo of Anduril Industries and a sign that reads \"Authorized personnel only.  All visitors must sign in at the office.\""),
    symbol = "6",
    color = "green",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "ANDURIL_AR_CARD" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = false,
        terrain_changes = { t_door_metal_locked = "t_thconc_floor" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

ccb.content.define_terrain {
    id = "t_card_exodii_string_dimension",
    name = ccb.content.text("keyhole"),
    description = ccb.content.text("An large keyhole attached to a physically toggled mechanism."),
    symbol = "6",
    color = "green",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "EXODII_STRING_DIMENSION_CARD" },
        consume_card = false,
        allow_hacking = false,
        despawn_monsters = false,
        terrain_changes = { t_door_metal_locked = "t_door_metal_o" },
        query = true,
        query_message = ccb.content.text("The large plastic key looks like it will fit in this odd keyhole.  Use it?"),
        success_message = ccb.content.text("The key fits in the lock with a soft, plasticky noise.  The door opens!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}
