local ccb = require("ccb")

-- Remove after 0.J
ccb.content.define_item {
    id = "aura_ward_off_rain",
    name = ccb.content.plural_text("Rain Ward", "Rain Wards"),
    description = ccb.content.text("Thanks to the words of the charm you spoke, you won't get wet."),
    mass = "0 g",
    volume = "0 ml",
    price = "0 cent",
    symbol = "x",
    color = "white",
    flags = {
        "AURA", "OVERSIZE", "PADDED", "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "TRADER_AVOID",
        "NO_REPAIR", "NO_TAKEOFF", "ZERO_WEIGHT", "NONCONDUCTIVE", "RAINPROOF",
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
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_aura_ward_off_rain_0" } },
}
