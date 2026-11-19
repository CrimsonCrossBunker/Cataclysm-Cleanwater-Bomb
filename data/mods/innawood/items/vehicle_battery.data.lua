local ccb = require("ccb")

-- 58Ah @ 12VDC. Could supply ~700 watts for an hour
ccb.content.define_item {
    id = "battery_car_clay",
    category = "veh_parts",
    name = ccb.content.plural_text("clay car battery", "clay car batteries"),
    description = ccb.content.text("A 12V lead-acid battery used to power car electrical systems, contained in a clay shell."),
    looks_like = "clay_hydria",
    mass = "18000 g",
    volume = "6250 ml",
    price = "40 USD",
    survival_price = "5 USD",
    materials = { "clay" },
    symbol = ":",
    color = "light_cyan",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "BATTERY_HEAVY", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2500 } } },
    magazine = { ammunition = { "battery" }, capacity = 2500 },
}

-- 4 batteries in a box
ccb.content.define_item {
    id = "battery_clay_array",
    category = "veh_parts",
    name = ccb.content.text("clay battery array"),
    description = ccb.content.text("A set of 4 clay car batteries wired together in series in a simple wooden frame."),
    looks_like = "clay_hydria",
    mass = "82400 g",
    volume = "26 L",
    price = "40 USD",
    survival_price = "5 USD",
    materials = { "clay", "wood" },
    symbol = ":",
    color = "light_cyan",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 10000 } } },
    magazine = { ammunition = { "battery" }, capacity = 10000 },
}
