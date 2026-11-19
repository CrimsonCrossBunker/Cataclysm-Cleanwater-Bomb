local ccb = require("ccb")

ccb.content.define_item {
    id = "Dana_sourdough_bread",
    name = ccb.content.plural_text("Dana's sourdough bread", "Dana's sourdough bread"),
    copy_from = "sourdough_bread",
    looks_like = "sourdough_bread",
    description = ccb.content.text("This round loaf of bread has a thick, dark crust, and smells very enticing."),
    comestible = {},
    inheritance = { scale = { fun = 2, price = 2 } },
}
