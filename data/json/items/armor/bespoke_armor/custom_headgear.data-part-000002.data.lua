local ccb = require("ccb")

-- I based these changes on the OKZK cap, as a general design but with a few changes and considerations. I removed the ballistic kevlar primarily due to it being unsuitable for headwear
ccb.content.define_item {
    id = "helmet_scavenger",
    name = ccb.content.plural_text("mercenary cowl", "mercenary cowls"),
    description = ccb.content.text("A sturdy canvas hat and cowl extending down to the neck, fitted with a shade brim, plastic eye visor and integrated filter cartridge intake built into the mouth section.  Provides smoke protection, and is cleverly designed to be relatively unencumbering and protective."),
    mass = "695 g",
    volume = "2500 ml",
    price = "550 USD",
    survival_price = "35 USD",
    materials = { "canvas", "plastic" },
    symbol = "[",
    looks_like = "mask_gas",
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
                materials = { { id = "canvas", coverage = 100, thickness = 1.5 } },
                covers = { "head" },
                subparts = { "head_crown", "head_nape", "head_ear_l", "head_ear_r", "head_forehead" },
                coverage = 100,
                encumbrance = 16,
            },
            {
                materials = { { id = "canvas", coverage = 100, thickness = 1.5 } },
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
                covers = { "mouth", "muzzle", "beak", "insect_proboscis" },
                coverage = 100,
                encumbrance = 5,
            },
        },
        warmth = 15,
        thickness = 2,
        environmental_protection = 4,
        filtered_protection = 7,
    },
    use_actions = { "GASMASK_ACTIVATE" },
    tick_actions = { "GASMASK" },
}
