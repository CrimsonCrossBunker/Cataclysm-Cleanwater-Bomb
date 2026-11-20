local ccb = require("ccb")

ccb.content.define_item {
    id = "chem_nitric_acid",
    category = "chems",
    price = "3 USD",
    survival_price = "9 cent",
    name = ccb.content.plural_text("nitric acid", "nitric acid"),
    symbol = "=",
    color = "white",
    flags = { "DROP_ACTION_ONLY_IF_LIQUID" },
    description = ccb.content.text("Nitric acid, a strong oxidant and an extremely corrosive material.  Mainly used in the production of synthetic fertilizers, for the etching of circuit boards, and in woodworking.  Remains quite useful both for making a vast array of pyrotechnic and explosive agents and as a direct weapon: not many beings enjoy being doused in nitric acid."),
    materials = { "acid" },
    volume = "250 ml",
    mass = "375 g",
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    comestible = { kind = "INVALID", servings = 1, freezing_point = -42 },
    drop_action = { kind = "emit_actor", emissions = { "emit_acid_drop" }, scale_quantity = true },
}
