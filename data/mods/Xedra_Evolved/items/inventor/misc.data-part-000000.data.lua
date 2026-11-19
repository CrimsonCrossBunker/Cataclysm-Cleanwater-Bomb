local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_light_minus_cell",
    copy_from = "light_minus_disposable_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("ultra-light modified battery", "ultra-light modified batteries"),
    description = ccb.content.text("A light battery cell that was modified and replaced with much more effective cells inside."),
    flags = {
        "NO_SALVAGE",
        "NO_UNLOAD",
        "NO_RELOAD",
        "RECHARGE",
        "BATTERY_ULTRA_LIGHT",
        "INVENTOR_CRAFTED",
    },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 125 } } },
    magazine = { count = 125, capacity = 125 },
}

ccb.content.define_item {
    id = "inventor_light_cell",
    copy_from = "light_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("light modified battery", "light modified batteries"),
    description = ccb.content.text("A light battery cell that was modified and replaced with much more effective cells inside."),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_LIGHT", "INVENTOR_CRAFTED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 375 } } },
    magazine = { count = 375, capacity = 375 },
}

ccb.content.define_item {
    id = "inventor_medium_cell",
    copy_from = "medium_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("medium modified battery", "medium modified batteries"),
    description = ccb.content.text("A medium battery cell that was modified and replaced with much more effective cells inside."),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_MEDIUM", "INVENTOR_CRAFTED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    magazine = { count = 1500, capacity = 1500 },
}

ccb.content.define_item {
    id = "inventor_heavy_cell",
    copy_from = "heavy_plus_battery_cell",
    category = "tool_magazine",
    name = ccb.content.plural_text("modified tool battery", "modified tool batteries"),
    description = ccb.content.text("A tool battery cell that was modified and replaced with much more effective cells inside."),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE", "BATTERY_HEAVY", "INVENTOR_CRAFTED" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 3125 } } },
    magazine = { count = 3125, capacity = 3125 },
}
