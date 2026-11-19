local ccb = require("ccb")

-- hands are lighter armored
-- feet are heavier armored
-- limbs are lighter armored than torso but still strongly armored this is the non joints so extra hardsteel
ccb.content.define_item {
    id = "phase_immersion_suit",
    category = "clothing",
    symbol = "[",
    color = "light_gray",
    name = ccb.content.plural_text("phase immersion suit", "phase immersion suits"),
    looks_like = "rm13_armor",
    description = ccb.content.text("Covered in interlocking plates of reflective metal, this advanced suit resembles both plate armor and an astronaut's spacesuit.  Designed to protect its wearer during extradimensional excursions, it offers unparalleled environmental protection, both in this Earth and beyond.  Use it to turn it on."),
    price = "1 kUSD 500 USD",
    survival_price = "150 USD",
    materials = { "carbide", "qt_steel", "lvl4ballisticglass", "superalloy" },
    mass = "9550 g",
    volume = "4050 ml",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 5000 } } },
    flags = {
        "RAD_PROOF", "STURDY", "WATERPROOF", "RAINPROOF", "NO_REPAIR", "NANOFAB_REPAIR", "PADDED",
        "USE_UPS", "NO_UNLOAD", "COMBAT_TOGGLEABLE", "UNBREAKABLE_MELEE",
    },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { ammo_types = "battery" },
    armor = {
        warmth = 30,
        environmental_protection = 10,
        thickness = 3,
        portions = {
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 80, thickness = 1.0 },
                    { id = "superalloy", coverage = 40, thickness = 1.0 },
                    { id = "superalloy", coverage = 40, thickness = 1.0 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "torso" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 60, thickness = 1.0 },
                },
                encumbrance = 5,
                coverage = 100,
                covers = { "hand_l", "hand_r" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 80, thickness = 3.0 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "foot_l", "foot_r" },
                layers = { "NORMAL", "OUTER" },
                volume_encumbrance = 0,
            },
            {
                materials = {
                    { id = "carbide", coverage = 100, thickness = 1.0 },
                    { id = "qt_steel", coverage = 75, thickness = 0.5 },
                    { id = "superalloy", coverage = 40, thickness = 0.5 },
                    { id = "superalloy", coverage = 40, thickness = 0.5 },
                },
                encumbrance = 10,
                coverage = 100,
                covers = { "arm_l", "arm_r", "leg_l", "leg_r" },
                volume_encumbrance = 0,
            },
        },
    },
    artifact = { enchantments = { "ench_climate_control_all" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("Initiating\nRunning suit integrity diagnostics…\nAll systems operational."),
            target = "phase_immersion_suit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("Warning: Operating on minimal power.  Protection compromised."),
        },
    },
}
