local ccb = require("ccb")

ccb.content.define_item {
    id = "survival_marker",
    name = ccb.content.plural_text("survival marker", "survival markers"),
    description = ccb.content.text("A sharpened piece of charcoal used as an improvised pencil.  Almost guaranteed to get your hands all covered in charcoal.  Activate it to write something down."),
    mass = "113 g",
    volume = "15 ml",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "charcoal" },
    symbol = ",",
    color = "dark_gray",
    flags = { "WRITE_MESSAGE" },
    tool = { initial_charges = 100, max_charges = 100, charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = true,
            material_restricted = false,
        },
    },
}
