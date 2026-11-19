local ccb = require("ccb")

-- NO_I18N
ccb.content.define_item {
    id = "camp_meal_small",
    name = ccb.content.plural_text("prepared meal (small)", "prepared meals (small)"),
    description = ccb.content.text_without_extraction("I am an item used in faction camps.  If you see this description, it is a bug."),
    mass = "250 g",
    volume = "250 ml",
    price = "100 cent",
    survival_price = "100 cent",
    materials = { "foodplace_foodstuff" },
    symbol = "F",
    color = "brown",
    flags = { "DEBUG_ONLY" },
    comestible = { kind = "FOOD", shelf_life = "300 days", calories = 0 },
}
