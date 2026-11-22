local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_bio_robofac_xmback_on",
    copy_from = "integrated_bio_robofac_xmback",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 BACK exoskeleton (on)", "Hub 01 BACK exoskeleton (on)"),
    revert_to = "integrated_bio_robofac_xmback",
    inheritance = { add = { flags = { "SPAWN_ACTIVE", "NO_TAKEOFF", "TRADER_AVOID" } } },
    subtype_order = { "armor", "tool", "artifact" },
    armor = { portions = { { encumbrance = 2, coverage = 5, covers = { "torso" } } } },
    tool = { power_draw = "37 W" },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You deactivate your Hub 01 XM-BACK system."),
            target = "integrated_bio_robofac_xmback",
        },
    },
}

ccb.content.define_item {
    id = "integrated_bio_robofac_xmarm",
    name = "Hub 01 ARM exoskeleton",
    description = "The Hub 01 Arm Reinforcement Motionframe, or ARM, a powered exoskeleton for the true frontier cyborg.  A metal frame runs along each of your arms and hands, with several straps at critical joints, twisting at the wrist into a glove-like matrix of steel.  The frame has a battery compartment and the elbows and lower arms have clips custom-fit for Hub 01 vambraces.  When powered, your arms are exceptionally stable, reducing firearm recoil by 30% and shot dispersion by 10%.  Moreover, you have better control over thrown objects, allowing you to throw objects 50% further and 25% harder.  Unpowered, they are a significant burden.  Activate them to toggle power.  Requires an XM-ARM Interface bionic to function.",
    symbol = ",",
    color = "dark_gray",
    category = "armor",
    mass = "1600 g",
    volume = "5000 ml",
    price = "400000 USD",
    survival_price = "450 USD",
    flags = {
        "OUTER",
        "CAN_USE_IN_DARK",
        "COMBAT_TOGGLEABLE",
        "STURDY",
        "WATER_FRIENDLY",
        "MUNDANE",
        "PADDED",
        "ROBOFAC_ARM",
    },
    materials = { "qt_steel" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5000 ml",
            mass_limit = "3 kg",
            moves = 200,
            volume_encumbrance = 0,
            ablative = true,
            allowed_items = {
                "robofac_basic_vambraces",
                "robofac_rubber_vambraces",
                "robofac_nomex_vambraces",
                "robofac_kevlar_vambraces",
                "robofac_military_vambraces",
            },
            description = "Clips for armored vambraces.",
        },
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "heavy_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    armor = {
        thickness = 4,
        warmth = 5,
        environmental_protection = 0,
        portions = {
            {
                covers = { "arm_l", "arm_r", "hand_l", "hand_r" },
                coverage = 5,
                encumbrance = 40,
            },
        },
    },
    tool = {
        ammo_types = { "battery" },
    },
    artifact = {
        enchantments = { "robofac_XM_ARM_on" },
    },
    subtype_order = { "armor", "tool", "artifact" },
}

ccb.content.define_item {
    id = "integrated_bio_robofac_xmleg",
    name = "Hub 01 LEG exoskeleton",
    description = "The Hub 01 Lower Extremity Gaitframe, or LEG, a powered exoskeleton for the true frontier cyborg.  A metal frame runs along each of the legs, with clasps for the hips, femurs, and knees, twisting at the lower leg into a metal plate with additional straps for the shin.  The frame covering the knee and lower leg has clips custom-fit for Hub 01 greaves, and there is a hip-mounted battery compartment.  When powered, you can move 15% faster, traverse obstacles with 50% higher efficiency, and carry 20kg of extra weight.  Unpowered, they are a significant burden.  Activate them to toggle power.  Requires an XM-LEG Interface bionic to function.",
    symbol = ",",
    color = "dark_gray",
    category = "armor",
    mass = "1600 g",
    volume = "5000 ml",
    price = "400000 USD",
    survival_price = "450 USD",
    flags = {
        "OUTER",
        "CAN_USE_IN_DARK",
        "COMBAT_TOGGLEABLE",
        "STURDY",
        "WATER_FRIENDLY",
        "MUNDANE",
        "PADDED",
        "ROBOFAC_LEG",
    },
    materials = { "qt_steel" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5000 ml",
            mass_limit = "3 kg",
            moves = 200,
            volume_encumbrance = 0,
            ablative = true,
            allowed_items = {
                "robofac_basic_greaves",
                "robofac_rubber_greaves",
                "robofac_nomex_greaves",
                "robofac_kevlar_greaves",
                "robofac_military_greaves",
            },
            description = "Clips for armored greaves.",
        },
        {
            kind = "MAGAZINE_WELL",
            default_magazine = "heavy_battery_cell",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
        },
    },
    armor = {
        thickness = 4,
        warmth = 5,
        environmental_protection = 0,
        portions = {
            {
                covers = { "leg_l", "leg_r" },
                coverage = 5,
                encumbrance = 40,
            },
        },
    },
    tool = {
        ammo_types = { "battery" },
    },
    artifact = {
        enchantments = { "robofac_XM_LEG_on" },
    },
    subtype_order = { "armor", "tool", "artifact" },
}
