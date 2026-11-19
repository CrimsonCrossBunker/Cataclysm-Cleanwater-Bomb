local ccb = require("ccb")

-- Density test expects 1.275, so volume derived from this
ccb.content.define_item {
    id = "iotv_shoulder_plate",
    category = "armor",
    name = ccb.content.plural_text("ballistic shoulder protectors (pair)", "ballistic shoulder protectors (pair)"),
    description = ccb.content.text("Nylon armor with soft armor inserts protecting the deltoid and upper arm.  Designed to be attached to heavy military body armor."),
    mass = "1034 g",
    volume = "812 ml",
    price = "600 USD",
    survival_price = "1 USD",
    symbol = ",",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
                },
                encumbrance = 3,
                coverage = 80,
                ranged_coverage = 95,
                vitals_coverage = 100,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r", "arm_upper_l", "arm_upper_r" },
                volume_encumbrance = 0,
            },
        },
    },
}

-- 33cm x 22cm x 5.4mm
ccb.content.define_item {
    id = "iotv_groin_plate",
    category = "armor",
    name = ccb.content.text("ballistic groin protector"),
    description = ccb.content.text("Front and back nylon armor with soft armor inserts for groin and butt protection.  Designed to be attached to heavy military body armor."),
    mass = "417 g",
    volume = "392 ml",
    price = "600 USD",
    survival_price = "1 USD",
    symbol = ",",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
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
}

ccb.content.define_item {
    id = "iotv_neck_plate",
    category = "armor",
    name = ccb.content.text("ballistic collar"),
    description = ccb.content.text("Front and back nylon collar assemblies with soft armor inserts for neck protection.  Designed to be attached to heavy military body armor."),
    mass = "621 g",
    volume = "488 ml",
    price = "600 USD",
    survival_price = "1 USD",
    symbol = ",",
    materials = { "kevlar_layered", "nylon" },
    color = "dark_gray",
    flags = { "STURDY", "OUTER", "WATER_FRIENDLY", "CANT_WEAR" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nylon", coverage = 100, thickness = 1.0 },
                    { id = "kevlar_layered", coverage = 100, thickness = 4.4 },
                },
                encumbrance = 0,
                coverage = 90,
                covers = { "head" },
                subparts = { "head_throat", "head_nape" },
                volume_encumbrance = 0,
            },
        },
    },
}

ccb.content.define_item {
    id = "lead_plate_xedra_mark",
    category = "armor",
    name = ccb.content.text("lead plate"),
    description = ccb.content.text("An lead plate like those found in most medical x-ray protection vests, affixed to a steel backing plate.  This is clearly intended to be inserted into the pocket of a protective vest, and can't be worn on its own."),
    mass = "10545 g",
    volume = "1110 ml",
    length = "46 cm",
    price = "400 USD",
    survival_price = "1 USD",
    materials = { "lead", "qt_steel" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_LARGE", "CANT_WEAR", "STURDY" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 6,
                coverage = 45,
                covers = { "torso" },
                subparts = { "torso_upper", "torso_lower" },
            },
        },
    },
}
