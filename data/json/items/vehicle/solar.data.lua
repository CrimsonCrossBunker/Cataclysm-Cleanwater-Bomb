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

ccb.content.define_item {
    id = "folding_solar_panel",
    copy_from = "solar_panel",
    name = "small folding solar panel",
    description = "This \"little\" solar panel folds up to carry around, in case you need to charge anything on the go.  Its small size means it might take quite some time to charge, however.",
    mass = "5700 g",
    volume = "7473 ml",
    length = "53 cm",
    price = "280 USD",
    survival_price = "5 USD",
    use_actions = {
        { kind = "deploy_appliance", base = "folding_solar_panel_deployed" },
    },
}
