local ccb = require("ccb")

-- depending on the lore as what acid these enemies use this could change, muriatic acid is stomach acid
ccb.content.define_item {
    id = "blood_acid",
    copy_from = "chem_muriatic_acid",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("toxic acidic blood", "toxic acidic blood"),
    symbol = "~",
    color = "red",
    description = ccb.content.text("Blood mixed with acidic compounds, extremely corrosive, a means of refining this could net some useful chemicals."),
    comestible = {},
}
