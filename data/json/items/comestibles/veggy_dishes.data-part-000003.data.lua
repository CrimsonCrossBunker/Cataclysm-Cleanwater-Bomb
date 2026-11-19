local ccb = require("ccb")

ccb.content.define_item {
    id = "buckwheat_cooked",
    name = ccb.content.plural_text("cooked buckwheat", "cooked buckwheat"),
    copy_from = "buckwheat",
    description = ccb.content.text("A serving of cooked buckwheat porridge.  Healthy and nutritious but bland."),
    price = "1 USD 20 cent",
    survival_price = "50 cent",
    flags = { "EATEN_HOT" },
    subtype_order = { "milling", "comestible" },
    milling = { result = "null", recipe = "" },
    comestible = { shelf_life = "20 days" },
}
