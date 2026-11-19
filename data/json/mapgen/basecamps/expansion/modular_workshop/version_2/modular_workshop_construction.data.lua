local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_smithy_1_construction",
    layout = {
        nested = {
            { id = "fbmw_2_smithy_1_construction", x = 14, y = 17, z = 0 },
            { id = "fbmw_2_smithy_1_roof_construction", x = 14, y = 17, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_smithy_2_construction",
    layout = {
        nested = {
            { id = "fbmw_2_smithy_2_construction", x = 14, y = 14, z = 0 },
            { id = "fbmw_2_smithy_2_roof_construction", x = 14, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_pottery_construction",
    layout = {
        nested = {
            { id = "fbmw_2_pottery_construction", x = 0, y = 16, z = 0 },
            { id = "fbmw_2_pottery_roof_construction", x = 0, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_smithy_3_construction",
    layout = {
        nested = {
            { id = "fbmw_2_smithy_3_construction", x = 8, y = 16, z = 0 },
            { id = "fbmw_2_smithy_3_roof_construction", x = 8, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_glassblower_construction",
    layout = {
        nested = {
            { id = "fbmw_2_glassblower_construction", x = 0, y = 7, z = 0 },
            { id = "fbmw_2_6x5_roof_construction", x = 0, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_2_tanner_construction",
    layout = {
        nested = {
            { id = "fbmw_2_tanner_construction", x = 14, y = 0, z = 0 },
            { id = "fbmw_2_6x5_roof_construction", x = 14, y = 0, z = 1 },
        },
    },
}
