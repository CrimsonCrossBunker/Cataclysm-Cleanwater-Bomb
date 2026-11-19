local ccb = require("ccb")

-- weight and freezing temp adjusted assuming the acid is diluted by essentially 50% water
ccb.content.define_item {
    id = "blood_acid_underground",
    copy_from = "chem_sulphuric_acid",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("foul acidic blood", "foul acidic blood"),
    symbol = "~",
    color = "red",
    mass = "352 g",
    description = ccb.content.text("Blood mixed with acidic compounds, foul-smelling and extremely corrosive, a means of refining this could net some useful chemicals."),
    comestible = { freezing_point = -18 },
}
