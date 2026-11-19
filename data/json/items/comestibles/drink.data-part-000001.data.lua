local ccb = require("ccb")

ccb.content.define_item {
    id = "bee_balm_tea",
    name = ccb.content.plural_text("bee balm tea", "bee balm tea"),
    copy_from = "tea",
    color = "green",
    description = ccb.content.text("A healthy beverage made from bee balm steeped in boiling water.  Can be used to reduce negative effects of common cold or flu."),
    display_type = "BY_VOLUME",
    price = "1 USD",
    survival_price = "25 cent",
    flags = { "EATEN_HOT", "NO_AUTO_CONSUME" },
    comestible = {
        kind = "MED",
        shelf_life = "10 days",
        calories = 2,
        fun = 1,
        vitamins = { { id = "caffeine", amount = 15 } },
    },
    use_actions = { "FLUMED" },
}
