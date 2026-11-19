local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_radio_tower_0_prepalisade_nested",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "pppppppppp              ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "p                       ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { p = "t_pit" },
        furniture = { p = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_radio_tower_1_prepalisade_nested",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "ppppppppppp             ",
            "p         p             ",
            "p         p             ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                   p   ",
            "p                   p   ",
            "p                   p   ",
            "ppp                     ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        pppppp          ",
            "                        ",
            "                        ",
        },
        terrain = { p = "t_pit" },
        furniture = { p = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_radio_tower_0_palisade_nested",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "ppgggggggp              ",
            "p        r              ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "p                    p  ",
            "pr                   p  ",
            "g                    p  ",
            "g                    p  ",
            "p                       ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { p = "t_palisade", g = "t_palisade_gate", r = "t_palisade_pulley" },
        furniture = { p = "f_clear", g = "f_clear", r = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fbmc_radio_tower_1_palisade_nested",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "ppgggggggpp             ",
            "p        rp             ",
            "p         p             ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                       ",
            "p                   p   ",
            "p                   p   ",
            "p                   p   ",
            "ppp                     ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "         r              ",
            "        ppgggp          ",
            "                        ",
            "                        ",
        },
        terrain = { p = "t_palisade", g = "t_palisade_gate", r = "t_palisade_pulley" },
        furniture = { p = "f_clear", g = "f_clear", r = "f_clear" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_0_palisade",
    layout = {
        nested = { { id = "fbmc_radio_tower_0_palisade_nested", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_1_palisade",
    layout = {
        nested = { { id = "fbmc_radio_tower_1_palisade_nested", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_0_prepalisade",
    layout = {
        nested = { { id = "fbmc_radio_tower_0_prepalisade_nested", x = 0, y = 0 } },
        item_group_placements = { { x = 4, y = 9, group = "digging_soil_loam_50L", chance = 99, repetitions = 870 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "fbmc_radio_tower_1_prepalisade",
    layout = {
        nested = { { id = "fbmc_radio_tower_1_prepalisade_nested", x = 0, y = 0 } },
        item_group_placements = { { x = 4, y = 9, group = "digging_soil_loam_50L", chance = 99, repetitions = 1080 } },
    },
}
