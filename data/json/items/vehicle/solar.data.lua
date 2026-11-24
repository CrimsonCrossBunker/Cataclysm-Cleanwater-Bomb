local ccb = require("ccb")

-- Assumed to be ~0.5 m x 0.5 m to fit in a vehicle tile
-- ["66 in x 40 in x 2 in = 68 L solar panels weigh 40 lbs, for density of ~210 g/L", "If this is 0.5 m x 0.5 m x 5 cm, it has a volume of 12.5 L, and a weight of 2.63 kg", "Numbers from https://modernize.com/homeowner-resources/solar/average-solar-panel-dimensions-and-sizes"]
ccb.content.define_item {
    id = "solar_panel",
    name = ccb.content.plural_text("vehicle solar panel", "vehicle solar panels"),
    description = ccb.content.text("An electronic device that can convert solar radiation into electric power.  Useful for a vehicle or a static power grid."),
    mass = "2630 g",
    length = "50 cm",
    accuracy = { grip = "none", length = "short", surface = "any", balance = "clumsy" },
    color = "yellow",
    symbol = "]",
    materials = { "glass" },
    volume = "12500 ml",
    flags = { "NO_REPAIR", "WATER_BREAK" },
    category = "veh_parts",
    price = "900 USD",
    survival_price = "10 USD",
    melee_damage = { bash = 1 },
}

-- ["Deployed version of the above. Shouldn't spawn in game.", "Has a little hacky battery pocket so it can charge phones and the like"]
ccb.content.define_item {
    id = "folding_solar_panel_deployed",
    copy_from = "folding_solar_panel",
    name = ccb.content.text("deployed folding solar panel"),
    flags = { "NO_SALVAGE", "NO_UNLOAD", "NO_RELOAD", "RECHARGE" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1 } } },
    magazine = { ammunition = { "battery" }, capacity = 1 },
}

ccb.content.define_item {
    id = "folding_solar_panel_v2",
    copy_from = "folding_solar_panel",
    name = "solar suitcase",
    description = "A large, ready-to-deploy set of solar panels, designed for portable off-the-grid use.",
    mass = "17500 g",
    volume = "39400 ml",
    length = "83 cm",
    price = "320 USD",
    survival_price = "20 USD",
    use_actions = {
        { kind = "deploy_appliance", base = "folding_solar_panel_v2_deployed" },
    },
}

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
