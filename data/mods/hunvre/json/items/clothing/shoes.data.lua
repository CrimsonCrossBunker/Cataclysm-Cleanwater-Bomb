local ccb = require("ccb")

ccb.content.define_item {
    id = "sneakers",
    copy_from = "abstract_garment_advanced_variants",
    color = "blue",
    symbol = "[",
    looks_like = "shoes_bowling",
    name = ccb.content.plural_text("sneakers (pair)", "sneakers (pair)"),
    description = ccb.content.text("Sporty, comfortable shoes with a low top leaving the ankles uncovered."),
    materials = { { id = "nylon", portions = 90 }, { id = "rubber", portions = 10 } },
    mass = "600 g",
    volume = "500 ml",
    price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    armor = {
        warmth = 5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l",
                    "foot_heel_r",
                    "foot_arch_l",
                    "foot_arch_r",
                    "foot_toes_l",
                    "foot_toes_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.2 } },
                encumbrance = 4,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "high_top_sneakers",
    copy_from = "sneakers",
    name = ccb.content.plural_text("high top sneakers (pair)", "high top sneakers (pair)"),
    description = ccb.content.text("Sporty, comfortable shoes with a high top covering the ankles."),
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l", "foot_heel_r", "foot_arch_l", "foot_arch_r", "foot_toes_l",
                    "foot_toes_r", "foot_ankle_l", "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.2 } },
                encumbrance = 4,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
            },
        },
    },
    inheritance = { scale = { mass = 1.1, volume = 1.1 } },
}

ccb.content.define_item {
    id = "boots",
    copy_from = "abstract_garment_advanced_variants",
    symbol = "[",
    color = "blue",
    looks_like = "dress_shoes",
    name = ccb.content.plural_text("boots (pair)", "boots (pair)"),
    description = ccb.content.text("Rugged boots with a thick sole, reaching above the ankles for support and protection."),
    materials = { { id = "nylon", portions = 90 }, { id = "rubber", portions = 10 } },
    mass = "700 g",
    volume = "600 ml",
    price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    armor = {
        warmth = 5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l", "foot_heel_r", "foot_arch_l", "foot_arch_r", "foot_toes_l",
                    "foot_toes_r", "foot_ankle_l", "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.3 } },
                encumbrance = 6,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "mid_calf_boots",
    copy_from = "boots",
    name = ccb.content.plural_text("mid-calf boots", "mid-calf boots"),
    description = ccb.content.text("Rugged boots with a thick sole, reaching the calf for more support and protection."),
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l", "foot_heel_r", "foot_arch_l", "foot_arch_r", "foot_toes_l",
                    "foot_toes_r", "foot_ankle_l", "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.3 } },
                encumbrance = 6,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 40,
            },
        },
    },
    inheritance = { scale = { mass = 1.2, volume = 1.2 } },
}

ccb.content.define_item {
    id = "minimal_shoes",
    copy_from = "abstract_garment_advanced_variants",
    color = "blue",
    symbol = "[",
    looks_like = "shoes_bowling",
    name = ccb.content.plural_text("minimal shoes (pair)", "minimal shoes (pair)"),
    description = ccb.content.text("Minimalist shoes, snug and featureless aside from the fasteners, with a thin, flexible sole and a low cut leaving the ankles uncovered."),
    materials = { { id = "nylon", portions = 95 }, { id = "rubber", portions = 5 } },
    mass = "500 g",
    volume = "400 ml",
    price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    armor = {
        warmth = 5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l",
                    "foot_heel_r",
                    "foot_arch_l",
                    "foot_arch_r",
                    "foot_toes_l",
                    "foot_toes_r",
                },
                materials = { { id = "nylon", coverage = 100, thickness = 0.2 } },
                coverage = 100,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                },
                coverage = 100,
            },
        },
    },
}

ccb.content.define_item {
    id = "high_top_minimal_shoes",
    copy_from = "minimal_shoes",
    name = ccb.content.plural_text("high top minimal shoes (pair)", "high top minimal shoes (pair)"),
    description = ccb.content.text("Minimalist shoes, snug and featureless aside from the fasteners, with a thin, flexible sole and a high cut covering the ankles."),
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l", "foot_heel_r", "foot_arch_l", "foot_arch_r", "foot_toes_l",
                    "foot_toes_r", "foot_ankle_l", "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.2 } },
                encumbrance = 3,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                },
            },
        },
    },
    inheritance = { scale = { mass = 1.1, volume = 1.1 } },
}

