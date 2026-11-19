local ccb = require("ccb")

ccb.content.define_item {
    id = "combat_exoskeleton_light_salvaged",
    copy_from = "combat_exoskeleton_abstract",
    name = ccb.content.text("salvaged combat exoskeleton mk3"),
    description = ccb.content.text("This is supposed to be a combat exoskeleton of third generation but its environmental suit is severely damaged and the mechanical components are non functional.  A variety of webbing, magnets, and clips allows the attachment of special armor plating onto the frame."),
    looks_like = "power_armor_light",
    armor = {
        warmth = 0,
        environmental_protection = 0,
        portions = {
            {
                layers = { "NORMAL" },
                volume_encumbrance = 0,
                covers = { "eyes" },
                encumbrance = 5,
                coverage = 50,
                materials = { { id = "lvl4ballisticglass", thickness = 1 } },
            },
            {
                layers = { "NORMAL" },
                volume_encumbrance = 0,
                covers = { "mouth" },
                encumbrance = 10,
                coverage = 50,
                materials = { { id = "thermo_resin", thickness = 1 } },
            },
            {
                layers = { "NORMAL", "OUTER" },
                volume_encumbrance = 0.3,
                covers = { "torso" },
                encumbrance = 10,
                coverage = 50,
                materials = {
                    { id = "lycra", thickness = 0.2 },
                    { id = "nylon", thickness = 1 },
                    { id = "nomex", thickness = 1 },
                    { id = "vinyl", thickness = 0.1 },
                    { id = "steel", thickness = 5, coverage = 5 },
                    { id = "aluminum", thickness = 5, coverage = 5 },
                },
            },
            {
                layers = { "NORMAL", "OUTER" },
                volume_encumbrance = 0,
                covers = { "head", "arm_l", "arm_r", "leg_l", "leg_r" },
                encumbrance = 10,
                coverage = 50,
                materials = {
                    { id = "lycra", thickness = 0.2 },
                    { id = "nylon", thickness = 1 },
                    { id = "nomex", thickness = 1 },
                    { id = "vinyl", thickness = 0.1 },
                    { id = "steel", thickness = 5, coverage = 5 },
                    { id = "aluminum", thickness = 5, coverage = 5 },
                },
            },
            {
                layers = { "NORMAL" },
                volume_encumbrance = 0,
                covers = { "hand_l", "hand_r" },
                encumbrance = 3,
                coverage = 50,
                materials = {
                    { id = "lycra", thickness = 0.2 },
                    { id = "nylon", thickness = 1 },
                    { id = "nomex", thickness = 1 },
                    { id = "vinyl", thickness = 0.1 },
                },
            },
            {
                layers = { "NORMAL" },
                volume_encumbrance = 0,
                encumbrance = 3,
                coverage = 50,
                covers = { "foot_l", "foot_r" },
                subparts = {
                    "foot_toes_r", "foot_toes_l", "foot_ankle_r", "foot_ankle_l", "foot_heel_r",
                    "foot_heel_l", "foot_arch_r", "foot_arch_l",
                },
                materials = {
                    { id = "lycra", thickness = 0.2 },
                    { id = "nylon", thickness = 1 },
                    { id = "nomex", thickness = 1 },
                    { id = "vinyl", thickness = 0.1 },
                },
            },
            {
                layers = { "NORMAL" },
                volume_encumbrance = 0,
                encumbrance = 0,
                coverage = 50,
                covers = { "foot_l", "foot_r" },
                subparts = { "foot_sole_r", "foot_sole_l" },
                materials = { { id = "rubber", thickness = 6 } },
            },
        },
    },
    inheritance = {
        remove = {
            flags = {
                "STURDY", "PADDED", "WATERPROOF", "RAINPROOF", "RAD_PROOF", "ELECTRIC_IMMUNE",
                "SUN_GLASSES", "COMBAT_TOGGLEABLE",
            },
        },
        scale = { volume = 0.5, mass = 0.5, price = 0.1, survival_price = 0.1 },
    },
}

ccb.content.define_item {
    id = "combat_exoskeleton_medium_salvaged",
    copy_from = "combat_exoskeleton_light_salvaged",
    name = ccb.content.plural_text("salvaged combat exoskeleton mk2", "salvaged combat exoskeletons mk2"),
    description = ccb.content.text("This was a second-generation combat exoskeleton, but its environmental suit is severely damaged and its mechanical components no longer function.  A variety of webbing, magnets, and clips allows the attachment of special armor plating onto the frame."),
    looks_like = "combat_exoskeleton_light_salvaged",
    armor = {},
}
