local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_NW",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_nw_wall", x = 8, y = 8 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_W1",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_w1_wall", x = 5, y = 10 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_W2",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_w1_wall", x = 5, y = 13 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_W3",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_w1_wall", x = 5, y = 16 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_SW",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_southwest_wall", x = 5, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_S1",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_south1_wall", x = 8, y = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_bed_S2",
    layout = {
        nested = { { id = "fbmc_shelter_1_bed_south2_wall", x = 11, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_dining_room",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            " hth",
            " hth",
            " hth",
            " hth",
        },
        palettes = { "fbmc_shelter_1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_shelter_1_dining",
    layout = {
        nested = { { id = "fbmc_shelter_1_dining_room", x = 12, y = 9 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_shelter_1_living_room",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "***  ",
            " sss ",
            "***  ",
            " xxx ",
            "***  ",
        },
        palettes = { "fbmc_shelter_1_palette" },
    },
}
