local ccb = require("ccb")

ccb.content.define_item {
    id = "mre_potato",
    copy_from = "mre_side",
    name = ccb.content.plural_text("potatoes, Au Gratin", "potatoes, Au Gratin"),
    description = ccb.content.text("Golden-fried potatoes."),
    materials = { "veggy" },
    comestible = { vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_fried_rice",
    copy_from = "mre_side",
    name = ccb.content.plural_text("fried rice (small portion)", "fried rice (small portions)"),
    description = ccb.content.text("Fried rice, a simple dish made by stir-frying rice with other ingredients."),
    materials = { "veggy" },
    comestible = { vitamins = { { id = "veggy_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_zapplesauce",
    copy_from = "mre_side",
    name = ccb.content.plural_text("zapplesauce", "zapplesauce"),
    description = ccb.content.text("Golden, jelly-like food with the flavor of apples."),
    materials = { "fruit" },
    comestible = { fun = 5, vitamins = { { id = "fruit_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "mre_blackbeans",
    copy_from = "mre_side",
    name = ccb.content.plural_text("black beans in sauce", "black beans in sauce"),
    description = ccb.content.text("A savory and flavorful combination of black beans and sauce."),
    materials = { "bean" },
    comestible = { calories = 130, vitamins = { { id = "veggy_allergen", amount = 1 } } },
}
