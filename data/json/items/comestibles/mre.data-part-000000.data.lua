local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mre_entree",
    abstract = true,
    name = ccb.content.text_without_extraction("MRE entree"),
    mass = "227 g",
    color = "brown",
    symbol = "%",
    description = ccb.content.text_without_extraction("A generic MRE entree, you shouldn't see this."),
    price = "12 USD 50 cent",
    survival_price = "3 USD",
    volume = "250 ml",
    flags = { "EATEN_HOT", "RAD_STERILIZED", "DECAY_EXPOSED_ATMOSPHERE" },
    looks_like = "mre_beef",
    stackable = true,
    comestible = { shelf_life = "3 days 8 hours", kind = "FOOD", calories = 320, fun = -1 },
}
