local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_saltworks_0",
    layout = {
        nested = { { id = "fbmsw_0", x = 15, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_saltpan_construction_northeast",
    layout = {
        nested = {
            { id = "fbmsw_saltpan_construction", x = 14, y = 3, z = 0 },
            { id = "fbmsw_saltpan_construction_roof", x = 14, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_shack_construction_southeast",
    layout = {
        nested = {
            { id = "fbmsw_shack_construction", x = 15, y = 15, z = 0 },
            { id = "fbmsw_shack_construction_roof", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmsw_brewery0_construction_southwest",
    layout = {
        nested = {
            { id = "fbmsw_brewery0_construction", x = 3, y = 14, z = 0 },
            { id = "fbmsw_brewery0_construction_roof", x = 3, y = 14, z = 1 },
        },
    },
}
