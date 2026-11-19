local ccb = require("ccb")

ccb.content.define_item {
    id = "5l_methanol_tank",
    category = "tool_magazine",
    name = ccb.content.text("5 L methanol fuel cartridge"),
    description = ccb.content.text("A 5-liter plastic tank filled with methanol, with a specialized opening to connect it to a methanol fuel cell.  It's not designed to be refillable by the user, but you could refill it if you had a syringe and a lot of time."),
    mass = "4300 g",
    volume = "5250 ml",
    length = "283 mm",
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "=",
    color = "yellow",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "METHANOL_TANK" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { methanol_fuelcell = 20000 },
            watertight = true,
        },
    },
    magazine = { count = 20000, ammunition = { "methanol_fuelcell" } },
}

ccb.content.define_item {
    id = "10l_methanol_tank",
    category = "tool_magazine",
    name = ccb.content.text("10 L methanol fuel cartridge"),
    description = ccb.content.text("A 10-liter plastic tank filled with methanol, with a specialized opening to connect it to a methanol fuel cell.  It's not designed to be refillable by the user, but you could refill it if you had a syringe and a lot of time."),
    mass = "8400 g",
    volume = "10500 ml",
    length = "318 mm",
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "=",
    color = "yellow",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "METHANOL_TANK" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { methanol_fuelcell = 40000 },
            watertight = true,
        },
    },
    magazine = { count = 40000, ammunition = { "methanol_fuelcell" } },
}

ccb.content.define_item {
    id = "28l_methanol_tank",
    category = "tool_magazine",
    name = ccb.content.text("28 L methanol fuel cartridge"),
    description = ccb.content.text("A 28-liter plastic tank filled with methanol, with a specialized opening to connect it to a methanol fuel cell.  It's not designed to be refillable by the user, but you could refill it if you had a syringe and a lot of time."),
    mass = "23400 g",
    volume = "29500 ml",
    length = "395 mm",
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "=",
    color = "yellow",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "METHANOL_TANK" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { methanol_fuelcell = 112000 },
            watertight = true,
        },
    },
    magazine = { count = 112000, ammunition = { "methanol_fuelcell" } },
}

ccb.content.define_item {
    id = "60l_methanol_tank",
    category = "tool_magazine",
    name = ccb.content.text("60 L methanol fuel cartridge"),
    description = ccb.content.text("A 60-liter plastic tank filled with methanol, with a specialized opening to connect it to a methanol fuel cell.  It's not designed to be refillable by the user, but you could refill it if you had a syringe and a lot of time."),
    mass = "55 kg",
    volume = "72 L",
    length = "670 mm",
    price = "100 USD",
    survival_price = "10 USD",
    materials = { "plastic" },
    symbol = "=",
    color = "yellow",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "METHANOL_TANK" },
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { methanol_fuelcell = 240000 },
            watertight = true,
        },
    },
    magazine = { count = 240000, ammunition = { "methanol_fuelcell" } },
}
