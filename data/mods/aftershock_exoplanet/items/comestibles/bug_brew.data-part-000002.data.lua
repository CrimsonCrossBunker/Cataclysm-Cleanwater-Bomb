local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_mealgrub_jelly",
    name = ccb.content.plural_text("live mealgrubs", "live mealgrubs"),
    description = ccb.content.text("Thousands of mature mealworms, squirming in the viscous remains of their growth medium.  They are ready for harvest, and in fact require speedy cleaning and processing, as the harvest can quickly rot in this stage."),
    mass = "100 g",
    emissions = { "emit_toxic_cloud" },
    default_container = "jug_plastic",
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
        calories = 260,
        shelf_life = "12 days",
        servings = 5,
        fun = -10,
    },
    use_actions = { "BLECH" },
}
