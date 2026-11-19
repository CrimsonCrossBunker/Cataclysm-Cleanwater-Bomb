local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_barricaded_b",
    layout = {
        size = { width = 21, height = 21 },
        rows = {
            "CCCCCCCCCCCCCC       ",
            "#:#:####+##::####### ",
            "..A..It............# ",
            ".EE..It............I ",
            ".....It..JJJJ......+.",
            "EE.EEIO..JJJJ...333I.",
            "AA.AAIo.........3.HI.",
            "EE.EEIo..iiii...H.i:.",
            "AA.AAIo..iiii...H.i:.",
            "IIDIIII.........3.iI.",
            ".........iiii...c.gI.",
            ".....I...iiii...3.gI.",
            "IDIDII.........IIIII.",
            "&.I.&I.........D...I.",
            "q.I.qIggggghhhhI...I.",
            "IIIIIIIIIIIIIIII...I.",
            "q.I..nnnA.IBBBF....I.",
            "&.D..AA...D........I+",
            "###l....n.I........D.",
            "wC+...fpppIBBBBBBBBI.",
            "wC###################",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_barricaded_safes_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".LL.",
            ".LL.",
            ".//.",
            ".44.",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_safes_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            ".LL.",
            ".LL.",
            ".//.",
            ".44.",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_looted_storage_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBBB",
            "B..B",
            "B..F",
            "II+I",
        },
        palettes = { "gunstore_palette_looted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "gunstore_unlooted_storage_a",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "BBBB",
            "B..B",
            "B..F",
            "II+I",
        },
        palettes = { "gunstore_palette_unlooted" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "destroyed_furniture_concrete_floor",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "a",
        },
        terrain = { a = "t_thconc_floor" },
        flags = { "DISMANTLE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "no_items_concrete_floor",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "#",
        },
        terrain = { ["#"] = "t_thconc_floor" },
        flags = { "ERASE_ITEMS_BEFORE_PLACING_TERRAIN", "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}
