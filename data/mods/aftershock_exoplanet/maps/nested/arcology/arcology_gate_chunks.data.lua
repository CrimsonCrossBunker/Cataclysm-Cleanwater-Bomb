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