ccb.content.define_item {
    id = "mid_calf_minimal_shoes",
    copy_from = "high_top_minimal_shoes",
    name = ccb.content.plural_text("mid calf minimal shoes (pair)", "mid calf minimal shoes (pair)"),
    description = ccb.content.text("Minimalist shoes reaching up to your calf, snug and featureless aside from the fasteners, with a thin, flexible sole."),
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l", "foot_heel_r", "foot_arch_l", "foot_arch_r", "foot_toes_l",
                    "foot_toes_r", "foot_ankle_l", "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.2 } },
                encumbrance = 4,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 100, thickness = 2.0 },
                },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 40,
            },
        },
    },
    inheritance = { scale = { mass = 1.2, volume = 1.2 } },
}

-- We don't inherit from the base sneakers because safety sneakers are exclusively for work and should not have fancy patterns.
ccb.content.define_item {
    id = "safety_sneakers",
    copy_from = "abstract_garment_basic_variants",
    color = "blue",
    symbol = "[",
    looks_like = "shoes_bowling",
    name = ccb.content.plural_text("safety sneakers (pair)", "safety sneakers (pair)"),
    description = ccb.content.text("Sporty, comfortable shoes with a low top leaving the ankles uncovered.  Metal caps have been added to protect the toes."),
    materials = {
        { id = "nylon", portions = 85 },
        { id = "rubber", portions = 10 },
        { id = "qt_steel", portions = 5 },
    },
    mass = "700 g",
    volume = "600 ml",
    price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    armor = {
        warmth = 5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_heel_l", "foot_heel_r", "foot_arch_l", "foot_arch_r" },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.2 } },
                encumbrance = 5,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "rubber", coverage = 100, thickness = 4.0 },
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.2 },
                    { id = "qt_steel", coverage = 100, thickness = 0.1 },
                },
            },
        },
    },
}

-- We don't inherit from the base boots because safety boots are exclusively for work and should not have fancy patterns.
ccb.content.define_item {
    id = "safety_boots",
    copy_from = "abstract_garment_basic_variants",
    symbol = "[",
    color = "blue",
    looks_like = "dress_shoes",
    name = ccb.content.plural_text("safety boots (pair)", "safety boots (pair)"),
    description = ccb.content.text("Rugged boots with a thick sole, reaching above the ankles for support and protection.  Metal caps have been added to protect the toes."),
    materials = {
        { id = "nylon", portions = 85 },
        { id = "rubber", portions = 10 },
        { id = "qt_steel", portions = 5 },
    },
    mass = "750 g",
    volume = "610 ml",
    price = "1 USD",
    faults = { { group = "fabric_cotton" } },
    flags = { "VARSIZE", "NORMAL" },
    armor = {
        warmth = 5,
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l",
                    "foot_heel_r",
                    "foot_arch_l",
                    "foot_arch_r",
                    "foot_ankle_l",
                    "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.3 } },
                encumbrance = 6,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "qt_steel", coverage = 100, thickness = 0.1 },
                },
            },
        },
    },
}

ccb.content.define_item {
    id = "safety_mid_calf_boots",
    copy_from = "safety_boots",
    name = ccb.content.plural_text("safety mid-calf boots (pair)", "safety mid-calf boots (pair)"),
    description = ccb.content.text("Rugged boots with a thick sole, reaching the calf for more support and protection.  Metal caps have been added to protect the toes."),
    materials = {
        { id = "nylon", portions = 85 },
        { id = "rubber", portions = 10 },
        { id = "qt_steel", portions = 5 },
    },
    armor = {
        portions = {
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_heel_l",
                    "foot_heel_r",
                    "foot_arch_l",
                    "foot_arch_r",
                    "foot_ankle_l",
                    "foot_ankle_r",
                },
                coverage = 100,
                materials = { { id = "nylon", coverage = 100, thickness = 0.3 } },
                encumbrance = 6,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "rubber", coverage = 100, thickness = 6.0 },
                },
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.3 },
                    { id = "qt_steel", coverage = 100, thickness = 0.1 },
                },
            },
            {
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_lower_l", "leg_lower_r" },
                coverage = 40,
            },
        },
    },
    inheritance = { scale = { mass = 1.2, volume = 1.2 } },
}
