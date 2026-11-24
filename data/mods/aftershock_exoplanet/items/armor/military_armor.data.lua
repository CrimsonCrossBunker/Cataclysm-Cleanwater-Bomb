local ccb = require("ccb")

ccb.content.define_item {
    id = "iotv_neck_plate",
    category = "armor",
    name = ccb.content.text("ballistic collar"),
    description = ccb.content.text("Front and back nylon collar assemblies with armor inserts for neck protection.  Designed to be attached to heavy military body armor."),
    mass = "621 g",
    volume = "488 ml",
    price = "600 USD",
    survival_price = "600 USD",
    symbol = ",",
    materials = { "vacuum_carbide", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 0.5 },
                    { id = "vacuum_carbide", coverage = 100, thickness = 1 },
                },
                encumbrance = 0,
                coverage = 30,
                covers = { "head" },
                subparts = { "head_throat", "head_nape" },
                volume_encumbrance = 0,
            },
        },
    },
}

-- an enemy could get under the protection in melee but ranged shots should almost always be blocked
ccb.content.define_item {
    id = "afs_military_vest",
    name = ccb.content.plural_text("IPAV armor", "IPAV armors"),
    description = ccb.content.text("Multipurpose military armor for the torso and upper arms, intended to protect against a wide variety of ballistic or direct energy attacks.  Made from a single piece of ablative carbide that keeps it relatively lightweight and completely disposable."),
    category = "armor",
    price = "1 kUSD 500 USD",
    mass = "7 kg",
    volume = "8 L",
    symbol = "[",
    materials = { "nylon", "vacuum_carbide_hard" },
    flags = { "OVERSIZE", "FRAGILE", "OUTER", "WATER_FRIENDLY" },
    faults = { { group = "carbide_armor" } },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "vacuum_carbide_hard", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 6,
                coverage = 100,
                vitals_coverage = 100,
                covers = { "torso" },
                volume_encumbrance = 0.3,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "vacuum_carbide_hard", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 5,
                coverage = 90,
                melee_coverage = 90,
                ranged_coverage = 100,
                vitals_coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "vacuum_carbide_hard", coverage = 100, thickness = 1.0 },
                },
                encumbrance = 2,
                coverage = 75,
                vitals_coverage = 100,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
                volume_encumbrance = 0,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 10 }, { kind = "detach_molle" } },
}

ccb.content.define_item {
    id = "afs_military_vestxl",
    name = ccb.content.text("IPAV armor"),
    copy_from = "afs_military_vest",
    description = ccb.content.text("Multipurpose military armor for the torso and upper arms, intended to protect against a wide variety of ballistic or direct energy attacks.  Made from a single piece of ablative carbide that keeps it relatively lightweight and completely disposable.  Made to fit the uplifted, the heavily augmented, or similarly sized individuals."),
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.13, price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xlswat_armor",
    category = "armor",
    name = ccb.content.text("Uplifted Enforcer armor"),
    copy_from = "afs_military_vestxl",
    description = ccb.content.text("An extra large suit of black bulletproof armor.  Specifically designed for Uplifted officers such as Mastodons."),
    replace_materials = { vacuum_carbide_hard = "vacuum_carbide" },
    armor = {},
    inheritance = { add = { flags = { "OVERSIZE", "PREFIX_XL" } }, remove = { flags = { "FRAGILE" } } },
}

ccb.content.define_item {
    id = "afs_military_cloak",
    category = "armor",
    looks_like = "poncho",
    name = ccb.content.text("ablative combat cloak"),
    description = ccb.content.text("A military poncho made from heat dissipating ablative fibers.  It is designed to be worn over armor and provide additional protection against direct energy attacks.  Its ablative properties make it disposable and relatively fragile, its not rated to survive more than a single combat engagement."),
    mass = "960 g",
    volume = "250 ml",
    price = "40 USD",
    survival_price = "7 USD 50 cent",
    symbol = "[",
    materials = { "carbide_thermal_weave" },
    color = "light_gray",
    flags = { "FRAGILE", "OUTER", "OVERSIZE", "WATERPROOF", "VARSIZE", "RAINPROOF", "HOOD", "SOFT" },
    armor = {
        warmth = 5,
        thickness = 1,
        portions = {
            {
                encumbrance = { 4, 8 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "torso" },
                layers = { "OUTER", "BELTED" },
            },
            {
                encumbrance = { 4, 4 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
            },
            {
                encumbrance = { 4, 4 },
                coverage = 100,
                vitals_coverage = 90,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r", "leg_upper_r", "leg_upper_l" },
            },
        },
    },
}
