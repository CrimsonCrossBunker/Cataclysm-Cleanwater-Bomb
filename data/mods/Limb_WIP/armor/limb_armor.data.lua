local ccb = require("ccb")

ccb.content.define_item {
    id = "debug_belt_tail",
    repair_like = "scarf",
    name = ccb.content.text("debug tail belt"),
    description = ccb.content.text("An example armor for testing custom limb/armor interactions.  100 coverage on the first sublimb of your debug tail with little encumbrance"),
    mass = "200 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "25 cent",
    accuracy = -1,
    materials = { "steel" },
    symbol = "[",
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 2000,
        portions = {
            {
                encumbrance = 2,
                coverage = 100,
                covers = { "debug_tail" },
                subparts = { "sub_limb_debug_tail_1" },
            },
        },
    },
}

ccb.content.define_item {
    id = "debug_belt_tail_weighted",
    copy_from = "debug_belt_tail",
    name = ccb.content.text("first weighted debug tail belt"),
    description = ccb.content.text("An example armor for testing custom limb/armor interactions.  100 coverage on the first sublimb of your debug tail with extreme encumbrance"),
    armor = {
        portions = {
            {
                encumbrance = 120,
                coverage = 100,
                covers = { "torso", "debug_tail" },
                subparts = { "sub_limb_debug_tail_1" },
            },
        },
    },
}

ccb.content.define_item {
    id = "debug_helmet_dragonfly",
    name = ccb.content.text("debug dragonfly helmet"),
    description = ccb.content.text("An example helmet to test on custom heads.  Should blind you."),
    copy_from = "helmet_scrap",
    armor = {
        portions = {
            {
                materials = { { id = "kevlar_rigid", coverage = 100, thickness = 1.0 } },
                encumbrance = 300,
                coverage = 100,
                covers = { "head_dragonfly", "eyes_dragonfly" },
            },
        },
    },
}

