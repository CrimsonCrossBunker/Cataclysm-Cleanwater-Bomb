local ccb = require("ccb")

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_N",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "gfa",
            "...",
            "   ",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_S",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "   ",
            "...",
            "gfa",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_W",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            "a. ",
            "f. ",
            "g. ",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "utility_3x3_e",
    layout = {
        size = { width = 3, height = 3 },
        rows = {
            " .a",
            " .f",
            " .g",
        },
        palettes = { "basement_utility_nest_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||++||",
            "|D  U|",
            "|z  U|",
            "|zzPU|",
            "|PzzU|",
            "||||||",
        },
        palettes = { "domestic_general_and_variant_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            P = "t_thconc_floor",
            z = "t_thconc_floor",
            U = "t_thconc_floor",
            D = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk_S",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|qz Q|",
            "|q zQ|",
            "|Uz 6|",
            "|U  6|",
            "||++||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            z = "t_thconc_floor",
            q = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|qzQQ|",
            "|q   +",
            "|Uz 6|",
            "|U z6|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            z = "t_thconc_floor",
            q = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basement
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_junk_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|qqzQ|",
            "+   Q|",
            "|Uz 6|",
            "|U z6|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_thconc_floor",
            U = "t_thconc_floor",
            Q = "t_thconc_floor",
            ["6"] = "t_thconc_floor",
            z = "t_thconc_floor",
            q = "t_thconc_floor",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_N",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|||+||",
            "|PP E|",
            "|T   |",
            "|rh y|",
            "|rrYR|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_S",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|PPYE|",
            "|r   |",
            "|rh y|",
            "|rr R|",
            "|:|+||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|PPTE|",
            "|r   +",
            "|rh y:",
            "|rrYR|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_office_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|PPTE|",
            "+    |",
            ":rh Y|",
            "|rrrR|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||+|||",
            "|6h  U|",
            "|Qh  U|",
            "|vzAHU|",
            "|@AEHq|",
            "|@zzPq|",
            "|||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|6hzzU|",
            "|QhE U|",
            "|vzAHU|",
            "|@A Hq|",
            "|@  Pq|",
            "|||+|||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_E",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|6hzzU|",
            "|QhE U|",
            "|vzAH +",
            "|@A Hq|",
            "|@QUPq|",
            "|||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_junk_W",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|6hzzU|",
            "|QhE U|",
            "+ zAHv|",
            "|@A Hq|",
            "|@RUPq|",
            "|||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_junk_N",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||+|||",
            "|6h   U|",
            "|6h  hU|",
            "|Qh Ø U|",
            "|vzAH U|",
            "|@AEH q|",
            "|@zzPÆq|",
            "||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_junk_S",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|6hz@@U|",
            "|6h zhU|",
            "|Qh Ø U|",
            "|vzAHzU|",
            "|@AEH q|",
            "|@  PÆq|",
            "|||+||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_N",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||+|||",
            "|1     |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "||||||||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_S",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|1     |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "|      |",
            "||||+|||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_E",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|1     |",
            "|      |",
            "|      |",
            "|      +",
            "|      |",
            "|      |",
            "||||||||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_hobby_W",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|1     |",
            "|      |",
            "|      |",
            "+      |",
            "|      |",
            "|      |",
            "||||||||",
        },
        terrain = { ["|"] = "t_wall_y", ["+"] = "t_door_c" },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "null", weight = 5 },
                    { id = "6x6_sewing_open", weight = 40 },
                    { id = "6x6_electronics_open", weight = 40 },
                },
            },
        },
    },
}

-- for dispersed scattering around a basement. This is a box of art.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = "f_cardboard_box" },
        rotation = { 0, 3 },
        item_groups = { x = { group = "art", chance = 90, repetitions = { 0, 3 } } },
    },
}

-- for dispersed scattering around a basement. This is a box of hardware.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = { { id = "f_crate_c" }, { id = "f_cardboard_box" } } },
        rotation = { 0, 3 },
        item_groups = { x = { group = "mischw", chance = 90, repetitions = { 0, 3 } } },
    },
}

-- for dispersed scattering around a basement. This is a box of bedding.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = "f_cardboard_box" },
        rotation = { 0, 3 },
        item_groups = { x = { group = "bed", chance = 90, repetitions = { 0, 8 } } },
    },
}

-- for dispersed scattering around a basement. This is a box of winter clothing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = "f_cardboard_box" },
        rotation = { 0, 3 },
        item_groups = { x = { group = "clothing_outdoor_set", chance = 90, repetitions = { 0, 3 } } },
    },
}

-- for dispersed scattering around a basement. This is a box of work clothing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = "f_cardboard_box" },
        rotation = { 0, 3 },
        item_groups = {
            x = {
                { group = "hardware_clothing", chance = 90, repetitions = { 0, 3 } },
                { group = "plumbing_clothing", chance = 50, repetitions = { 0, 3 } },
            },
        },
    },
}

-- for dispersed scattering around a basement. This is a box of old clothing.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = "f_cardboard_box" },
        rotation = { 0, 3 },
        item_groups = { x = { group = "donated_clothes", chance = 90, repetitions = { 0, 3 } } },
    },
}

