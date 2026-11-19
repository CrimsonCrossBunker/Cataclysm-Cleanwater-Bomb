local ccb = require("ccb")

ccb.content.define_item {
    id = "wintergreen_leaves",
    name = ccb.content.plural_text("pile of wintergreen leaves", "piles of wintergreen leaves"),
    mass = "5 g",
    color = "green",
    default_container = "bag_plastic_small",
    symbol = "%",
    description = ccb.content.text("These leaves smell strongly medicinal.  When chewed, they first taste sweet but the aftertaste is incredibly bitter.  These leaves contain good amounts of methyl salicylate and merely chewing them may have a similar effect to aspirin."),
    price = "1 USD 30 cent",
    survival_price = "1 USD",
    materials = { { id = "dried_vegetable", portions = 10 }, { id = "veggy", portions = 1 } },
    volume = "50 ml",
    flags = { "EDIBLE_FROZEN", "RAW" },
    stackable = true,
    comestible = {
        sleepiness = 3,
        stimulation = 1,
        kind = "FOOD",
        calories = 4,
        fun = -10,
        vitamins = { { id = "veggy_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You chew the wintergreen leaves."),
            effects = { { id = "pkill_wintergreen", duration = "30 m" } },
        },
    },
}
