local ccb = require("ccb")

ccb.content.define_item {
    id = "xe_alchemy_powder_of_revelation",
    name = ccb.content.plural_text("powder of revelation", "handfuls of powder of revelation"),
    description = ccb.content.text("A dull grayish powder with a slight shimmering opalescence.  When thrown it will fill the air and reveal the true form and existence of any creature whose form it coats."),
    mass = "50 g",
    volume = "250 ml",
    symbol = ":",
    default_container = "flask_glass",
    color = "light_gray",
    materials = { "powder" },
    price = "2 USD",
    drop_action = { kind = "emit_actor", emissions = { "emit_powder_of_revelation" }, scale_quantity = false },
}