ccb.content.define_item {
    id = "integrated_feathers",
    copy_from = "integrated_feathers",
    name = ccb.content.plural_text("feathers", "feathers"),
    armor = {
        portions = {
            {
                materials = { { id = "mut_feather", coverage = 100, thickness = 4 } },
                covers = {
                    "hand_l", "hand_r", "foot_l", "foot_r", "leg_l", "leg_r", "arm_l", "arm_r", "torso",
                    "head", "arm_feathers_l", "arm_feathers_r", "arm_wing_bird_l", "arm_wing_bird_r",
                },
                coverage = 100,
                encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_arms_basic",
    category = "armor",
    name = ccb.content.plural_text("bionic plating - arms", "bionic plating - arms"),
    description = ccb.content.text("The durable alloy armor which protects the sensitive components that operate your bionic arms."),
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = 1,
    materials = { "kevlar_rigid", "superalloy" },
    symbol = "[",
    color = "dark_gray",
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "OUTER",
        "WATER_FRIENDLY",
        "NO_REPAIR",
        "NO_SALVAGE",
        "PADDED",
        "ZERO_WEIGHT",
    },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 0,
        thickness = 8,
        environmental_protection = 25,
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 1.0 },
                    { id = "superalloy", coverage = 95, thickness = 1.0 },
                },
                covers = {
                    "arm_bionic_basic_l",
                    "arm_bionic_basic_r",
                    "hand_bionic_basic_l",
                    "hand_bionic_basic_r",
                },
                subparts = {
                    "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r", "arm_elbow_l",
                    "arm_elbow_r", "arm_lower_l", "arm_lower_r", "hand_wrist_l", "hand_wrist_r",
                    "hand_fingers_l", "hand_fingers_r", "hand_palm_l", "hand_palm_r", "hand_back_l",
                    "hand_back_r",
                },
                coverage = 100,
                encumbrance = 0,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_arm_l",
    name = ccb.content.plural_text("bionic plating - left arm", "bionic plating - left arm"),
    copy_from = "armor_bio_arms_basic",
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 1.0 },
                    { id = "superalloy", coverage = 95, thickness = 1.0 },
                },
                covers = { "arm_bionic_basic_l", "arm_bionic_basic_l" },
                subparts = {
                    "arm_shoulder_l", "arm_upper_l", "arm_elbow_l", "arm_lower_l", "hand_wrist_l",
                    "hand_fingers_l", "hand_palm_l", "hand_back_l",
                },
                coverage = 100,
                encumbrance = 0,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_arm_r",
    name = ccb.content.plural_text("bionic plating - right arm", "bionic plating - right arm"),
    copy_from = "armor_bio_arms_basic",
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 1.0 },
                    { id = "superalloy", coverage = 95, thickness = 1.0 },
                },
                covers = { "arm_bionic_basic_r", "arm_bionic_basic_r" },
                subparts = {
                    "arm_shoulder_r", "arm_upper_r", "arm_elbow_r", "arm_lower_r", "hand_wrist_r",
                    "hand_fingers_r", "hand_palm_r", "hand_back_r",
                },
                coverage = 100,
                encumbrance = 0,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_legs_basic",
    category = "armor",
    name = ccb.content.plural_text("bionic plating - legs", "bionic plating - legs"),
    description = ccb.content.text("The durable alloy armor which protects the sensitive components that operate your bionic legs."),
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = 1,
    materials = { "kevlar_rigid", "superalloy" },
    symbol = "[",
    color = "dark_gray",
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "OUTER",
        "WATER_FRIENDLY",
        "NO_REPAIR",
        "NO_SALVAGE",
        "PADDED",
        "ZERO_WEIGHT",
    },
    melee_damage = { bash = 8 },
    armor = {
        warmth = 0,
        thickness = 8,
        environmental_protection = 25,
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 1.0 },
                    { id = "superalloy", coverage = 95, thickness = 1.0 },
                },
                covers = {
                    "leg_bionic_basic_l",
                    "leg_bionic_basic_r",
                    "foot_bionic_basic_l",
                    "foot_bionic_basic_r",
                },
                subparts = {
                    "leg_hip_l", "leg_hip_r", "leg_upper_l", "leg_upper_r", "leg_knee_l", "leg_knee_r",
                    "leg_lower_l", "leg_lower_r", "foot_ankle_l", "foot_ankle_r", "foot_heel_l",
                    "foot_heel_r", "foot_sole_l", "foot_sole_r", "foot_toes_l", "foot_toes_r",
                    "foot_arch_l", "foot_arch_r",
                },
                coverage = 100,
                encumbrance = 0,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_leg_l",
    name = ccb.content.plural_text("bionic plating - left leg", "bionic plating - left leg"),
    copy_from = "armor_bio_legs_basic",
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 1.0 },
                    { id = "superalloy", coverage = 95, thickness = 1.0 },
                },
                covers = { "leg_bionic_basic_l", "foot_bionic_basic_l" },
                subparts = {
                    "leg_hip_l", "leg_upper_l", "leg_knee_l", "leg_lower_l", "foot_ankle_l",
                    "foot_heel_l", "foot_sole_l", "foot_toes_l", "foot_arch_l",
                },
                coverage = 100,
                encumbrance = 0,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_leg_r",
    name = ccb.content.plural_text("bionic plating - right leg", "bionic plating - right leg"),
    copy_from = "armor_bio_legs_basic",
    armor = {
        portions = {
            {
                materials = {
                    { id = "kevlar_rigid", coverage = 100, thickness = 1.0 },
                    { id = "superalloy", coverage = 95, thickness = 1.0 },
                },
                covers = { "leg_bionic_basic_r", "foot_bionic_basic_r" },
                subparts = {
                    "leg_hip_r", "leg_upper_r", "leg_knee_r", "leg_lower_r", "foot_ankle_r",
                    "foot_heel_r", "foot_sole_r", "foot_toes_r", "foot_arch_r",
                },
                coverage = 100,
                encumbrance = 0,
                vitals_coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "armor_bio_treads",
    category = "armor",
    name = ccb.content.plural_text("bionic plating - tank treads", "bionic plating - tank treads"),
    description = ccb.content.text("The protective armor for the bionic tank treads which replace the legs."),
    volume = "80000 ml",
    price = "0 cent",
    survival_price = "0 cent",
    accuracy = 1,
    materials = { "superalloy", "rubber", "qt_steel" },
    symbol = "[",
    color = "dark_gray",
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "OUTER",
        "WATER_FRIENDLY",
        "NO_REPAIR",
        "NO_SALVAGE",
        "PADDED",
        "ZERO_WEIGHT",
    },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "40 L",
            mass_limit = "200 kg",
            max_item_length = "50 cm",
            moves = 500,
            description = ccb.content.text("Cargo storage compartment."),
            rigid = true,
        },
    },
    armor = {
        warmth = 0,
        thickness = 8,
        environmental_protection = 25,
        portions = {
            {
                materials = {
                    { id = "superalloy", coverage = 100, thickness = 4.0 },
                    { id = "qt_steel", coverage = 95, thickness = 4.0 },
                },
                covers = { "leg_bionic_treads" },
                subparts = { "bionic_treads_body" },
                coverage = 100,
                encumbrance = { 0, 0 },
                vitals_coverage = 100,
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                    { id = "qt_steel", coverage = 100, thickness = 1.0 },
                },
                covers = { "leg_bionic_treads" },
                subparts = { "bionic_treads_treads" },
                coverage = 100,
                encumbrance = { 0, 0 },
                vitals_coverage = 100,
            },
        },
    },
}
