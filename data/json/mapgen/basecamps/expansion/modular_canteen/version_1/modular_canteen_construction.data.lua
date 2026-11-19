local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen_construction",
    layout = {
        nested = {
            { id = "fbmk_kitchen_room_construction", x = 9, y = 7, z = 0 },
            { id = "fbmk_kitchen_room_roof_construction", x = 9, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_canteen2_construction",
    layout = {
        nested = {
            { id = "fbmk_kitchen_room2_construction", x = 9, y = 7, z = 0 },
            { id = "fbmk_kitchen_room2_roof_construction", x = 9, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_smoking_area_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_smoking_area_construction", x = 16, y = 7, z = 0 },
            { id = "fbmk_canteen_smoking_area_roof_construction", x = 16, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_pantry_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_pantry_construction", x = 3, y = 7, z = 0 },
            { id = "fbmk_canteen_pantry_roof_construction", x = 3, y = 7, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_west_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_dining_west_construction", x = 3, y = 14, z = 0 },
            { id = "fbmk_canteen_dining_west_roof_construction", x = 3, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_east_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_dining_east_construction", x = 14, y = 14, z = 0 },
            { id = "fbmk_canteen_dining_east_roof_construction", x = 14, y = 14, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmk_canteen_dining_center_construction",
    layout = {
        nested = {
            { id = "fbmk_canteen_dining_center_construction", x = 8, y = 14, z = 0 },
            { id = "fbmk_canteen_dining_center_roof_construction", x = 8, y = 14, z = 1 },
        },
    },
}
