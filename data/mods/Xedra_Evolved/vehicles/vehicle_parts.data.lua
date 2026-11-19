local ccb = require("ccb")

ccb.content.define_item {
    id = "floral_battery",
    copy_from = "battery_car",
    name = ccb.content.plural_text("solar power", "solar power"),
    description = ccb.content.text("Magical solar power, to power a floral vessel."),
    mass = "1500 g",
    volume = "750 ml",
    price = "200 USD",
    survival_price = "1 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 225 } } },
    magazine = { capacity = 225 },
}
