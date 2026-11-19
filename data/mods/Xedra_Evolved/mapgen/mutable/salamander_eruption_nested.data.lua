local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "salamander_eruption_palette",
    layout = {
        terrain = { ["#"] = "t_obsidian_wall", [" "] = "t_obsidian_floor", ["$"] = "t_obsidian_roof" },
        furniture = { ["$"] = "f_boulder_large" },
    },
}

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

ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_sinkhole",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_obsidian_floor", x = 0, y = 0 } },
        trap_placements = { { id = "tr_sinkhole", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "salamander_toxic_gas",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_gas_vent", x = 0, y = 0, intensity = 2, age_turns = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "fallen_adventurer",
    layout = {
        size = { width = 1, height = 1 },
        item_group_placements = { { group = "map_extra_fallen_adventurer", x = { 0, 0 }, y = { 0, 0 }, chance = 100 } },
        field_placements = {
            { id = "fd_blood", x = { 0, 0 }, y = { 0, 0 } },
            { id = "fd_gibs_flesh", x = { 0, 0 }, y = { 0, 0 } },
        },
    },
}
