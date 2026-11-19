local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_1",
    layout = {
        nested = {
            { id = "fbmk_2_room", x = 9, y = 9, z = 0 },
            { id = "fbmk_2_room_roof", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_2",
    layout = {
        nested = {
            { id = "fbmk_2_room_2", x = 9, y = 9, z = 0 },
            { id = "fbmk_2_room_2_roof", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_smoking_area_construction",
    layout = {
        nested = {
            { id = "fbmk_2_smoking_area_construction", x = 15, y = 18, z = 0 },
            { id = "fbmk_2_smoking_area_roof_construction", x = 15, y = 18, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_pantry_construction",
    layout = {
        nested = {
            { id = "fbmk_2_pantry_construction", x = 0, y = 9, z = 0 },
            { id = "fbmk_2_pantry_roof_construction", x = 0, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_dining_1",
    layout = {
        nested = {
            { id = "fbmk_2_dining_1", x = 10, y = 16, z = 0 },
            { id = "fbmk_2_dining_1_roof", x = 10, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_dining_2",
    layout = {
        nested = {
            { id = "fbmk_2_dining_2", x = 6, y = 16, z = 0 },
            { id = "fbmk_2_dining_2_roof", x = 6, y = 16, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_2_brewery",
    layout = {
        nested = {
            { id = "fbmk_2_brewery", x = 0, y = 16, z = 0 },
            { id = "fbmk_2_brewery_roof", x = 0, y = 16, z = 1 },
        },
    },
}
