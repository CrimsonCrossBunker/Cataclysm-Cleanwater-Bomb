local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_gates_mech_control",
    name = ccb.content.text("mechanical winch"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate or door."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_mech_control_lab",
    name = ccb.content.text("mechanical winch"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_thconc_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_control_concrete",
    name = ccb.content.text("mechanical winch"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_rock_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_control_concrete_lab",
    name = ccb.content.text("mechanical winch"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_thconc_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_boom_barrier",
    copy_from = "t_gates_control_concrete",
    name = ccb.content.text("boom barrier controls"),
    description = ccb.content.text("Controls for a boom barrier.  If they were functioning, it could have been used to raise or lower a nearby boom barrier."),
}

ccb.content.define_terrain {
    id = "t_gates_control_brick",
    name = ccb.content.text("mechanical winch"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_rock_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_control_brick_lab",
    name = ccb.content.text("mechanical winch"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "cyan_red",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_thconc_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_control_metal",
    name = ccb.content.text("control lever"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "white",
    move_cost = 0,
    flags = { "TRANSPARENT", "PERMEABLE", "NOITEM", "COLLAPSES", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_rock_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_gates_control_metal_lab",
    name = ccb.content.text("control lever"),
    description = ccb.content.text("A gate control winch.  If it's functioning, it can be used to open or close a nearby gate."),
    symbol = "6",
    color = "white",
    move_cost = 0,
    flags = { "TRANSPARENT", "PERMEABLE", "NOITEM", "COLLAPSES", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 18,
        maximum_strength = 80,
        sound = ccb.content.text("metal screeching!"),
        failure_sound = ccb.content.text("clang!"),
        terrain = "t_thconc_floor",
        drops = { { item = "mc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 3, 6 } } },
    },
}

ccb.content.define_terrain {
    id = "t_barndoor",
    name = ccb.content.text("barn door pulley"),
    description = ccb.content.text("A system of ropes and pulleys that allows a single person to raise heavy doors."),
    symbol = "|",
    color = "brown",
    move_cost = 0,
    connect_groups = "INDOORFLOOR",
    flags = { "TRANSPARENT", "NOITEM", "INDOORS", "PERMEABLE", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 8,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_dirtfloor",
        drops = {
            { item = "rope_6", count = { 3, 4 } },
            { item = "2x4", count = { 1, 4 } },
            { item = "splinter", count = { 2, 4 } },
            { item = "nuts_bolts", count = { 2, 3 } },
            { item = "block_and_tackle", count = { 0, 1 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    deconstruct = {
        terrain = "t_dirtfloor",
        drops = {
            { item = "rope_30", count = 1 },
            { item = "nuts_bolts", count = 3 },
            { item = "2x4", count = 8 },
            { item = "block_and_tackle", count = 1 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_palisade_pulley",
    name = ccb.content.text("gate pulley"),
    description = ccb.content.text("A system of ropes and pulleys that allows a single person to raise heavy doors or gates."),
    symbol = "|",
    color = "brown",
    move_cost = 0,
    flags = { "TRANSPARENT", "NOITEM", "SHORT", "PERMEABLE", "EASY_DECONSTRUCT", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 8,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_null",
        drops = {
            { item = "rope_makeshift_6", count = { 3, 4 } },
            { item = "2x4", count = { 1, 4 } },
            { item = "splinter", count = { 2, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    deconstruct = {
        terrain = "t_dirt",
        drops = {
            { item = "rope_makeshift_30", count = 1 },
            { item = "2x4", count = 8 },
            { item = "block_and_tackle", count = 1 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_palisade_pulley_wood",
    looks_like = "t_palisade_pulley",
    name = ccb.content.text("gate pulley"),
    description = ccb.content.text("A system of ropes and wooden pulleys that allows a single person to raise heavy doors or gates."),
    symbol = "|",
    color = "brown",
    move_cost = 0,
    flags = { "TRANSPARENT", "NOITEM", "SHORT", "PERMEABLE", "EASY_DECONSTRUCT", "THIN_OBSTACLE" },
    builtin_examine = "controls_gate",
    bash = {
        minimum_strength = 8,
        maximum_strength = 40,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whump."),
        terrain = "t_null",
        drops = {
            { item = "rope_makeshift_6", count = { 3, 4 } },
            { item = "2x4", count = { 1, 4 } },
            { item = "splinter", count = { 2, 4 } },
        },
        hit_field = { "fd_dust", 2 },
        destroyed_field = { "fd_splinters", 1 },
    },
    deconstruct = {
        terrain = "t_dirt",
        drops = {
            { item = "rope_makeshift_30", count = 1 },
            { item = "2x4", count = 8 },
            { item = "block_and_tackle_wood", count = 1 },
        },
    },
}

-- For the player to chat with an NPC through the intercom, the npc must have 'name_unique': 'the_intercom' and must be within 10 tiles of the intercom.
ccb.content.define_terrain {
    id = "t_intercom",
    name = ccb.content.text("intercom"),
    description = ccb.content.text("An intercom panel.  For when you want to scare the crap out of someone, or just talk to them over the intercom system, if you're boring like that."),
    symbol = "=",
    color = "light_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    builtin_examine = "intercom",
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_concrete_wall",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- For the player to chat with an NPC through the intercom, the npc must have NC_BALTHAZAR and must be within 10 tiles of the intercom.
ccb.content.define_terrain {
    id = "t_intercom_balthazar",
    name = ccb.content.text("intercom"),
    description = ccb.content.text("A rudimentary intercom panel.  This one looks to be set up in a hurry with the microphone and speaker just dangling."),
    symbol = "=",
    color = "light_gray",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "FREE_TO_EXAMINE" },
    builtin_examine = "intercom_balthazar",
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_strconc_wall",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- It takes a science card/hack attempt and then calls iexamine::intercom
ccb.content.define_terrain {
    id = "t_card_robofac",
    looks_like = "t_card_science",
    name = ccb.content.text("card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom inside a flask that is universally known to indicate SCIENCE.  An ominous red LED reminds you of a robot gone haywire from an old sci-fi flick.  You could swipe a scientific ID badge near it if you do not fear the machine."),
    symbol = "6",
    color = "pink",
    move_cost = 0,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    builtin_examine = "cardreader_robofac",
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_card_reader_broken",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- Science
ccb.content.define_terrain {
    id = "t_card_science",
    name = ccb.content.text("card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom inside a flask that is universally known to indicate SCIENCE.  The stark red LED blinks askance at your geek cred.  You could swipe a scientific ID badge near it to unlock the gates to discovery."),
    symbol = "6",
    color = "pink",
    move_cost = 0,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    card_reader = {
        flags = { "SCIENCE_CARD" },
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query_message = ccb.content.text("Swipe your ID card?"),
        success_message = ccb.content.text("You insert your ID card.\n<color_light_green>The nearby doors unlock.</color>"),
        redundant_message = ccb.content.text("The nearby doors are already opened."),
    },
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_card_reader_broken",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- Military
ccb.content.define_terrain {
    id = "t_card_military",
    name = ccb.content.text("card reader"),
    description = ccb.content.text("A smartcard reader.  The universal symbol of an eagle driving a tank, biting a grenade pin, stands rampant in front of an American flag.  A small, red LED remains constant, as if watching you, waiting.  You could swipe a military ID card in front of the reader if you dared."),
    symbol = "6",
    color = "pink",
    move_cost = 0,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    card_reader = {
        flags = { "MILITARY_CARD" },
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query_message = ccb.content.text("Swipe your ID card?"),
        success_message = ccb.content.text("You insert your ID card.\n<color_light_green>The nearby doors unlock.</color>"),
        redundant_message = ccb.content.text("The nearby doors are already opened."),
    },
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_card_reader_broken",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- Industrial
ccb.content.define_terrain {
    id = "t_card_industrial",
    looks_like = "t_card_science",
    name = ccb.content.text("card reader"),
    roof = "t_metal_roof",
    description = ccb.content.text("A smartcard reader.  The symbol of a gear in front of a bulging bicep is emblazoned on the matte black surface with an illegible heavy industrial company title.  A red LED blinks on the card reader.  Perhaps an industrial ID card could still open it."),
    symbol = "6",
    color = "pink",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    card_reader = {
        flags = { "INDUSTRIAL_CARD" },
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query_message = ccb.content.text("Swipe your ID card?"),
        success_message = ccb.content.text("You insert your ID card.\n<color_light_green>The nearby doors unlock.</color>"),
        redundant_message = ccb.content.text("The nearby doors are already opened."),
    },
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_card_reader_broken",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- Foodplace
ccb.content.define_terrain {
    id = "t_card_fp",
    looks_like = "t_card_science",
    name = ccb.content.text("card reader"),
    roof = "t_metal_roof",
    description = ccb.content.text("This looks like the console controlling the security door, there's a pretty big reading surface on it.  You can see \"Fp\" soberly printed above the reader.  You have no idea what could open it."),
    symbol = "6",
    color = "pink",
    move_cost = 0,
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    builtin_examine = "cardreader_fp",
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_card_reader_broken",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- Entrance card for a lab.  Low security access.
ccb.content.define_terrain {
    id = "t_card_science_visitor",
    name = ccb.content.text("Facility entrance card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom inside a flask that is universally known to indicate SCIENCE.  You could swipe a visitor's pass near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_VISITOR" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- for the isolated artisans faction
ccb.content.define_terrain {
    id = "t_card_artisans",
    looks_like = "t_card_science",
    name = ccb.content.text("card reader"),
    description = ccb.content.text("A smartcard reader.  A sticky note plastered above it reads 'CO-OP MEMBERS ONLY'."),
    symbol = "6",
    color = "pink",
    move_cost = 0,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM" },
    card_reader = {
        flags = { "COOP_CARD" },
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query_message = ccb.content.text("Swipe your ID card?"),
        success_message = ccb.content.text("You insert your ID card.\n<color_light_green>The nearby doors unlock.</color>"),
        redundant_message = ccb.content.text("The nearby doors are already opened."),
    },
    bash = {
        minimum_strength = 18,
        maximum_strength = 180,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_card_reader_broken",
        drops = { { item = "plastic_chunk", count = { 0, 2 } }, { item = "scrap", chance = 50 } },
    },
}

-- Entrance card for a lab.  Low security access.
ccb.content.define_terrain {
    id = "t_card_science_maintenance_green",
    name = ccb.content.text("Maintenance: green zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a wrench on a green background.  You could swipe a maintenance employee badge near it to unlock the gates."),
    symbol = "6",
    color = "green",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MAINTENANCE_GREEN" },
        consume_card = false,
        allow_hacking = false,
        despawn_monsters = true,
        radius = 7,
        terrain_changes = { t_door_metal_locked = "t_thconc_floor" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this gate?"),
        success_message = ccb.content.text("You opened the gate!"),
        redundant_message = ccb.content.text("The gate is already open."),
    },
}

-- Tier 2 card for a lab.  Medium security access. Reanamed player facing name to ocher.
ccb.content.define_terrain {
    id = "t_card_science_maintenance_yellow",
    name = ccb.content.text("Maintenance: ocher zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a wrench on a ocher background.  You could swipe a maintenance employee badge near it to unlock the gates."),
    symbol = "6",
    color = "yellow",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MAINTENANCE_YELLOW" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = false,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Tier 3 card for a lab.  High security access.
ccb.content.define_terrain {
    id = "t_card_science_maintenance_blue",
    name = ccb.content.text("Maintenance: blue zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a wrench on a blue background.  You could swipe a maintenance employee badge near it to unlock the gates."),
    symbol = "6",
    color = "blue",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MAINTENANCE_BLUE" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = false,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for a lab.  Low security access.
ccb.content.define_terrain {
    id = "t_card_science_transport_1",
    name = ccb.content.text("Freight hauler access card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a truck.  You could swipe a transporter's badge near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_TRANSPORT_1" },
        consume_card = false,
        allow_hacking = false,
        despawn_monsters = false,
        radius = 7,
        terrain_changes = { t_door_metal_locked = "t_thconc_floor" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this gate?"),
        success_message = ccb.content.text("You opened the gate!"),
        redundant_message = ccb.content.text("The gate is already open."),
    },
}

-- Tier 1 card for a lab.  Medium security access.
ccb.content.define_terrain {
    id = "t_card_science_security_yellow",
    name = ccb.content.text("Security: yellow zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a taser on a yellow background.  You could swipe a security employee badge near it to unlock the gates."),
    symbol = "6",
    color = "yellow",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_SECURITY_YELLOW" },
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

-- Tier 2 card for a lab.  Medium security access.
ccb.content.define_terrain {
    id = "t_card_science_security_magenta",
    name = ccb.content.text("Security: magenta zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a pistol on a magenta background.  You could swipe a security employee badge near it to unlock the gates."),
    symbol = "6",
    color = "magenta",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_SECURITY_MAGENTA" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 4,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Tier 3 card for a lab.  High security access.
ccb.content.define_terrain {
    id = "t_card_science_security_black",
    name = ccb.content.text("Security: black zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a rifle on a black background.  You could swipe a security employee badge near it to unlock the gates."),
    symbol = "6",
    color = "dark_gray",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_SECURITY_BLACK" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Tier 3 card for a lab.  High security access.
ccb.content.define_terrain {
    id = "t_card_science_mu",
    name = ccb.content.text("Systems: slate zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a node graph on a slate background.  You could swipe a security employee badge near it to unlock the gates."),
    symbol = "6",
    color = "dark_gray",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MU_UNIVERSAL" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for a lab research areas.
ccb.content.define_terrain {
    id = "t_card_science_mutagen_green",
    name = ccb.content.text("Researcher: light green zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a flask on a light green background.  You could swipe a researcher scientist badge near it to unlock the gates."),
    symbol = "6",
    color = "light_green",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MUTAGEN_GREEN" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for a lab research areas.
ccb.content.define_terrain {
    id = "t_card_science_mutagen_pink",
    name = ccb.content.text("Researcher: pink zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a flask on a pink background.  You could swipe a researcher scientist badge near it to unlock the gates."),
    symbol = "6",
    color = "light_red",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MUTAGEN_PINK" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for a lab research areas.
ccb.content.define_terrain {
    id = "t_card_science_mutagen_cyan",
    name = ccb.content.text("Researcher: cyan zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a flask on a cyan background.  You could swipe a researcher scientist badge near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MUTAGEN_CYAN" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Entrance card for a lab medical areas.
ccb.content.define_terrain {
    id = "t_card_science_medical_red",
    name = ccb.content.text("Medical: red zone card reader"),
    description = ccb.content.text("A smartcard reader.  It sports the stylized symbol of an atom and a syringe on a red background.  You could swipe a researcher scientist badge near it to unlock the gates."),
    symbol = "6",
    color = "cyan",
    copy_from = "t_card_science",
    looks_like = "t_card_science",
    card_reader = {
        flags = { "SCIENCE_CARD_MEDICAL_RED" },
        consume_card = false,
        allow_hacking = true,
        despawn_monsters = true,
        radius = 3,
        terrain_changes = { t_door_metal_locked = "t_door_metal_c" },
        query = true,
        query_message = ccb.content.text("Are you sure you want to open this door?"),
        success_message = ccb.content.text("You opened the door!"),
        redundant_message = ccb.content.text("The door is already open."),
    },
}

-- Since these are set into the walls, they ought to have the resilience of metal walls.
ccb.content.define_terrain {
    id = "t_card_reader_broken",
    name = ccb.content.text("broken card reader"),
    description = ccb.content.text("A smartcard reader that doesn't seem to be functioning.  Probably because there's no more blinking red LED."),
    symbol = "6",
    color = "light_gray",
    move_cost = 0,
    roof = "t_metal_roof",
    connect_groups = "WALL",
    connects_to = "WALL",
    flags = { "NOITEM", "MINEABLE" },
    bash = {
        minimum_strength = 200,
        maximum_strength = 600,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
        terrain = "t_concrete",
        drops = {
            { item = "processor", chance = 25 },
            { item = "cable", count = { 1, 2 }, chance = 50 },
            { item = "small_lcd_screen", chance = 25 },
            { item = "e_scrap", count = { 1, 3 }, chance = 50 },
            { item = "circuit", chance = 25 },
            { item = "plastic_chunk", count = { 4, 6 }, chance = 50 },
            { item = "scrap", count = { 2, 4 }, chance = 50 },
        },
    },
}

ccb.content.define_terrain {
    id = "t_elevator_control",
    name = ccb.content.text("elevator controls"),
    description = ccb.content.text("The control face for an elevator.  You could press the appropriate button to travel to your choice of floor."),
    symbol = "6",
    color = "light_blue",
    move_cost = 0,
    coverage = 50,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "NOITEM", "INDOORS" },
    builtin_examine = "elevator",
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
    copy_from = "t_elevator_control",
    symbol = ".",
    color = "dark_gray",
    id = "t_elevator_control_no_roof",
    roof = "t_null",
    flags = { "NOITEM" },
}

ccb.content.define_terrain {
    id = "t_elevator_control_robofac_up",
    name = ccb.content.text("elevator controls"),
    description = ccb.content.text("The control face for an elevator.  You could press the appropriate button to travel to your choice of floor."),
    symbol = "6",
    color = "light_blue",
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
    examine_handler = "examine_t_elevator_control_robofac_up",
}

ccb.content.define_terrain {
    id = "t_elevator_control_robofac_down",
    name = ccb.content.text("elevator controls"),
    description = ccb.content.text("The control face for an elevator.  You could press the appropriate button to travel to your choice of floor."),
    symbol = "6",
    color = "light_blue",
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
    examine_handler = "examine_t_elevator_control_robofac_down",
}

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
