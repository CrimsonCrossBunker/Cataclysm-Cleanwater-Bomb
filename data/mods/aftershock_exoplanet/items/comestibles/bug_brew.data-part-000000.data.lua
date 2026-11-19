local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_mealgrub_medium",
    name = ccb.content.plural_text("mealgrub growth medium", "mealgrub growth medium"),
    description = ccb.content.text("All sorts of organic substances rendered into a nutritious goop that can be used as a growth medium in grub aquaculture.  Urban myth claims that its original formula was just bottled industrial runoff.  Whatever the case, mealgrubs thrive within it."),
    mass = "100 g",
    default_container = "jug_plastic",
    flags = { "NUTRIENT_OVERRIDE" },
    symbol = "~",
    price = "10 USD",
    survival_price = "1 USD",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    comestible = {
        kind = "DRINK",
        quench = -10,
        healthy = -2,
        calories = 400,
        servings = 5,
        fun = -30,
        vitamins = {
            { id = "calcium", amount = 2 },
            { id = "iron", amount = 12 },
            { id = "bad_food", amount = 1 },
        },
    },
    use_actions = { "BLECH" },
}

ccb.content.define_item {
    id = "afs_mealgrub_spores",
    name = ccb.content.plural_text("mealgrub spores", "mealgrub spores"),
    description = ccb.content.text("Mealgrubs are a staple aquacultural product, treasured for their ability to process nearly any organic substance into safe for consumption animal protein.  As the result of very heavy-handed gene-modding these are proprietary organisms, and strictly speaking, it's illegal to grow them without a license."),
    mass = "100 g",
    default_container = "bottle_plastic_small",
    symbol = "~",
    price = "10 USD",
    survival_price = "1 USD",
    volume = "250 ml",
    phase = "liquid",
    category = "chems",
    comestible = { kind = "DRINK", quench = -10, healthy = -2, calories = 1, servings = 100, fun = -10 },
    use_actions = { "BLECH" },
}
