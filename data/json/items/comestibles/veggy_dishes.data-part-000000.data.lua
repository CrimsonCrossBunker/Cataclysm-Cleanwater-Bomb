local ccb = require("ccb")

ccb.content.define_item {
    id = "cooked_cattail_stalk",
    name = ccb.content.text("cooked cattail stalk"),
    copy_from = "cattail_stalk",
    color = "white",
    description = ccb.content.text("A cooked stalk from a cattail plant.  Its fibrous outer leaves have been stripped away, and now it is quite delicious."),
    price = "0 cent",
    survival_price = "10 cent",
    comestible = { shelf_life = "2 days 12 hours", fun = 1 },
    inheritance = { remove = { flags = { "RAW" } } },
}

ccb.content.define_item {
    id = "cooked_burdock_stalk",
    name = ccb.content.text("cooked plant stalk"),
    copy_from = "cooked_cattail_stalk",
    description = ccb.content.text("A cooked stalk from a plant.  Its fibrous outer leaves have been stripped away, and now it is quite delicious."),
    comestible = {},
}
