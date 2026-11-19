local ccb = require("ccb")

ccb.content.define_item {
    id = "nanomesh_vest",
    category = "armor",
    name = ccb.content.text("nanomesh vest"),
    description = ccb.content.text("A lightweight nanomesh vest designed to face down many of the perils of space travel.  These vests are mass produced and often stacked in starship lockers."),
    mass = "6953 g",
    volume = "1 L",
    price = "160 USD",
    survival_price = "160 USD",
    accuracy = -1,
    materials = { "nanoprinted_alloy" },
    symbol = "[",
    looks_like = "mt_chainmail_vest",
    color = "light_red",
    flags = { "VARSIZE", "OUTER" },
    armor = {
        portions = {
            {
                materials = { { id = "nanoprinted_alloy", coverage = 100, thickness = 1 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 12,
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_nanomesh_vest",
    copy_from = "nanomesh_vest",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.125, volume = 1.13, price = 1.25, survival_price = 1.25 },
    },
}

ccb.content.define_item {
    id = "carbide_cuirass",
    category = "armor",
    looks_like = "cuirass_lightplate",
    name = ccb.content.plural_text("carbide cuirass", "carbide cuirasses"),
    description = ccb.content.text("This piece of armor hearkens back to renaissance designs.  It differs in that it is cast as a single piece in deep space installations where conditions can be controlled absolutely.  Not quite bulletproof, but it will stop most small arms fire."),
    mass = "4200 g",
    volume = "6 L",
    price = "3 kUSD",
    survival_price = "3 kUSD",
    accuracy = -1,
    materials = { "vacuum_carbide" },
    symbol = "[",
    color = "light_gray",
    length = "60 cm",
    flags = { "VARSIZE", "OUTER", "STURDY" },
    armor = {
        warmth = 20,
        thickness = 1,
        portions = {
            { encumbrance = 20, coverage = 95, covers = { "torso" } },
            {
                encumbrance = 4,
                coverage = 95,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_shoulder_l", "arm_shoulder_r" },
            },
            {
                encumbrance = 4,
                coverage = 95,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
}

ccb.content.define_item {
    id = "xl_carbide_cuirass",
    copy_from = "carbide_cuirass",
    armor = {},
    inheritance = {
        add = { flags = { "OVERSIZE", "PREFIX_XL" } },
        scale = { mass = 1.25, volume = 1.3, price = 1.25, survival_price = 1.25 },
    },
}

ccb.content.define_item {
    id = "xs_carbide_cuirass",
    copy_from = "carbide_cuirass",
    armor = {},
    inheritance = {
        add = { flags = { "UNDERSIZE", "PREFIX_XS" } },
        scale = { mass = 0.75, volume = 0.75, price = 0.5, survival_price = 0.5 },
    },
}
