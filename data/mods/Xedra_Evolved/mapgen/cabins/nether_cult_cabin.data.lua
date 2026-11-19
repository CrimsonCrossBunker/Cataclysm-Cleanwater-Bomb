local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "cabin_nether_cult_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "  -5------------------  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -................~.-  ",
            "  -..................-  ",
            "  --------------------  ",
            "  ....................  ",
            "  ....................  ",
            "  ....................  ",
            "  ....................  ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_tar_flat_roof" },
        fill_terrain = "t_tar_flat_roof",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cabin_nether_cult" },
    layout = {
        rows = {
            "...........~~...........",
            "...........~~...........",
            "...%.......~~...........",
            "**######w##++#########**",
            "**#R  d#sT#  #A DBBD #**",
            "**#R  c#  #  #A  BB  w**",
            "**wR   #  =  =       w**",
            "**wR   #  #  #########**",
            "**#R   ####  =  DBBD #**",
            "**#R   L#>A  #A  BB  w**",
            "**####=####  #A      w**",
            "**#ttb  uu#  #########**",
            "**wttb   u#  #a OOO  w**",
            "**wbb     =  =       w**",
            "**#      u#  #     S #**",
            "**#1F5V234#  #a      #**",
            "**###ww####++####ww###**",
            "..o bbbb             o..",
            "..-                  -..",
            "..-                  -..",
            "..o-------o  o-------o..",
            "...........~~...........",
            "...........~~...........",
            "...........~~...........",
        },
        palettes = { "cabin_palette" },
        terrain = { ["-"] = "t_railing", [">"] = "t_wood_stairs_down", w = "t_window_bars_curtains" },
        fill_terrain = "t_floor",
        item_groups = {
            A = {
                { group = "homebooks", chance = 60, repetitions = { 1, 3 } },
                { group = "magazines", chance = 60, repetitions = { 1, 8 } },
                { group = "manuals", chance = 30 },
                { group = "esoteric_books", chance = 25 },
                { group = "hedge_magic_books", chance = 5 },
            },
        },
        loot_placements = { { group = "homeguns", x = 7, y = 9, chance = 30, ammo = 90, magazine = 100 } },
        monster_group_placements = {
            { group = "GROUP_ZOMBIE", x = 11, y = 12 },
            { group = "GROUP_NETHER_CULT", x = { 4, 20 }, y = { 4, 14 }, repetitions = 2 },
        },
    },
}

