local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "cryo_storage_loot",
    abstract = true,
    symbol = "q",
    color = "red",
    name = ccb.content.text_without_extraction("frozen thing"),
    description = ccb.content.text_without_extraction("Oh my god, don't let it thaw!"),
    price = "10 USD",
    survival_price = "50 cent",
    materials = { "flesh" },
    flags = { "TRADER_AVOID", "INEDIBLE", "CRYOGENIC_ROT" },
    mass = "114 g",
    volume = "250 ml",
    category = "chems",
    comestible = { kind = "FOOD", freezing_point = -9999, quench = 2, shelf_life = "30 seconds" },
}
