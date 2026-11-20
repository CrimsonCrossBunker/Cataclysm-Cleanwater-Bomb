local ccb = require("ccb")

ccb.content.define_item {
    id = "fermentable_liquid_mixture",
    name = ccb.content.plural_text("fermentable liquid mixture", "fermentable liquid mixture"),
    volume = "500 ml",
    mass = "500 g",
    description = ccb.content.text("A mixture of various organic wastes and water.  Wait about two months for them to be fermented in a tank.  Also, biogas production will start after one month."),
    copy_from = "fertilizer_liquid",
    price = "0 cent",
    survival_price = "0 cent",
    flags = { "NUTRIENT_OVERRIDE", "TRADER_AVOID" },
    subtype_order = { "composting", "comestible" },
    composting = {
        duration = "60 days",
        products = { { item = "fermented_fertilizer_liquid", count = 1 }, { item = "biogas", count = 250 } },
    },
    comestible = { servings = 1 },
}
