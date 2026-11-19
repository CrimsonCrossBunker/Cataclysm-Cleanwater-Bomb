local ccb = require("ccb")

ccb.content.define_item {
    id = "dreamforged_plate_armor",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.plural_text("dreamforged plate armor", "dreamforged plate armors"),
    description = ccb.content.text("Lightweight armor, forged using dreamdross.  The only reason it feels soft enough is the magic.  It also has few MOLLE-compatible strips that you can utilize.  The dreamdross grant it some minor magical properties, but you can't control their effects."),
    mass = "3896 g",
    volume = "17500 ml",
    survival_price = "0 cent",
    materials = { "forged_dreamstuff" },
    symbol = "[",
    looks_like = "armor_lc_lightplate",
    color = "dark_gray",
    length = "60 cm",
    flags = { "OUTER", "STURDY", "BLOCK_WHILE_WORN", "PADDED", "MORPHIC" },
    max_worn = 1,
    armor = {
        warmth = 12,
        thickness = 2,
        portions = {
            {
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 2 } },
                covers = { "torso" },
                coverage = 100,
                encumbrance = 7,
            },
            {
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 1.25 } },
                covers = { "arm_l", "arm_r" },
                coverage = 100,
                encumbrance = 5,
            },
            {
                materials = { { id = "forged_dreamstuff", coverage = 100, thickness = 1.25 } },
                covers = { "leg_l", "leg_r" },
                coverage = 100,
                encumbrance = 5,
            },
        },
    },
    use_actions = { { kind = "attach_molle", size = 4 }, { kind = "detach_molle" } },
}
