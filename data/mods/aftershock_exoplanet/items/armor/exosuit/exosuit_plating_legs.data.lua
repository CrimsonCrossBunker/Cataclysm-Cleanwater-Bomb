local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_leg_steel",
    category = "exosuit",
    name = ccb.content.plural_text("steel leg plate (exosuit)", "steel leg plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's legs, these are sturdy plates of steel."),
    mass = "13500 g",
    volume = "6500 ml",
    materials = { "afs_steel" },
    symbol = "L",
    looks_like = "armor_lc_leg_guard",
    color = "light_gray",
    flags = { "CANT_WEAR", "ABLATIVE_LARGE", "EXO_LEG_PLATE" },
    faults = { { group = "afs_steel_armor" } },
    armor = {
        portions = {
            {
                materials = { { id = "afs_steel", coverage = 100, thickness = 2 } },
                covers = { "leg_l", "leg_r", "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "exo_leg_plastic",
    category = "exosuit",
    copy_from = "exo_leg_steel",
    name = ccb.content.plural_text("plastic leg plate (exosuit)", "plastic leg plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's legs, these are plates of plastic."),
    mass = "3375 g",
    materials = { "plastic" },
    armor = {
        broken_item = "damaged_exo_leg_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 12 } },
                covers = { "leg_l", "leg_r", "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "damaged_exo_leg_plastic",
    copy_from = "exo_leg_plastic",
    name = ccb.content.plural_text("damaged plastic leg plate (exosuit)", "damaged plastic leg plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic leg plate after taking a strong impact.  Can be restored to full effectiveness via reforging."),
    looks_like = "exo_leg_plastic",
    armor = {
        broken_item = "destroyed_exo_leg_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 6 } },
                covers = { "leg_l", "leg_r", "foot_l", "foot_r" },
                coverage = 85,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "destroyed_exo_leg_plastic",
    copy_from = "exo_leg_plastic",
    name = ccb.content.plural_text("shattered plastic leg plate (exosuit)", "shattered plastic leg plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic leg plate after taking a strong impact.  No longer provides functional protection, just weight."),
    looks_like = "exo_leg_plastic",
    armor = {},
}

ccb.content.define_item {
    id = "exo_leg_vcc",
    category = "exosuit",
    copy_from = "exo_leg_steel",
    name = ccb.content.plural_text("carbide leg plate (exosuit)", "carbide leg plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's legs, these are sturdy plates of vacuum-cast carbide."),
    mass = "20250 g",
    materials = { "vacuum_carbide_hard" },
    faults = { { group = "carbide_armor" } },
    armor = {
        portions = {
            {
                materials = { { id = "vacuum_carbide", coverage = 100, thickness = 1 } },
                covers = { "leg_l", "leg_r", "foot_l", "foot_r" },
                coverage = 100,
                encumbrance = 20,
            },
        },
    },
}
