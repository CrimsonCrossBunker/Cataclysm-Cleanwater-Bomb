local ccb = require("ccb")

ccb.content.define_item {
    id = "rune_druid_weapon",
    copy_from = "compositebow",
    name = "Druid composite bow",
    description = "A bow made of multiple materials to maximize energy efficiency.  There are two Druid runes embedded at the tips.",
    color = "yellow",
    price = "320 USD",
    min_strength = 9,
    flags = {
        "FIRE_TWOHAND",
        "STR_DRAW",
        "RELOAD_AND_SHOOT",
        "PRIMITIVE_RANGED_WEAPON",
        "BELTED",
        "TRADER_AVOID",
        "MAGIC_FOCUS",
        "DURABLE_MELEE",
        "WATER_FRIENDLY",
        "SHEATH_BOW",
    },
    materials = { "wood", "bone" },
    armor = {
        portions = {
            {
                covers = { "torso" },
                coverage = 5,
                encumbrance = 13,
                materials = {
                    { id = "wood", thickness = 1.0, coverage = 100 },
                    { id = "bone", thickness = 1.0, coverage = 100 },
                },
            },
        },
    },
    gun = {
        range = 13,
        dispersion = 855,
        damage = { type = "stab", amount = 9 },
        mod_locations = {
            { id = "sights", count = 1 },
            { id = "dampening", count = 1 },
        },
    },
    subtype_order = { "armor", "gun" },
}
