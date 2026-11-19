local ccb = require("ccb")

ccb.content.define_item {
    id = "dreamforged_armguard_plate",
    copy_from = "armor_lc_armguard",
    name = ccb.content.plural_text("pair of dreamforged arm guards", "pairs of dreamforged arm guards"),
    description = ccb.content.text("Pair of arm protectors, forged entirely from dreamdross.  Instead of straps this one uses a pretty smart locking mechanism, which allows you to adjust it to your hands.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    mass = "706 g",
    volume = "5500 ml",
    survival_price = "0 cent",
    materials = { "forged_dreamstuff" },
    symbol = "[",
    looks_like = "armor_lc_armguard",
    color = "dark_gray",
    flags = { "MORPHIC", "OUTER", "STURDY", "BLOCK_WHILE_WORN", "PADDED" },
    armor = {
        warmth = 10,
        thickness = 1.2,
        portions = {
            {
                covers = { "arm_l", "arm_r" },
                encumbrance = 16,
                coverage = 95,
                melee_coverage = 95,
                ranged_coverage = 95,
                vitals_coverage = 90,
                subparts = {
                    "arm_lower_r",
                    "arm_lower_l",
                    "arm_elbow_r",
                    "arm_elbow_l",
                    "arm_upper_r",
                    "arm_upper_l",
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "dreamforged_boots",
    copy_from = "boots_plate",
    name = ccb.content.plural_text("pair of dreamforged boots", "pairs of dreamforged boots"),
    description = ccb.content.text("Light set of boots, forged from dreamdross.  Surprisingly comfortable for clothing that has no physical padding.  The dreamdross grants it some minor magical properties, but you can't control their effects."),
    mass = "490 g",
    volume = "3250 ml",
    survival_price = "0 cent",
    symbol = "[",
    looks_like = "boots_steel",
    color = "light_gray",
    flags = { "MORPHIC", "WATERPROOF", "STURDY", "PADDED" },
    armor = {
        warmth = 10,
        thickness = 1.5,
        environmental_protection = 1,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_heel_r", "foot_heel_l", "foot_arch_r",
                    "foot_arch_l", "foot_sole_r", "foot_sole_l",
                },
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 1.0 } },
                encumbrance = 15,
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_r", "foot_ankle_l" },
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 2.0 } },
                coverage = 100,
            },
        },
    },
}
