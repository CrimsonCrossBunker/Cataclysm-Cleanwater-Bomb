local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_coop_construction",
    layout = {
        nested = {
            { id = "fbml_2_coop_construction", x = 13, y = 0, z = 0 },
            { id = "fbml_2_coop_roof_construction", x = 13, y = 0, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_shack_construction",
    layout = {
        nested = {
            { id = "fbml_2_shack_construction", x = 15, y = 18, z = 0 },
            { id = "fbml_2_shack_furniture", x = 16, y = 19, z = 0 },
            { id = "fbml_2_shack_roof_construction", x = 15, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_1_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_1_construction", x = 0, y = 18, z = 0 },
            { id = "fbml_2_stall_1", x = 3, y = 19, z = 0 },
            { id = "fbml_2_stall_1_roof_construction", x = 0, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_2_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_2_4_construction", x = 0, y = 14, z = 0 },
            { id = "fbml_2_stall_bench", x = 3, y = 15, z = 0 },
            { id = "fbml_2_stall_2_3_4_roof_construction", x = 0, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_3_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_3_construction", x = 0, y = 10, z = 0 },
            { id = "fbml_2_stall_3", x = 3, y = 11, z = 0 },
            { id = "fbml_2_stall_2_3_4_roof_construction", x = 0, y = 10, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_4_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_2_4_construction", x = 0, y = 6, z = 0 },
            { id = "fbml_2_stall_bench", x = 3, y = 7, z = 0 },
            { id = "fbml_2_stall_2_3_4_roof_construction", x = 0, y = 6, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbml_2_stall_5_construction",
    layout = {
        nested = {
            { id = "fbml_2_stall_5_construction", x = 0, y = 0, z = 0 },
            { id = "fbml_2_stall_5", x = 3, y = 1, z = 0 },
            { id = "fbml_2_stall_5_roof_construction", x = 0, y = 0, z = 1 },
        },
    },
}
