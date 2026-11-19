local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_NW",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_nw_wall", x = 3, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_W1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_w1_wall", x = 3, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_W2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_w1_wall", x = 3, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_W3",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_w2_wall", x = 8, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_SW",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_southwest_wall", x = 7, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_S1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_south1_wall", x = 10, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_S2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_south1_wall", x = 13, y = 21 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E1",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east1_wall", x = 14, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E2",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east2_wall", x = 19, y = 11 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E3",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east2_wall", x = 19, y = 14 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_bed_E4",
    layout = {
        nested = { { id = "fbmc_shelter_2_bed_east2_wall", x = 19, y = 17 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_dining_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "hhhh",
            "tttt",
            "hhhh",
            "    ",
        },
        palettes = { "fbmc_shelter_2_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_dining",
    layout = {
        nested = { { id = "fbmc_shelter_2_dining_room", x = 12, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_living_room",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "xCB",
            "s Q",
            "s B",
        },
        palettes = { "fbmc_shelter_2_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_2_living_room_roof",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "  V",
            "   ",
        },
        palettes = { "fbmc_shelter_2_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_2_livingroom",
    layout = {
        nested = {
            { id = "fbmc_shelter_2_living_room", x = 17, y = 7, z = 0 },
            { id = "fbmc_shelter_2_living_room_roof", x = 17, y = 7, z = 1 },
        },
    },
}
