local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room0_construction_northeast",
    layout = {
        nested = {
            { id = "fbmw_room0_construction", x = 15, y = 3, z = 0 },
            { id = "fbmw_room0_roof_construction", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room3_construction_north",
    layout = {
        nested = {
            { id = "fbmw_room3_construction", x = 9, y = 3, z = 0 },
            { id = "fbmw_room3_roof_construction", x = 9, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room4_construction_east",
    layout = {
        nested = {
            { id = "fbmw_room4_construction", x = 15, y = 9, z = 0 },
            { id = "fbmw_room4_roof_construction", x = 15, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room5_construction_center",
    layout = {
        nested = {
            { id = "fbmw_room5_construction", x = 9, y = 9, z = 0 },
            { id = "fbmw_room5_roof_construction", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room7to9_construction_northwest",
    layout = {
        nested = {
            { id = "fbmw_room7_construction", x = 3, y = 3, z = 0 },
            { id = "fbmw_room7_roof_construction", x = 3, y = 3, z = 1 },
            { id = "fbmw_room8_construction", x = 3, y = 9, z = 0 },
            { id = "fbmw_room8_roof_construction", x = 3, y = 9, z = 1 },
            { id = "fbmw_room9_construction", x = 9, y = 9, z = 0 },
            { id = "fbmw_room9_roof_construction", x = 9, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room6_construction_north",
    layout = {
        nested = {
            { id = "fbmw_room6_construction", x = 9, y = 3, z = 0 },
            { id = "fbmw_room6_roof_construction", x = 9, y = 3, z = 1 },
        },
        loot_placements = {
            { id = "tongs", x = 19, y = 5, chance = 100 },
            { id = "chisel", x = 19, y = 5, chance = 100 },
            { id = "hammer", x = 19, y = 5, chance = 100 },
            { id = "swage", x = 19, y = 5, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room11to12_construction_southeast",
    layout = {
        nested = {
            { id = "fbmw_room11_construction", x = 15, y = 15, z = 0 },
            { id = "fbmw_room11_roof_construction", x = 15, y = 15, z = 1 },
            { id = "fbmw_room12_construction", x = 9, y = 15, z = 0 },
            { id = "fbmw_room12_roof_construction", x = 9, y = 15, z = 1 },
        },
        loot_placements = {
            { id = "wrench", x = 19, y = 7, chance = 100 },
            { id = "pliers", x = 19, y = 7, chance = 100 },
        },
        tile_edits = { { shape = "point", operation = "furniture", id = "f_drophammer", x = 19, y = 12 } },
    },
}