-- Headless corpse inside a locked room. Spooky!
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_4x4_library_lies",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        item_placements = {
            { id = "book_deduction_lies", x = 3, y = 3, chance = 100 },
            { id = "corpse_painful", x = 3, y = 4, chance = 100 },
        },
        item_group_placements = { { group = "default_zombie_death_drops", x = 3, y = 4, chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cabin_nether_cult_basement" },
    layout = {
        rows = {
            "|||||||||||||||||||||||#",
            "|BBl        LC A+     |#",
            "|t      cd     A----- |#",
            "|---+---------%------ |#",
            "|Ś   j-      - -    - |#",
            "|ȻȻȻsȻ-      + +    - |#",
            "|------      - -    - |#",
            "|  - L-      - -    - |#",
            "|  ?  --------+------ |#",
            "|--- c---<     gSSS-  |#",
            "|  -  ----        S- ||#",
            "|  ?  % +       t S- |##",
            "|---  ---  ctc    L- |##",
            "|  -  ----+---+----- |##",
            "|  ?  -sj- -c   DDL- |##",
            "|------Ȼ + -t     D- |##",
            "||||||----+-----+---+|##",
            "#####|£    s-        |##",
            "#####|£     -        |##",
            "#####|----  -   OO   |##",
            "#####|rrrr  -   OO   |##",
            "#####|      +        |##",
            "#####|rrrr L-        |##",
            "#####|||||||||||||||||##",
        },
        terrain = {
            ["-"] = "t_wall_wood",
            ["|"] = "t_concrete_wall",
            ["<"] = "t_wood_stairs_up",
            ["+"] = { { id = "t_door_c", copies = 2 }, { id = "t_door_o", copies = 1 } },
            ["?"] = "t_door_c_peep",
            ["%"] = "t_door_locked_interior",
            ["#"] = "t_soil",
            A = "t_thconc_floor",
            c = "t_thconc_floor",
            C = "t_thconc_floor",
            ["Ȼ"] = "t_thconc_floor",
            d = "t_thconc_floor",
            D = "t_thconc_floor",
            g = "t_thconc_floor",
            j = "t_thconc_floor",
            l = "t_thconc_floor",
            L = "t_thconc_floor",
            ["£"] = "t_thconc_floor",
            O = "t_thconc_floor",
            r = "t_thconc_floor",
            s = "t_thconc_floor",
            S = "t_thconc_floor",
            ["Ś"] = "t_thconc_floor",
            t = "t_thconc_floor",
            ["Ŧ"] = "t_thconc_floor",
        },
        furniture = {
            A = "f_bookcase",
            B = "f_bed",
            c = "f_chair",
            C = "f_armchair",
            ["Ȼ"] = "f_counter",
            d = "f_desk",
            D = "f_dresser",
            g = "f_trashcan",
            l = "f_foot_locker_aluminum",
            L = "f_floor_lamp",
            ["£"] = "f_locker",
            O = "f_xe_magic_circle",
            r = "f_rack_wood",
            s = "f_sink",
            S = "f_sofa",
            ["Ś"] = "f_shower",
            t = "f_table",
            ["Ŧ"] = "f_table",
        },
        fill_terrain = "t_thconc_floor",
        toilets = { "j" },
        nested = {
            { id = "cabin_nether_cult_basement_4x4_opening_rec_area", x = 15, y = 9 },
            { id = "cabin_nether_cult_basement_6x6_meeting_room", x = 7, y = 3 },
            { id = "cabin_nether_cult_basement_4x4_library", x = 15, y = 3 },
            {
                choices = {
                    { id = "null", weight = 6 },
                    { id = "cabin_nether_cult_basement_4x4_star_vampire_overlay", weight = 1 },
                    { id = "cabin_nether_cult_basement_4x4_huntsman_overlay", weight = 1 },
                },
                x = 8,
                y = 4,
            },
            {
                choices = {
                    { id = "null", weight = 3 },
                    { id = "cabin_nether_cult_basement_4x4_star_vampire_overlay", weight = 1 },
                    { id = "cabin_nether_cult_basement_4x4_huntsman_overlay", weight = 1 },
                },
                x = 7,
                y = 20,
            },
            {
                choices = {
                    { id = "null", weight = 10 },
                    { id = "cabin_nether_cult_basement_2x2_bathroom_overlay", weight = 1000 },
                },
                x = 7,
                y = 13,
            },
        },
        item_groups = {
            A = {
                { group = "homebooks", chance = 75 },
                { group = "esoteric_books", chance = 50 },
                { group = "deduction_books", chance = 25 },
                { group = "hedge_magic_books", chance = 25, repetitions = { 1, 2 } },
                { group = "nether_sorcery_books", chance = 15 },
            },
            ["Ȼ"] = { { group = "SUS_bathroom_cabinet", chance = 50 } },
            D = { { group = "nether_cabin_ritual_prep_clothes", repetitions = { 2, 8 } } },
            g = { { group = "SUS_trash_trashcan" } },
            j = { group = "SUS_toilet", chance = 50 },
            ["£"] = { group = "cleaning", repetitions = { 2, 4 } },
            r = {
                { group = "nether_cabin_ritual_ingredients", repetitions = { 2, 4 } },
                { group = "xe_nether_cult_artifact", chance = 2 },
            },
            s = { group = "SUS_bathroom_sink", chance = 50 },
        },
        item_placements = {
            { id = "book_deduction_black_iron_prison", x = 1, y = 2, chance = 50 },
            { id = "book_nether_sorcery_opening_of_the_way", x = 18, y = 21, chance = 100 },
            { id = "mop", x = 7, y = 17 },
            { id = "candle", chance = 95, x = 16, y = 18 },
            { id = "candle", chance = 95, x = 16, y = 18 },
            { id = "candle", chance = 95, x = 17, y = 18 },
            { id = "candle", chance = 95, x = 15, y = 19 },
            { id = "candle", chance = 95, x = 15, y = 20 },
            { id = "candle", chance = 95, x = 18, y = 19 },
            { id = "candle", chance = 95, x = 18, y = 20 },
            { id = "candle", chance = 95, x = 16, y = 21 },
            { id = "candle", chance = 95, x = 17, y = 21 },
        },
        loot_placements = {
            {
                group = "nether_cabin_ritual_prep_clothes",
                x = { 15, 22 },
                y = { 17, 22 },
                repetitions = { 2, 5 },
            },
        },
        monster_placements = {
            { id = "mon_gracke", x = 1, y = 7, chance = 50 },
            { id = "mon_blank", x = 1, y = 10, chance = 50 },
            { id = "mon_gracke", x = 1, y = 13, chance = 50 },
            { id = "mon_blank", x = 1, y = 1, chance = 90 },
            { id = "mon_star_vampire", x = 8, y = 1, chance = 80 },
            {
                id = "mon_nether_huntsman",
                x = { 17, 18 },
                y = { 20, 21 },
                chance = 100,
                repetitions = 2,
            },
            { group = "GROUP_NETHER_CULT", x = { 13, 20 }, y = { 17, 22 }, repetitions = { 2, 4 } },
            {
                group = "GROUP_NETHER_CULT",
                x = { 13, 20 },
                y = { 17, 22 },
                chance = 75,
                repetitions = { 0, 2 },
            },
        },
        field_placements = {
            { id = "fd_blood", x = { 13, 21 }, y = { 17, 22 }, repetitions = { 22, 44 } },
            { id = "fd_gibs_flesh", x = { 13, 21 }, y = { 17, 22 }, repetitions = { 12, 24 } },
        },
    },
}

-- An overlay with a star vampire with minimal blood.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_4x4_star_vampire_overlay",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "    ",
            "    ",
            "    ",
        },
        rotation = { 0, 0 },
        field_placements = {
            { id = "fd_blood", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 1, 2 } },
            { id = "fd_gibs_flesh", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 4 } },
        },
        monster_placements = { { id = "mon_star_vampire", x = { 0, 3 }, y = { 0, 3 } } },
    },
}

