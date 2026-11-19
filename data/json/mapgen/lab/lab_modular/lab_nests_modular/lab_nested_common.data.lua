local ccb = require("ccb")

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "h h h ",
            "s s s ",
            "      ",
            "  II  ",
            "  h   ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general lab security areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_6x6_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "P sh P",
            "Phs  P",
            "P sh P",
            "h    T",
            "Y     ",
        },
        palettes = { "lab_common_palette", "lab_security_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "yh    Y",
            "       ",
            "h h h h",
            "s s s s",
            "       ",
            " rrr   ",
            "  h  RR",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "yh    Y",
            "    E E",
            " r     ",
            "hr  rrr",
            "    r  ",
            "h   rh ",
            "Y     P",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Y     y",
            "H     H",
            "H     H",
            "s HHH s",
            "H     H",
            "H     H",
            "y     Y",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "  h   y",
            "  ff  R",
            " hffh R",
            "  ffh h",
            " hffh  ",
            "Y h    ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "H     H",
            "H     H",
            "y     T",
            "])]|])]",
            "E T|E y",
            "  r|rr ",
            "Yhr|h Y",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Yhr|h Y",
            "  r|rr ",
            "E T|E y",
            "])]|])]",
            "y     T",
            "H     H",
            "H     H",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "H     E",
            "H rr  E",
            "y  h  Y",
            "])]||+|",
            "E  |P P",
            " rr|P P",
            " hT|P P",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Yhr|P P",
            "  r|P P",
            "h T|P P",
            "])]||+|",
            "   h   ",
            "E rr  H",
            "E     H",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for general office areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_generic_7x7_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            "  h   y",
            "  ff  x",
            " hffh x",
            "  ffh h",
            " hffh  ",
            "Y h    ",
        },
        palettes = { "lab_common_palette" },
        rotation = { 0, 3 },
    },
}
