local ccb = require("ccb")

ccb.content.define_item {
    id = "armor_dreamdross",
    category = "armor",
    copy_from = "armor_lc_lightplate",
    name = ccb.content.plural_text("dream armor", "dream armor"),
    description = ccb.content.text("A summoned medieval armor made from dreamdross.  It shimmers in the light and provides some protection."),
    materials = { "dreamstuff" },
    flags = { "OVERSIZE", "PERSONAL", "PADDED", "STURDY", "NO_REPAIR", "NO_SALVAGE", "TRADER_AVOID" },
    max_worn = 1,
    armor = {
        warmth = 0,
        thickness = 5,
        portions = {
            {
                encumbrance = 5,
                coverage = 100,
                covers = {
                    "head", "mouth", "eyes", "torso", "arm_l", "arm_r", "hand_l", "hand_r", "leg_l",
                    "leg_r", "foot_l", "foot_r",
                },
            },
        },
    },
}
