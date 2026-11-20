local ccb = require("ccb")

ccb.content.define_item {
    id = "chem_acetone",
    category = "chems",
    price = "50 cent",
    survival_price = "5 cent",
    name = ccb.content.plural_text("acetone", "acetone"),
    symbol = "=",
    color = "white",
    description = ccb.content.text("Acetone, best known as the primary constituent of most nail polish removers.  Flammable, and can be easily used for potent homemade explosives, as demonstrated by the terrorist attacks of 2016."),
    volume = "250 ml",
    mass = "190 g",
    materials = { "acetone" },
    phase = "liquid",
    default_container = "bottle_glass",
    display_type = "BY_VOLUME",
    ammunition = { type = "components" },
}
