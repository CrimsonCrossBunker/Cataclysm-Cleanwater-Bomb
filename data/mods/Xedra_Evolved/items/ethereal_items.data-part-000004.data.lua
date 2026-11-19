local ccb = require("ccb")

ccb.content.define_item {
    id = "salamander_flaming_summon_whip",
    category = "weapons",
    symbol = "/",
    color = "red",
    name = ccb.content.plural_text("Tongues of Flame", "Tongues of Flames"),
    description = ccb.content.text("A long whip made of red-hot fire.  It crackles menacingly and casts a flickering red glow."),
    mass = "60 g",
    volume = "1500 ml",
    length = "40 cm",
    accuracy = { grip = "weapon", length = "long", surface = "point", balance = "neutral" },
    melee_damage = { cut = 6 },
    techniques = { "PRECISE", "WIDE", "SWEEP" },
    light = 15,
    flags = {
        "REACH_ATTACK", "REACH3", "WHIP", "STURDY", "TRADER_AVOID", "UNBREAKABLE_MELEE", "NO_REPAIR",
        "NO_SALVAGE", "FIRESTARTER", "FLAMING", "FIRE",
    },
    weapon_categories = { "WHIPS" },
    artifact = { enchantments = { "SALAMANDER_SUMMON_WHIP" } },
}

ccb.content.define_item {
    id = "item_ierde_iron_armor",
    category = "armor",
    name = ccb.content.plural_text("invulnerable iron skin", "invulnerable iron skin"),
    description = ccb.content.text("Fae iron essence."),
    mass = "0 g",
    volume = "0 L",
    materials = { "moon_tears" },
    symbol = "[",
    color = "dark_gray",
    flags = { "OVERSIZE", "PERSONAL", "ZERO_WEIGHT", "NO_DROP", "STURDY", "PADDED" },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 5,
        thickness = 0.6,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 20,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = {
        enchantments = {
            "ITEM_ENCH_Xedra_Evolved_item_ierde_iron_armor_0",
            "ITEM_ENCH_Xedra_Evolved_item_ierde_iron_armor_1",
        },
    },
}
