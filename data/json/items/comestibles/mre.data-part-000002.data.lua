local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mre_side",
    abstract = true,
    name = ccb.content.text_without_extraction("MRE side"),
    mass = "142 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text_without_extraction("A generic MRE side, you shouldn't see this."),
    price = "12 USD 50 cent",
    survival_price = "3 USD",
    volume = "250 ml",
    flags = { "EATEN_HOT", "RAD_STERILIZED", "DECAY_EXPOSED_ATMOSPHERE" },
    looks_like = "mre_beef",
    comestible = { shelf_life = "3 days 8 hours", kind = "FOOD", calories = 220, fun = 2 },
}
