local ccb = require("ccb")

ccb.content.define_item {
    id = "450_ar15mag",
    name = ccb.content.text(".450 Bushmaster 4-round conversion magazine"),
    description = ccb.content.text("An aluminum box magazine containing a single four round stack of .450 Bushmaster cartridges, engineered to fit and feed appropriately converted AR-platform rifles."),
    mass = "226 g",
    volume = "290 ml",
    length = "190 mm",
    price = "29 USD 99 cent",
    survival_price = "2 USD 50 cent",
    materials = { "aluminum" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["450"] = 4 } } },
    magazine = { ammunition = { "450" } },
}

ccb.content.define_item {
    id = "ruger_arr_mag",
    name = ccb.content.text("Ruger American Rifle 3-round magazine"),
    description = ccb.content.text("A detachable polymer box magazine, capable of containing three rounds of .450 Bushmaster and compatible with appropriately chambered American Ranch Rifles."),
    mass = "78 g",
    volume = "220 ml",
    length = "100 mm",
    price = "29 USD 99 cent",
    survival_price = "1 USD 50 cent",
    materials = { "plastic", "steel" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["450"] = 3 } } },
    magazine = { ammunition = { "450" } },
}
