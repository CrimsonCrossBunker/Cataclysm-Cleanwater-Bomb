local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_safehouse_bathroom_roof",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "    ",
            "    ",
            "    ",
        },
        terrain = { T = "t_wood_stairs_down" },
        rotation = { 0, 0 },
        nested = { { id = "bloodthorne_druid_safehouse_bathroom_roof_z1", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_safehouse_bathroom_roof_z1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "----",
            "...-",
            "...-",
            "...-",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_tar_flat_roof" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_11x11_basement_stairs",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "        T  ",
            "           ",
        },
        terrain = { T = "t_wood_stairs_down" },
        rotation = { 0, 0 },
        nested = { { id = "bloodthorne_druid_11x11_basement", x = 0, y = 0, z = -1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_11x11_basement",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "#---------#",
            "#-   |-tt-#",
            "#-||+|-ct-#",
            "#-    - t-#",
            "#---d--  -#",
            "#-R      -#",
            "#-R      -#",
            "#-RRR    -#",
            "#------- -#",
            "#######-T-#",
            "#######---#",
        },
        terrain = {
            ["#"] = "t_soil",
            T = "t_wood_stairs_up",
            ["-"] = "t_wall_wood",
            [" "] = "t_dirtfloor",
            ["|"] = "t_bars",
            ["+"] = "t_door_bar_locked",
            d = "t_door_c",
            R = "t_dirtfloor",
            t = "t_dirtfloor",
            c = "t_dirtfloor",
        },
        furniture = { R = "f_rack_wood", t = "f_table", c = "f_chair" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            R = {
                {
                    group = "veggy_pickled_jar_3l_glass_sealed_12",
                    chance = 15,
                    repetitions = { 1, 2 },
                },
                { group = "fruits_in_3l_jar", chance = 15 },
                {
                    group = "fish_pickled_jar_3l_glass_sealed_12",
                    chance = 15,
                    repetitions = { 1, 2 },
                },
                { group = "meat_pickled_jar_3l_glass_sealed_12", chance = 15 },
                {
                    group = "veggy_canned_jar_3l_glass_sealed_12",
                    chance = 15,
                    repetitions = { 1, 2 },
                },
                { group = "can_tomato_jar_3l_glass_sealed_24", chance = 15, repetitions = { 1, 2 } },
                { group = "meat_canned_jar_3l_glass_sealed_12", chance = 15 },
                { group = "flour_bag_paper_full", chance = 60, repetitions = { 1, 2 } },
                { group = "kitchen_sack", chance = 60, repetitions = { 0, 2 } },
            },
        },
        item_placements = {
            { id = "silver_locket", x = 7, y = 1, chance = 5 },
            { id = "vacutainer", x = 7, y = 2, chance = 85 },
            { id = "note_snippet_bloodthorne_druid", x = 7, y = 1, chance = 80 },
            { id = "note_snippet_bloodthorne_druid", x = 6, y = 1, chance = 45 },
        },
        item_group_placements = { { group = "portable_non_flashlight_light_sources", x = 8, y = 0 } },
        monster_placements = { { id = "mon_vampire_feral", x = 2, y = 1, chance = 70 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "roof_6x6_greenhouse_bloodthorne",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "%#++#%",
            "%1__1%",
            "#1__1#",
            "#1__1#",
            "%1__1%",
            "%####%",
        },
        terrain = {
            _ = "t_railroad_rubble",
            ["#"] = "t_reinforced_glass_shutter_open",
            ["+"] = "t_reinforced_door_glass_c",
            ["%"] = "t_reinforced_glass_shutter",
            ["$"] = "t_wall_glass",
        },
        furniture = { S = "f_statue" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "roof_6x6_greenhouse_roof", x = 0, y = 0, z = 1 } },
        sealed_item_glyphs = { ["1"] = { item = { id = "seed_rose" }, furniture = "f_planter_mature" } },
    },
}
