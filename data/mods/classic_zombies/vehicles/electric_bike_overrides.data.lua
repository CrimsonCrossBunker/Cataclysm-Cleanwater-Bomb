local ccb = require("ccb")

ccb.content.define_vehicle {
    id = "bicycle_electric",
    copy_from = "bicycle_dirt",
    name = ccb.content.text("SUV"),
}

ccb.content.define_vehicle {
    id = "scooter_electric",
    copy_from = "scooter",
    name = ccb.content.text("SUV"),
}
