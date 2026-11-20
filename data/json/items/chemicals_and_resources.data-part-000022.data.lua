local ccb = require("ccb")

ccb.content.define_item {
    id = "blood_acid_insect",
    copy_from = "formic_acid",
    category = "chems",
    survival_price = "0 cent",
    name = ccb.content.plural_text("virulent acidic blood", "virulent acidic blood"),
    symbol = "~",
    color = "red",
    description = ccb.content.text("Blood mixed with acidic compounds, extremely corrosive, a means of refining this could net some useful chemicals."),
    volume = "250 ml",
    mass = "305 g",
    default_container = "bottle_glass",
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    comestible = {},
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}

ccb.content.define_item {
    id = "blood_acid_plant",
    copy_from = "chem_acetic_acid",
    price = "0 cent",
    survival_price = "0 cent",
    name = ccb.content.plural_text("putrid acidic blood", "putrid acidic blood"),
    symbol = "~",
    color = "green",
    description = ccb.content.text("Blood mixed with acidic compounds, smells putrid, a means of refining this could net some useful chemicals."),
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    comestible = { kind = "INVALID", servings = 1 },
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}
