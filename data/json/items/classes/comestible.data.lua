local ccb = require("ccb")

-- NO_I18N
-- Spices are inedible in their base form but useful in crafting
ccb.content.define_item {
    id = "spice",
    abstract = true,
    name = ccb.content.text_without_extraction("spice", "spice"),
    flags = { "NUTRIENT_OVERRIDE", "INEDIBLE", "WATER_DISSOLVE" },
    mass = "3500 mg",
    volume = "5 ml",
    price = "2 cent",
    default_container = "bag_plastic_small",
    materials = { "powder" },
    symbol = "%",
    display_type = "BY_WEIGHT",
    stackable = true,
    comestible = { kind = "FOOD", freezing_point = -274 },
}
