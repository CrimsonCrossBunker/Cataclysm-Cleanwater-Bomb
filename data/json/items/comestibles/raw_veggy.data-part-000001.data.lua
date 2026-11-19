local ccb = require("ccb")

ccb.content.define_item {
    id = "dogbane",
    name = ccb.content.plural_text("dogbane", "dogbane"),
    description = ccb.content.text("A stalk of dogbane.  It has very fibrous stems and is mildly poisonous."),
    flags = { "CORROSIVE" },
    mass = "40 g",
    color = "magenta",
    symbol = ",",
    materials = { "veggy" },
    volume = "250 ml",
    price = "0 cent",
    survival_price = "0 cent",
    stackable = true,
    comestible = { kind = "FOOD", calories = 9, fun = -15, vitamins = { { id = "veggy_allergen", amount = 1 } } },
    use_actions = { "BLECH" },
}
