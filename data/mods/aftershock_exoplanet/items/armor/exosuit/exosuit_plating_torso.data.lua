local ccb = require("ccb")

ccb.content.define_item {
    id = "exo_torso_steel",
    category = "exosuit",
    name = ccb.content.plural_text("steel torso plate (exosuit)", "steel torso plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's torso, this is a sturdy plate of steel."),
    mass = "25 kg",
    volume = "15 L",
    materials = { "afs_steel" },
    symbol = "[",
    looks_like = "cuirass_lightplate",
    color = "light_gray",
    flags = { "CANT_WEAR", "ABLATIVE_LARGE", "EXO_TORSO_PLATE" },
    faults = { { group = "afs_steel_armor" } },
    armor = {
        warmth = 25,
        portions = {
            {
                materials = { { id = "afs_steel", coverage = 100, thickness = 1 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "afs_steel", coverage = 100, thickness = 2 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l", "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "exo_torso_plastic",
    category = "exosuit",
    copy_from = "exo_torso_steel",
    name = ccb.content.plural_text("plastic torso plate (exosuit)", "plastic torso plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's torso, this is a plate of plastic."),
    mass = "6250 g",
    materials = { "plastic" },
    armor = {
        broken_item = "damaged_exo_torso_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 12 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 6 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l", "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "damaged_exo_torso_plastic",
    copy_from = "exo_torso_plastic",
    name = ccb.content.plural_text("damaged plastic helmet plate (exosuit)", "damaged plastic helmet plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic torso plate after taking a strong impact.  Can be restored to full effectiveness via reforging."),
    looks_like = "exo_torso_plastic",
    armor = {
        broken_item = "destroyed_exo_helmet_plastic",
        portions = {
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.25 } },
                covers = { "torso" },
                coverage = 85,
                encumbrance = 5,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2.25 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l", "leg_hip_l", "leg_hip_r" },
                coverage = 85,
                encumbrance = 5,
            },
        },
    },
}

ccb.content.define_item {
    id = "destroyed_exo_torso_plastic",
    copy_from = "exo_torso_plastic",
    name = ccb.content.plural_text("shattered plastic torso plate (exosuit)", "shattered plastic torso plates (exosuit)"),
    description = ccb.content.text("The remains of a plastic torso plate after taking a strong impact.  No longer provides functional protection, just weight."),
    looks_like = "exo_torso_plastic",
    armor = {},
    inheritance = { add = { flags = { "NO_REPAIR" } } },
}

ccb.content.define_item {
    id = "exo_torso_vcc",
    category = "exosuit",
    copy_from = "exo_torso_steel",
    name = ccb.content.plural_text("carbide torso plate (exosuit)", "carbide torso plates (exosuit)"),
    description = ccb.content.text("Designed to attach to an exosuit's torso, this is a sturdy plate of vacuum-cast carbide."),
    mass = "50 kg",
    materials = { "vacuum_carbide_hard" },
    faults = { { group = "carbide_armor" } },
    armor = {
        portions = {
            {
                materials = { { id = "vacuum_carbide", coverage = 100, thickness = 1 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "vacuum_carbide", coverage = 100, thickness = 1 } },
                covers = { "leg_l", "leg_r", "arm_l", "arm_r" },
                subparts = { "arm_shoulder_r", "arm_shoulder_l", "leg_hip_l", "leg_hip_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
}