-- An overlay with a nether huntsman with gore.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_4x4_huntsman_overlay",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "    ",
            "    ",
            "    ",
        },
        rotation = { 0, 0 },
        field_placements = {
            { id = "fd_blood", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 6, 12 } },
            { id = "fd_gibs_flesh", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 4 } },
        },
        monster_placements = { { id = "mon_nether_huntsman", x = { 0, 3 }, y = { 0, 3 } } },
    },
}

-- An overlay with a bloody corpse.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_2x2_bathroom_overlay",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "  ",
        },
        rotation = { 0, 0 },
        field_placements = {
            { id = "fd_blood", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 6 } },
            { id = "fd_gibs_flesh", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 4 } },
        },
        item_placements = { { id = "corpse_painful", x = 1, y = 0, chance = 100 } },
        item_group_placements = { { group = "default_zombie_death_drops", x = 1, y = 0, chance = 100 } },
    },
}

-- An overlay with an undead cultist.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_2x2_bathroom_overlay",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "  ",
        },
        rotation = { 0, 0 },
        field_placements = {
            { id = "fd_blood", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 6 } },
            { id = "fd_gibs_flesh", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 4 } },
        },
        monster_placements = { { id = "mon_dementia", x = 1, y = 0, chance = 100 } },
    },
}

