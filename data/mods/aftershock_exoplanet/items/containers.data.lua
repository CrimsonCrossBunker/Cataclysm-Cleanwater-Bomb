local ccb = require("ccb")

ccb.content.define_item {
    id = "pressure_tank",
    copy_from = "pressure_tank",
    name = ccb.content.plural_text("pressurized tank", "pressurized tanks"),
    flags = { "NO_RELOAD", "MAG_BULKY" },
    tool = {},
}
