local ccb = require("ccb")

ccb.content.define_item {
    id = "skull_pig",
    name = ccb.content.plural_text("pig skull", "pig skulls"),
    description = ccb.content.text("The skull of a pig, either a domestic or a wild one."),
    copy_from = "skull_abstract",
    mass = "650 g",
    volume = "6 L",
    length = "30 cm",
    inheritance = { scale = { calories = 0.65 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "3900 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_sheep",
    name = ccb.content.plural_text("sheep skull", "sheep skulls"),
    description = ccb.content.text("The skull of a domestic sheep."),
    copy_from = "skull_medium_abstract",
    mass = "500 g",
    volume = "4 L",
    length = "25 cm",
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = {},
}

ccb.content.define_item {
    id = "skull_goat",
    name = ccb.content.plural_text("goat skull", "goat skulls"),
    description = ccb.content.text("The skull of a goat with the horns still attached."),
    copy_from = "skull_abstract",
    mass = "800 g",
    volume = "4500 ml",
    length = "25 cm",
    inheritance = { scale = { calories = 0.8 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "4800 mg" }, { id = "meat_allergen", amount = 1 } } },
}
