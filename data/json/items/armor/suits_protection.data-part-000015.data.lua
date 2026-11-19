local ccb = require("ccb")

-- 2mm Nomex across the entire suit with a waterproof silicone outer to provide hazmat properties. Hands and feet reinforced/shaped with other materials to provide full-body hazmat protection with minimal encumbrance.
-- Back of hand from the wrist to the knuckles can be stiffer but still needs a little flexibility. This area can afford the most thickness on gloves.
-- Molded knuckle plates, spacious enough inside the gloves to flex your knuckles fine while providing extra knuckle protection because busting your knuckles sucks.
-- encumbrance accounted for above
-- A bit of Kevlar between the third and second knuckles, the part of the fingers where flexibility is least important.
-- Fingers need to be the most flexible and tactile part of the hand. Lycra/nylon blend (as the lycra material is defined) will give both those qualities while sacrificing the least protection.
-- encumbrance accounted for above
-- The boots are reinforced with plastic plates throughout to protect against penetration.
-- The Kevlar is 2mm thick over most of the boots, and 1mm thick for flexible joints.
-- Steel shank for excellent arch support and to maintain boot shape for longevity.
-- encumbrance accounted for above
-- Steel toes
-- encumbrance accounted for above
-- encumbrance accounted for above
ccb.content.define_item {
    id = "robofac_resonance_suit",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 hazardous materials suit", "Hub 01 hazardous materials suits"),
    description = ccb.content.text("A hefty environmental suit incorporating Kevlar-lined boots and gloves, worn by Hub personnel in their rare forays aboveground.  This one has a large battery pack and otherworldly electronics which snake the entire exterior, making it substantially more cumbersome to wear than its base model.  Colored brown and blue, the white seal of Hub 01 is embroidered on both of its upper arms.  It requires a separate gas mask for full protection.  Activate it to turn on."),
    mass = "5000 g",
    volume = "18 L",
    price = "1 kUSD 175 USD",
    survival_price = "40 USD",
    materials = { "nomex", "kevlar", "hc_steel", "thermo_resin", "lycra", "vinyl" },
    symbol = "[",
    looks_like = "hazmat_suit",
    color = "brown",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_HEAVY" },
            default_magazine = "heavy_battery_cell",
        },
    },
    flags = {
        "WATERPROOF", "RAINPROOF", "GAS_PROOF", "RAD_PROOF", "ELECTRIC_IMMUNE", "STURDY", "NO_REPAIR",
        "NANOFAB_REPAIR",
    },
    subtype_order = { "armor", "tool", "artifact" },
    armor = {
        portions = {
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 30, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_back_r", "hand_back_l" },
                coverage = 100,
                encumbrance = { 16, 16 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_palm_r", "hand_wrist_r", "hand_palm_l", "hand_wrist_l" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "kevlar", coverage = 25, thickness = 1 },
                    { id = "lycra", coverage = 100, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_fingers_r", "hand_fingers_l" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "thermo_resin", coverage = 85, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 90, thickness = 1 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_ankle_l", "foot_heel_l", "foot_ankle_r", "foot_heel_r" },
                coverage = 100,
                encumbrance = { 25, 25 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 25, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_arch_l", "foot_arch_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "hc_steel", coverage = 100, thickness = 1 },
                    { id = "kevlar", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_toes_l", "foot_toes_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "rubber", coverage = 100, thickness = 6 },
                    { id = "nomex", coverage = 100, thickness = 2 },
                },
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_l", "foot_sole_r" },
                coverage = 100,
                encumbrance = { 0, 0 },
            },
            {
                materials = {
                    { id = "nomex", coverage = 100, thickness = 2 },
                    { id = "vinyl", coverage = 100, thickness = 0.2 },
                },
                covers = { "head", "torso", "leg_l", "leg_r", "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = { 14, 14 },
            },
        },
        warmth = 40,
        environmental_protection = 20,
    },
    tool = { ammo_types = "battery" },
    artifact = { enchantments = { "resonance_suit_active" } },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("A tiny green LED on the chest of the %s lights up."),
            target = "robofac_resonance_suit_on",
            need_charges = 1,
            need_charges_message = ccb.content.text("It seems like this device needs power."),
        },
    },
}
