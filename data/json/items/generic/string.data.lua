local ccb = require("ccb")

ccb.content.define_item {
    id = "stick_fiber",
    category = "spare_parts",
    name = ccb.content.text("fibrous stalk"),
    symbol = "=",
    materials = { "dry_plant" },
    description = ccb.content.text("A rather green stick.  Very fibrous."),
    volume = "100 ml",
    mass = "80 g",
    comestible = { kind = "INVALID", fun = -100, healthy = -20 },
}
