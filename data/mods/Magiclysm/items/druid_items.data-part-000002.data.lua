local ccb = require("ccb")

ccb.content.define_item {
    id = "mag_brokeweaver",
    symbol = ";",
    color = "green",
    name = ccb.content.plural_text("small damaged weaver", "small damaged weavers"),
    description = ccb.content.text("A tiny broken weaver.  Its legs bent and broken, it can no longer be used to repair clothing or create a shelter."),
    materials = { "wood", "veggy" },
    mass = "50 g",
    volume = "125 ml",
    flags = { "TRADER_AVOID" },
    artifact = {},
}
