local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_kitchen1",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "---   ",
            "---   ",
            "t--   ",
            "t    t",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_kitchen2",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "u     ",
            "c     ",
            "   r  ",
            "   r  ",
            "  cc  ",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_farm_land",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "       ",
            "^^.^.^^",
            "^^.^.^^",
            "^^.^.^^",
            "^^.^.^^",
            "^^.^.^^",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_sw",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_SW", x = 14, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_nw",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_NW", x = 14, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_ne",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_NE", x = 20, y = 15 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_bedroom_se",
    layout = {
        nested = { { id = "fbmc_firestation1_living_quarters_SE", x = 20, y = 19 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_garden_fence",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "####G#####",
            "         #",
            "         #",
            "         #",
            "         #",
            "         G",
            "         #",
            "          ",
            "          ",
            "          ",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_garden_fence1",
    layout = {
        nested = { { id = "fbmc_firestation1_garden_fence", x = 5, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_firestation1_quarters_common_room",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "hhh C s",
            "ttt   s",
            "hhh C s",
            "    BBB",
            "       ",
            "       ",
        },
        palettes = { "fbmc_firestation1_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_quarters_common",
    layout = {
        nested = { { id = "fbmc_firestation1_quarters_common_room", x = 16, y = 9 } },
    },
}
