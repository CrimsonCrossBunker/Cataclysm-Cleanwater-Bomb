local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "robofac_helmet",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("abstract helmet"),
    mass = "1176 g",
    volume = "1750 ml",
    price = "600 USD",
    survival_price = "50 USD",
    materials = { "ceramic" },
    symbol = ",",
    color = "dark_gray",
    flags = { "ABLATIVE_HELMET", "CANT_WEAR", "OUTER" },
    armor = {
        thickness = 7,
        environmental_protection = 5,
        warmth = 15,
        portions = { { coverage = 85, vitals_coverage = 95, covers = { "head" } } },
    },
}
