local ccb = require("ccb")

-- Capacity 3x normal
ccb.content.define_item {
    id = "light_battery_electronoetic",
    category = "tool_magazine",
    name = ccb.content.plural_text("light electronoetic battery", "light electronoetic batteries"),
    description = ccb.content.text("A light battery but with the casing devoid of branding or symbols other than a plus and minus on opposite ends.  It's surprisingly heavy."),
    ascii_picture = "light_battery_cell",
    mass = "20 g",
    volume = "8 ml",
    length = "50 mm",
    price = "31 cent",
    survival_price = "2 USD",
    materials = {
        { id = "budget_steel", portions = 90 },
        { id = "nether_crystal", portions = 9 },
        { id = "plastic", portions = 1 },
    },
    symbol = "=",
    color = "cyan",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "BATTERY_LIGHT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 48 } } },
    magazine = { ammunition = { "battery" }, capacity = 48 },
}

-- Capacity 8x normal
ccb.content.define_item {
    id = "light_battery_electronoetic_refined",
    copy_from = "light_battery_electronoetic",
    category = "tool_magazine",
    name = ccb.content.plural_text("light refined electronoetic battery", "light refined electronoetic batteries"),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 128 } } },
    magazine = { capacity = 128 },
}

-- Capacity 3x normal
ccb.content.define_item {
    id = "medium_battery_electronoetic",
    category = "tool_magazine",
    name = ccb.content.plural_text("medium electronoetic battery", "medium electronoetic batteries"),
    description = ccb.content.text("A medium battery but with the casing devoid of branding or symbols other than a plus and minus on opposite ends.  It's surprisingly heavy."),
    ascii_picture = "medium_battery_cell",
    mass = "100 g",
    volume = "17 ml",
    length = "65 mm",
    price = "101 cent",
    survival_price = "5 USD",
    materials = {
        { id = "budget_steel", portions = 90 },
        { id = "nether_crystal", portions = 9 },
        { id = "plastic", portions = 1 },
    },
    symbol = "=",
    color = "cyan",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "BATTERY_MEDIUM" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 168 } } },
    magazine = { ammunition = { "battery" }, capacity = 168 },
}

-- Capacity 8x normal
ccb.content.define_item {
    id = "medium_battery_electronoetic_refined",
    copy_from = "medium_battery_electronoetic",
    category = "tool_magazine",
    name = ccb.content.plural_text("medium refined electronoetic battery", "medium refined electronoetic batteries"),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 448 } } },
    magazine = { capacity = 448 },
}

-- 113 * 75 * 62 mm
-- Capacity 3x normal
ccb.content.define_item {
    id = "heavy_battery_electronoetic",
    category = "tool_magazine",
    name = ccb.content.plural_text("electronoetic tool battery", "electronoetic tool batteries"),
    description = ccb.content.text("A battery cell, compatible with all kinds of industrial-grade equipment and portable tools, but with the casing devoid of branding or symbols other than a plus and minus on opposite ends.  It's surprisingly heavy."),
    ascii_picture = "heavy_battery_cell",
    mass = "400 g",
    volume = "382 ml",
    length = "113 mm",
    price = "22 USD",
    survival_price = "35 cent",
    materials = {
        { id = "budget_steel", portions = 90 },
        { id = "nether_crystal", portions = 9 },
        { id = "plastic", portions = 1 },
    },
    symbol = "=",
    color = "cyan",
    looks_like = "battery",
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "BATTERY_HEAVY" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 777 } } },
    magazine = { ammunition = { "battery" }, capacity = 777 },
}

-- Capacity 8x normal
ccb.content.define_item {
    id = "heavy_battery_electronoetic_refined",
    copy_from = "heavy_battery_electronoetic",
    category = "tool_magazine",
    name = ccb.content.plural_text("refined electronoetic tool battery", "refined electronoetic tool batteries"),
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 2072 } } },
    magazine = { capacity = 2072 },
}
