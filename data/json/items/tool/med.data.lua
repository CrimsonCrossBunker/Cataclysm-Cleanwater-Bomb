local ccb = require("ccb")

ccb.content.define_item {
    id = "syringe",
    name = ccb.content.plural_text("syringe", "syringes"),
    description = ccb.content.text("A medical syringe.  Used for administering intravenous drugs."),
    mass = "4240 mg",
    volume = "10ml",
    length = "10 cm",
    accuracy = { grip = "none", length = "hand", surface = "point", balance = "neutral" },
    price = "25 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = ",",
    color = "white",
    flags = { "FRAGILE_MELEE" },
    melee_damage = { stab = 1 },
    tool = {},
}
