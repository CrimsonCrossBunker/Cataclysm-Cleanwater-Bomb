local ccb = require("ccb")

ccb.content.define_item {
    id = "force_magical_armor",
    name = ccb.content.plural_text("Force Shield", "Force Shield"),
    description = ccb.content.text("A shield of pure force that protects you from most types of physical damage."),
    mass = "500 mg",
    volume = "1 ml",
    accuracy = -10,
    symbol = "[",
    color = "brown",
    materials = { "magical_material" },
    flags = {
        "WATERPROOF",
        "TRADER_AVOID",
        "SEMITANGIBLE",
        "OVERSIZE",
        "AURA",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    subtype_order = { "armor", "artifact" },
    armor = {
        environmental_protection = 2,
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
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_force_magical_armor_0" } },
}
