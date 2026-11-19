local ccb = require("ccb")

ccb.content.define_item {
    id = "blurred_aura",
    name = ccb.content.plural_text("blurred aura", "blurred auras"),
    description = ccb.content.text("Your edges blur and expand and contract in ways that don't reflect reality.  Allows you to dodge two extra attacks in a given turn."),
    mass = "1g",
    volume = "1ml",
    price = "36 USD 46 cent",
    symbol = "o",
    color = "white",
    materials = { "dreamstuff" },
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
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_blurred_aura_0" } },
}

ccb.content.define_item {
    id = "aura_futuresight",
    category = "armor",
    name = ccb.content.plural_text("precognitive aura", "precognitive aura"),
    description = ccb.content.text("A precognitive aura that allows you to dodge things you didn't see coming."),
    mass = "100 g",
    volume = "25 L",
    materials = { "dreamstuff" },
    symbol = "[",
    color = "light_gray",
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 5,
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
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_futuresight_0" } },
}

ccb.content.define_item {
    id = "dagger_dreamdross",
    name = ccb.content.plural_text("dreamer dagger", "dreamer daggers"),
    description = ccb.content.text("This ephemeral dagger is 15 inches long from the hilt to the tip, the double-edged blade itself is a pearly white color and extremely sharp."),
    mass = "145 g",
    volume = "250 ml",
    length = "38 cm",
    price = "40 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "weapon", length = "hand", surface = "point", balance = "good" },
    materials = { "dreamstuff" },
    symbol = "/",
    color = "light_gray",
    looks_like = "knife_combat",
    techniques = { "RAPID", "WBLOCK_1", "PRECISE" },
    qualities = { { id = "CUT", level = 2 }, { id = "CUT_FINE", level = 1 }, { id = "BUTCHER", level = 5 } },
    flags = {
        "UNBREAKABLE_MELEE", "NONCONDUCTIVE", "NO_REPAIR", "NO_SALVAGE", "MAGIC_FOCUS", "TRADER_AVOID",
        "SHEATH_KNIFE",
    },
    weapon_categories = { "KNIVES" },
    category = "weapons",
    melee_damage = { stab = 16 },
    subtype_order = { "tool", "artifact" },
    tool = {},
    artifact = { enchantments = { "DREAM_DAGGER" } },
}
