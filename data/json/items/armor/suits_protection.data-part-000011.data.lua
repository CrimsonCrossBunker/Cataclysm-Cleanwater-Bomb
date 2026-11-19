local ccb = require("ccb")

-- Predecessor of, and lab equivalent to, the phase immersion suit
-- not in direct contact with eye or mouth
-- feet have boot-covers with a tough footpad
-- standard hazmat suit on most of body
ccb.content.define_item {
    id = "xedra_artifact_cleansuit",
    name = ccb.content.plural_text("S02a hazmat suit", "S02a hazmat suits"),
    description = ccb.content.text("A bulky hazardous materials handling suit.  This one appears outfitted for the highest levels of protection, featuring built in oversized rubber gloves, sealed boot covers with a rubber sole, and an active temperature control system.  It's clearly designed to accommodate additional equipment, including self-contained breathing apparatuses or powered air purifying respirator systems.  Strange wiring snakes the entire garment, connecting to small electronic pads on all of the joints and the head.  A battery compartment marked with \"X.E.D.R.A PROTOTYPE S02a\" is attached to the back."),
    mass = "2500 g",
    volume = "2500 ml",
    price = "1 kUSD 500 USD",
    survival_price = "80 USD",
    materials = { "plastic", "hard_plastic_transp", "butyl_rubber" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "white",
    length = "12 cm",
    flags = { "OVERSIZE", "WATERPROOF", "HOOD", "RAINPROOF", "RAD_PROOF", "ELECTRONIC", "SOFT", "OUTER" },
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 10,
        environmental_protection = 10,
        portions = {
            {
                materials = { { id = "hard_plastic_transp", coverage = 100, thickness = 1.0 } },
                encumbrance = 5,
                coverage = 100,
                covers = { "mouth", "eyes" },
                volume_encumbrance = 0,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "butyl_rubber", coverage = 100, thickness = 2.0 } },
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = { { id = "plastic", coverage = 100, thickness = 2 } },
                encumbrance = 5,
                coverage = 100,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "butyl_rubber", coverage = 100, thickness = 2 } },
                encumbrance = 5,
                coverage = 100,
                layers = { "OUTER" },
                rigid_only = true,
            },
            {
                materials = { { id = "plastic", coverage = 100, thickness = 2 } },
                encumbrance = 27,
                coverage = 100,
                covers = { "arm_l", "arm_r", "leg_l", "leg_r", "head", "torso" },
                layers = { "OUTER" },
                volume_encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "resonance_suit_active", "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("The %s starts to faintly vibrate."),
            target = "xedra_artifact_cleansuit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}
