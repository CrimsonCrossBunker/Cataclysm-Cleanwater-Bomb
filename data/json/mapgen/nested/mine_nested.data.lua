local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "spiral_cw",
    layout = {
        palettes = { "mine_palette" },
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
        palettes = { "mine_palette" },
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
        palettes = { "mine_palette" },
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
        palettes = { "mine_palette" },
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
    id = "mine_tunnel_entrance",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "     ## ",
            "      ##",
            "        ",
            "        ",
            "#       ",
            "##  &***",
            "###     ",
            "###     ",
        },
        terrain = {
            [" "] = "t_rock_floor",
            ["#"] = "t_rock",
            ["*"] = "t_railroad_track_small",
            ["&"] = "t_buffer_stop",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_tunnel_bounds_h",
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
            ["№"] = { { id = "t_pillar", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_tunnel_bounds_h1",
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
            ["№"] = { { id = "t_pillar", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_tunnel_bounds_v",
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
            ["№"] = { { id = "t_pillar", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_tunnel_bounds_v1",
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
            ["№"] = { { id = "t_pillar", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
    },
}

-- walls of mine tunnel that can shift from side to side to make the tunnel wind
ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_tunnel_bounds_v2",
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
            ["№"] = { { id = "t_pillar", copies = 10 }, { id = "t_rock", copies = 90 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_lava",
    layout = {
        palettes = { "mine_palette" },
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
    id = "mine_finale_archaeology",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "!!!###",
            "#C  D#",
            "##! c#",
            "##GG##",
            "@####@",
            "@@@@@@",
        },
        terrain = {
            [" "] = "t_rock_floor",
            ["#"] = "t_rock",
            ["@"] = { { id = "t_rock", copies = 4 }, { id = "t_rock_floor", copies = 1 } },
            c = "t_rock_floor",
            C = "t_rock_floor",
            D = "t_rock_floor",
            G = "t_rock_floor",
        },
        furniture = {
            c = "f_crate_c",
            C = "f_crate_c",
            D = "f_crate_c",
            G = { { id = "f_grave_stone_old" }, { id = "f_grave_head" }, { id = "f_grave_monument" } },
            [" "] = { { id = "f_null" }, { id = "f_rubble_rock" } },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_spawns = {
            ["!"] = { id = "material_soil", chance = 40, amount = { 5, 10 } },
            D = { id = "dynamite", chance = 90, repetitions = 2 },
        },
        item_groups = {
            C = { group = "museum_misc", chance = 90, repetitions = { 1, 2 } },
            c = { group = "museum_primitive", chance = 90, repetitions = { 1, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_sinkhole",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_rock_floor", x = 0, y = 0 } },
        trap_placements = { { id = "tr_sinkhole", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_toxic_gas",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_gas_vent", x = 0, y = 0, intensity = 2, age_turns = 20 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_wreckage",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        furniture_placements = { { id = "f_wreckage", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_minerals_equipment",
    layout = {
        size = { width = 1, height = 1 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = {
            {
                group = {
                    entries = {
                        { item = "coal_lump", probability = 20, count = { 2, 20 } },
                        { item = "rock", probability = 40, count = { 1, 10 } },
                        { item = "rock_large", probability = 10, count = { 1, 10 } },
                        { item = "rock_flaking", probability = 20, count = { 1, 10 } },
                        { item = "material_shrd_limestone", probability = 40, count = { 1, 10 } },
                        { item = "material_limestone", probability = 40, count = { 1, 10 } },
                        { item = "material_niter", probability = 5, count = { 1, 10 } },
                        { item = "material_sand", probability = 50, charges = { 10, 500 } },
                        { item = "material_soil", probability = 50, charges = { 5, 30 } },
                        { item = "chunk_sulfur", probability = 5, count = { 1, 10 } },
                        { item = "material_rocksalt", probability = 5, count = { 1, 10 } },
                        { item = "material_rhodonite", probability = 5, count = { 1, 10 } },
                        { item = "material_zincite", probability = 5, count = { 1, 10 } },
                    },
                },
                repetitions = { 1, 3 },
                chance = 50,
                x = 0,
                y = 0,
            },
            {
                group = {
                    entries = { { group = "mine_equipment" }, { item = "corpse", damage = 4 } },
                    kind = "collection",
                },
                chance = 10,
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mine_the_thing_victims",
    layout = {
        size = { width = 3, height = 3 },
        item_group_placements = { { group = "the_thing_victim", x = { 0, 2 }, y = { 0, 2 }, chance = 100 } },
        field_placements = {
            { id = "fd_blood", x = { 0, 2 }, y = { 0, 2 } },
            { id = "fd_gibs_flesh", x = { 0, 2 }, y = { 0, 2 } },
        },
    },
}
