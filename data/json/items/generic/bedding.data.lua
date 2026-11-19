local ccb = require("ccb")

ccb.content.define_item {
    id = "sleeping_bag_improvised",
    name = ccb.content.text("improvised sleeping bag"),
    description = ccb.content.text("You might think it is bizarre to sleep in a body bag stuffed with dead plants.  However, the thought of sleeping in the cold is far more uncomfortable."),
    mass = "4700 g",
    volume = "30 L",
    price = "20 USD",
    survival_price = "5 USD",
    materials = { "plastic", "dry_plant" },
    symbol = "[",
    looks_like = "blanket",
    color = "light_red",
    flags = {
        "OVERSIZE", "OUTER", "SOFT", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 30,
        thickness = 1,
        environmental_protection = 1,
        portions = {
            {
                encumbrance = 80,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "grass_sheet",
    name = ccb.content.text("grass sheet"),
    description = ccb.content.text("Some grass yarn woven into a crude sheet."),
    mass = "500 g",
    volume = "700 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "blanket",
    color = "white",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 10,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 15,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "grass_blanket",
    name = ccb.content.text("grass blanket"),
    description = ccb.content.text("Some grass sheets sewn together.  Itchy, but more comfortable than the cold."),
    mass = "1020 g",
    volume = "1400 ml",
    price = "10 USD",
    survival_price = "1 USD",
    materials = { "dry_plant" },
    symbol = "[",
    looks_like = "blanket",
    color = "white",
    flags = {
        "OVERSIZE", "OUTER", "ALLOWS_GASTROPOD_FOOT", "ALLOWS_LEG_TENTACLES", "ALLOWS_WING_ARMS",
        "ALLOWS_WINGS", "NO_WING_GLIDING",
    },
    armor = {
        warmth = 20,
        thickness = 0.1,
        portions = {
            {
                encumbrance = 30,
                coverage = 100,
                covers = {
                    "leg_l", "leg_r", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "foot_l", "foot_r",
                    "tail", "arm_wing_bat_l", "arm_wing_bat_r", "arm_wing_bird_l", "arm_wing_bird_r",
                    "wing_l", "wing_r", "gastropod_foot", "hoof_r", "hoof_l", "avian_talon_l",
                    "avian_talon_r", "animal_paw_l", "animal_paw_r", "animal_paw_rabbit_l",
                    "animal_paw_rabbit_r", "tentacle_lower_front_l", "tentacle_lower_middle_l",
                    "tentacle_lower_rear_l", "tentacle_lower_front_r", "tentacle_lower_middle_r",
                    "tentacle_lower_rear_r",
                },
            },
        },
    },
}
