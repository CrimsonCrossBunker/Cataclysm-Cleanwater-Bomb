local ccb = require("ccb")

ccb.content.define_item {
    id = "rock_candy_chunk",
    category = "spare_parts",
    name = ccb.content.plural_text("rock candy chunk", "rock candy chunks"),
    description = ccb.content.text("This is a chunk of hard rock candy.  It can be broken down into sugar."),
    mass = "50 g",
    volume = "250 ml",
    price = "0 cent",
    survival_price = "10 cent",
    materials = { "rock_candy" },
    symbol = ",",
    color = "light_gray",
    flags = { "NO_SALVAGE" },
    tool = {},
}
