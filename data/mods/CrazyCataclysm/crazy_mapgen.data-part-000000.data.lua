local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest",
    copy_from = "forest",
    add_extras = { { extra = "mx_shia", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = { { extra = "mx_shia", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "field",
    copy_from = "field",
    add_extras = { { extra = "mx_shia", weight = 1 } },
}

ccb.content.define_map_extra_collection {
    id = "road",
    copy_from = "road",
    add_extras = { { extra = "mx_jackson", weight = 1 } },
}
