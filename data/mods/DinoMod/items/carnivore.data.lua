local ccb = require("ccb")

ccb.content.define_item {
    id = "stomach_sauropod",
    copy_from = "stomach_large",
    name = ccb.content.text("sauropod stomach"),
    description = ccb.content.text("The stomach of an enormous sauropod dinosaur.  It is surprisingly durable and very roomy."),
    comestible = {},
    inheritance = { scale = { mass = 2.0, volume = 2.0, price = 1.5, calories = 2.0 } },
}

ccb.content.define_item {
    id = "sauropod_stomach_boiled",
    copy_from = "stomach_boiled",
    name = ccb.content.text("boiled sauropod stomach"),
    description = ccb.content.text("A boiled stomach from a sauropod, nothing else.  It looks all but appetizing."),
    comestible = { fun = -5 },
    inheritance = { scale = { price = 2.0, calories = 2.0, volume = 2.0, mass = 2.0 } },
}
