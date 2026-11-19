local ccb = require("ccb")

-- ["Deployed version of the above. Shouldn't spawn in game.", "Has a little hacky battery pocket so it can charge phones and the like"]
ccb.content.define_item {
    id = "folding_solar_panel_v2_deployed",
    copy_from = "folding_solar_panel_v2",
    name = ccb.content.text("deployed solar suitcase"),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1 } } },
    magazine = { ammunition = { "battery" }, capacity = 1 },
}
