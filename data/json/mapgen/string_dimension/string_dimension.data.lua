local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "string_dimension_void",
    layout = {
        fill_terrain = "t_string_void",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "string_dimension_true_void",
    layout = {
        fill_terrain = "t_string_true_void",
    },
}
