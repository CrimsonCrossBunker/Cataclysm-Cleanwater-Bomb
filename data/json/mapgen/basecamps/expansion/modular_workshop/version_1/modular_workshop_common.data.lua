local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_0",
    layout = {
        size = { width = 6, height = 6 },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "faction_base_workshop_0",
    layout = {
        nested = { { id = "fbmw_0", x = 15, y = 3 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room1_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  ftL ",
            "      ",
            "      ",
            "      ",
            "    x ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room1_roof_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "  C   ",
            "      ",
            "      ",
            "      ",
            "    C ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room2_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "r     ",
            "    c ",
            "  A c ",
            "    c ",
            "      ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmw_room10_common",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " Q    ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "fbmw_common_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room1_common_northeast",
    layout = {
        nested = {
            { id = "fbmw_room1_common", x = 15, y = 3, z = 0 },
            { id = "fbmw_room1_roof_common", x = 15, y = 3, z = 1 },
        },
        loot_placements = { { id = "crucible", x = 18, y = 4, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room2_common_northeast",
    layout = {
        nested = { { id = "fbmw_room2_common", x = 15, y = 3 } },
        loot_placements = {
            { id = "55gal_drum", x = 17, y = 7, chance = 100 },
            { id = "30gal_drum", x = 17, y = 8, chance = 100 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmw_room10_common_northeast",
    layout = {
        nested = { { id = "fbmw_room10_common", x = 15, y = 3 } },
        loot_placements = {
            { id = "hammer_sledge", x = 19, y = 6, chance = 100 },
            { id = "knife_combat", x = 19, y = 6, chance = 100 },
            { id = "copper_knife", x = 19, y = 6, chance = 100 },
        },
    },
}
