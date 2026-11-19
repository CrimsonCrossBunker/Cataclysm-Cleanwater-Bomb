local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_candy_shop",
    name = ccb.content.text("Candy Shop"),
    targets = { "candy_shop", "candy_shop_1" },
}
