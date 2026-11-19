local ccb = require("ccb")
local content = ccb.content

content.define_mutation {
    id = "SORCERER",
    name = ccb.content.text("Sorcerer"),
    description = ccb.content.text("Your magical power comes from your inner strength, rather than book learning."),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    cancels = { "ANIMIST", "MAGUS", "KELVINIST", "STORMSHAPER", "EARTHSHAPER", "TECHNOMANCER", "DRUID", "BIOMANCER" },
    flags = { "ALLOW_ADVANCED_SPELLS", "CANNOT_READ_SPELLBOOKS" },
    active = true,
    on_activate = "sorcerer_open_menu",
}
