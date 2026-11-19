local ccb = require("ccb")

ccb.content.define_item {
    id = "item_hedge_cure_cold_or_flu",
    copy_from = "tea",
    name = ccb.content.text("Curative tea"),
    description = ccb.content.text("Tea with herbs, iron, and a bit of magick.  If you're sick, there's nothing better for your body than this."),
    comestible = {},
}

ccb.content.define_item {
    id = "item_hedge_turn_into_bear_off",
    name = ccb.content.text("drained bearskin talisman"),
    description = ccb.content.text("A heavy fur mantle attached to the skull of a bear.  The charm worked into it has been expended."),
    mass = "2368 g",
    volume = "4 L",
    price = "245 USD",
    survival_price = "7 USD 50 cent",
    materials = { "fur", "bone" },
    symbol = "[",
    looks_like = "cloak_leather",
    color = "brown",
    flags = { "OVERSIZE", "HOOD", "TRADER_AVOID", "BELTED", "RAINPROOF" },
    armor = {
        warmth = 60,
        thickness = 2,
        environmental_protection = 3,
        portions = {
            {
                encumbrance = 6,
                coverage = 65,
                covers = { "torso", "arm_l", "arm_r" },
                subparts = {
                    "torso_upper",
                    "torso_neck",
                    "arm_shoulder_l",
                    "arm_upper_l",
                    "arm_shoulder_r",
                    "arm_upper_r",
                },
            },
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 100,
                covers = { "head" },
                subparts = { "head_crown" },
            },
            {
                encumbrance_modifiers = { "IMBALANCED" },
                coverage = 60,
                covers = { "head" },
                subparts = { "head_forehead" },
            },
        },
    },
}

ccb.content.define_item {
    id = "item_hedge_turn_into_bear",
    name = ccb.content.text("bearskin talisman"),
    copy_from = "item_hedge_turn_into_bear_off",
    description = ccb.content.text("A heavy fur mantle attached to the skull of a bear.  When you put it on, the charm will take effect and grant you the bear's power."),
    armor = {},
    inheritance = { add = { flags = { "SKINCHANGED", "HEDGE_ENCHANTED" } } },
}
