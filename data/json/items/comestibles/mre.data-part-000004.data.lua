local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mre_dessert",
    abstract = true,
    name = ccb.content.text_without_extraction("MRE dessert"),
    mass = "52 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text_without_extraction("A generic MRE dessert, you shouldn't see this."),
    price = "12 USD 50 cent",
    survival_price = "3 USD",
    volume = "125 ml",
    flags = { "RAD_STERILIZED", "DECAY_EXPOSED_ATMOSPHERE" },
    looks_like = "cookies",
    comestible = { shelf_life = "3 days 8 hours", kind = "FOOD", calories = 270, fun = 4 },
}
