local ccb = require("ccb")

ccb.content.define_item {
    id = "tinyweldtank",
    looks_like = "pressurized_canister",
    category = "tool_magazine",
    name = ccb.content.text("tiny welding tank"),
    description = ccb.content.text("A tiny acetylene tank.  It can pressurize up to 1 liter of welding gas."),
    mass = "500 g",
    volume = "1 L",
    length = "20 cm",
    price = "100 USD",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "brown",
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { weldgas = 100 }, watertight = true } },
    magazine = { ammunition = { "weldgas" }, capacity = 100, count = 100 },
}

-- Hot Max 24012 Acetylene Cylinder
ccb.content.define_item {
    id = "smallweldtank",
    looks_like = "pressurized_tank",
    category = "tool_magazine",
    name = ccb.content.text("small welding tank"),
    description = ccb.content.text("A compact MC size acetylene tank.  It can pressurize up to 10 cubic feet of welding gas."),
    mass = "3640 g",
    volume = "3 L",
    length = "39 cm",
    price = "157 USD 90 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "brown",
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { weldgas = 350 }, watertight = true } },
    magazine = { ammunition = { "weldgas" }, capacity = 350, count = 350 },
}

-- Lemorele B Steel Acetylene Cylinder
ccb.content.define_item {
    id = "weldtank",
    looks_like = "pressurized_tank",
    category = "tool_magazine",
    name = ccb.content.text("welding tank"),
    description = ccb.content.text("A bulky B size acetylene tank.  It can pressurize up to 40 cubic feet of welding gas."),
    mass = "11360 g",
    volume = "18 L",
    length = "60 cm",
    price = "169 USD 90 cent",
    survival_price = "1 USD",
    materials = { "steel" },
    symbol = "#",
    color = "brown",
    flags = { "NO_UNLOAD", "NO_RELOAD" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { weldgas = 1400 }, watertight = true } },
    magazine = { ammunition = { "weldgas" }, capacity = 1400, count = 1400 },
}
