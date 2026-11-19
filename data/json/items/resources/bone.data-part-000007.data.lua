local ccb = require("ccb")

ccb.content.define_item {
    id = "skull_moose",
    name = ccb.content.text("moose skull"),
    description = ccb.content.text("The skull of a moose, unmistakable thanks to the antler shape."),
    copy_from = "skull_large_abstract",
    mass = "12 kg",
    volume = "85 L",
    length = "65 cm",
    comestible = { vitamins = { { id = "calcium", amount = "72000 mg" }, { id = "meat_allergen", amount = 1 } } },
    inheritance = { scale = { calories = 1.2 } },
}

ccb.content.define_item {
    id = "skull_moose_tusked",
    name = ccb.content.text("tusked moose skull"),
    description = ccb.content.text("The skull of a moose, unmistakable thanks to the antler shape and… tusks?  Okay, maybe this did not belong to a normal moose after all."),
    copy_from = "skull_large_abstract",
    mass = "20 kg",
    volume = "125 L",
    length = "120 cm",
    comestible = {
        vitamins = { { id = "calcium", amount = "120000 mg" }, { id = "meat_allergen", amount = 1 } },
    },
    inheritance = { scale = { calories = 2 } },
}