-- for dispersed scattering around a basement. This is a box of toys.
ccb.content.define_mapgen {
    kind = "nested",
    id = "basement_storage_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "x",
        },
        furniture = { x = "f_cardboard_box" },
        rotation = { 0, 3 },
        item_groups = { x = { group = "crate_toys", chance = 90, repetitions = { 0, 3 } } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_woodworker",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|GEEA|",
            "|G  C|",
            "|G FD|",
            "|GF B|",
            "|||+||",
        },
        terrain = {
            ["|"] = "t_wall_w",
            ["+"] = "t_door_locked",
            [" "] = "t_thconc_floor",
            A = "t_thconc_floor",
            B = "t_thconc_floor",
            C = "t_thconc_floor",
            D = "t_thconc_floor",
            E = "t_thconc_floor",
            F = "t_thconc_floor",
            G = "t_thconc_floor",
        },
        furniture = {
            A = { { id = "f_drill_press" }, { id = "f_planer" } },
            B = { { id = "f_jointer" }, { id = "f_router" }, { id = "f_mitresaw" } },
            C = "f_tablesaw",
            D = "f_bandsaw",
            E = "f_workbench",
            F = "f_stool",
            G = "f_rack_wood",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = {
            { group = "home_hw", x = { 1, 3 }, y = 4, chance = 50, repetitions = { 1, 3 } },
            { group = "wood_workshop", x = 1, y = { 1, 4 }, chance = 70, repetitions = { 1, 3 } },
            { group = "carpentrybooks", x = 2, y = 1, chance = 20 },
            { group = "carpentrybooks", x = 3, y = 1, chance = 20 },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_bike",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|   T|",
            "|   B|",
            "|   B|",
            "|   S|",
            "||++||",
        },
        terrain = {
            ["|"] = "t_wall_w",
            ["+"] = "t_door_c",
            [" "] = "t_thconc_floor",
            T = "t_thconc_floor",
            S = "t_thconc_floor",
            B = "t_thconc_floor",
        },
        furniture = { T = "f_trashcan", S = "f_utility_shelf", B = "f_workbench" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        vehicle_placements = { { id = "bikeshop", x = 1, y = 2, rotation = 270, chance = 50 } },
        item_group_placements = { { group = "bikeshop_tools", x = 4, y = { 2, 4 }, chance = 10, repetitions = { 1, 3 } } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_W",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|%,=!|",
            "+   ~|",
            "|Y h~|",
            "|$  ~|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            [" "] = "t_floor",
            ["%"] = "t_floor",
            ["$"] = "t_floor",
            ["="] = "t_floor",
            [","] = "t_floor",
            ["~"] = "t_floor",
            Y = "t_floor",
            h = "t_floor",
            P = "t_floor",
            ["!"] = "t_floor",
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["="] = "f_table",
            [","] = "f_table",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["="] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 60, repetitions = { 1, 2 } } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%% %%",
            "%   %",
            "%  G%",
            "%=KK%",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_earthbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "alcohol_bottled_canned", x = { 2, 3 }, y = 3, chance = 80 },
            { group = "stash_food", x = { 2, 3 }, y = 3, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 3, chance = 70, repetitions = { 2, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%GKK%",
            "%   %",
            "%=  %",
            "%% %%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_earthbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "alcohol_bottled_canned", x = { 2, 3 }, y = 1, chance = 80 },
            { group = "stash_food", x = { 2, 3 }, y = 1, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 1, chance = 70, repetitions = { 2, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%GKK%",
            "%    ",
            "%=  %",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_sandbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "alcohol_bottled_canned", x = { 2, 3 }, y = 1, chance = 80 },
            { group = "stash_food", x = { 2, 3 }, y = 1, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 1, chance = 70, repetitions = { 2, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_holdout_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%GKK%",
            "    %",
            "%=  %",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        furniture = { ["%"] = "f_sandbag_wall" },
        traps = { ["="] = "tr_rollmat" },
        loot_placements = {
            { id = "sleeping_bag", x = 1, y = 3, chance = 100, repetitions = { 1, 2 } },
            { group = "alcohol_bottled_canned", x = { 2, 3 }, y = 1, chance = 80 },
            { group = "stash_food", x = { 2, 3 }, y = 1, chance = 30, repetitions = { 2, 3 } },
            { group = "roof_holdout", x = { 2, 3 }, y = 1, chance = 70, repetitions = { 2, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_sauna_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%&:%",
            "%i  %",
            "%i 0%",
            "%iii%",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["%"] = "t_wall_wood",
            ["&"] = "t_door_glass_c",
            i = "t_floor",
            [" "] = "t_floor",
            ["0"] = "t_floor",
        },
        furniture = { ["0"] = "f_brazier" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "towel", x = 1, y = { 1, 3 }, chance = 100, repetitions = { 1, 2 } },
            { group = "charcoal_bag_part", x = 3, y = 2, chance = 100, repetitions = { 1, 2 } },
            { id = "bucket", x = 3, y = 1, chance = 100 },
            { id = "water_clean", x = 1, y = 1, chance = 80, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_sauna_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%iii%",
            "%i 0%",
            "%i  %",
            "%%&:%",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["%"] = "t_wall_wood",
            ["&"] = "t_door_glass_c",
            i = "t_floor",
            [" "] = "t_floor",
            ["0"] = "t_floor",
        },
        furniture = { ["0"] = "f_brazier" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "towel", x = 1, y = { 1, 3 }, chance = 100, repetitions = { 1, 2 } },
            { group = "charcoal_bag_part", x = 3, y = 2, chance = 100, repetitions = { 1, 2 } },
            { id = "bucket", x = 3, y = 3, chance = 100 },
            { id = "water_clean", x = 1, y = 1, chance = 80, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_sauna_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            "%i0 :",
            "%i  &",
            "%iii%",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["%"] = "t_wall_wood",
            ["&"] = "t_door_glass_c",
            i = "t_floor",
            [" "] = "t_floor",
            ["0"] = "t_floor",
        },
        furniture = { ["0"] = "f_brazier" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "towel", x = 1, y = { 1, 3 }, chance = 100, repetitions = { 1, 2 } },
            { group = "charcoal_bag_part", x = 2, y = 1, chance = 100, repetitions = { 1, 2 } },
            { id = "bucket", x = 3, y = 1, chance = 100 },
            { id = "water_clean", x = 1, y = 1, chance = 80, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_sauna_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%%%%%",
            ": 0i%",
            "&  i%",
            "%iii%",
            "%%%%%",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["%"] = "t_wall_wood",
            ["&"] = "t_door_glass_c",
            i = "t_floor",
            [" "] = "t_floor",
            ["0"] = "t_floor",
        },
        furniture = { ["0"] = "f_brazier" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "towel", x = 3, y = { 1, 3 }, chance = 100, repetitions = { 1, 2 } },
            { group = "charcoal_bag_part", x = 2, y = 1, chance = 100, repetitions = { 1, 2 } },
            { id = "bucket", x = 1, y = 1, chance = 100 },
            { id = "water_clean", x = 3, y = 1, chance = 80, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_pool",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "y   y",
            " === ",
            " === ",
            " === ",
            "y   y",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["="] = "t_pool_water", [" "] = "t_floor_blue", y = "t_floor_blue" },
        furniture = { y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = { { id = "towel", x = 0, y = { 1, 3 }, chance = 100, repetitions = { 1, 2 } } },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_junk_E",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|6hzzQU|",
            "|6hØzhU|",
            "|      +",
            "|QzAHzU|",
            "|@AEH q|",
            "|@svPÆq|",
            "||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { fuel = 0, rotation = 180, status = 0, id = "canoe", x = 4, y = 3 } },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_8x8_junk_W",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "||||||||",
            "|6hzzQU|",
            "|shØzhU|",
            "+      |",
            "|QzAHzU|",
            "|@AEH q|",
            "|@svPÆq|",
            "||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { id = "bikeshop", x = 1, y = 2, rotation = 180 } },
        item_group_placements = { { group = "bikeshop_tools", x = 1, y = 2, chance = 80, repetitions = { 1, 3 } } },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_junk_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||+|||",
            "|6hzz   U|",
            "|shØzh  U|",
            "| x      |",
            "|zx E   h|",
            "|rrr z  P|",
            "|QzAHz sU|",
            "|@AEH T q|",
            "|@szP d q|",
            "||||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { id = "bikeshop", x = 6, y = 3, rotation = 270 } },
        item_group_placements = { { group = "bikeshop_tools", x = 9, y = 2, chance = 80, repetitions = { 1, 3 } } },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_junk_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|6hzzPT U|",
            "|shØzh  U|",
            "| x      |",
            "|zx E   h|",
            "|rrr z  P|",
            "|QzAHz sU|",
            "|@AEH   q|",
            "|@szP   q|",
            "||||||+|||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { id = "bikeshop", x = 6, y = 5, rotation = 270 } },
        item_group_placements = { { group = "bikeshop_tools", x = 9, y = 2, chance = 80, repetitions = { 1, 3 } } },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_junk_E",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|6hzzPT U|",
            "|shØzh  U|",
            "|        +",
            "|z  E   h|",
            "|rrr z  P|",
            "|QzAHz sU|",
            "|@AEH ʭ q|",
            "|@szP xxq|",
            "||||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { id = "boats_narrow", x = 4, y = 3, rotation = 180 } },
        item_group_placements = { { group = "fishing_items", x = 9, y = 2, chance = 80, repetitions = { 1, 3 } } },
    },
}

-- room of junk
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_junk_W",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|6hzzPT U|",
            "|shØzh LU|",
            "+        |",
            "|zs E   h|",
            "|rrr z ʭP|",
            "|QzAHz sU|",
            "|@AEH M q|",
            "|@szP xxq|",
            "||||||||||",
        },
        palettes = { "standard_domestic_palette" },
        rotation = { 0, 3 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { id = "boats_narrow", x = 4, y = 3, rotation = 180 } },
        item_group_placements = { { group = "fishing_items", x = 9, y = 2, chance = 80, repetitions = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_pool_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "::::&&::::",
            "!        i",
            "      ===i",
            "      === ",
            "      ===i",
            "      ===i",
            "Q     === ",
            "%%  G ===i",
            "9&  K ===i",
            "%%  G     ",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["="] = "t_pool_water", ["&"] = "t_door_glass_c", ["%"] = "t_wall_b" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["!"] = {
                choices = {
                    { id = "null", weight = 70 },
                    { id = "5x5_sauna_E", weight = 10 },
                    { id = "5x5_gym_S", weight = 20 },
                },
            },
        },
        loot_placements = { { id = "towel", x = 9, y = { 1, 9 }, chance = 100, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_pool_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "!        i",
            "      ===i",
            "      === ",
            "      ===i",
            "      ===i",
            "Q     === ",
            "K   G ===i",
            "%%    ===i",
            "9&        ",
            "%%::&&::::",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["="] = "t_pool_water", ["&"] = "t_door_glass_c", ["%"] = "t_wall_b" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["!"] = {
                choices = {
                    { id = "null", weight = 70 },
                    { id = "5x5_sauna_S", weight = 10 },
                    { id = "5x5_gym_N", weight = 20 },
                },
            },
        },
        loot_placements = { { id = "towel", x = 9, y = { 1, 9 }, chance = 100, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_pool_W",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "%%%yQ!    ",
            "%9&       ",
            "%%%y      ",
            ":ii       ",
            ":         ",
            "&         ",
            ": ======= ",
            ": ======= ",
            ": ======= ",
            ":  ii  ii ",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["="] = "t_pool_water", ["&"] = "t_door_glass_c", ["%"] = "t_wall_b" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["!"] = {
                choices = {
                    { id = "null", weight = 70 },
                    { id = "5x5_sauna_S", weight = 10 },
                    { id = "5x5_gym_E", weight = 20 },
                },
            },
        },
        loot_placements = { { id = "towel", x = 9, y = { 1, 9 }, chance = 100, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_pool_E",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "!     y%%%",
            "       &9%",
            "      y%%%",
            "       ii:",
            "         :",
            "         &",
            " ======= :",
            " ======= :",
            " ======= :",
            "         :",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["="] = "t_pool_water", ["&"] = "t_door_glass_c", ["%"] = "t_wall_b" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = {
            ["!"] = {
                choices = {
                    { id = "null", weight = 70 },
                    { id = "5x5_sauna_S", weight = 10 },
                    { id = "5x5_gym_W", weight = 20 },
                },
            },
        },
        loot_placements = { { id = "towel", x = 9, y = { 1, 9 }, chance = 100, repetitions = { 1, 2 } } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_woodworker_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||++||||",
            "|GGG  GGG|",
            "|        |",
            "|J      D|",
            "|L    F B|",
            "|I CLH  A|",
            "|        |",
            "|G  F   G|",
            "|G EEE  G|",
            "||||||||||",
        },
        terrain = { ["|"] = "t_wall_w", ["+"] = "t_door_locked" },
        furniture = {
            A = "f_drill_press",
            B = "f_jointer",
            C = "f_tablesaw",
            D = "f_bandsaw",
            E = "f_workbench",
            F = "f_stool",
            G = "f_rack_wood",
            H = "f_planer",
            I = "f_mitresaw",
            J = "f_router",
            L = "f_table",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            G = {
                { group = "wood_workshop", chance = 90, repetitions = { 0, 3 } },
                { group = "carpentrybooks", chance = 20 },
            },
            E = { { group = "home_hw", chance = 90, repetitions = { 0, 3 } } },
        },
        vehicle_placements = { { fuel = 0, rotation = 180, status = 0, id = "canoe", x = 5, y = 3 } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_woodworker_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|G EEE  G|",
            "|G  F   G|",
            "|        |",
            "|J      B|",
            "|L CLH  A|",
            "|I  L   D|",
            "| F      |",
            "|GGG  GGG|",
            "||||++||||",
        },
        terrain = { ["|"] = "t_wall_w", ["+"] = "t_door_locked" },
        furniture = {
            A = "f_drill_press",
            B = "f_jointer",
            C = "f_tablesaw",
            D = "f_bandsaw",
            E = "f_workbench",
            F = "f_stool",
            G = "f_rack_wood",
            H = "f_planer",
            I = "f_mitresaw",
            J = "f_router",
            L = "f_table",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            G = {
                { group = "wood_workshop", chance = 90, repetitions = { 0, 3 } },
                { group = "carpentrybooks", chance = 20 },
            },
            E = { { group = "home_hw", chance = 80, repetitions = { 0, 2 } } },
        },
        vehicle_placements = { { fuel = 0, rotation = 180, status = 0, id = "canoe", x = 5, y = 3 } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_woodworker_E",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|G EEE  G|",
            "|G  F   G|",
            "|        +",
            "|J      B|",
            "|L CLH  A|",
            "|I  L   D|",
            "| F      |",
            "|GGG  GGG|",
            "||||||||||",
        },
        terrain = { ["|"] = "t_wall_w", ["+"] = "t_door_locked" },
        furniture = {
            A = "f_drill_press",
            B = "f_jointer",
            C = "f_tablesaw",
            D = "f_bandsaw",
            E = "f_workbench",
            F = "f_stool",
            G = "f_rack_wood",
            H = "f_planer",
            I = "f_mitresaw",
            J = "f_router",
            L = "f_table",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            G = {
                { group = "wood_workshop", chance = 90, repetitions = { 0, 3 } },
                { group = "carpentrybooks", chance = 20 },
            },
            E = { { group = "home_hw", chance = 80, repetitions = { 0, 2 } } },
        },
        vehicle_placements = { { fuel = 0, rotation = 180, status = 0, id = "canoe", x = 5, y = 3 } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_woodworker_W",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|G EEE  G|",
            "|G  F   G|",
            "+        |",
            "|J      B|",
            "|L CLH  A|",
            "|I  L   D|",
            "| F      |",
            "|GGG  GGG|",
            "||||||||||",
        },
        terrain = { ["|"] = "t_wall_w", ["+"] = "t_door_locked" },
        furniture = {
            A = "f_drill_press",
            B = "f_jointer",
            C = "f_tablesaw",
            D = "f_bandsaw",
            E = "f_workbench",
            F = "f_stool",
            G = "f_rack_wood",
            H = "f_planer",
            I = "f_mitresaw",
            J = "f_router",
            L = "f_table",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            G = {
                { group = "wood_workshop", chance = 90, repetitions = { 0, 3 } },
                { group = "carpentrybooks", chance = 20 },
            },
            E = { { group = "home_hw", chance = 80, repetitions = { 0, 2 } } },
        },
        vehicle_placements = { { fuel = 0, rotation = 180, status = 0, id = "canoe", x = 5, y = 3 } },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_guns_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||+|||",
            "|T~~~  Y!|",
            "|  h     |",
            "|        |",
            "|     h  |",
            "))])) IIT|",
            ")%;0) HHs|",
            ")$;=)   E|",
            ")%;,)yk; |",
            ")))))|||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            [")"] = "t_wall_metal",
            ["]"] = "t_door_metal_pickable",
            [";"] = "t_thconc_floor",
            [" "] = "t_floor",
            y = "t_floor",
            Y = "t_floor",
            h = "t_floor",
            T = "t_floor",
            ["~"] = "t_floor",
            I = "t_floor",
            H = "t_floor",
            E = "t_floor",
            s = "t_floor",
            ["!"] = "t_floor",
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["0"] = "f_safe_l",
            ["="] = "f_safe_l",
            [","] = "f_safe_l",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["="] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 80, repetitions = { 1, 2 } } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_guns_E",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|T~~~  Y!|",
            "|  h     |",
            "|        +",
            "|     h  |",
            "))])) IIT|",
            ")%;0) HHs|",
            ")$;=)   E|",
            ")%;,)yk; |",
            ")))))|||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            [")"] = "t_wall_metal",
            ["]"] = "t_door_metal_pickable",
            [";"] = "t_thconc_floor",
            [" "] = "t_floor",
            y = "t_floor",
            Y = "t_floor",
            h = "t_floor",
            T = "t_floor",
            ["~"] = "t_floor",
            I = "t_floor",
            H = "t_floor",
            E = "t_floor",
            s = "t_floor",
            ["!"] = "t_floor",
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["0"] = "f_safe_l",
            ["="] = "f_safe_l",
            [","] = "f_safe_l",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["="] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 80, repetitions = { 1, 2 } } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_guns_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            ")))))|||||",
            ")%;,)yk; |",
            ")$;=)   E|",
            ")%;0) HHs|",
            "))])) IIT|",
            "|     h  |",
            "|        |",
            "|  h     |",
            "|T~~~  Y!|",
            "||||||+|||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            [")"] = "t_wall_metal",
            ["]"] = "t_door_metal_pickable",
            [";"] = "t_thconc_floor",
            [" "] = "t_floor",
            y = "t_floor",
            Y = "t_floor",
            h = "t_floor",
            T = "t_floor",
            ["~"] = "t_floor",
            I = "t_floor",
            H = "t_floor",
            E = "t_floor",
            s = "t_floor",
            ["!"] = "t_floor",
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["0"] = "f_safe_l",
            ["="] = "f_safe_l",
            [","] = "f_safe_l",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["="] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 80, repetitions = { 1, 2 } } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_guns_W",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "|T~~~  Y!|",
            "|  h     |",
            "+        |",
            "|     h  |",
            "))])) IIT|",
            ")%;0) HHs|",
            ")$;=)   E|",
            ")%;,)yk; |",
            ")))))|||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            [")"] = "t_wall_metal",
            ["]"] = "t_door_metal_pickable",
            [";"] = "t_thconc_floor",
            [" "] = "t_floor",
            y = "t_floor",
            Y = "t_floor",
            h = "t_floor",
            T = "t_floor",
            ["~"] = "t_floor",
            I = "t_floor",
            H = "t_floor",
            E = "t_floor",
            s = "t_floor",
            ["!"] = "t_floor",
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["0"] = "f_safe_l",
            ["="] = "f_safe_l",
            [","] = "f_safe_l",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["="] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 80, repetitions = { 1, 2 } } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_11x11_apartment_N",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "|||||+|||||",
            "|ffh     F|",
            "|h    41O3|",
            "|Hl  x|||||",
            "|Hl  x|t89|",
            "|TEs  +  S|",
            "||||| |||||",
            "|d  + +  R|",
            "|@ y|+| hr|",
            "|@IT|q|Y r|",
            "|||||||||||",
        },
        palettes = { "standard_domestic_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "television", x = 5, y = 3, chance = 50 },
            { id = "stereo", x = 5, y = 4, chance = 50 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_11x11_apartment_S",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "|||||||||||",
            "|@IT|U|Y r|",
            "|@ y|+| hr|",
            "|d  + +  R|",
            "||||| |||||",
            "|TEs  +  S|",
            "|Hl  x|t89|",
            "|Hl  x|||||",
            "|h   Y41O3|",
            "|ffh     F|",
            "|||||+|||||",
        },
        palettes = { "standard_domestic_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "television", x = 5, y = 6, chance = 50 },
            { id = "stereo", x = 5, y = 7, chance = 50 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_11x11_apartment_E",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "|||||||||||",
            "|@@I|s E T|",
            "|@@ |Hl  x|",
            "|D  |Hl  x|",
            "|||+|  A y|",
            "|Q+   ff  +",
            "|||+|+||3 |",
            "|E  | t|4 |",
            "|I  | 8|O |",
            "|@@d|S9|F1|",
            "|||||||||||",
        },
        palettes = { "standard_domestic_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "television", x = 9, y = 2, chance = 50 },
            { id = "stereo", x = 9, y = 3, chance = 50 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_11x11_apartment_W",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "|||||||||||",
            "|@@I|s E T|",
            "|@@ |Hl  x|",
            "|D  |Hl  x|",
            "|||+|  A y|",
            "+     ff  |",
            "|||+|+||3 |",
            "|E  | t|4 |",
            "|I  | 8|O |",
            "|@@d|S9|F1|",
            "|||||||||||",
        },
        palettes = { "standard_domestic_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "television", x = 9, y = 2, chance = 50 },
            { id = "stereo", x = 9, y = 3, chance = 50 },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_cellar_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "#########",
            "#aafffaa#",
            "#c..A..b#",
            "#c.....b#",
            "#c.HXW..+",
            "#c.....f#",
            "#e.....f#",
            "#eeerrrr#",
            "#########",
        },
        terrain = { ["+"] = "t_door_locked", ["#"] = "t_wall_w", ["."] = "t_thconc_floor" },
        furniture = {
            a = "f_rack_wood",
            A = "f_stool",
            r = "f_rack_wood",
            c = "f_rack_wood",
            e = "f_rack_wood",
            f = "f_table",
            H = "f_fvat_empty",
            b = "f_sofa",
            X = "f_wood_keg",
            W = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            X = { id = "hb_beer", amount = { 0, 100 } },
            W = { id = "dandelion_wine", amount = { 0, 100 } },
        },
        loot_placements = {
            { id = "jar_3l_glass_sealed", x = 7, y = { 5, 6 }, chance = 60, repetitions = { 0, 4 } },
            { id = "pot_canning", x = 7, y = 5, chance = 80 },
            { id = "hotplate", x = 7, y = 6, chance = 50 },
            { id = "jar_glass_sealed", x = { 3, 5 }, y = 1, chance = 60, repetitions = { 0, 4 } },
        },
        item_groups = {
            a = { group = "dry_goods", chance = 50, repetitions = { 1, 2 } },
            r = { group = "preserved_food", chance = 50, repetitions = { 1, 2 } },
            c = { group = "condiments", chance = 50, repetitions = { 1, 4 } },
            e = { group = "pantry_liquids", chance = 50, repetitions = { 1, 4 } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_cellar_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "#########",
            "#aafffaa#",
            "#b.A...c#",
            "#b..H..c#",
            "+...X..c#",
            "#f..W..c#",
            "#f.....e#",
            "#eeerrrr#",
            "#########",
        },
        terrain = { ["+"] = "t_door_locked", ["#"] = "t_wall_w", ["."] = "t_thconc_floor" },
        furniture = {
            a = "f_rack_wood",
            A = "f_stool",
            r = "f_rack_wood",
            c = "f_rack_wood",
            e = "f_rack_wood",
            f = "f_table",
            H = "f_fvat_empty",
            b = "f_sofa",
            X = "f_wood_keg",
            W = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            X = { id = "mead", amount = { 0, 100 } },
            W = { id = "dandelion_wine", amount = { 0, 100 } },
        },
        loot_placements = {
            { id = "jar_3l_glass_sealed", x = 1, y = { 5, 6 }, chance = 60, repetitions = { 0, 4 } },
            { id = "pot_canning", x = 1, y = 5, chance = 80 },
            { id = "hotplate", x = 1, y = 6, chance = 50 },
            { id = "jar_glass_sealed", x = { 3, 5 }, y = 1, chance = 60, repetitions = { 0, 4 } },
        },
        item_groups = {
            a = { group = "dry_goods", chance = 50, repetitions = { 1, 2 } },
            r = { group = "preserved_food", chance = 50, repetitions = { 1, 2 } },
            c = { group = "condiments", chance = 50, repetitions = { 1, 4 } },
            e = { group = "pantry_liquids", chance = 50, repetitions = { 1, 4 } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_cellar_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "#########",
            "#aafffaa#",
            "#b.A...c#",
            "#b..f..c#",
            "#W..f..c#",
            "#X..f..c#",
            "#H...h.c#",
            "#eee.rrr#",
            "####+####",
        },
        terrain = { ["+"] = "t_door_locked", ["#"] = "t_wall_w", ["."] = "t_thconc_floor" },
        furniture = {
            a = "f_rack_wood",
            A = "f_stool",
            r = "f_rack_wood",
            c = "f_rack_wood",
            e = "f_rack_wood",
            f = "f_table",
            h = "f_chair",
            H = "f_fvat_empty",
            b = "f_sofa",
            X = "f_wood_keg",
            W = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            X = { id = "hb_beer", amount = { 0, 100 } },
            W = { id = "dandelion_wine", amount = { 0, 100 } },
        },
        loot_placements = {
            { id = "jar_3l_glass_sealed", x = 4, y = { 3, 5 }, chance = 60, repetitions = { 0, 4 } },
            { id = "pot_canning", x = 4, y = 4, chance = 80 },
            { id = "hotplate", x = 4, y = 3, chance = 50 },
            { id = "jar_glass_sealed", x = { 3, 5 }, y = 1, chance = 60, repetitions = { 0, 4 } },
        },
        item_groups = {
            a = { group = "dry_goods", chance = 50, repetitions = { 1, 2 } },
            r = { group = "preserved_food", chance = 50, repetitions = { 1, 2 } },
            c = { group = "condiments", chance = 50, repetitions = { 1, 4 } },
            e = { group = "pantry_liquids", chance = 50, repetitions = { 1, 4 } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_cellar_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "####+####",
            "#aae.eaa#",
            "#b.A...c#",
            "#b..f..c#",
            "#H..f..c#",
            "#X..fA.c#",
            "#W.....r#",
            "#eefffrr#",
            "#########",
        },
        terrain = { ["+"] = "t_door_locked", ["#"] = "t_wall_w", ["."] = "t_thconc_floor" },
        furniture = {
            a = "f_rack_wood",
            A = "f_stool",
            r = "f_rack_wood",
            c = "f_rack_wood",
            e = "f_rack_wood",
            f = "f_table",
            H = "f_fvat_empty",
            b = "f_sofa",
            X = "f_wood_keg",
            W = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            X = { id = "mead", amount = { 0, 100 } },
            W = { id = "dandelion_wine", amount = { 0, 100 } },
        },
        loot_placements = {
            { id = "jar_3l_glass_sealed", x = 4, y = { 3, 5 }, chance = 60, repetitions = { 0, 4 } },
            { id = "pot_canning", x = 4, y = 4, chance = 80 },
            { id = "hotplate", x = 4, y = 3, chance = 50 },
            { id = "jar_glass_sealed", x = { 3, 5 }, y = 7, chance = 60, repetitions = { 0, 4 } },
        },
        item_groups = {
            a = { group = "dry_goods", chance = 50, repetitions = { 1, 2 } },
            r = { group = "preserved_food", chance = 50, repetitions = { 1, 2 } },
            c = { group = "condiments", chance = 50, repetitions = { 1, 4 } },
            e = { group = "pantry_liquids", chance = 50, repetitions = { 1, 4 } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_brewer_W",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|THHs|",
            "+    |",
            "|   $|",
            "|%%0!|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["|"] = "t_wall_wood" },
        furniture = {
            ["%"] = "f_rack_wood",
            ["$"] = "f_fvat_empty",
            ["0"] = "f_wood_keg",
            ["!"] = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            X = { id = "hb_beer", amount = { 100, 500 } },
            W = { id = "dandelion_wine", amount = { 100, 500 } },
        },
        item_groups = {
            ["%"] = {
                { group = "liqstore_brew", chance = 50, repetitions = { 2, 8 } },
                { group = "misc_alcohol", chance = 100, repetitions = { 2, 8 } },
            },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_brewer_E",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|THHs|",
            "|    +",
            "| A $|",
            "|%%0!|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["|"] = "t_wall_wood" },
        furniture = {
            ["%"] = "f_rack_wood",
            ["$"] = "f_fvat_empty",
            ["0"] = "f_wood_keg",
            ["!"] = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "hb_beer", amount = { 10, 500 } },
            ["!"] = { id = "dandelion_wine", amount = { 10, 500 } },
        },
        item_groups = {
            ["%"] = {
                { group = "liqstore_brew", chance = 50, repetitions = { 2, 8 } },
                { group = "misc_alcohol", chance = 100, repetitions = { 2, 8 } },
            },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_brewer_N",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|||+||",
            "|%  0|",
            "|%  $|",
            "|E  !|",
            "|~,ss|",
            "||||||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["|"] = "t_wall_wood" },
        furniture = {
            ["%"] = "f_rack_wood",
            ["$"] = "f_fvat_empty",
            ["0"] = "f_wood_keg",
            [","] = "f_still",
            ["~"] = "f_ash",
            ["!"] = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "moonshine", amount = { 100, 500 } },
            ["!"] = { id = "mead", amount = { 100, 500 } },
        },
        item_groups = {
            ["%"] = {
                { group = "liqstore_brew", chance = 50, repetitions = { 2, 8 } },
                { group = "misc_alcohol", chance = 50, repetitions = { 2, 8 } },
            },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_brewer_S",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|%~,s|",
            "|%  s|",
            "|E  !|",
            "|  0$|",
            "||+|||",
        },
        palettes = { "standard_domestic_palette" },
        terrain = { ["|"] = "t_wall_wood" },
        furniture = {
            ["%"] = "f_rack_wood",
            ["$"] = "f_fvat_empty",
            ["0"] = "f_wood_keg",
            [","] = "f_still",
            ["~"] = "f_ash",
            ["!"] = "f_wood_keg",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "moonshine", amount = { 100, 500 } },
            ["!"] = { id = "mead", amount = { 100, 500 } },
        },
        item_groups = {
            ["%"] = {
                { group = "liqstore_brew", chance = 50, repetitions = { 2, 8 } },
                { group = "misc_alcohol", chance = 50, repetitions = { 2, 8 } },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_wine_cellar_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||+|||",
            "|!...0|",
            "|. E .|",
            "|.EtE.|",
            "|. E .|",
            "|%%.%m|",
            "|||||||",
        },
        terrain = {
            ["|"] = "t_wall_r",
            ["+"] = "t_door_c",
            ["."] = "t_floor",
            ["!"] = "t_floor",
            ["0"] = "t_floor",
            ["%"] = "t_floor",
            m = "t_floor",
            t = "t_carpet_red",
            [" "] = "t_carpet_red",
            E = "t_carpet_red",
        },
        furniture = {
            ["%"] = "f_rack_wood",
            ["0"] = "f_wood_keg",
            ["!"] = "f_wood_keg",
            t = "f_table",
            E = "f_armchair",
            m = "f_glass_fridge",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "wine_cabernet", amount = { 100, 500 } },
            ["!"] = { id = "wine_chardonnay", amount = { 100, 500 } },
        },
        loot_placements = { { id = "deck_of_cards", x = 3, y = 3, chance = 100 } },
        item_groups = {
            ["%"] = { group = "wines_worthy", chance = 70, repetitions = { 1, 2 } },
            m = { group = "chilled_wine", chance = 40, repetitions = { 1, 4 } },
            t = { group = "table_wine", chance = 100, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_wine_cellar_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|!...0|",
            "|. E .|",
            "|.EtE.|",
            "|. E .|",
            "|%%.%m|",
            "|||+|||",
        },
        terrain = {
            ["|"] = "t_wall_r",
            ["+"] = "t_door_c",
            ["."] = "t_floor",
            ["!"] = "t_floor",
            ["0"] = "t_floor",
            ["%"] = "t_floor",
            m = "t_floor",
            t = "t_carpet_red",
            [" "] = "t_carpet_red",
            E = "t_carpet_red",
        },
        furniture = {
            ["%"] = "f_rack_wood",
            ["0"] = "f_wood_keg",
            ["!"] = "f_wood_keg",
            t = "f_table",
            E = "f_armchair",
            m = "f_glass_fridge",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "wine_cabernet", amount = { 100, 500 } },
            ["!"] = { id = "wine_chardonnay", amount = { 100, 500 } },
        },
        loot_placements = { { id = "deck_of_cards", x = 3, y = 3, chance = 100 } },
        item_groups = {
            ["%"] = { group = "wines_worthy", chance = 70, repetitions = { 1, 2 } },
            m = { group = "chilled_wine", chance = 40, repetitions = { 1, 4 } },
            t = { group = "table_wine", chance = 100, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_wine_cellar_E",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|!...0|",
            "|. E .|",
            "|.EtE.+",
            "|. E .|",
            "|%%.%m|",
            "|||||||",
        },
        terrain = {
            ["|"] = "t_wall_r",
            ["+"] = "t_door_c",
            ["."] = "t_floor",
            ["!"] = "t_floor",
            ["0"] = "t_floor",
            ["%"] = "t_floor",
            m = "t_floor",
            t = "t_carpet_red",
            [" "] = "t_carpet_red",
            E = "t_carpet_red",
        },
        furniture = {
            ["%"] = "f_rack_wood",
            ["0"] = "f_wood_keg",
            ["!"] = "f_wood_keg",
            t = "f_table",
            E = "f_armchair",
            m = "f_glass_fridge",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "wine_cabernet", amount = { 100, 500 } },
            ["!"] = { id = "wine_chardonnay", amount = { 100, 500 } },
        },
        loot_placements = { { id = "deck_of_cards", x = 3, y = 3, chance = 100 } },
        item_groups = {
            ["%"] = { group = "wines_worthy", chance = 70, repetitions = { 1, 2 } },
            m = { group = "chilled_wine", chance = 40, repetitions = { 1, 4 } },
            t = { group = "table_wine", chance = 100, repetitions = { 1, 4 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_wine_cellar_W",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|!...0|",
            "|. E .|",
            "+.EtE.|",
            "|. E .|",
            "|%%.%m|",
            "|||||||",
        },
        terrain = {
            ["|"] = "t_wall_r",
            ["+"] = "t_door_c",
            ["."] = "t_floor",
            ["!"] = "t_floor",
            ["0"] = "t_floor",
            ["%"] = "t_floor",
            m = "t_floor",
            t = "t_carpet_red",
            [" "] = "t_carpet_red",
            E = "t_carpet_red",
        },
        furniture = {
            ["%"] = "f_rack_wood",
            ["0"] = "f_wood_keg",
            ["!"] = "f_wood_keg",
            t = "f_table",
            E = "f_armchair",
            m = "f_glass_fridge",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = {
            ["0"] = { id = "wine_cabernet", amount = { 100, 500 } },
            ["!"] = { id = "wine_chardonnay", amount = { 100, 500 } },
        },
        loot_placements = { { id = "deck_of_cards", x = 3, y = 3, chance = 100 } },
        item_groups = {
            ["%"] = { group = "wines_worthy", chance = 70, repetitions = { 1, 2 } },
            m = { group = "chilled_wine", chance = 40, repetitions = { 1, 4 } },
            t = { group = "table_wine", chance = 100, repetitions = { 1, 4 } },
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "recroom_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "============",
            "====ElHHHl==",
            "==========T=",
            "==========ER",
            "===eee=====R",
            "===eee=====R",
            "===eee======",
            "===eee=====$",
            "========AC==",
            "========AC==",
            "========AC==",
            "MMM======CS!",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["!"] = { group = "wetbar_fridge", chance = 100, repetitions = { 1, 10 } },
            e = { group = "pool_table", chance = 5 },
            C = { { group = "wetbar_stack", chance = 25 }, { group = "wetbar_counter", chance = 25 } },
            M = { { group = "antique", chance = 65 }, { group = "antique_rare", chance = 1 } },
            ["$"] = { group = "pool_table", chance = 100, repetitions = { 1, 6 } },
        },
        palettes = {
            "standard_domestic_palette",
            "standard_domestic_basement_palette",
            "parametrized_carpets_nest_palette",
        },
        terrain = {
            e = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            R = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            E = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            C = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            S = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["$"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = { ["!"] = "f_fridge", ["$"] = "f_rack_wood" },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "tvroom_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "============",
            "=,,,,,,,,,==",
            "=,,,,,,,,,!=",
            "=,,,,,,,,,!=",
            "=,,,,,,,,,!=",
            "=,,,,,,,,,==",
            "==HHHHHHH===",
            "==H========T",
            "====lll====E",
            "============",
            "=====$======",
            "============",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["!"] = { group = "toy_box", chance = 80, repetitions = { 1, 10 } },
            ["="] = {
                { group = "toy_box", chance = 5 },
                { group = "SUS_trash_floor", chance = 1 },
                { group = "bed", chance = 1 },
                { group = "candy_chocolate", chance = 2 },
            },
            ["$"] = { group = "a_television", chance = 100 },
        },
        palettes = {
            "standard_domestic_palette",
            "standard_domestic_basement_palette",
            "parametrized_carpets_nest_palette",
        },
        terrain = {
            [","] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            E = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["$"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
        },
        furniture = { ["!"] = "f_rack_wood", ["$"] = "f_rack_wood" },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "workoutroom_12x12",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "============",
            "==,,,,,,,,==",
            "==,X,,,,X,==",
            "==,,,,,,,,==",
            "==,,,,,,,,==",
            "==,cc,,uu,==",
            "==,,,,,,,,==",
            "============",
            "=========AA=",
            "=======CCCC=",
            "=======S====",
            "=======!===$",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["!"] = { group = "produce", chance = 80, repetitions = { 2, 8 } },
            ["$"] = { group = "a_television", chance = 100 },
        },
        palettes = {
            "parametrized_linoleum_palette", "standard_domestic_palette",
            "standard_domestic_basement_palette", "parametrized_carpets_nest_palette",
        },
        terrain = {
            A = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            C = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            S = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["$"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            [","] = { parameter = "linoleum_color", fallback = "t_linoleum_white" },
            c = { parameter = "linoleum_color", fallback = "t_linoleum_white" },
            u = { parameter = "linoleum_color", fallback = "t_linoleum_white" },
            X = { parameter = "linoleum_color", fallback = "t_linoleum_white" },
        },
        furniture = { ["!"] = "f_fridge", ["$"] = "f_rack_wood" },
    },
}

-- an grow area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_weed_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "||||+||||",
            "|RRR UUU|",
            "|Q     Q|",
            "|Q QQQ Q|",
            "|Q hTh Q|",
            "|Q hTh Q|",
            "|Q     Q|",
            "|HWX XCA|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { H = { id = "water_clean", amount = { 0, 100 } } },
        sealed_item_glyphs = { Q = { item = { id = "seed_weed" }, furniture = "f_planter_harvest" } },
        item_groups = {
            T = { { group = "supplies_farming", chance = 70 }, { group = "weed_farm", chance = 50 } },
            R = { { group = "weed_farm", chance = 70 } },
            U = { { group = "home_hw", chance = 50 } },
            X = {
                { group = "supplies_farming", chance = 50 },
                { group = "cleaning", chance = 50 },
                { group = "chem_home", chance = 50 },
            },
        },
        palettes = { "parametrized_linoleum_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            ["+"] = "t_door_c",
            [" "] = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            C = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            X = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            W = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            R = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            H = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            h = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            U = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            A = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            Q = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            T = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
        },
        furniture = {
            T = "f_workbench",
            h = "f_chair",
            R = "f_rack",
            A = "f_air_filter",
            C = "f_air_conditioner",
            H = "f_water_heater",
            W = "f_water_purifier",
            X = { { id = "f_crate_c" }, { id = "f_crate_o" }, { id = "f_cardboard_box" } },
            U = "f_utility_shelf",
        },
    },
}

-- an grow area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_weed_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|RRR UUU|",
            "|Q     Q|",
            "|Q QQQ Q|",
            "|Q hTh Q|",
            "|Q hTh Q|",
            "|Q     Q|",
            "|HWX XCA|",
            "||||+||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { H = { id = "water_clean", amount = { 0, 100 } } },
        sealed_item_glyphs = { Q = { item = { id = "seed_weed" }, furniture = "f_planter_harvest" } },
        item_groups = {
            T = { { group = "supplies_farming", chance = 70 }, { group = "weed_farm", chance = 50 } },
            R = { { group = "weed_farm", chance = 70 } },
            U = { { group = "home_hw", chance = 50 } },
            X = {
                { group = "supplies_farming", chance = 50 },
                { group = "cleaning", chance = 50 },
                { group = "chem_home", chance = 50 },
            },
        },
        palettes = { "parametrized_linoleum_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            ["+"] = "t_door_c",
            [" "] = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            C = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            X = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            W = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            R = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            H = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            h = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            U = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            A = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            Q = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            T = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
        },
        furniture = {
            T = "f_workbench",
            h = "f_chair",
            R = "f_rack",
            A = "f_air_filter",
            C = "f_air_conditioner",
            H = "f_water_heater",
            W = "f_water_purifier",
            X = { { id = "f_crate_c" }, { id = "f_crate_o" }, { id = "f_cardboard_box" } },
            U = "f_utility_shelf",
        },
    },
}

-- an grow area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_weed_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|RRR UUU|",
            "|Q     Q|",
            "|Q QQQ Q|",
            "|Q hTh  +",
            "|Q hTh Q|",
            "|Q     Q|",
            "|HWX XCA|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { H = { id = "water_clean", amount = { 0, 100 } } },
        sealed_item_glyphs = { Q = { item = { id = "seed_weed" }, furniture = "f_planter_harvest" } },
        item_groups = {
            T = { { group = "supplies_farming", chance = 70 }, { group = "weed_farm", chance = 50 } },
            R = { { group = "weed_farm", chance = 70 } },
            U = { { group = "home_hw", chance = 50 } },
            X = {
                { group = "supplies_farming", chance = 50 },
                { group = "cleaning", chance = 50 },
                { group = "chem_home", chance = 50 },
            },
        },
        palettes = { "parametrized_linoleum_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            ["+"] = "t_door_c",
            [" "] = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            C = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            X = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            W = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            R = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            H = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            h = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            U = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            A = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            Q = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            T = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
        },
        furniture = {
            T = "f_workbench",
            h = "f_chair",
            R = "f_rack",
            A = "f_air_filter",
            C = "f_air_conditioner",
            H = "f_water_heater",
            W = "f_water_purifier",
            X = { { id = "f_crate_c" }, { id = "f_crate_o" }, { id = "f_cardboard_box" } },
            U = "f_utility_shelf",
        },
    },
}

-- an grow area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_weed_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|RRR UUU|",
            "|Q     Q|",
            "|Q QQQ Q|",
            "+  hTh Q|",
            "|Q hTh Q|",
            "|Q     Q|",
            "|HWX XCA|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        liquid_glyphs = { H = { id = "water_clean", amount = { 0, 100 } } },
        sealed_item_glyphs = { Q = { item = { id = "seed_weed" }, furniture = "f_planter_harvest" } },
        item_groups = {
            T = { { group = "supplies_farming", chance = 70 }, { group = "weed_farm", chance = 50 } },
            R = { { group = "weed_farm", chance = 70 } },
            U = { { group = "home_hw", chance = 50 } },
            X = {
                { group = "supplies_farming", chance = 50 },
                { group = "cleaning", chance = 50 },
                { group = "chem_home", chance = 50 },
            },
        },
        palettes = { "parametrized_linoleum_palette" },
        terrain = {
            ["|"] = "t_wall_w",
            ["+"] = "t_door_c",
            [" "] = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            C = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            X = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            W = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            R = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            H = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            h = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            U = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            A = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            Q = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
            T = { parameter = "linoleum_color", fallback = "t_linoleum_gray" },
        },
        furniture = {
            T = "f_workbench",
            h = "f_chair",
            R = "f_rack",
            A = "f_air_filter",
            C = "f_air_conditioner",
            H = "f_water_heater",
            W = "f_water_purifier",
            X = { { id = "f_crate_c" }, { id = "f_crate_o" }, { id = "f_cardboard_box" } },
            U = "f_utility_shelf",
        },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "||||+||||",
            "|HHH===?|",
            "|Hl====x|",
            "|%=====?|",
            "|=A=A==&|",
            "|JJ5JJ..|",
            "|.......|",
            "|mVJ14.T|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = "t_floor",
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_N",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "||||+||||",
            "|A=====?|",
            "|==ee==x|",
            "|A=ee==?|",
            "|==ee==&|",
            "|======%|",
            "|Hll=E==|",
            "|HHHHsyT|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            E = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            e = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|HHH===?|",
            "|Hl====x|",
            "|%=====?|",
            "|=A=A==&|",
            "|JJ5JJ..|",
            "|.......|",
            "|mVJ14.T|",
            "||||||+||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = "t_floor",
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_S",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|A.....=|",
            "|..ee..x|",
            "|A.ee..=|",
            "|..ee..&|",
            "|......%|",
            "|Hll.E..|",
            "|HHHHs.T|",
            "||||||+||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette" },
        terrain = {
            ["."] = "t_floor",
            H = "t_floor",
            l = "t_floor",
            A = "t_floor",
            ["="] = "t_floor",
            x = "t_floor",
            ["%"] = "t_floor",
            E = "t_floor",
            T = "t_floor",
            y = "t_floor",
            s = "t_floor",
            e = "t_floor",
            ["&"] = "t_floor",
        },
        furniture = { ["%"] = "f_arcade_machine", ["="] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|HHH===?|",
            "|Hl====x|",
            "|%=====?|",
            "|=A=A==&|",
            "|JJ5JJ..+",
            "|.......|",
            "|mVJ14.T|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = "t_floor",
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_E",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|A=====?|",
            "|==ee==x|",
            "|A=ee==?|",
            "|==ee==&|",
            "|=======+",
            "|Hll=E=%|",
            "|HHHHsyT|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            H = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            E = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            y = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            e = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|HHH===?|",
            "|Hl====x|",
            "|%=====?|",
            "+=A=A==&|",
            "|JJ5JJ..|",
            "|.......|",
            "|mVJ14.T|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = "t_floor",
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_9x9_recroom_W",
    layout = {
        size = { width = 9, height = 9 },
        rows = {
            "|||||||||",
            "|A=====?|",
            "|==ee==x|",
            "|A=ee==?|",
            "+==ee==&|",
            "|======%|",
            "|Hll=E==|",
            "|HHHHsyT|",
            "|||||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 7, y = 2, chance = 100 },
            { id = "laptop", x = 5, y = 5, chance = 60 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            E = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            e = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_N",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "|||+||",
            "|%==!|",
            "|,==~|",
            "|?=h~|",
            "|$Y=~|",
            "||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["?"] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 10, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 50, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 40, repetitions = { 1, 2 } } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["$"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            [","] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["~"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            P = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["0"] = "f_displaycase",
            ["?"] = "f_displaycase",
            [","] = "f_displaycase",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_S",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|%Y=!|",
            "|,==~|",
            "|?=h~|",
            "|$==~|",
            "|||+||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["?"] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 40, repetitions = { 1, 2 } } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            [" "] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["$"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            [","] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["~"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            P = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = {
            ["%"] = "f_rack_wood",
            ["$"] = "f_rack_wood",
            ["="] = "f_table",
            [","] = "f_table",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
    },
}

-- a nested map for basements
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_6x6_guns_E",
    weight = 1000,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "||||||",
            "|%=P!|",
            "|,===+",
            "|?=h~:",
            "|$Y=~:",
            "||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            ["%"] = {
                { group = "guns_rifle_common", chance = 100, repetitions = { 1, 3 } },
                { group = "guns_shotgun_common", chance = 2, repetitions = { 1, 2 } },
            },
            ["$"] = { { group = "guns_pistol_common", chance = 100, repetitions = { 2, 5 } } },
            [","] = { { group = "mags_common", chance = 60, repetitions = { 1, 6 } } },
            ["?"] = { { group = "ammo_common_boxed", chance = 40, repetitions = { 1, 10 } } },
            ["~"] = {
                { group = "museum_guns", chance = 1 },
                { group = "tools_common", chance = 60 },
                { group = "gunmod_rare", chance = 5, repetitions = { 1, 2 } },
                { group = "gunmod_common", chance = 20, repetitions = { 1, 2 } },
            },
            ["!"] = { { group = "book_gunref", chance = 60, repetitions = { 1, 2 } } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["$"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            [","] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["~"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            P = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
        },
        furniture = {
            ["%"] = "f_locker",
            ["$"] = "f_locker",
            ["?"] = "f_table",
            [","] = "f_table",
            ["~"] = "f_workbench",
            ["!"] = "f_bookcase",
        },
    },
}

-- a tent for basements, indoor scenarios
ccb.content.define_mapgen {
    kind = "nested",
    id = "7x7_tent_indoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "==K====",
            "=G=%%%=",
            "===&?%=",
            "===%%%=",
            "===G===",
            "=====G=",
            "=====K=",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_group_placements = {
            { group = "snacks", x = 5, y = 6, chance = 75 },
            { group = "snacks", x = 2, y = 0, chance = 75 },
            { group = "camping", x = 4, y = 2, chance = 30, repetitions = { 1, 3 } },
            {
                group = "child_items",
                x = { 0, 6 },
                y = { 4, 6 },
                chance = 80,
                repetitions = { 4, 8 },
            },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        traps = { ["?"] = "tr_rollmat" },
        terrain = {
            [" "] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            K = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            G = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["0"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = { ["%"] = "f_canvas_wall", ["?"] = "f_groundsheet", ["&"] = "f_canvas_door" },
    },
}

-- a band practice space in an open area
ccb.content.define_mapgen {
    kind = "nested",
    id = "7x7_band_practice_open",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "       ",
            " ===?= ",
            " =%===s",
            " ?==h=s",
            " !&=== ",
            " ===== ",
            "  sHH  ",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "laptop", x = 6, y = 3, chance = 100 },
            { id = "amplifier_head", x = 4, y = 4, chance = 100 },
            { id = "amplifier_head", x = 1, y = 5, chance = 100 },
            { id = "mixer_music", x = 6, y = 2, chance = 100 },
            { id = "guitar_stand", x = 3, y = 3, chance = 100 },
            { id = "qt_wire", x = 3, y = 3, chance = 20 },
            { id = "guitar_stand", x = 0, y = 5, chance = 100 },
            { id = "qt_wire", x = 0, y = 5, chance = 20 },
            { id = "mic_stand_tall", x = 5, y = 5, chance = 100 },
            { id = "microphone_xlr_generic", x = 5, y = 5, chance = 100 },
            { id = "headphones_circumaural", x = 6, y = 2, chance = 100 },
            { id = "cable_instrument", x = 3, y = { 0, 5 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_xlr", x = { 0, 6 }, y = 5, chance = 80, repetitions = { 3, 6 } },
        },
        item_groups = {
            h = { { group = "mussto_stringinst", chance = 100 } },
            ["&"] = { { group = "mussto_stringinst", chance = 100 } },
            ["!"] = { { group = "mussto_windinst", chance = 70 } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["~"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["0"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_piano", copies = 5 }, { id = "f_null" } },
            ["?"] = "f_speaker_cabinet",
            ["&"] = "f_chair",
            ["!"] = "f_table",
        },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||+|||",
            "|y===?|",
            "|H===x|",
            "|H===x|",
            "|=h==?|",
            "|Trr=%|",
            "|||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 5, y = 2, chance = 100 },
            { id = "television", x = 5, y = 3, chance = 75 },
            { id = "laptop", x = 2, y = 5, chance = 100 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            r = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            R = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_punching_bag" }, { id = "f_arcade_machine" }, { id = "f_pinball_machine" } },
            ["?"] = "f_speaker_cabinet",
        },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_N",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|::!::|",
            "|T===s|",
            "|&A==x|",
            "|s=A=x|",
            "|&A=As|",
            "|Y%s%y|",
            "|||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = { { id = "stereo", x = 5, y = 2, chance = 100 } },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = "t_door_glass_c",
            y = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = { ["%"] = "f_arcade_machine", s = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|y===?|",
            "|H===x|",
            "|H===x|",
            "|=h==?|",
            "|Trr=%|",
            "||||+||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 5, y = 2, chance = 100 },
            { id = "television", x = 5, y = 3, chance = 75 },
            { id = "laptop", x = 2, y = 5, chance = 100 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            r = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            R = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_punching_bag" }, { id = "f_arcade_machine" }, { id = "f_pinball_machine" } },
            ["?"] = "f_speaker_cabinet",
        },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_S",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|T%s%?|",
            "|&A==x|",
            "|s=A=x|",
            "|&A=A?|",
            "|Y===y|",
            "|::!::|",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = { { id = "stereo", x = 5, y = 2, chance = 100 } },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = "t_door_glass_c",
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_E",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|x==HH|",
            "|x==lH|",
            "|?====+",
            "|=h==Y|",
            "|Trr%?|",
            "|||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 1, y = 1, chance = 100 },
            { id = "television", x = 1, y = 2, chance = 75 },
            { id = "laptop", x = 2, y = 5, chance = 100 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            r = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            R = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_punching_bag" }, { id = "f_arcade_machine" }, { id = "f_pinball_machine" } },
            ["?"] = "f_speaker_cabinet",
        },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_E",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|T%s%A:",
            "|&A=A=:",
            "|s====!",
            "|&A===:",
            "|Y?x?y:",
            "|||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = { { id = "stereo", x = 3, y = 5, chance = 100 } },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = "t_door_glass_c",
            y = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_W",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            "|x=?HH|",
            "|x==lH|",
            "+====?|",
            "|=h===|",
            "|Trr=%|",
            "|||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 1, y = 1, chance = 100 },
            { id = "television", x = 1, y = 2, chance = 75 },
            { id = "laptop", x = 2, y = 5, chance = 100 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            r = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            R = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_punching_bag" }, { id = "f_arcade_machine" }, { id = "f_pinball_machine" } },
            ["?"] = "f_speaker_cabinet",
        },
    },
}

-- an entertainment area for various recreations
ccb.content.define_mapgen {
    kind = "nested",
    id = "room_7x7_recroom_W",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "|||||||",
            ":T%s%=|",
            ":=A=A&|",
            "!====s|",
            ":===A&|",
            ":Y?x?y|",
            "|||||||",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = { { id = "stereo", x = 3, y = 5, chance = 100 } },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = "t_door_glass_c",
            y = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            Y = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            x = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = { ["%"] = "f_arcade_machine", ["?"] = "f_speaker_cabinet", ["&"] = "f_pinball_machine" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_gym_N",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%=ccc",
            "=====",
            "==&=&",
            "&=&==",
            "B==B=",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["@"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            V = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            B = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            O = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            r = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = { ["%"] = "f_punching_bag", c = "f_bench", B = "f_bigmirror" },
        traps = { ["&"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_gym_S",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "B==B=",
            "==?==",
            "?==?=",
            "=====",
            "ccc=%",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        clear_glyphs = { [" "] = {}, B = {}, c = {}, ["%"] = {}, ["?"] = {} },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            B = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = { ["%"] = "f_punching_bag", c = "f_bench", B = "f_bigmirror" },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_gym_E",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "%=ccc",
            "=====",
            "=?==?",
            "===?=",
            "B==B=",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        clear_glyphs = { B = {}, c = {}, ["%"] = {}, ["?"] = {} },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            B = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["="] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
        },
        furniture = { ["%"] = "f_punching_bag", c = "f_bench", B = "f_bigmirror" },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "5x5_gym_W",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "B==B=",
            "==?==",
            "?==?=",
            "=====",
            "cc==%",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        clear_glyphs = { B = {}, c = {}, ["%"] = {}, ["?"] = {} },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            B = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = { ["%"] = "f_punching_bag", c = "f_bench", B = "f_bigmirror" },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_gym_N",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "========",
            "=!=@=V==",
            "========",
            "1====c==",
            "=====c==",
            "========",
            "========",
            "======B=",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "5x5_sauna_N", weight = 30 },
                    { id = "5x5_pool", weight = 10 },
                    { id = "5x5_gym_N", weight = 60 },
                },
            },
        },
        clear_glyphs = { ["!"] = {}, ["@"] = {}, V = {}, B = {}, c = {}, ["?"] = {} },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["@"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            V = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            B = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = {
            ["!"] = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["@"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            V = "f_exercise",
            c = "f_bench",
            B = "f_bigmirror",
        },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_gym_S",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "B==1====",
            "=?c=====",
            "?=c=====",
            "========",
            "========",
            "========",
            "=!=@=V==",
            "========",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "5x5_sauna_S", weight = 30 },
                    { id = "5x5_pool", weight = 10 },
                    { id = "5x5_gym_S", weight = 60 },
                },
            },
        },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            [" "] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["@"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            V = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            B = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            O = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["!"] = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["@"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            V = "f_exercise",
            c = "f_bench",
            B = "f_bigmirror",
        },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_gym_E",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "========",
            "=!=@=V==",
            "========",
            "1=======",
            "========",
            "=======?",
            "======?=",
            "======B=",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "5x5_sauna_E", weight = 30 },
                    { id = "5x5_pool", weight = 10 },
                    { id = "5x5_gym_E", weight = 60 },
                },
            },
        },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["@"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            V = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            B = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            O = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
        },
        furniture = {
            ["!"] = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["@"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            V = "f_exercise",
            c = "f_bench",
            B = "f_bigmirror",
        },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "8x8_gym_W",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "B==1====",
            "=?======",
            "?=======",
            "========",
            "========",
            "========",
            "=!=@=V=c",
            "=======c",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested_glyphs = {
            ["1"] = {
                choices = {
                    { id = "5x5_sauna_W", weight = 30 },
                    { id = "5x5_pool", weight = 10 },
                    { id = "5x5_gym_W", weight = 60 },
                },
            },
        },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["@"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            V = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            B = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            c = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            O = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["?"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = {
            ["!"] = { { id = "f_ergometer" }, { id = "f_ergometer_mechanical" } },
            ["@"] = { { id = "f_treadmill" }, { id = "f_treadmill_mechanical" } },
            V = "f_exercise",
            c = "f_bench",
            B = "f_bigmirror",
        },
        traps = { ["?"] = "tr_rollmat" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_electronics_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "CyT..C",
            "C====C",
            "C=EE=C",
            ".====.",
            ".h==Af",
            "BBB..f",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        item_placements = {
            { id = "television", x = 5, y = 5, chance = 100 },
            { id = "laptop", x = 1, y = 5, chance = 90 },
            { id = "multitool", x = 0, y = 5, chance = 100 },
            { id = "breadboard", x = 1, y = 5, chance = 95 },
            { id = "voltmeter", x = 1, y = 5, chance = 90 },
            { id = "multimeter", x = 1, y = 5, chance = 90 },
        },
        item_groups = {
            C = {
                { group = "elecsto_homapl", chance = 30, repetitions = { 0, 3 } },
                { group = "elecsto_persele", chance = 20, repetitions = { 0, 2 } },
                { group = "elecsto_diy", chance = 60, repetitions = { 2, 4 } },
                { group = "electronicbooks", chance = 20 },
            },
            f = {
                { group = "electronics", chance = 50, repetitions = { 1, 2 } },
                { group = "elecsto_entapl", chance = 30, repetitions = { 1, 2 } },
                { group = "elecsto_stor", chance = 40, repetitions = { 2, 4 } },
            },
            B = {
                { group = "elecsto_diy", chance = 60, repetitions = { 1, 4 } },
                { group = "elecsto_books", chance = 40, repetitions = { 1, 2 } },
            },
        },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            B = "t_floor",
            C = "t_floor",
            y = "t_floor",
            T = "t_floor",
            f = "t_floor",
            E = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            A = "f_stool",
            B = "f_workbench",
            E = "f_sofa",
            C = "f_rack_wood",
            T = "f_floor_lamp",
            f = "f_table",
            h = "f_chair",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "6x6_sewing_open",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "BBT..C",
            "Bh===C",
            "B=Af=C",
            ".==f=.",
            "Ed=f=C",
            "yE...C",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            C = {
                { group = "SUS_tailoring_materials", chance = 80, repetitions = { 3, 6 } },
                { group = "leather_shop_repair", chance = 40, repetitions = { 2, 4 } },
            },
            f = {
                { group = "SUS_tailoring_materials", chance = 50, repetitions = { 1, 2 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 1, 2 } },
                { group = "leather_shop_repair", chance = 40, repetitions = { 2, 4 } },
            },
            d = {
                { group = "pants", chance = 100 },
                { group = "shirts", chance = 100 },
                { group = "leather_shop_accessories", chance = 10 },
            },
            B = {
                { group = "SUS_tailoring_tool_drawer", chance = 60, repetitions = { 0, 1 } },
                { group = "tailorbooks", chance = 60, repetitions = { 0, 1 } },
                { group = "SUS_tailoring_fasteners", chance = 30, repetitions = { 2, 6 } },
                { group = "tailorbooks", chance = 25 },
            },
        },
        palettes = { "parametrized_carpets_nest_palette" },
        terrain = {
            ["."] = "t_floor",
            B = "t_floor",
            C = "t_floor",
            y = "t_floor",
            T = "t_floor",
            E = "t_floor",
            h = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            d = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            f = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            O = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = {
            A = "f_stool",
            B = "f_workbench",
            E = "f_armchair",
            C = "f_rack_wood",
            T = "f_floor_lamp",
            d = "f_mannequin",
            b = "f_bench",
            f = "f_table",
            h = "f_chair",
            y = { { id = "f_indoor_plant_y" }, { id = "f_indoor_plant" } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_recording_studio_N",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||++||||",
            "|HH   ??s|",
            "|l   A Es|",
            "|? Ysssss|",
            "|:)::::::|",
            "| ====== |",
            "| ==h!&= |",
            "| %===== |",
            "| ====== |",
            "||||||||||",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 8, y = 1, chance = 100 },
            { id = "laptop", x = 8, y = 2, chance = 100 },
            { id = "amplifier_head", x = { 5, 6 }, y = 3, chance = 100 },
            { id = "amplifier_head", x = 4, y = 5, chance = 100 },
            { id = "amplifier_head", x = 6, y = 5, chance = 100 },
            { id = "mixer_music", x = { 4, 7 }, y = 3, chance = 80, repetitions = { 1, 4 } },
            { id = "guitar_stand", x = 7, y = { 5, 8 }, chance = 70, repetitions = { 1, 4 } },
            { id = "qt_wire", x = 7, y = 5, chance = 20 },
            { id = "guitar_stand", x = 4, y = 7, chance = 100 },
            { id = "mic_stand_tall", x = 7, y = 5, chance = 100 },
            { id = "mic_stand_tall", x = 2, y = 5, chance = 100 },
            { id = "mic_stand_tall", x = 3, y = 1, chance = 100 },
            { id = "microphone_xlr_generic", x = 7, y = 5, chance = 80, repetitions = { 1, 3 } },
            {
                id = "headphones_circumaural",
                x = { 4, 6 },
                y = 6,
                chance = 80,
                repetitions = { 1, 3 },
            },
            {
                id = "headphones_circumaural",
                x = { 4, 7 },
                y = 3,
                chance = 60,
                repetitions = { 1, 3 },
            },
            { id = "cable_instrument", x = 1, y = { 5, 8 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_speaker", x = 8, y = { 5, 8 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_xlr", x = { 1, 5 }, y = 8, chance = 80, repetitions = { 3, 6 } },
        },
        item_groups = {
            h = { { group = "mussto_stringinst", chance = 100 } },
            ["&"] = { { group = "mussto_stringinst", chance = 100 } },
            ["!"] = { { group = "mussto_windinst", chance = 70 } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            [")"] = "t_door_glass_c",
            ["|"] = "t_wall_b",
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_piano", copies = 10 }, { id = "f_null" } },
            ["?"] = "f_speaker_cabinet",
            ["&"] = "f_chair",
            ["!"] = "f_table",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_recording_studio_S",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "| ====== |",
            "| %===== |",
            "| ==h!&= |",
            "| ====== |",
            "|:)::::::|",
            "|? Ysssss|",
            "|l   A Es|",
            "|HH   ??s|",
            "||||++||||",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 8, y = 8, chance = 100 },
            { id = "laptop", x = 8, y = 7, chance = 100 },
            { id = "amplifier_head", x = { 5, 6 }, y = 6, chance = 100 },
            { id = "amplifier_head", x = 4, y = 4, chance = 100 },
            { id = "amplifier_head", x = 6, y = 4, chance = 100 },
            { id = "mixer_music", x = { 4, 7 }, y = 6, chance = 80, repetitions = { 1, 4 } },
            { id = "qt_wire", x = 4, y = 6, chance = 20 },
            { id = "guitar_stand", x = 7, y = { 1, 4 }, chance = 70, repetitions = { 1, 4 } },
            { id = "guitar_stand", x = 4, y = 2, chance = 100 },
            { id = "mic_stand_tall", x = 7, y = 4, chance = 100 },
            { id = "mic_stand_tall", x = 2, y = 4, chance = 100 },
            { id = "mic_stand_tall", x = 3, y = 8, chance = 100 },
            { id = "microphone_xlr_generic", x = 7, y = 4, chance = 80 },
            { id = "microphone_xlr_generic", x = 2, y = 4, chance = 80 },
            {
                id = "headphones_circumaural",
                x = { 4, 6 },
                y = 3,
                chance = 80,
                repetitions = { 1, 3 },
            },
            {
                id = "headphones_circumaural",
                x = { 4, 7 },
                y = 6,
                chance = 60,
                repetitions = { 1, 3 },
            },
            { id = "cable_instrument", x = 1, y = { 1, 4 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_instrument", x = 8, y = { 1, 4 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_xlr", x = { 1, 5 }, y = 1, chance = 80, repetitions = { 3, 6 } },
        },
        item_groups = {
            h = { { group = "mussto_stringinst", chance = 100 } },
            ["&"] = { { group = "mussto_stringinst", chance = 100 } },
            ["!"] = { { group = "mussto_windinst", chance = 70 } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            [")"] = "t_door_glass_c",
            ["|"] = "t_wall_b",
            h = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_yellow" },
        },
        furniture = {
            ["%"] = { { id = "f_piano", copies = 10 }, { id = "f_null" } },
            ["?"] = "f_speaker_cabinet",
            ["&"] = "f_chair",
            ["!"] = "f_table",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_recording_studio_E",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "| ====== |",
            "| =%==== |",
            "| ==h!&= |",
            "| ====== |",
            "|::::::):|",
            "|ssssY   +",
            "|sE A  l |",
            "|s?? HHH?|",
            "||||||||||",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 1, y = 8, chance = 100 },
            { id = "laptop", x = 1, y = 7, chance = 100 },
            { id = "amplifier_head", x = { 2, 3 }, y = 6, chance = 100 },
            { id = "amplifier_head", x = 4, y = 4, chance = 100 },
            { id = "amplifier_head", x = 6, y = 4, chance = 100 },
            { id = "mixer_music", x = { 1, 4 }, y = 6, chance = 80, repetitions = { 1, 4 } },
            { id = "guitar_stand", x = 7, y = { 1, 4 }, chance = 70, repetitions = { 1, 4 } },
            { id = "qt_wire", x = 7, y = 1, chance = 20 },
            { id = "guitar_stand", x = 4, y = 2, chance = 100 },
            { id = "mic_stand_tall", x = 7, y = 4, chance = 100 },
            { id = "mic_stand_tall", x = 2, y = 4, chance = 100 },
            { id = "mic_stand_tall", x = 4, y = 8, chance = 100 },
            { id = "microphone_xlr_generic", x = 7, y = 4, chance = 80 },
            { id = "microphone_xlr_generic", x = 2, y = 4, chance = 80 },
            {
                id = "headphones_circumaural",
                x = { 4, 6 },
                y = 3,
                chance = 80,
                repetitions = { 1, 3 },
            },
            {
                id = "headphones_circumaural",
                x = { 1, 4 },
                y = 6,
                chance = 60,
                repetitions = { 1, 3 },
            },
            { id = "cable_instrument", x = 1, y = { 1, 4 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_instrument", x = 8, y = { 1, 4 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_xlr", x = { 1, 5 }, y = 1, chance = 80, repetitions = { 3, 6 } },
        },
        item_groups = {
            h = { { group = "mussto_stringinst", chance = 100 } },
            ["&"] = { { group = "mussto_stringinst", chance = 100 } },
            ["!"] = { { group = "mussto_windinst", chance = 70 } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            [")"] = "t_door_glass_c",
            ["|"] = "t_wall_b",
            h = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = {
            ["%"] = { { id = "f_piano", copies = 10 }, { id = "f_null" } },
            ["?"] = "f_speaker_cabinet",
            ["&"] = "f_chair",
            ["!"] = "f_table",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "room_10x10_recording_studio_W",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "||||||||||",
            "| ====== |",
            "| %===== |",
            "| ==h!&= |",
            "| ====== |",
            "|:)::::::|",
            "+  Ysssss|",
            "|E  A  Es|",
            "|T?HHH ?s|",
            "||||||||||",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 8, y = 8, chance = 100 },
            { id = "laptop", x = 8, y = 7, chance = 100 },
            { id = "amplifier_head", x = { 5, 6 }, y = 6, chance = 100 },
            { id = "amplifier_head", x = 4, y = 4, chance = 100 },
            { id = "amplifier_head", x = 6, y = 4, chance = 100 },
            { id = "mixer_music", x = { 4, 7 }, y = 6, chance = 80, repetitions = { 1, 4 } },
            { id = "qt_wire", x = 5, y = 6, chance = 20 },
            { id = "guitar_stand", x = 7, y = { 1, 4 }, chance = 70, repetitions = { 1, 4 } },
            { id = "guitar_stand", x = 4, y = 2, chance = 100 },
            { id = "mic_stand_tall", x = 7, y = 4, chance = 100 },
            { id = "mic_stand_tall", x = 2, y = 4, chance = 100 },
            { id = "mic_stand_tall", x = 6, y = 8, chance = 100 },
            { id = "microphone_xlr_generic", x = 7, y = 4, chance = 80 },
            { id = "microphone_xlr_generic", x = 2, y = 4, chance = 80 },
            {
                id = "headphones_circumaural",
                x = { 4, 6 },
                y = 3,
                chance = 80,
                repetitions = { 1, 3 },
            },
            {
                id = "headphones_circumaural",
                x = { 4, 7 },
                y = 6,
                chance = 60,
                repetitions = { 1, 3 },
            },
            { id = "cable_instrument", x = 1, y = { 1, 4 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_instrument", x = 8, y = { 1, 4 }, chance = 80, repetitions = { 3, 6 } },
            { id = "cable_xlr", x = { 1, 5 }, y = 1, chance = 80, repetitions = { 3, 6 } },
        },
        item_groups = {
            h = { { group = "mussto_stringinst", chance = 100 } },
            ["&"] = { { group = "mussto_stringinst", chance = 100 } },
            ["!"] = { { group = "mussto_windinst", chance = 70 } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            [")"] = "t_door_glass_c",
            ["|"] = "t_wall_y",
            h = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
            ["&"] = { parameter = "carpet_color_type", fallback = "t_carpet_red" },
        },
        furniture = {
            ["%"] = { { id = "f_piano", copies = 10 }, { id = "f_null" } },
            ["?"] = "f_speaker_cabinet",
            ["&"] = "f_chair",
            ["!"] = "f_table",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_gym_open",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "           ",
            "      $ $  ",
            "     i$ $  ",
            "     i!!!  ",
            "     i$ $  ",
            "      $ $  ",
            "      ===  ",
            "   &  =%=  ",
            " &&&  ===  ",
            "           ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "towel", x = 5, y = { 3, 5 }, chance = 100, repetitions = { 1, 2 } },
            { id = "wheel_wide", x = 1, y = 1, chance = 100 },
            { id = "wheel_wide", x = 2, y = 2, chance = 100 },
            { id = "wheel_wide", x = 1, y = 3, chance = 100 },
            { id = "wheel_wide", x = 2, y = 4, chance = 100 },
            { id = "wheel_wide", x = 1, y = 5, chance = 100 },
            { id = "wheel_wide", x = 2, y = 6, chance = 100 },
            { id = "wheel_wide", x = 1, y = 7, chance = 100 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = { ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" } },
        furniture = {
            ["&"] = "f_barricade_road",
            ["%"] = "f_punching_bag",
            ["!"] = "f_sandbag_wall",
            ["$"] = "f_sandbag_half",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_recroom_open",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            " T=====!== ",
            " x====h=== ",
            " x===ss=== ",
            " !==hssh== ",
            " ====ss=== ",
            " =====h=== ",
            " y======== ",
            " Hll====== ",
            " HHHH=A%== ",
            "           ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 1, y = 3, chance = 100 },
            { id = "deck_of_cards", x = 5, y = 4, chance = 100 },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            x = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            y = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_green" },
        },
        furniture = {
            ["%"] = { { id = "f_punching_bag" }, { id = "f_arcade_machine" }, { id = "f_pinball_machine" } },
            ["!"] = "f_speaker_cabinet",
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_recroom_open",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            " T=====!== ",
            " x====h=== ",
            " x===ss=== ",
            " !==hssh== ",
            " ===hss=== ",
            " =====h=== ",
            " y======== ",
            " Hll====== ",
            " HHHH=A%== ",
            "           ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { id = "stereo", x = 1, y = 3, chance = 100 },
            { id = "dnd_handbook", x = 5, y = 3, chance = 100 },
            {
                id = "novel_fantasy",
                x = { 5, 6 },
                y = { 3, 5 },
                chance = 60,
                repetitions = { 0, 4 },
            },
            {
                id = "character_sheet",
                x = { 5, 6 },
                y = { 3, 5 },
                chance = 80,
                repetitions = { 1, 5 },
            },
            { id = "metal_RPG_die", x = 6, y = 3, chance = 10 },
            { id = "RPG_die", x = { 5, 6 }, y = { 3, 5 }, chance = 90, repetitions = { 1, 4 } },
        },
        palettes = { "standard_domestic_palette", "parametrized_carpets_nest_palette" },
        terrain = {
            x = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["!"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            h = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            s = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            y = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            H = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            A = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            ["%"] = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            l = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
            T = { parameter = "carpet_color_type", fallback = "t_carpet_purple" },
        },
        furniture = {
            ["%"] = { { id = "f_punching_bag" }, { id = "f_arcade_machine" }, { id = "f_pinball_machine" } },
            ["!"] = "f_speaker_cabinet",
        },
    },
}
