local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "special_deep_rock",
    layout = {
        predecessor_mapgen = "deep_rock",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "special_rock",
    layout = {
        predecessor_mapgen = "empty_rock",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "special_earth",
    layout = {
        predecessor_mapgen = "solid_earth",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "special_field", "pasture", "special_field_highway" },
    layout = {
        predecessor_mapgen = "field",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "special_forest", "special_forest_isherwood" },
    layout = {
        predecessor_mapgen = "forest",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "special_forest_thick", "special_forest_thick_isherwood" },
    layout = {
        predecessor_mapgen = "forest_thick",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "special_air",
    layout = {
        predecessor_mapgen = "open_air",
    },
}
