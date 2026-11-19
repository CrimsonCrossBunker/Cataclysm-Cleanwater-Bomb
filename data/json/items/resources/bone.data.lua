local ccb = require("ccb")

ccb.content.define_item {
    id = "skull_llama",
    name = ccb.content.plural_text("llama skull", "llama skulls"),
    description = ccb.content.text("The skull of a llama."),
    copy_from = "skull_abstract",
    mass = "800 g",
    volume = "8850 ml",
    length = "30 cm",
    inheritance = { scale = { calories = 0.8 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "4800 mg" }, { id = "meat_allergen", amount = 1 } } },
}
