local ccb = require("ccb")

ccb.content.define_item {
    id = "obfuscating_aura",
    name = ccb.content.plural_text("obfuscating aura", "obfuscating auras"),
    description = ccb.content.text("An all-encompassing, invisible layer of magic distorts light around your body.  Allows you to dodge two extra attacks in a given turn."),
    mass = "500 mg",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            {
                encumbrance = 0,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "head", "foot_l",
                    "foot_r", "mouth", "eyes",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_obfuscating_aura_0" } },
}

ccb.content.define_item {
    id = "shape_of_dust",
    name = ccb.content.plural_text("dust cloak", "dust cloaks"),
    description = ccb.content.text("You are unseen in between of the sand that cover you."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "brown",
    looks_like = "cloak",
    materials = { "magical_material" },
    flags = {
        "AURA",
        "TRADER_AVOID",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "OVERSIZE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_shape_of_dust_0" } },
}
