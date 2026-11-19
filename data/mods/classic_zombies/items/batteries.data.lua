local ccb = require("ccb")

-- Just a simple multiplier on weight/volume
ccb.content.define_item {
    id = "battery_car_assembly",
    category = "veh_parts",
    name = ccb.content.plural_text("car battery assembly", "car battery assemblies"),
    description = ccb.content.text("A group of six 12V lead-acid batteries, wired together with a battery management system.  Designed to be plugged into a static power grid."),
    ascii_picture = "battery_car",
    mass = "120 kg",
    volume = "60 L",
    price = "150 USD",
    survival_price = "30 USD",
    materials = { "plastic", "lead" },
    symbol = ":",
    color = "light_cyan",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 18000 } } },
    magazine = { ammunition = { "battery" }, capacity = 18000 },
}
