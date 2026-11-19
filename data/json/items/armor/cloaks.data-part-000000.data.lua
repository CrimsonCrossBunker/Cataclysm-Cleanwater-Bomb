local ccb = require("ccb")

ccb.content.define_item {
    id = "american_flag",
    name = ccb.content.plural_text("American flag", "American flags"),
    description = ccb.content.text("A large American flag, made to fly in even the worst conditions."),
    mass = "1 kg",
    volume = "2 L",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "towel",
    color = "light_red",
    flags = {
        "OVERSIZE", "BELTED", "ALLOWS_NATURAL_ATTACKS", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES",
        "ALLOWS_WING_ARMS", "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 20,
        thickness = 0.3,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 50,
                coverage = 60,
                covers = {
                    "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l", "leg_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "tentacle_lower_front_l",
                    "tentacle_lower_middle_l", "tentacle_lower_rear_l", "tentacle_lower_front_r",
                    "tentacle_lower_middle_r", "tentacle_lower_rear_r",
                },
            },
        },
    },
    use_actions = { "POST_UP" },
}
