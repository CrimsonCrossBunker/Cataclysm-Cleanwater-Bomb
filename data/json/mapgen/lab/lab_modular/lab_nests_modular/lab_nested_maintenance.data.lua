local ccb = require("ccb")

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vv   g",
            "   5 g",
            " A₸5  ",
            "  Z5  ",
            "   5 g",
            "uu   g",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " XXXX ",
            " - ØX ",
            " XØØX ",
            " XXXX ",
            "      ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " h   ",
            "NN  Q",
            "    q",
            "  NN ",
            "   h ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "L   L",
            "L j y",
            "  j  ",
            "Y j L",
            "L   L",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "^^^^^",
            "^ƨƨƨ^",
            "^ƨƨƨ^",
            "^ƨƨƨ^",
            "^^^^^",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "00   ",
            " 0ƨƨ ",
            " 07Z ",
            " 0ƨƨ ",
            "00   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "₸   ⁵",
            "    ⁵",
            " ɱJJ ",
            "  A  ",
            "⁵⁵   ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            ";ƧƧƧ;",
            ";~~~;",
            ";~~~;",
            ";~~~;",
            ";ƧƧƧ;",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        terrain = { ["~"] = "t_sewage", ["Ƨ"] = "t_thconc_floor" },
        furniture = { ["Ƨ"] = "f_barricade_road" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for generic content.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " WWW ",
            " WWW ",
            " WWW ",
            "     ",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- A nested map for maintenance areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maintenance_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "II    ",
            "h  Ø  ",
            "   Ø  ",
            "   Ø  ",
            "⁵  Ø ⁵",
            "⁵⁵  ⁵⁵",
        },
        palettes = { "lab_common_palette", "lab_maintenance_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
