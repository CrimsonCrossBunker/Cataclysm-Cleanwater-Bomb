local ccb = require("ccb")

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
    category = "ARMOR",
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
