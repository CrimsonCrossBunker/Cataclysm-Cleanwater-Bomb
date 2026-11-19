local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_4g_plasma",
    looks_like = "plasma",
    name = ccb.content.text("4g plasma cell"),
    description = ccb.content.text("A tiny canister that can safely store up to 4 grams of solid hydrogen in a cryo-pressurized state."),
    mass = "25 g",
    volume = "80 ml",
    price = "300 USD",
    survival_price = "300 USD",
    materials = { "hydrogen_cell" },
    symbol = "o",
    color = "light_blue",
    flags = { "NO_UNLOAD", "NO_RELOAD", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, airtight = true, ammunition = { afs_shydrogen = 4 } } },
    magazine = { ammunition = { "afs_shydrogen" }, capacity = 4, reload_time = 10 },
}

ccb.content.define_item {
    id = "afs_20g_plasma",
    looks_like = "plasma",
    name = ccb.content.text("20g plasma cell"),
    description = ccb.content.text("A reinforced canister that can safely store up to 20 grams of solid hydrogen in a cryo-pressurized state."),
    mass = "30 g",
    volume = "120 ml",
    price = "1400 USD",
    survival_price = "1400 USD",
    materials = { "hydrogen_cell" },
    symbol = "o",
    color = "light_blue",
    flags = { "NO_UNLOAD", "NO_RELOAD", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, airtight = true, ammunition = { afs_shydrogen = 20 } } },
    magazine = { ammunition = { "afs_shydrogen" }, capacity = 4, reload_time = 10 },
}

ccb.content.define_item {
    id = "afs_40g_plasma_civ",
    looks_like = "plasma",
    name = ccb.content.plural_text("40g plasma cell (civilian)", "40g plasma cells (civilian)"),
    description = ccb.content.text("A yellow and red canister that can safely store up to 40 grams of solid hydrogen in a cryo-pressurized state.  A complex nozzle with integrated digital failsafes make it incompatible with military railguns."),
    mass = "45 g",
    volume = "400 ml",
    price = "140 USD",
    survival_price = "140 USD",
    materials = { "hydrogen_cell" },
    symbol = "o",
    color = "light_red",
    flags = { "NO_UNLOAD", "NO_RELOAD", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, airtight = true, ammunition = { afs_shydrogen = 40 } } },
    magazine = { ammunition = { "afs_shydrogen" }, capacity = 40, reload_time = 40 },
}
