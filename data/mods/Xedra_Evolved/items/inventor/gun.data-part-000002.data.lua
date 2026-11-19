local ccb = require("ccb")

ccb.content.define_item {
    id = "bio_launcher",
    name = ccb.content.plural_text("bio detonator", "bio detonators"),
    description = ccb.content.text("A long, huge barrel drum mortar with a small device in the very end.  It is collapsible, and you can comfortably wear it using a strap."),
    looks_like = "m3_carlgustav",
    materials = { "mc_steel" },
    mass = "2560 g",
    volume = "5896 ml",
    length = "1200 mm",
    symbol = "[",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { bio_warhead = 1 } } },
    flags = {
        "TRADER_AVOID",
        "PADDED",
        "BELTED",
        "OVERSIZE",
        "WATER_FRIENDLY",
        "MUNDANE",
        "INVENTOR_CRAFTED",
    },
    subtype_order = { "tool", "armor" },
    tool = { charges_per_use = 1, ammo_types = { "bio_warhead" } },
    armor = {
        portions = {
            {
                encumbrance = { 10, 12 },
                coverage = 70,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "bio_explosion",
            no_fail = true,
            level = 0,
            need_wielding = true,
        },
    },
}
