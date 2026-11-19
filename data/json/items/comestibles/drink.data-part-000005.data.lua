local ccb = require("ccb")

ccb.content.define_item {
    id = "spurge_tea",
    name = ccb.content.plural_text("spurge tea", "spurge tea"),
    copy_from = "tea",
    color = "green",
    description = ccb.content.text("A healthy beverage made from spurge flowers steeped in boiling water.  Can be used to prevent asthma attacks."),
    display_type = "BY_VOLUME",
    price = "1 USD",
    survival_price = "25 cent",
    flags = { "EATEN_HOT", "NUTRIENT_OVERRIDE", "NO_AUTO_CONSUME" },
    comestible = { shelf_life = "10 days", calories = 1, kind = "MED", fun = 1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You no longer need to worry about asthma attacks, at least for a while."),
            effects = { { id = "took_antiasthmatic", duration = 86400 } },
        },
    },
}
