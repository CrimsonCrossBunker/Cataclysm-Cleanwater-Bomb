local ccb = require("ccb")

ccb.content.define_terrain {
    id = "t_concrete_light",
    copy_from = "t_concrete",
    name = ccb.content.text("Concrete light"),
    description = ccb.content.text("Concrete light"),
    extend = { flags = { "TRANSPARENT_FLOOR" } },
}

ccb.content.define_terrain {
    id = "t_floor_container",
    copy_from = "t_concrete_light",
    name = ccb.content.text("Container"),
    description = ccb.content.text("Container"),
    extend = { flags = { "CONTAINER" } },
}
