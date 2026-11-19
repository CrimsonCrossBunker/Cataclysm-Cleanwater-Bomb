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
