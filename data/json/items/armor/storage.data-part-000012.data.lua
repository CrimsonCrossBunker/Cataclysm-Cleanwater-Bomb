local ccb = require("ccb")

-- Less moves as the arm version since grabing things wrapped around your legs is easier.
ccb.content.define_item {
    id = "leg_small_bag",
    copy_from = "armrig",
    name = ccb.content.plural_text("small leg pouch", "small leg pouches"),
    description = ccb.content.text("A small pouch that can be worn on the upper leg using buckled straps, easier to use than on the arm.  For those who want to wear a dress without pockets while carrying their phone and money.  Use it to adjust it to fit your arm."),
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "16 cm",
            moves = 100,
        },
    },
    armor = {
        portions = {
            {
                encumbrance = 1,
                volume_encumbrance = 0.35,
                coverage = 50,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_upper_r", "leg_upper_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You adjust your purse to wear it on your arm."),
            target = "armrig",
            menu_text = ccb.content.text("Adjust on the arm"),
        },
    },
}

ccb.content.define_item {
    id = "armrig",
    name = ccb.content.plural_text("small armband pouch", "small armband pouches"),
    description = ccb.content.text("A small pouch that can be worn on the upper arm using buckled straps.  This is a favored item among sports & camping enthusiasts.  Use it to adjust it to fit your leg."),
    mass = "205 g",
    volume = "550 ml",
    price = "30 USD",
    survival_price = "2 USD 50 cent",
    materials = { "canvas", "plastic" },
    symbol = "[",
    looks_like = "armguard_soft",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "500 ml",
            mass_limit = "1 kg",
            max_item_length = "16 cm",
            moves = 200,
        },
    },
    flags = { "OVERSIZE", "WATER_FRIENDLY", "BELTED" },
    armor = {
        sided = true,
        thickness = 1,
        portions = {
            {
                encumbrance = 0,
                volume_encumbrance = 0.35,
                coverage = 50,
                covers = { "arm_l", "arm_r" },
                subparts = { "arm_upper_r", "arm_upper_l" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You adjust your purse to wear it on your leg."),
            target = "leg_small_bag",
            menu_text = ccb.content.text("Adjust on the leg"),
        },
    },
}
