local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest_thick",
    copy_from = "forest_thick",
    add_extras = { { extra = "mx_catoblepas_lair", weight = 1 } },
}
