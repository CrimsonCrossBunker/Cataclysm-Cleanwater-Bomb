local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_plant_incursion1",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "  ll l ",
            " l lll ",
            "ll f lf",
            " lfl ll",
            "l llfl ",
            " ll  l ",
            "  l   l",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        furniture = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_plant_incursion2",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            " l   ll",
            " lll  l",
            "l lF ll",
            "   l l ",
            "ll l ll",
            "F l Fl ",
            " lll   ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        furniture = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_plant_incursion3",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            " Ll  L ",
            " LllLl ",
            "LllLlL ",
            " lLlLLL",
            "lLLllL ",
            " lLlLl ",
            "  l LL ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        furniture = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_gas_emit1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "G  G",
            "    ",
            "    ",
            "    ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_gas_emit2",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "g  g",
            "    ",
            "    ",
            "    ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_gas_emit3",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "G  g",
            "    ",
            "    ",
            "    ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_gas_emit4",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "g  G",
            "    ",
            "    ",
            "    ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "nm_cartilage_web",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "CCCC  CCCC",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
        },
        palettes = { "nether_monster_palette" },
        terrain = {},
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
