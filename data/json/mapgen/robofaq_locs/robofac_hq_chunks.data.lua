local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "window_sandbags_meteorology1",
    layout = {
        nested = {
            { id = "robofachqy_window_sand_wall", x = 2, y = 11 },
            { id = "robofachqy_window_sand_wall", x = 2, y = 19 },
            { id = "robofachqy_window_sand_wall", x = 15, y = 11 },
            { id = "robofachqy_window_sand_wall", x = 15, y = 19 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "window_sandbags_meteorology2",
    layout = {
        nested = {
            { id = "robofachqy_window_sand_wall", x = 4, y = 11 },
            { id = "robofachqy_window_sand_wall", x = 4, y = 19 },
            { id = "robofachq_window_sand_wall_l", x = 13, y = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "window_sandbags_surface_road2",
    layout = {
        nested = { { id = "robofachq_window_sand_wall_l", x = 13, y = 0 } },
    },
}

-- remove the null chunks once there's enough BEM npcs.
ccb.content.define_mapgen {
    kind = "update",
    id = "nest_ancilla_bar_place_BEMs",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "    1    4    2         ",
            "                        ",
            "                        ",
            "           3            ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "BEM_hireable", weight = 40 },
                    { id = "BEM_jabberwock", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
            ["2"] = {
                choices = {
                    { id = "BEM_human_sample", weight = 20 },
                    { id = "BEM_anchor_seller", weight = 20 },
                    { id = "BEM_exodii_hunter", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
            ["3"] = {
                choices = {
                    { id = "BEM_keycard_seller", weight = 20 },
                    { id = "BEM_template_seller", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
            ["4"] = {
                choices = {
                    { id = "BEM_gunrunner", weight = 20 },
                    { id = "BEM_drugrunner", weight = 20 },
                    { id = "BEM_chatting_veterans", weight = 20 },
                    { id = "null", weight = 20 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "robofac_hq_surface_freemerchant_camp_roof",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "               ",
            " rrrrrr        ",
            " rrrrrr        ",
            " rrrrrr        ",
            " rrrrrr        ",
            " rrrrrr        ",
            " rrrrr         ",
            " rrrrr         ",
            "       rrr rrr ",
            "       rrr rrr ",
            "       rrr rrr ",
            "               ",
            "               ",
            "               ",
            "               ",
        },
        terrain = { r = "t_canvas_roof" },
        faction_areas = { { id = "free_merchants", x = { 0, 14 }, y = { 0, 14 } } },
    },
}

-- migration from older saved games - remove older shop stocks
ccb.content.define_mapgen {
    kind = "nested",
    id = "robofac_hq_surface_freemerchant_camp",
    layout = {
        size = { width = 15, height = 15 },
        rows = {
            "        ...... ",
            " ###### ...... ",
            " #x.rrrr.......",
            " #t.rrrr.......",
            " #x.rrrr...F...",
            " #+++##..h.....",
            " #c.t#v........",
            " #####v........",
            "       #+# #+# ",
            "       #c# #c# ",
            "       ### ### ",
            "               ",
            "               ",
            "               ",
            "               ",
        },
        terrain = {
            ["."] = "t_dirt",
            r = "t_carpet_concrete_yellow",
            M = "t_pavement",
            ["#"] = "t_dirt",
            x = "t_dirt",
            c = "t_dirt",
            F = "t_pit_shallow",
        },
        furniture = {
            ["#"] = "f_skin_wall",
            ["+"] = "f_skin_door",
            x = "f_crate_o",
            t = "f_table",
            h = "f_chair",
            F = "f_firering",
        },
        traps = { c = "tr_fur_rollmat", v = "tr_funnel" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "robofac_hq_surface_freemerchant_camp_roof", x = 0, y = 0, z = 1 } },
        faction_areas = { { id = "free_merchants", x = { 0, 14 }, y = { 0, 14 } } },
        npc_placements = {
            { id = "roabofac_free_merchant", x = 5, y = 3 },
            { id = "guard", x = 7, y = 7 },
            { id = "guard", x = 10, y = 4 },
        },
        item_groups = { c = { group = "bed", chance = 100 } },
        item_spawns = {
            r = { id = "pillow", chance = 33 },
            F = { id = "pot", chance = 100 },
            v = { id = "jug_plastic", chance = 100 },
        },
        zone_placements = {
            { id = "LOOT_UNSORTED", faction = "free_merchants", x = 2, y = { 2, 4 } },
            {
                id = "LOOT_ITEM_GROUP",
                filter = "NC_ROBOFAC_FREE_MERCHANT_misc",
                faction = "free_merchants",
                x = 2,
                y = 2,
            },
            {
                id = "LOOT_ITEM_GROUP",
                filter = "NC_ROBOFAC_FREE_MERCHANT_misc",
                faction = "free_merchants",
                x = 2,
                y = 4,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "robofac_hq_surface_merc_1",
    layout = {
        size = { width = 2, height = 2 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 4 }, y = { 0, 4 } } },
        npc_placements = { { id = "robofac_merc_1", x = 1, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "robofac_hq_surface_merc_2",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "chief_meteorologist_pat", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "robofachqy_window_sand_wall",
    layout = {
        size = { width = 8, height = 8 },
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_sandbag_wall",
                x = 0,
                y = 0,
                end_x = 7,
                end_y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "robofachq_window_sand_wall_l",
    layout = {
        size = { width = 11, height = 11 },
        tile_edits = {
            {
                shape = "line",
                operation = "furniture",
                id = "f_sandbag_wall",
                x = 0,
                y = 0,
                end_x = 10,
                end_y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_hireable",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_hireable", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_human_sample",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_human_sample", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_anchor_seller",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_anchor_seller", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_keycard_seller",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_keycard_seller", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_template_seller",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_template_seller", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_gunrunner",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_gunrunner", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_exodii_hunter",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_exodii_hunter", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_chatting_veterans",
    layout = {
        size = { width = 3, height = 3 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = {
            { id = "BEM_silent_veteran", x = 0, y = 0 },
            { id = "BEM_chatting_veteran", x = 2, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_drugrunner",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_drugrunner", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "BEM_jabberwock",
    layout = {
        size = { width = 1, height = 1 },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 0 }, y = { 0, 0 } } },
        npc_placements = { { id = "BEM_jabberwock", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "robofachq_ancilla_bionic_garage",
    layout = {
        rows = {
            "|||||||||||%%%%%%%%___||",
            "^ hY ||||||_______%___||",
            " ddd |SSSSy___________||",
            "     |    y___________||",
            "(((([|    y____$$____D||",
            "          y____WW____D||",
            "          y____WW____D||",
            "    Y Y   y__________S||",
            "yyyyyyyyyyy__________w||",
            "y    y   R|__________S||",
            "yRRRRyRRRR|55555555555||",
            "|||||||||||MMMMMMMMMMM||",
            "|||||||||||mmmmmmmmmmm||",
            ",,,,,,,,||||||||||||||||",
            ",,,,,,,,||||||||||||||||",
            ",,,,,,,,||||||||||||||||",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            "||||||||||||||||||||||||",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
            ",,,,,,,,,,,,,,,,,,,,,,,,",
        },
        palettes = { "robofachq" },
        terrain = {
            M = "t_ramp_down_high",
            m = "t_ramp_down_low",
            ["%"] = "t_pavement",
            S = "t_pavement",
            w = "t_pavement",
            W = "t_pavement",
            R = "t_pavement",
            D = "t_pavement",
            Y = "t_strconc_floor_olight",
            ["$"] = "t_strconc_floor_olight",
        },
        furniture = {
            R = "f_warehouse_shelf",
            W = "f_workbench",
            ["$"] = "f_workbench",
            S = "f_utility_shelf",
            w = "f_mitresaw",
            ["%"] = "f_sandbag_wall",
            D = "f_standing_tank",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        faction_areas = { { id = "robofac_auxiliaries", x = { 0, 23 }, y = { 0, 23 } } },
        vehicle_placements = {
            { chance = 100, fuel = 0, rotation = 0, status = 0, id = "engine_crane", x = 12, y = 3 },
            { chance = 100, fuel = 0, rotation = 0, status = 0, id = "welding_cart", x = 16, y = 8 },
        },
        item_groups = {
            R = {
                { group = "SUS_exodii_storage_lowvalue", chance = 80 },
                { group = "SUS_exodii_botrack", chance = 80 },
            },
            S = {
                { group = "mechanics", chance = 100, repetitions = { 1, 6 } },
                { group = "SUS_welding_gear", chance = 80, repetitions = { 1, 2 } },
            },
        },
        npc_placements = { { id = "robofac_garage_scientist_1", x = 2, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "robofachq_ancilla_fortress_basic",
    layout = {
        rows = {
            "UUUUUUUUUUUUUUUUUUUUUUUU",
            "_______,,,,,,,,,,,,,,,,,",
            "_______||||,,,:,,:,,,:,,",
            "___R___|r |,,,,,,,,,,,,,",
            "_______||2|,,,,,,,,,,,,,",
            "___R____________________",
            "________________________",
            "___R___,,,,,,_,,,,,,,,,,",
            "_______,,,,,,_,,,,,,,,,,",
            ",,,,,,,,,,,,|WWWWWWWWWWW",
            ",,,,,,,,,,,,|[==|====|==",
            ",,,|WWWWWWWW|A.A=ll 6h B",
            "||||========|A.A=  Ydd 7",
            "h ...AA...  +A.A[  Y   ^",
            "  6A.A@@..  |||||==[=|||",
            "h hA.A....   7|>|    |i;",
            " ddA.A@@..  |||S|    +  ",
            "   A......  +...   Y |||",
            "||||========|...    Q  ^",
            ",,,|WWWWWWWW|      Y t ?",
            "ssssssssssAA|AA ...  t ?",
            "_y______ssA.[.. ...  t ?",
            "_y______ssA.[AA ...Ya a^",
            "_y______ssA.|===========",
        },
        palettes = { "robofachq" },
        terrain = {
            ["$"] = {
                { id = "t_region_tree_shade" },
                { id = "t_region_tree_fruit" },
                { id = "t_region_shrub_decorative" },
            },
            ["/"] = "t_wall_w",
            ["@"] = "t_metal_floor",
            A = "t_metal_floor",
            R = "t_radio_tower",
            S = "t_secretdoor_concrete_o",
            Y = "t_strconc_floor_olight",
        },
        furniture = {
            ["7"] = "f_filing_cabinet",
            A = "f_sandbag_wall",
            W = "f_sandbag_wall",
            [":"] = "f_small_satellite_dish",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        clear_glyphs = { [" "] = {} },
        item_groups = {
            l = {
                { group = "NC_ANCILLA_GRUNT_worn", chance = 50 },
                { group = "NC_ANCILLA_GRUNT_wield", chance = 50 },
                { group = "NC_ANCILLA_GRUNT_carry", chance = 50 },
            },
        },
        npc_glyphs = { Q = { id = "ancilla_hq_guard" } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "robofachq_ancilla_bar_basic",
    layout = {
        rows = {
            "########################",
            "########################",
            "||||||||||||||||||||||##",
            "'''''''''''''''''''''|##",
            "'''''''''''''''''''''|##",
            "'''''''''''''''''''''|##",
            "'''''''''''''''''''''|##",
            "||||=========|||||||||##",
            "|cFcb ^h hth^??|^^^^^|##",
            "|c cb  t hth t?|^ YY  ||",
            "|rÑc   h      ?|^ YY   >",
            "|r c     PP  n|||      >",
            "2      Y   Y  2 2    |||",
            "||||=========|||||   |##",
            "'''''''''''''|##|    |##",
            "'''''''''''''||||    |##",
            "'''''''''''''||<  YY |##",
            "'''''''''''''||||    |##",
            "'''''''''''''|##|    |##",
            "|||||||||||||||||    |##",
            "################|    |||",
            "################| YY  >|",
            "################||||||||",
            "########################",
        },
        palettes = { "robofachq" },
        terrain = { ["'"] = "t_open_air", Y = "t_strconc_floor_olight", ["#"] = "t_rock" },
        furniture = { b = "f_stool", P = "f_pool_table" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        clear_glyphs = { [" "] = {}, h = {}, c = {}, F = {}, P = {}, t = {}, ["?"] = {} },
        item_spawns = {
            P = {
                { id = "pool_cue", chance = 100, repetitions = 2 },
                { id = "pool_ball", chance = 100, repetitions = 8 },
            },
        },
        npc_glyphs = { ["Ñ"] = { id = "ancilla_barkeep" } },
        zone_placements = {
            {
                id = "NPC_INVESTIGATE_ONLY",
                faction = "robofac_auxiliaries",
                x = { 1, 14 },
                y = { 8, 12 },
            },
            { id = "LOOT_UNSORTED", faction = "robofac_auxiliaries", x = { 1, 1 }, y = { 10, 10 } },
            { id = "LOOT_CURRENCY", faction = "robofac_auxiliaries", x = { 1, 1 }, y = { 9, 9 } },
        },
    },
}

-- Spawns by itself at the moment, spawning should be triggered by missions later on.
ccb.content.define_mapgen {
    kind = "update",
    id = "robofachq_ancilla_bar_autodoc",
    layout = {
        rows = {
            "########################",
            "########################",
            "||||||||||||||||||||||||",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "=======|||||========:::|",
            "         |      =   :71A",
            "         |      =   :.YA",
            "         |      =   :h..",
            "         |==[=====[=::[:",
            "^        2              ",
            "=======|||||===========|",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "''''''''''''''''''''''''",
            "||||||||||||||||||||||||",
            "########################",
            "########################",
            "########################",
            "########################",
        },
        palettes = { "robofachq" },
        terrain = {
            ["'"] = "t_open_air",
            Y = "t_metal_floor_olight",
            [":"] = "t_wall_metal_corrugated",
            ["#"] = "t_rock",
        },
        furniture = { ["7"] = "f_autodoc_couch", ["1"] = "f_autodoc", A = "f_rack", h = "f_chair" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        clear_glyphs = { ["7"] = {}, ["1"] = {}, A = {}, h = {} },
        npc_glyphs = { h = { id = "ancilla_doctor" } },
        zone_placements = {
            { id = "LOOT_UNSORTED", faction = "no_faction", x = 23, y = 8 },
            { id = "LOOT_CURRENCY", faction = "no_faction", x = 23, y = 9 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "nest_ancilla_bar_remove_BEMs",
    layout = {
        npc_removals = {
            { id = "BEM_hireable", x = 0, y = 0 },
            { id = "BEM_anchor_seller", x = 0, y = 0 },
            { id = "BEM_human_sample", x = 0, y = 0 },
            { id = "BEM_gunrunner", x = 0, y = 0 },
            { id = "BEM_drugrunner", x = 0, y = 0 },
            { id = "BEM_jabberwock", x = 0, y = 0 },
            { id = "BEM_template_seller", x = 0, y = 0 },
            { id = "BEM_silent_veteran", x = 0, y = 0 },
            { id = "BEM_chatting_veteran", x = 0, y = 0 },
            { id = "BEM_keycard_seller", x = 0, y = 0 },
            { id = "BEM_exodii_hunter", x = 0, y = 0 },
        },
    },
}
