local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "......",
            "......",
            "......",
            "......",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "v....v",
            "v....v",
            "v....v",
            "v....v",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- narrowing type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "vv..vv",
            "vv..vv",
            "vv..vv",
            "vv..vv",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- moth-eaten type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vo..ov",
            "vo..ov",
            "vo..ov",
            "vo..ov",
            "vo..ov",
            "vo..ov",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- walled type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v|..|v",
            "vϴ..ϴv",
            "v|..|v",
            "v|..|v",
            "vϴ..ϴv",
            "v|..|v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- split type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "ϴ....ϴ",
            "..vv..",
            "..vv..",
            "..vv..",
            "..vv..",
            "ϴ....ϴ",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- hole type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "..vv..",
            ".vvvv.",
            ".vvvv.",
            "..vv..",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- tiny storeroom type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "......",
            ".|--|.",
            ".-1_-.",
            ".-__-.",
            ".|--|.",
            "......",
        },
        palettes = { "labyrinthine_base_palette" },
        terrain = { ["-"] = { { id = "t_nl_metal_wall", copies = 6 }, { id = "t_nl_door_c" } } },
        nested_glyphs = { ["1"] = { id = "ls_2x2_furniture" } },
    },
}

-- jagged hole type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "..oo..",
            ".ovvo.",
            ".ovvo.",
            "..oo..",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- holy rusted metal batman type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ns_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vo.oov",
            "voo.ov",
            "vo.oov",
            "voo.ov",
            "vo.oov",
            "voo.ov",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- moth-eaten type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "oooooo",
            "......",
            "......",
            "oooooo",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- wall support type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "|ϴ||ϴ|",
            "......",
            "......",
            "|ϴ||ϴ|",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- narrowing type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            ".vvvv.",
            "......",
            "......",
            ".vvvv.",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- swoopy-up type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vv..vv",
            "......",
            "......",
            "..vv..",
            ".vvvv.",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- swoopy-down type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            ".vvvv.",
            "..vv..",
            "......",
            "......",
            "vv..vv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- holy rusted metal batman type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_ew_6x6hall_fancy",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "oooooo",
            "o.o.o.",
            ".o.o.o",
            "oooooo",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_secorner_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "vv....",
            "v.ϴ...",
            "v.....",
            "v.....",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_necorner_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "v.....",
            "v.....",
            "v.ϴ...",
            "vv....",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_nwcorner_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            ".....v",
            ".....v",
            "...ϴ.v",
            "....vv",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_swcorner_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "....vv",
            "...ϴ.v",
            ".....v",
            ".....v",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Tn_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            ".ϴ..ϴ.",
            "......",
            "......",
            "......",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- swoopy type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Tn_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "......",
            "......",
            "..vv..",
            ".vvvv.",
            "vvvvvv",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Tw_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            ".ϴ...v",
            ".....v",
            ".....v",
            ".ϴ...v",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- swoopy type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Tw_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "....vv",
            "...vvv",
            "...vvv",
            "....vv",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Te_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "v...ϴ.",
            "v.....",
            "v.....",
            "v...ϴ.",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- swoopy type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Te_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "vv....",
            "vvv...",
            "vvv...",
            "vv....",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Ts_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            "......",
            "......",
            "......",
            ".ϴ..ϴ.",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

-- swoopy type
ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_Ts_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "vvvvvv",
            ".vvvv.",
            "..vv..",
            "......",
            "......",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4way_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            ".ϴ..ϴ.",
            "......",
            "......",
            ".ϴ..ϴ.",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4way_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            ".ϴ..ϴ.",
            "..vv..",
            "..vv..",
            ".ϴ..ϴ.",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "ls_4way_6x6hall_basic",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "v....v",
            "..vv..",
            ".vvvv.",
            ".vvvv.",
            "..vv..",
            "v....v",
        },
        palettes = { "labyrinthine_base_palette" },
    },
}
