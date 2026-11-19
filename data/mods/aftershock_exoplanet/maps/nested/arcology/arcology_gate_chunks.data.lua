local ccb = require("ccb")

-- Broken Console, closed gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_w_2",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,||",
            ",,,,,,..",
            ",,,,,,..",
            ",,,,,,..",
            ",,,,,,..",
            ",,,,,,..",
            ",,,,,,..",
            ",,,,%,||",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
    },
}

-- Broken Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_w_3",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,||",
            ",,,,,,OO",
            ",,,,,,OO",
            ",,,,,,OO",
            ",,,,,,OO",
            ",,,,,,OO",
            ",,,,,,OO",
            ",,,,%,||",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
    },
}

-- Broken Console, closed gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_s_2",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "________",
            "________",
            "6_______",
            "|......|",
            "|......|",
            ",,,,,,,%",
            ",,,,,,,,",
            ",,,,,,,,",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
    },
}

-- Broken Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_s_3",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "________",
            "________",
            "6_______",
            "|OOOOOO|",
            "|OOOOOO|",
            ",,,,,,,%",
            ",,,,,,,,",
            ",,,,,,,,",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
    },
}

-- Broken Console, closed gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_e_2",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "__||,%,,",
            "__..,,,,",
            "__..,,,,",
            "__..,,,,",
            "__..,,,,",
            "__..,,,,",
            "__..,,,,",
            "_6||,,,,",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
    },
}

-- Broken Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_e_3",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "__||,%,,",
            "__OO,,,,",
            "__OO,,,,",
            "__OO,,,,",
            "__OO,,,,",
            "__OO,,,,",
            "__OO,,,,",
            "_6||,,,,",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
    },
}

-- Broken Console, closed gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_n_2",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            "%,,,,,,,",
            ",,,,,,,,",
            "|......|",
            "|......|",
            "_______6",
            "________",
            "________",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
    },
}

-- Broken Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_n_3",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            "%,,,,,,,",
            ",,,,,,,,",
            "|OOOOOO|",
            "|OOOOOO|",
            "_______6",
            "________",
            "________",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
    },
}

-- Broken Console
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_1x1_gate_broken",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "%",
        },
        palettes = { "arcology_exterior" },
    },
}

-- Broken Console, broke gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_w_5",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,||",
            ",,,,,,.C",
            ",,,,,,CW",
            ",,,,,,W.",
            ",,,,,,CP",
            ",,,,,,W.",
            ",,,,,,..",
            ",,,,%,||",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { P = "f_ash" },
        rotation = { 0, 3 },
        item_groups = {
            W = { { group = "collapsed_building_rubble", chance = 80, repetitions = { 1, 3 } } },
            C = { { group = "wreckage", chance = 100, repetitions = { 1, 2 } } },
        },
    },
}

-- Broken Console, broke gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_s_5",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "________",
            "________",
            "6_______",
            "|.CWCOO|",
            "|COWPW.|",
            ",,,,,,,%",
            ",,,,,,,,",
            ",,,,,,,,",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { P = "f_ash" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
        item_groups = {
            W = { { group = "collapsed_building_rubble", chance = 80, repetitions = { 1, 3 } } },
            C = { { group = "wreckage", chance = 100, repetitions = { 1, 2 } } },
        },
    },
}

-- Broken Console, broke gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_e_5",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "__||,%,,",
            "__..,,,,",
            "__.W,,,,",
            "__CW,,,,",
            "__W.,,,,",
            "__OP,,,,",
            "__C.,,,,",
            "_6||,,,,",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { P = "f_ash" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
        item_groups = {
            W = { { group = "collapsed_building_rubble", chance = 80, repetitions = { 1, 3 } } },
            C = { { group = "wreckage", chance = 100, repetitions = { 1, 2 } } },
        },
    },
}

-- Broken Console, broke gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_n_5",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            "%,,,,,,,",
            ",,,,,,,,",
            "|.CWCOO|",
            "|COWPW.|",
            "_______6",
            "________",
            "________",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_metal_floor", C = "t_metal_floor", W = "t_metal_floor" },
        furniture = { P = "f_ash" },
        rotation = { 0, 3 },
        nested_glyphs = {
            ["6"] = {
                choices = {
                    { id = "arcology_1x1_gate", weight = 50 },
                    { id = "arcology_1x1_gate_broken", weight = 50 },
                },
            },
        },
        item_groups = {
            W = { { group = "collapsed_building_rubble", chance = 80, repetitions = { 1, 3 } } },
            C = { { group = "wreckage", chance = 100, repetitions = { 1, 2 } } },
        },
    },
}
