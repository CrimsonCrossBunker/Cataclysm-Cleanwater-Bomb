local ccb = require("ccb")

ccb.content.define_item {
    id = "dry_bottle_gourd",
    name = ccb.content.text("dried bottle gourd"),
    copy_from = "dry_lentils",
    looks_like = "pumpkin",
    symbol = "6",
    description = ccb.content.text("A vegetable from the gourd family, bottle gourds were brought to the Americas by the first Native American settlers crossing the Bering strait.  This one has been dried for processing into a watertight container."),
    volume = "1250 ml",
    default_container = "bag_plastic",
    flags = { "INEDIBLE" },
    comestible = { kind = "FOOD" },
}
