local ccb = require("ccb")

-- LIR2032, Li-Ion, DURACELL DL2032
ccb.content.define_item {
    id = "light_minus_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("ultra-light battery", "ultra-light batteries"),
    description = ccb.content.text("A light, coin-like battery cell designed for small size over everything else.  Used for watches, calculators, toys or similar low-power electronics."),
    ascii_picture = "light_minus_battery_cell",
    mass = "3 g",
    volume = "1 ml",
    length = "1 mm",
    price = "32 cent",
    survival_price = "1 cent",
    materials = { { id = "budget_steel", portions = 99 }, { id = "plastic", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_ULTRA_LIGHT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2 } } },
    magazine = { ammunition = { "battery" }, capacity = 2 },
}

-- cr2032, Lithium-Manganese, duracell CR2032 but they all pretty equal in their range
ccb.content.define_item {
    id = "light_minus_disposable_cell",
    copy_from = "light_minus_battery_cell",
    name = ccb.content.plural_text("ultra-light battery (disposable)", "ultra-light batteries (disposable)"),
    description = ccb.content.text("A light, coin-like battery cell designed for small size over everything else.  Used for watches, calculators, toys or similar low-power electronics.  This one can't be recharged."),
    ascii_picture = "light_minus_disposable_cell",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2 } } },
    inheritance = { remove = { flags = { "RECHARGE" } } },
    magazine = {},
}

-- AA, Lithium/Iron Disulfide, ENERGIZER L91
ccb.content.define_item {
    id = "light_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("light battery (disposable)", "light batteries (disposable)"),
    description = ccb.content.text("A light battery cell, popular for any consumer-grade electronic: from remotes to mice, from clocks to thermometers.  This one can't be recharged."),
    ascii_picture = "light_battery_cell",
    mass = "15 g",
    volume = "8 ml",
    length = "50 mm",
    price = "31 cent",
    survival_price = "3 cent",
    materials = { { id = "budget_steel", portions = 99 }, { id = "plastic", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "BATTERY_LIGHT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 16 } } },
    magazine = { ammunition = { "battery" }, capacity = 16 },
}

-- AA, Nickel-Metal Hydride, ENERGIZER NH15-2300
ccb.content.define_item {
    id = "light_cell_rechargeable",
    copy_from = "light_battery_cell",
    name = ccb.content.plural_text("light battery", "light batteries"),
    description = ccb.content.text("A light battery cell, popular for any consumer-grade electronic: from remotes to mice, from clocks to thermometers."),
    mass = "27 g",
    ascii_picture = "light_battery_cell",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 10 } } },
    inheritance = { add = { flags = { "RECHARGE" } } },
    magazine = { capacity = 10 },
}

-- 18650, Li-ion, https://cdn-shop.adafruit.com/datasheets/18650%204400mAh.pdf
ccb.content.define_item {
    id = "medium_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("medium battery", "medium batteries"),
    description = ccb.content.text("A medium battery cell, wildly used in modern tools: heavy flashlights, two-way radios, security cameras, multiple of them make a tool battery, and some older generation of EV use thousands of this as the power storage."),
    ascii_picture = "medium_battery_cell",
    mass = "85 g",
    volume = "17 ml",
    length = "65 mm",
    price = "101 cent",
    survival_price = "6 cent",
    materials = { { id = "budget_steel", portions = 99 }, { id = "plastic", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_MEDIUM" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 56 } } },
    magazine = { ammunition = { "battery" }, capacity = 56 },
}

-- Li-ion 18V LXT BL1815N
ccb.content.define_item {
    id = "heavy_battery_cell",
    copy_from = "heavy_plus_battery_cell",
    name = ccb.content.plural_text("small tool battery", "small tool batteries"),
    description = ccb.content.text("A light battery cell, universally compatible with all kinds of industrial-grade equipment and portable tools - drills, angle grinders, chainsaws."),
    ascii_picture = "heavy_battery_cell",
    mass = "350 g",
    volume = "382 ml",
    length = "113 mm",
    price = "22 USD",
    survival_price = "35 cent",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 259 } } },
    magazine = { capacity = 259 },
}

-- Li-ion 18V LXT BL1850B by Makita, because, you guess it, there is no single standard for this type of batteries irl
-- 113 * 75 * 62 mm
ccb.content.define_item {
    id = "heavy_plus_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("big tool battery", "big tool batteries"),
    description = ccb.content.text("A heavy battery cell, universally compatible with all kinds of industrial-grade equipment and portable tools - drills, angle grinders, chainsaws."),
    ascii_picture = "heavy_plus_battery_cell",
    mass = "680 g",
    volume = "525 ml",
    length = "113 mm",
    price = "192 USD",
    survival_price = "35 cent",
    materials = { { id = "budget_steel", portions = 99 }, { id = "plastic", portions = 1 } },
    symbol = "=",
    color = "yellow",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_HEAVY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 503 } } },
    magazine = { ammunition = { "battery" }, capacity = 503 },
}

ccb.content.define_item {
    id = "heavy_atomic_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("heavy plutonium fuel battery (disposable)", "heavy plutonium fuel batteries (disposable)"),
    description = ccb.content.text("A battery that uses a thin plutonium-244 rod to stabilize an exotic nanocompound.  It is universally compatible with all kinds of industrial-grade equipment and large tools.  Although it stores a huge amount of power, it cannot be recharged."),
    ascii_picture = "heavy_atomic_battery_cell",
    mass = "1600 g",
    volume = "1000 ml",
    price = "60 kUSD",
    survival_price = "500 USD",
    materials = { "plut_cell", "plastic" },
    symbol = "=",
    color = "green",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "LEAK_DAM", "RADIOACTIVE", "BATTERY_HEAVY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 4800 } } },
    magazine = { ammunition = { "battery" }, count = 4800, capacity = 4800 },
}

ccb.content.define_item {
    id = "huge_atomic_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("military plutonium fuel cell (disposable)", "military plutonium fuel cells (disposable)"),
    description = ccb.content.text("A battery that uses a huge plutonium-244 rod to stabilize an exotic nanocompound.  It was used in military mech-suits, was highly experimental, and had no civilian applications.  Although it stores a stupendous amount of power, it cannot be recharged."),
    mass = "34000 g",
    volume = "20 L",
    price = "12000 kUSD",
    survival_price = "10 kUSD",
    materials = { "plut_cell", "superalloy" },
    symbol = "=",
    color = "red",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "MECH_BAT", "LEAK_DAM", "RADIOACTIVE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 100000 } } },
    magazine = { ammunition = { "battery" }, count = 100000, capacity = 100000 },
}
