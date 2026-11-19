local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_coop_construction_northeast",
    layout = {
        nested = {
            { id = "fbml_coop_construction", x = 15, y = 3, z = 0 },
            { id = "fbml_coop_roof_construction", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_shack_construction_southeast",
    layout = {
        nested = {
            { id = "fbml_shack_construction", x = 15, y = 15, z = 0 },
            { id = "fbml_shack_roof_construction", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_stable0_construction_southwest",
    layout = {
        nested = {
            { id = "fbml_stable0_construction", x = 3, y = 15, z = 0 },
            { id = "fbml_stable_roof_construction", x = 3, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_stable1_construction_west",
    layout = {
        nested = {
            { id = "fbml_stable1_construction", x = 3, y = 9, z = 0 },
            { id = "fbml_stable_roof_construction", x = 3, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_stable2_construction_northwest",
    layout = {
        nested = {
            { id = "fbml_stable2_construction", x = 3, y = 3, z = 0 },
            { id = "fbml_stable_roof_construction", x = 3, y = 3, z = 1 },
        },
    },
}
