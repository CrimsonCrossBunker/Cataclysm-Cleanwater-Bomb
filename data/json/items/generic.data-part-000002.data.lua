local ccb = require("ccb")

ccb.content.define_item {
    id = "paper",
    name = ccb.content.plural_text("paper", "paper"),
    category = "spare_parts",
    mass = "3 g",
    color = "white",
    symbol = "`",
    description = ccb.content.text("A piece of paper.  Can be used to start fires."),
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "paper" },
    flags = { "TINDER", "PAPER_SHAPED" },
    volume = "6 ml",
    length = "297 mm",
    ammunition = { type = "paper" },
}
