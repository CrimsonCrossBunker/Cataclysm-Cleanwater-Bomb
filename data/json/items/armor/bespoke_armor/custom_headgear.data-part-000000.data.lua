local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_nomad",
    name = ccb.content.plural_text("nomad cowl", "nomad cowls"),
    description = ccb.content.text("A denim cowl with additional leather padding stitched onto the head with integrated protection from a plastic visor, sun brim, and filter cartridge intake, designed for long travels.  The design includes some clever shaping that allows it to offer a lot of coverage without interfering too much with vision and breathing."),
    mass = "470 g",
    volume = "2500 ml",
    survival_price = "2 USD 50 cent",
    materials = { "denim", "leather", "plastic" },
    symbol = "[",
    looks_like = "balclava",
    color = "white",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "GASFILTER_SM" },
            default_magazine = "gasfilter_sm",
        },
    },
    flags = { "VARSIZE", "SUN_GLASSES", "RAINPROOF", "PADDED" },
    subtype_order = { "tool", "armor" },
    tool = { ammo_types = "gasfilter_s" },
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
                encumbrance = 5,
            },
        },
        warmth = 15,
        thickness = 3,
        environmental_protection = 4,
        filtered_protection = 7,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}
