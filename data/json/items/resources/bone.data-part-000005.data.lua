local ccb = require("ccb")

ccb.content.define_item {
    id = "skull_bovine",
    name = ccb.content.text("cow skull"),
    description = ccb.content.text("The skull of a bovine, likely a domestic cow, with the horns still attached."),
    copy_from = "skull_large_abstract",
    mass = "10 kg",
    volume = "58500 ml",
    length = "35 cm",
    comestible = {},
}

ccb.content.define_item {
    id = "skull_equine",
    name = ccb.content.text("horse skull"),
    description = ccb.content.text("The skull of a horse.  Given the circumstances you can be pretty sure it was a domestic horse."),
    copy_from = "skull_large_abstract",
    mass = "10 kg",
    volume = "45 L",
    length = "55 cm",
    comestible = {},
}
