local ccb = require("ccb")

-- Contain a single big item.  No weight reduction.
ccb.content.define_item {
    id = "inventor_carry_hands",
    copy_from = "molle_medium_rucksack",
    name = ccb.content.plural_text("Carry-Hands", "Carry-Hands"),
    description = ccb.content.text("A passive exoskeleton consisting of two metal arms ready to hold anything.  The arms refuse to hold more than a single thing at a time and won't make it easier to carry heavy items."),
    materials = { "steel" },
    symbol = "[",
    looks_like = "clamp",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "5000 L",
            mass_limit = "5000 kg",
            max_item_length = "5000 cm",
            moves = 100,
            holster = true,
        },
    },
    flags = { "MORPHIC", "BELTED", "WATER_FRIENDLY", "MUNDANE", "INVENTOR_CRAFTED" },
    armor = {
        warmth = 0,
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 50 },
                coverage = 20,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
}

ccb.content.define_item {
    id = "inventor_fists",
    symbol = "3",
    color = "light_gray",
    name = ccb.content.text("heavy CQC system"),
    description = ccb.content.text("This robust system begins at your hands, where it features a squarish steel frame enhanced with strategic protrusions to amplify impact damage by focusing the point of contact.  It extends along your forearms with thick, hardened steel shields protecting both your limbs and the underlying hydraulic mechanisms.  Aluminum tubes channel these hydraulics up into your upper arms, culminating at your back where the central hub for the hydraulic servos is located.  While the system recovers some energy with each movement, its substantial weight and bulk significantly limit the use of your hands for anything else."),
    materials = { "aluminum", "mc_steel" },
    volume = "11678 ml",
    mass = "3970 g",
    flags = { "MORPHIC", "DURABLE_MELEE", "PADDED", "MUNDANE", "INVENTOR_CRAFTED", "PROVIDES_TECHNIQUES" },
    techniques = { "WBLOCK_3", "BRUTAL", "SWEEP" },
    melee_damage = { bash = 28 },
    armor = {
        thickness = 1,
        portions = {
            {
                materials = { { id = "mc_steel", coverage = 100, thickness = 5 } },
                encumbrance = 7,
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_l", "hand_palm_r", "hand_wrist_l", "hand_wrist_r" },
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "aluminum", coverage = 25, thickness = 1.0 },
                    { id = "mc_steel", coverage = 100, thickness = 2.5 },
                },
                encumbrance = 7,
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_lower_l", "arm_lower_r", "arm_elbow_l", "arm_elbow_r" },
                breathability = "GOOD",
            },
            {
                materials = { { id = "aluminum", coverage = 100, thickness = 1.0 } },
                encumbrance = 7,
                coverage = 25,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_l", "arm_upper_r", "arm_shoulder_l", "arm_shoulder_r" },
                breathability = "GOOD",
            },
            {
                materials = {
                    { id = "aluminum", coverage = 100, thickness = 1.0 },
                    { id = "mc_steel", coverage = 100, thickness = 0.3 },
                },
                encumbrance = 11,
                coverage = 100,
                covers = { "torso" },
                subparts = { "torso_upper" },
                breathability = "GOOD",
            },
        },
    },
}
