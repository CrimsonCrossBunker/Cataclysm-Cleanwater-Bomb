local ccb = require("ccb")

ccb.content.define_item {
    id = "candy_bracelet",
    name = ccb.content.plural_text("candy bracelet", "candy bracelets"),
    looks_like = "copper_bracelet",
    color = "yellow",
    description = ccb.content.text("A candy bracelet made by stringing candies onto a thread.  In theory, you could both wear and eat the bracelet."),
    copy_from = "candy4",
    materials = { "junk" },
    subtype_order = { "comestible", "armor" },
    comestible = { vitamins = { { id = "junk_allergen", amount = 1 } } },
    armor = {
        sided = true,
        portions = {
            {
                coverage = 50,
                covers = { "hand_l", "hand_r" },
                subparts = { "hand_wrist_l", "hand_wrist_r" },
            },
        },
    },
}
