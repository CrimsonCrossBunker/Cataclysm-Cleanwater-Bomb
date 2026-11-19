local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_frost",
    category = "armor",
    name = ccb.content.plural_text("frost armor", "frost armor"),
    description = ccb.content.text("A thin layer of magical ice, covering the entire body.  It doesn't provide much armor, instead dealing significant damage to enemies that try to attack you."),
    mass = "5000 g",
    volume = "5 L",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    flags = {
        "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "PERSONAL", "STURDY", "NO_TAKEOFF", "NONCONDUCTIVE",
        "PADDED", "UNRESTRICTED",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 0,
        thickness = 0.5,
        environmental_protection = 2,
        portions = {
            {
                encumbrance = 8,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_armor_frost_0" } },
}
