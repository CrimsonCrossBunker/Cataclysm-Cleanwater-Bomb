local ccb = require("ccb")

ccb.content.define_item {
    id = "skull_cervine",
    name = ccb.content.plural_text("deer skull", "deer skulls"),
    description = ccb.content.text("The skull of a cervine, either a deer or a reindeer, with the antlers still attached."),
    copy_from = "skull_abstract",
    mass = "2500 g",
    volume = "2 L",
    length = "50 cm",
    inheritance = { scale = { calories = 2.5 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "15000 mg" }, { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "skull_cervine_spideer",
    name = ccb.content.plural_text("spideer skull", "spideer skulls"),
    description = ccb.content.text("The skull of a cervine, with the antlers still attached…  But why does it have eight eye sockets?"),
    copy_from = "skull_abstract",
    mass = "2250 g",
    volume = "2 L",
    length = "40 cm",
    inheritance = { scale = { calories = 2.25 } },
    subtype_order = { "milling", "comestible" },
    milling = {},
    comestible = { vitamins = { { id = "calcium", amount = "13500 mg" }, { id = "meat_allergen", amount = 1 } } },
}
