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

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_kitchen1_cleared",
    layout = {
        nested = { { id = "fbmc_firestation1_kitchen1", x = 1, y = 9 } },
        loot_placements = {
            { id = "2x4", repetitions = 24, x = 2, y = 10, chance = 100 },
            { id = "nail", repetitions = 36, x = 2, y = 10, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_garage_area",
    layout = {
        loot_placements = {
            { id = "wrench", x = 8, y = 21, chance = 100 },
            { id = "hacksaw", x = 8, y = 21, chance = 100 },
            { id = "pliers", x = 8, y = 21, chance = 100 },
            { id = "screwdriver", x = 8, y = 21, chance = 100 },
            { id = "hammer", x = 8, y = 21, chance = 100 },
            { id = "manual_mechanics", x = 8, y = 21, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_forge4",
    layout = {
        loot_placements = {
            { id = "tongs", x = 8, y = 21, chance = 100 },
            { id = "chisel", x = 8, y = 21, chance = 100 },
            { id = "swage", x = 8, y = 21, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_firestation1_farm",
    layout = {
        nested = { { id = "fbmc_firestation1_farm_land", x = 7, y = 0 } },
        loot_placements = { { id = "pickaxe", x = 8, y = 21, chance = 100 } },
    },
}
