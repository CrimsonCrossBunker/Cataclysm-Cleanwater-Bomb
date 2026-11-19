local ccb = require("ccb")

ccb.content.define_item {
    id = "concentrated_underhill_essence",
    name = ccb.content.plural_text("concentrated underhill essence", "concentrated underhill essence"),
    description = ccb.content.text("The distilled essence of the Fae.  Can be used as part of rituals."),
    mass = "9 g",
    volume = "5 ml",
    price = "8 USD",
    survival_price = "10 cent",
    symbol = "~",
    color = "light_blue",
    phase = "liquid",
    looks_like = "fae_blood",
    flags = { "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 1 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You drink some concentrated underhill essence."),
            vitamins = { { id = "underhill_essence", minimum = 100 } },
        },
    },
}
