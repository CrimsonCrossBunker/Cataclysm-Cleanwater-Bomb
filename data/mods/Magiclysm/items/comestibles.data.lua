local ccb = require("ccb")

ccb.content.define_item {
    id = "impure_meat",
    copy_from = "mutant_meat",
    name = ccb.content.plural_text("impure meat", "impure meat"),
    description = "Not as tainted as previously and tastes like the real thing.  You do not want to cook this for your friends, though if you do they won't know the difference for a while.",
    price = "1 USD",
    comestible = { calories = 201 },
    inheritance = {
        add = {
            flags = { "NUTRIENT_OVERRIDE" },
        },
    },
}
