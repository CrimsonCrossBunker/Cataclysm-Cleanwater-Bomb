local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_nomad_papr",
    name = ccb.content.plural_text("advanced nomad cowl", "advanced nomad cowls"),
    description = ccb.content.text("A denim cowl with additional leather padding stitched onto the head with integrated protection from a sun brim, a plastic face-shield sealed with rubber gaskets, a filter cartridge intake, and several rubber-tube connections for a powered air purifying respirator system, all designed for long travels.  The design includes some clever shaping that allows it to offer a lot of coverage without interfering too much with vision and breathing."),
    mass = "600 g",
    volume = "2500 ml",
    survival_price = "4 USD 50 cent",
    materials = {
        { id = "denim", portions = 8 },
        { id = "leather", portions = 3 },
        { id = "plastic", portions = 8 },
    },
    symbol = "[",
    looks_like = "helmet_nomad",
    color = "white",
    flags = { "VARSIZE", "SUN_GLASSES", "RAINPROOF", "PADDED", "SLEEP_IGNORE", "PAPR_MASK" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = {
                    { id = "denim", coverage = 100, thickness = 2.0 },
                    { id = "leather", coverage = 100, thickness = 1.5 },
                },
                covers = { "head" },
                subparts = { "head_crown", "head_nape", "head_ear_l", "head_ear_r", "head_forehead" },
                coverage = 100,
                encumbrance = 20,
            },
            {
                materials = { { id = "denim", coverage = 100, thickness = 2.0 } },
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "eyes" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
                covers = { "mouth" },
                coverage = 100,
                encumbrance = 3,
            },
        },
        warmth = 10,
        thickness = 3,
        environmental_protection = 4,
        filtered_protection = 16,
    },
    use_actions = { "PAPR_MASK_ACTIVATE" },
    tick_actions = { "PAPR_MASK" },
}
