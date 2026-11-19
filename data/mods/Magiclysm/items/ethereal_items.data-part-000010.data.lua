local ccb = require("ccb")

ccb.content.define_item {
    id = "protect_env",
    name = ccb.content.plural_text("aura of protection", "auras of protection"),
    description = ccb.content.text("An all-encompassing, invisible layer of magical aura that protects you from the environment."),
    mass = "500 mg",
    volume = "1 ml",
    symbol = "o",
    color = "blue",
    materials = { "magical_material" },
    flags = {
        "AURA", "SEMITANGIBLE", "OVERSIZE", "TRADER_AVOID", "NO_TAKEOFF", "NONCONDUCTIVE", "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    max_worn = 1,
    armor = {
        environmental_protection = 15,
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
}
