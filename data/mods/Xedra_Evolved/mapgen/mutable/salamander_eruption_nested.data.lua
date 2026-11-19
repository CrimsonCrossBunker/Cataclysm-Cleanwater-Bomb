local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "spiral_cw",
    layout = {
        palettes = { "salamander_eruption_palette" },
        size = { width = 6, height = 6 },
        rows = {
            "######",
            "     #",
            "#### #",
            "#  # #",
            "#    #",
            "######",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "spiral_ccw",
    layout = {
        palettes = { "salamander_eruption_palette" },
        size = { width = 6, height = 6 },
        rows = {
            "######",
            "#     ",
            "# ####",
            "# #  #",
            "#    #",
            "######",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "spiral_boulder_cw",
    layout = {
        palettes = { "salamander_eruption_palette" },
        size = { width = 6, height = 6 },
        rows = {
            "$$$$$$",
            "     $",
            "$$$$ $",
            "$  $ $",
            "$    $",
            "$$$$$$",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "spiral_boulder_ccw",
    layout = {
        palettes = { "salamander_eruption_palette" },
        size = { width = 6, height = 6 },
        rows = {
            "$$$$$$",
            "$     ",
            "$ $$$$",
            "$ $  $",
            "$    $",
            "$$$$$$",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_tunnel_entrance",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "     ## ",
            "      ##",
            "        ",
            "        ",
            "#       ",
            "##      ",
            "###     ",
            "###     ",
        },
        terrain = { [" "] = "t_rock_floor", ["#"] = "t_rock" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_tunnel_bounds_h",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "###№      №###",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        terrain = {
            ["#"] = "t_rock",
            ["№"] = { { id = "t_salamander_veins", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
    },
}

-- walls of tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_tunnel_bounds_h1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "###№          ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        terrain = {
            ["#"] = "t_rock",
            ["№"] = { { id = "t_salamander_veins", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_tunnel_bounds_v",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "#             ",
            "#             ",
            "#             ",
            "№             ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "№             ",
            "#             ",
            "#             ",
            "#             ",
        },
        terrain = {
            ["#"] = "t_rock",
            ["№"] = { { id = "t_salamander_veins", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_tunnel_bounds_v1",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "#             ",
            "#             ",
            "#             ",
            "№             ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
        },
        terrain = {
            ["#"] = "t_rock",
            ["№"] = { { id = "t_salamander_veins", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_tunnel_bounds_v2",
    layout = {
        size = { width = 14, height = 14 },
        rows = {
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "              ",
            "№             ",
            "#             ",
            "#             ",
            "#             ",
        },
        terrain = {
            ["#"] = "t_rock",
            ["№"] = { { id = "t_salamander_veins", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_lava",
    layout = {
        palettes = { "salamander_eruption_palette" },
        size = { width = 4, height = 4 },
        rows = {
            "*   ",
            "**  ",
            " ** ",
            "  **",
        },
        terrain = { ["*"] = "t_lava" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- slopes down to be used where appropriate
ccb.content.define_mapgen {
    kind = "nested",
    id = "transition_down",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "<<",
            "<<",
        },
        terrain = { ["<"] = "t_slope_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- slopes up to be used where appropriate
ccb.content.define_mapgen {
    kind = "nested",
    id = "transition_up",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            ">>",
            ">>",
        },
        terrain = { [">"] = "t_slope_up" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
