local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_mealgrub_jelly",
    name = ccb.content.plural_text("live mealgrubs", "live mealgrubs"),
    description = ccb.content.text("Thousands of mature mealgrubs squirm in the viscous remains of their growth medium.  They are ready for harvest, and require speedy cleaning and processing, as they can quickly rot in this stage.  They look somewhat disgusting: pale, soft, and uncomfortably maggot-like.  According to product literature this is normal: mealgrubs remain in a sterile juvenile form for their entire useful lifespan and die quickly once removed from the vat."),
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
