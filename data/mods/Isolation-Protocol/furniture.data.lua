local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_elevator_control_iso",
    name = ccb.content.text("elevator controls"),
    description = ccb.content.text("This is the control face for an elevator.  You could press the appropriate button to take you to your choice of floor."),
    symbol = "6",
    color = "light_blue",
    move_cost = 0,
    coverage = 50,
    roof = "t_flat_roof",
    connect_groups = "INDOORFLOOR",
    flags = { "NOITEM", "INDOORS" },
    examine_handler = "examine_t_elevator_control_iso",
}

-- Easy installation
ccb.content.define_furniture {
    id = "f_autodoc_super",
    name = ccb.content.text("chirurgic suite"),
    symbol = "&",
    color = "light_cyan",
    copy_from = "f_autodoc",
    flags = { "TRANSPARENT", "AUTODOC" },
    description = ccb.content.text("A multitude of surgical arms seamlessly meld with the chromed ceiling.  They expectantly unravel with your approach, animated by an AI whose performances blur the lines between medicine and art."),
    builtin_examine = "autodoc",
    surgery_skill_multiplier = 999999,
    deconstruct = {
        drops = {
            { item = "processor", count = { 1, 2 } },
            { item = "RAM", count = { 4, 8 } },
            { item = "cable", count = { 1, 2 } },
            { item = "small_lcd_screen", count = { 1, 2 } },
            { item = "e_scrap", count = { 10, 16 } },
            { item = "circuit", count = { 6, 10 } },
            { item = "power_supply", count = { 2, 4 } },
            { item = "amplifier", count = { 2, 4 } },
            { item = "plastic_chunk", count = { 10, 12 } },
            { item = "scrap", count = { 6, 8 } },
        },
    },
    bash = {
        minimum_strength = 8,
        maximum_strength = 150,
        sound = ccb.content.text("crunch!"),
        failure_sound = ccb.content.text("whack!"),
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

ccb.content.define_furniture {
    id = "f_experimental_crafter_terminal",
    name = ccb.content.text("Advanced Recycling and Manufacturing terminal"),
    description = ccb.content.text("An ethereal blue glow highlights a command line.  Awaiting input."),
    symbol = "0",
    color = "light_blue",
    move_cost_mod = -1,
    required_strength = -1,
    coverage = 50,
    flags = { "NOITEM", "INDOORS" },
    crafting_pseudo_item = "pseudo_experimental_crafter",
    examine_handler = "examine_f_experimental_crafter_terminal",
}

ccb.content.define_furniture {
    id = "f_experimental_crafter",
    name = ccb.content.text("Advanced Recycling and Manufacturing Ouroboros"),
    description = ccb.content.text("A smooth metal casing, icy cold to the touch.  The whirrs of complex machinery hasten as you approach."),
    symbol = "A",
    builtin_examine = "iso_recycler",
    color = "blue",
    move_cost_mod = -1,
    required_strength = -1,
    coverage = 50,
    flags = { "INDOORS" },
}
