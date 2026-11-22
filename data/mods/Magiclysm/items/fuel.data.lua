local ccb = require("ccb")

ccb.content.define_item {
    id = "blood_tainted",
    copy_from = "blood_tainted",
    name = ccb.content.plural_text("tainted blood", "tainted blood"),
    symbol = "~",
    category = "fuel",
    mass = "1048 mg",
    volume = "1 ml",
    ammunition = { type = "blood_tainted" },
    comestible = { calories = 2 },
    subtype_order = { "ammunition", "comestible" },
}
