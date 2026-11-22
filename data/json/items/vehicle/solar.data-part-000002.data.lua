local ccb = require("ccb")

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
