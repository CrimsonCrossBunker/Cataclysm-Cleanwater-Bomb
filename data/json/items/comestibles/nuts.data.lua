local ccb = require("ccb")

ccb.content.define_item {
    id = "vegan_butter",
    name = ccb.content.plural_text("vegan butter", "vegan butter"),
    mass = "14180 mg",
    color = "brown",
    symbol = "%",
    default_container = "wrapper",
    description = ccb.content.text("A light brown butter substitute made from nuts.  Differs from other nut butters in that the fats are removed from the meat and only the fats retained."),
    display_type = "BY_VOLUME",
    price = "9 cent",
    survival_price = "23 cent",
    materials = { "nut" },
    volume = "15 ml",
    flags = { "NO_AUTO_CONSUME" },
    stackable = true,
    comestible = {
        shelf_life = "18 days",
        kind = "FOOD",
        quench = -1,
        calories = 101,
        fun = -1,
        vitamins = { { id = "nut_allergen", amount = 1 } },
    },
}