-- An overlay with a zombie.
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_2x2_bathroom_overlay",
    weight = 500,
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "  ",
        },
        rotation = { 0, 0 },
        field_placements = {
            { id = "fd_blood", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 6 } },
            { id = "fd_gibs_flesh", x = { 0, 3 }, y = { 0, 3 }, repetitions = { 2, 4 } },
        },
        monster_placements = { { group = "GROUP_ZOMBIE", x = { 0, 3 }, y = { 0, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_4x4_opening_rec_area",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "gSSS",
            "   S",
            " t S",
            "   S",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { g = { { group = "SUS_trash_trashcan" } }, t = { group = "homebooks" } },
        monster_placements = { { group = "GROUP_NETHER_CULT", x = { 0, 3 }, y = { 0, 3 }, chance = 50 } },
        parameters = {
            carpet_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_concrete_yellow", weight = 1 },
                        { id = "t_carpet_concrete_green", weight = 1 },
                        { id = "t_carpet_concrete_purple", weight = 1 },
                        { id = "t_carpet_concrete_red", weight = 1 },
                    },
                },
                scope = "nested",
            },
        },
        terrain = {
            [" "] = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            S = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            g = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            t = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
        },
        furniture = { g = "f_trashcan", S = "f_sofa", t = "f_table" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_4x4_library",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "-----",
            "-CtLA",
            "+   A",
            "-   A",
            "-CtCA",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                x = 0,
                y = 0,
                choices = {
                    { id = "null", weight = 80 },
                    { id = "cabin_nether_cult_basement_4x4_star_vampire_overlay", weight = 10 },
                    { id = "cabin_nether_cult_basement_4x4_huntsman_overlay", weight = 10 },
                    { id = "cabin_nether_cult_basement_4x4_library_lies", weight = 1 },
                },
            },
        },
        item_groups = {
            A = {
                { group = "homebooks", chance = 75 },
                { group = "esoteric_books", chance = 50, repetitions = { 1, 2 } },
                { group = "deduction_books", chance = 10 },
                { group = "hedge_magic_books", chance = 25, repetitions = { 1, 2 } },
            },
        },
        parameters = {
            carpet_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_concrete_yellow", weight = 1 },
                        { id = "t_carpet_concrete_green", weight = 1 },
                        { id = "t_carpet_concrete_purple", weight = 1 },
                        { id = "t_carpet_concrete_red", weight = 1 },
                    },
                },
                scope = "nested",
            },
        },
        terrain = {
            ["-"] = "t_wall_wood",
            ["+"] = { { id = "t_door_c", copies = 2 }, { id = "t_door_o", copies = 1 } },
            [" "] = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            A = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            C = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            L = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            t = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
        },
        furniture = { A = "f_bookcase", C = "f_armchair", L = "f_floor_lamp", t = "f_table" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_6x6_meeting_room",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "------",
            "g cc  ",
            " cttc ",
            " cttc ",
            "L cc  ",
            "------",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = {
            g = { { group = "SUS_trash_trashcan" } },
            t = { group = "nether_cabin_ritual_cult_meeting_room", chance = 50, repetitions = { 2, 5 } },
        },
        monster_placements = { { group = "GROUP_NETHER_CULT", x = { 0, 3 }, y = { 0, 3 }, chance = 25 } },
        parameters = {
            carpet_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_carpet_concrete_yellow", weight = 1 },
                        { id = "t_carpet_concrete_green", weight = 1 },
                        { id = "t_carpet_concrete_purple", weight = 1 },
                        { id = "t_carpet_concrete_red", weight = 1 },
                    },
                },
                scope = "nested",
            },
        },
        terrain = {
            ["-"] = "t_wall_wood",
            [" "] = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            g = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            L = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            t = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
            c = { parameter = "carpet_type", fallback = "t_carpet_concrete_yellow" },
        },
        furniture = { c = "f_chair", g = "f_trashcan", t = "f_table" },
    },
}
