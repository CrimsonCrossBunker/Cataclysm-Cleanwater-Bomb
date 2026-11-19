local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room0_construction_east",
    layout = {
        nested = {
            { id = "fbms_room0_construction", x = 15, y = 9, z = 0 },
            { id = "fbms_room0_roof_construction", x = 15, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room1_construction_west",
    layout = {
        nested = {
            { id = "fbms_room1_construction", x = 3, y = 9, z = 0 },
            { id = "fbms_room1_roof_construction", x = 3, y = 9, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room2_construction_northwest",
    layout = {
        nested = {
            { id = "fbms_room2_construction", x = 3, y = 3, z = 0 },
            { id = "fbms_room2_roof_construction", x = 3, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room3_construction_southwest",
    layout = {
        nested = {
            { id = "fbms_room3_construction", x = 3, y = 15, z = 0 },
            { id = "fbms_room3_roof_construction", x = 3, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room4_construction_northeast",
    layout = {
        nested = {
            { id = "fbms_room4_construction", x = 15, y = 3, z = 0 },
            { id = "fbms_room4_roof_construction", x = 15, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room5_construction_southeast",
    layout = {
        nested = {
            { id = "fbms_room5_construction", x = 15, y = 15, z = 0 },
            { id = "fbms_room5_roof_construction", x = 15, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room6_construction_south",
    layout = {
        nested = {
            { id = "fbms_room6_construction", x = 9, y = 15, z = 0 },
            { id = "fbms_room6_roof_construction", x = 9, y = 15, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room7_construction_north",
    layout = {
        nested = {
            { id = "fbms_room7_construction", x = 9, y = 3, z = 0 },
            { id = "fbms_room7_roof_construction", x = 9, y = 3, z = 1 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbms_room8_construction_center",
    layout = {
        nested = {
            { id = "fbms_room8_construction", x = 9, y = 9, z = 0 },
            { id = "fbms_room8_roof_construction", x = 9, y = 9, z = 1 },
            { id = "fbms_room9_construction", x = 3, y = 9, z = 0 },
            { id = "fbms_room9_roof_construction", x = 3, y = 9, z = 1 },
            { id = "fbms_room10_construction", x = 15, y = 9, z = 0 },
            { id = "fbms_room10_roof_construction", x = 15, y = 9, z = 1 },
        },
    },
}
