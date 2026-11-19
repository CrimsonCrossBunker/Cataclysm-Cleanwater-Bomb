local ccb = require("ccb")

ccb.content.define_item {
    id = "alien_battery",
    category = "spare_parts",
    name = ccb.content.text("alien cell"),
    description = ccb.content.text("A conical device salvaged from an alien artifact.  Grooves etched on its circular face slowly pulse with purple light."),
    mass = "1000 g",
    volume = "1225ml",
    price = "1 kUSD",
    materials = { "iron", "plastic" },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "MAG_BULKY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 4500 } } },
    magazine = { ammunition = { "battery" }, capacity = 4500 },
}
