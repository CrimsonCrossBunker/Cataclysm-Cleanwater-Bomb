local ccb = require("ccb")

ccb.content.define_item {
    id = "acorns_cooked",
    name = ccb.content.plural_text("Handful of cooked acorns", "of cooked acorns"),
    display_type = "BY_WEIGHT",
    copy_from = "acorns",
    mass = "22 g",
    volume = "46 ml",
    description = ccb.content.text("A serving of acorns that have been hulled, chopped, and boiled in water before being thoroughly toasted until dry.  Filling and nutritious."),
    price = "22 cent",
    survival_price = "75 cent",
    flags = { "EDIBLE_FROZEN" },
    subtype_order = { "milling", "comestible" },
    milling = { result = "flour_wheat_free", recipe = "flour_wheat_free_mill_2_3" },
    comestible = { shelf_life = "30 days", smoking_result = "acorn_roasted", fun = 0 },
}
