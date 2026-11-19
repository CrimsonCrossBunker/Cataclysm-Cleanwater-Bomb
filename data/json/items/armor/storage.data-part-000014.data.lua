local ccb = require("ccb")

ccb.content.define_item {
    id = "mbag",
    name = ccb.content.plural_text("messenger bag", "messenger bags"),
    description = ccb.content.text("Light and easy to wear, but doesn't offer much storage."),
    mass = "690 g",
    volume = "2625 ml",
    price = "79 USD",
    survival_price = "2 USD 50 cent",
    materials = { "nylon", "plastic" },
    symbol = "[",
    looks_like = "purse",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "15 L",
            mass_limit = "18 kg",
            max_item_length = "50 cm",
            magazine_well = "2500 ml",
            moves = 150,
        },
    },
    flags = { "BELTED", "WATER_FRIENDLY", "OVERSIZE" },
    armor = {
        thickness = 1,
        portions = {
            {
                encumbrance = 4,
                volume_encumbrance = 0.25,
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You slide the bag to your side."),
            menu_text = ccb.content.text("Adjust"),
            target = "mbag_sided",
            moves = 120,
        },
    },
}

ccb.content.define_item {
    id = "mbag_sided",
    name = ccb.content.plural_text("messenger bag", "messenger bags"),
    copy_from = "mbag",
    flags = { "OUTER", "WATER_FRIENDLY", "OVERSIZE" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 4,
                volume_encumbrance = 0.25,
                coverage = 40,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_l", "leg_hip_r" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You move the bag to your back."),
            menu_text = ccb.content.text("Adjust"),
            target = "mbag",
            moves = 120,
        },
    },
}
