local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_arm_steel",
    category = "exosuit",
    name = ccb.content.plural_text("steel arm plate (exosuit)", "steel arm plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's arms, these are sturdy plates of steel."),
    mass = "13500 g",
    volume = "6500 ml",
    materials = { "afs_steel" },
    symbol = "[",
    looks_like = "armor_lc_armguard",
    color = "light_gray",
    flags = { "CANT_WEAR", "ABLATIVE_LARGE", "EXO_ARM_PLATE" },
    faults = { { group = "afs_steel_armor" } },
    armor = {
        warmth = 20,
        portions = {
            {
                materials = { { id = "afs_steel", coverage = 100, thickness = 1 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "afs_steel", coverage = 100, thickness = 1 } },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "exo_arm_plastic",
    category = "exosuit",
    copy_from = "exo_arm_steel",
    name = ccb.content.plural_text("plastic arm plate (exosuit)", "plastic arm plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's arms, these are plates of plastic."),
    mass = "3375 g",
    materials = { "plastic" },
    armor = {
        broken_item = "damaged_exo_arm_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 12 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 12 } },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "damaged_exo_arm_plastic",
    copy_from = "exo_arm_plastic",
    name = ccb.content.plural_text("damaged plastic arm plate (exosuit)", "damaged plastic arm plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic arm plate after taking a strong impact.  Can be restored to full effectiveness via reforging."),
    looks_like = "exo_arm_plastic",
    armor = {
        broken_item = "destroyed_exo_arm_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 6 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 6 } },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "destroyed_exo_arm_plastic",
    copy_from = "exo_arm_plastic",
    name = ccb.content.plural_text("shattered plastic arm plate (exosuit)", "shattered plastic arm plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic arm plate after taking a strong impact.  No longer provides functional protection, just weight."),
    looks_like = "exo_arm_plastic",
    armor = {},
}

ccb.content.define_item {
    id = "exo_arm_vcc",
    category = "exosuit",
    copy_from = "exo_arm_steel",
    name = ccb.content.plural_text("carbide arm plate (exosuit)", "carbide arm plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's arms, these are sturdy plates of vacuum-cast carbide."),
    mass = "20250 g",
    materials = { "vacuum_carbide_hard" },
    faults = { { group = "carbide_armor" } },
    armor = {
        portions = {
            {
                materials = { { id = "vacuum_carbide_hard", coverage = 100, thickness = 1 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 5,
                layers = { "OUTER" },
            },
            {
                materials = { { id = "vacuum_carbide_hard", coverage = 100, thickness = 1 } },
                covers = { "hand_l", "hand_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}
