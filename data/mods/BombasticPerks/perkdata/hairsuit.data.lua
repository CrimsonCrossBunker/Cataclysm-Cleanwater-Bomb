local ccb = require("ccb")

ccb.content.define_item {
    id = "hair_suit_off",
    name = ccb.content.plural_text("hair suit (loose)", "hair suit (loose)"),
    flags = { "INTEGRATED", "UNBREAKABLE", "NO_SALVAGE", "PERSONAL", "TRADER_AVOID", "SOFT", "ZERO_WEIGHT" },
    description = ccb.content.text("Your hair, currently in normal loose form.  Activate to weave it into clothing."),
    materials = { "hair" },
    symbol = "H",
    color = "white",
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = { { id = "hair", coverage = 100, thickness = 0.375 } },
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 1,
                encumbrance = 0,
            },
        },
        warmth = 1,
        thickness = 0.375,
        environmental_protection = 0,
    },
    use_actions = {
        {
            kind = "transform",
            need_worn = true,
            target = "hair_suit_on",
            message = ccb.content.text("You weave your hair into a form-fitting bodysuit."),
            menu_text = ccb.content.text("Weave hair"),
        },
    },
}

-- want it to look like the bondage lycra bodysuit (most bayonetta-like in msx) but you cannot looks_like an item variant.
ccb.content.define_item {
    id = "hair_suit_on",
    copy_from = "hair_suit_off",
    name = ccb.content.plural_text("hair suit (worn)", "hair suit (worn)"),
    looks_like = "nomad_bodyglove_2",
    description = ccb.content.text("Your hair, woven into a fashionable, form-fitting bodysuit.  Activate to wear it loose."),
    flags = {
        "INTEGRATED",
        "UNBREAKABLE",
        "NO_SALVAGE",
        "SKINTIGHT",
        "TRADER_AVOID",
        "SOFT",
        "ZERO_WEIGHT",
    },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = { { id = "hair", coverage = 100, thickness = 0.375 } },
                covers = { "head" },
                subparts = { "head_throat" },
                coverage = 100,
                encumbrance = 0,
            },
            {
                materials = { { id = "hair", coverage = 100, thickness = 0.375 } },
                coverage = 100,
                covers = { "foot_l", "foot_r", "hand_l", "hand_r" },
                subparts = {
                    "foot_sole_l", "foot_sole_r", "foot_arch_l", "foot_arch_r", "foot_ankle_l",
                    "foot_ankle_r", "hand_palm_l", "hand_palm_r", "hand_wrist_l", "hand_wrist_r",
                    "hand_back_l", "hand_back_r",
                },
                encumbrance = 0,
            },
            {
                materials = { { id = "hair", coverage = 100, thickness = 0.375 } },
                coverage = 100,
                covers = { "torso", "arm_l", "arm_r", "leg_l", "leg_r" },
                encumbrance = 0,
            },
        },
        warmth = 8,
    },
    use_actions = {
        {
            kind = "transform",
            need_worn = true,
            target = "hair_suit_off",
            message = ccb.content.text("You unweave your bodysuit and let your hair free."),
            menu_text = ccb.content.text("Unweave hair"),
        },
    },
}
