local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest_water",
    copy_from = "forest_water",
    add_extras = { { extra = "mx_pond_swamp", weight = 240 }, { extra = "mx_pond_swamp_2", weight = 240 } },
}
