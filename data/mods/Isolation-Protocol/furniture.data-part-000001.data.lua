local ccb = require("ccb")

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
