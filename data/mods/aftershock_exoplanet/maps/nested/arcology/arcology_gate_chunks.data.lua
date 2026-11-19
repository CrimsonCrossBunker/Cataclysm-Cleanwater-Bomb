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

-- Working Console, closed gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_w_1",
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
            ",,,,5,||",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("West Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_w_4",
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
            ",,,,5,||",
        },
        palettes = { "arcology_exterior" },
        rotation = { 0, 3 },
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("West Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, broken gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_w_6",
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
            ",,,,5,||",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_broken_metal_floor", C = "t_broken_metal_floor", W = "t_broken_metal_floor" },
        furniture = { P = "f_ash" },
        rotation = { 0, 3 },
        item_groups = {
            W = { { group = "collapsed_building_rubble", chance = 80, repetitions = { 1, 3 } } },
            C = { { group = "wreckage", chance = 100, repetitions = { 1, 2 } } },
        },
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("West Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, closed gate
-- Go back and make interior consoles have their own 1x1 nested chunk for broken and working consoles.
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_s_1",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "________",
            "________",
            "6_______",
            "|......|",
            "|......|",
            ",,,,,,,5",
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("South Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_s_4",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "________",
            "________",
            "6_______",
            "|OOOOOO|",
            "|OOOOOO|",
            ",,,,,,,5",
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("South Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, broken gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_s_6",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "________",
            "________",
            "6_______",
            "|.CWCOO|",
            "|COWPW.|",
            ",,,,,,,5",
            ",,,,,,,,",
            ",,,,,,,,",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_broken_metal_floor", C = "t_broken_metal_floor", W = "t_broken_metal_floor" },
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("South Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
        item_groups = {
            W = { { group = "collapsed_building_rubble", chance = 80, repetitions = { 1, 3 } } },
            C = { { group = "wreckage", chance = 100, repetitions = { 1, 2 } } },
        },
    },
}

-- Working Console, closed gate
-- Go back and make interior consoles have their own 1x1 nested chunk for broken and working consoles.
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_e_1",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "__||,5,,",
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("East Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_e_4",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "__||,5,,",
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("East Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, broken gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_e_6",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "__||,5,,",
            "__..,,,,",
            "__.W,,,,",
            "__CW,,,,",
            "__W.,,,,",
            "__OP,,,,",
            "__C.,,,,",
            "_6||,,,,",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_broken_metal_floor", C = "t_broken_metal_floor", W = "t_broken_metal_floor" },
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("East Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, closed gate
-- Go back and make interior consoles have their own 1x1 nested chunk for broken and working consoles.
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_n_1",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            "5,,,,,,,",
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("North Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, open gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_n_4",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            "5,,,,,,,",
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("North Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console, broken gate
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_8x8_gate_n_6",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            ",,,,,,,,",
            "5,,,,,,,",
            ",,,,,,,,",
            "|.CWCOO|",
            "|COWPW.|",
            "_______6",
            "________",
            "________",
        },
        palettes = { "arcology_exterior" },
        terrain = { P = "t_broken_metal_floor", C = "t_broken_metal_floor", W = "t_broken_metal_floor" },
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
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("North Entrance Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 3,
                    },
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - CLOSE GATES"),
                        action = "close_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}

-- Working Console
ccb.content.define_mapgen {
    kind = "nested",
    id = "arcology_1x1_gate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "5",
        },
        palettes = { "arcology_exterior" },
        computer_glyphs = {
            ["5"] = {
                name = ccb.content.text("Interior Gate Controls"),
                security = 1,
                menu = {
                    {
                        label = ccb.content.text("EMERGENCY OVERRIDE - OPEN GATES"),
                        action = "open_gate",
                        security = 1,
                    },
                },
                failures = { "damage", "shutdown" },
            },
        },
    },
}
