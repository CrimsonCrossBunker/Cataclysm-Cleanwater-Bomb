local ccb = require("ccb")

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q J  ",
            "  JA ",
            "     ",
            "  J  ",
            " AJ  ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q N  ",
            "  NA ",
            "     ",
            "  N  ",
            " AN  ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "q c Y",
            "  ch ",
            "    o",
            "  l  ",
            "ɱhcP ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_5x5_open",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            " Ph  ",
            " ccc ",
            " ccc ",
            "  h  ",
            " k   ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
    },
}

-- A nested map for mutagen research areas.  Science crate loot.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_small_animals_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "surface_sub_f_crate", weight = 50 } },
                x = { 0, 4 },
                y = { 0, 4 },
                repetitions = { 2, 10 },
            },
        },
    },
}

-- A nested map for mutagen research areas.  Small animals for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_small_animal_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "lab_rats_1x1", weight = 50 },
                    { id = "lab_hares_1x1", weight = 50 },
                    { id = "lab_rabbits_1x1", weight = 50 },
                    { id = "lab_black_rats_1x1", weight = 50 },
                    { id = "lab_foxes_1x1", weight = 50 },
                    { id = "lab_racoons_1x1", weight = 50 },
                    { id = "lab_pigeon_1x1", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- A nested map for mutagen research areas.  mid size animals.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medium_animal_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_cats_1x1", weight = 50 }, { id = "lab_dog_1x1", weight = 50 } },
                x = 0,
                y = 0,
            },
        },
    },
}

-- A nested map for mutagen research areas.  mid size animals.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_medium_animal_1x1_MUTANT",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        nested = {
            {
                choices = {
                    { id = "lab_cats_1x1_MUTANT", weight = 50 },
                    { id = "lab_dog_1x1_MUTANT", weight = 50 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- A nested map for mutagen research areas.  Rats for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_black_rats_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_black_rat", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Rats for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_rats_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_lab_rat", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Hares for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_hares_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_hare", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Rabbits for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_rabbits_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_rabbit", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Pigeons for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_pigeon_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_pigeon", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Dogs for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_dog_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_dog", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Dogs for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_dog_1x1_MUTANT",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { group = "GROUP_MUTANT_PET_DOGS", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Cats for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_cats_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_cat", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Mutant cats for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_cats_1x1_MUTANT",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_cat_mutant_prism", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Foxes for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_foxes_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_fox_red", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for mutagen research areas.  Raccoons for cages.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_racoons_1x1",
    layout = {
        size = { width = 1, height = 1 },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_raccoon", x = 0, y = 0, chance = 100 } },
    },
}

-- A nested map for lab mutagen research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 20,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "................",
            "..d.............",
            "...........6....",
            "........d.......",
            "................",
            "................",
            "................",
            "................",
            "....6d.....d....",
            "................",
            "................",
            ".........d......",
            "..............6.",
            "................",
        },
        terrain = {
            ["."] = "t_gelatinous_groundcover",
            ["6"] = "t_gelatinous_groundcover",
            ["|"] = "t_concrete_wall",
            X = "t_laminated_glass",
        },
        furniture = { d = "f_crystalline_flower", ["6"] = "f_fog_breather" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_BREATHER",
                x = { 0, 15 },
                y = { 2, 15 },
                density = 2.5,
                repetitions = 5,
            },
        },
    },
}

-- A nested map for lab mutagen research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 200,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "..........gg....",
            "..d.............",
            "................",
            "........d.......",
            "....g...........",
            ".....g..........",
            "................",
            "................",
            ".....d.....d....",
            "................",
            "......g.........",
            "......g..d......",
            "................",
            "................",
        },
        terrain = {
            g = "t_trunk",
            [";"] = "t_strconc_floor",
            ["|"] = "t_concrete_wall",
            X = "t_laminated_glass",
            ["-"] = "t_reinforced_door_glass_lab_c",
            ["<"] = "t_stairs_up",
            ["."] = {
                { id = "t_grass_tall", copies = 5 },
                { id = "t_grass_dead", copies = 4 },
                { id = "t_stump", copies = 3 },
                { id = "t_trunk", copies = 3 },
                { id = "t_region_tree_dead", copies = 7 },
                { id = "t_grass_long", copies = 5 },
                { id = "t_water_sh", copies = 25 },
                { id = "t_swater_sh", copies = 50 },
                { id = "t_water_dp", copies = 10 },
                { id = "t_moss", copies = 10 },
                { id = "t_mud", copies = 10 },
                { id = "t_underbrush", copies = 3 },
                { id = "t_dirt", copies = 2 },
                { id = "t_shrub" },
            },
        },
        furniture = {
            d = {
                { id = "f_boulder_small", copies = 5 },
                { id = "f_boulder_medium", copies = 4 },
                { id = "f_boulder_large", copies = 3 },
            },
            ["6"] = "f_rubble",
        },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_SWAMP",
                x = { 0, 6 },
                y = { 0, 6 },
                density = 0.1,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- A nested map for lab mutagen research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 200,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "...........g....",
            "..d.............",
            "................",
            "................",
            "....g........g..",
            ".....g.......g..",
            "................",
            "................",
            ".....d..........",
            "................",
            "................",
            ".........d...g..",
            ".d..........g...",
            "................",
        },
        terrain = {
            g = "t_trunk",
            [";"] = "t_strconc_floor",
            ["|"] = "t_concrete_wall",
            X = "t_laminated_glass",
            ["-"] = "t_reinforced_door_glass_lab_c",
            ["<"] = "t_stairs_up",
            ["."] = {
                { id = "t_region_groundcover_forest", copies = 20 },
                { id = "t_region_tree", copies = 2 },
                { id = "t_region_tree_dead" },
                { id = "t_water_sh", copies = 1 },
                { id = "t_region_shrub", copies = 4 },
            },
        },
        furniture = {
            d = {
                { id = "f_boulder_small", copies = 5 },
                { id = "f_boulder_medium", copies = 4 },
                { id = "f_boulder_large", copies = 3 },
                { id = "f_region_weed", copies = 10 },
            },
        },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_FOREST",
                x = { 0, 6 },
                y = { 0, 6 },
                density = 0.1,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- A nested map for lab mutagen research areas. Shoggoth variant
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 50,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "ßßßßßßßßßßßßßßßß",
            "ß..............ß",
            "ß..XXXXXXXXXX..ß",
            "ß..X````````X..ß",
            "ß..X````````X..ß",
            "ß..XXXX--XXXX..ß",
            "ß...-.#``#.-...ß",
            "ß..XXXX--XXXX..ß",
            "ß..X````````X..ß",
            "ß..X````````X..ß",
            "ß..X````````X..ß",
            "ß..XXXXXXXXXX..ß",
            "ß..............ß",
            "ßßßßßßßßßßßßßßßß",
        },
        palettes = { "lab_common_palette" },
        terrain = { ["."] = "t_strconc_floor" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        loot_placements = {
            { id = "meat", x = { 5, 10 }, y = 4, chance = 70 },
            { group = "civilian_phones", x = { 5, 10 }, y = 5, chance = 70 },
            { id = "apple", x = { 5, 10 }, y = 4, chance = 70 },
        },
        monster_placements = { { id = "mon_shoggoth", x = 8, y = 10 } },
    },
}

-- A nested map for lab mutagen research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 50,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "%%XX%%%XX%%%XX%%",
            "................",
            "................",
            "...........##...",
            "...........#....",
            "..##............",
            ".....||+||......",
            "....||...||.....",
            "...||.i.d.||....",
            "...|.......|....",
            ".##|#..nn..+....",
            "...|..F....|..&.",
            "...||....d||....",
            "....||d.d||.....",
            ".....|||||..V...",
        },
        terrain = {
            ["."] = "t_floor_resin",
            i = "t_floor_resin",
            n = "t_floor_resin",
            V = "t_floor_resin",
            ["&"] = "t_floor_resin",
            F = "t_floor_resin",
            d = "t_floor_resin",
            ["%"] = "t_concrete_wall",
            X = "t_laminated_glass",
            ["|"] = "t_wall_resin",
            ["#"] = "t_wall_resin_cage",
            ["+"] = "t_resin_hole_c",
        },
        furniture = {
            i = "f_alien_tendril",
            n = "f_alien_table",
            V = "f_alien_anemone",
            ["&"] = "f_alien_gasper",
            F = "f_alien_zapper",
            d = {
                { id = "f_alien_pod", copies = 2 },
                { id = "f_alien_pod_organ", copies = 2 },
                { id = "f_alien_pod_resin", copies = 1 },
            },
        },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_MI-GO_BASE_COMMON",
                x = { 4, 6 },
                y = { 4, 6 },
                density = 0.1,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- A nested map for lab mutagen research areas.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 200,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "................",
            "~~~~**~~~~~~~~~.",
            "~~**********~~..",
            ".~~**********~~.",
            "~~***********~~.",
            "dddd********dddd",
            "dddd********dddd",
            "..~~*********~~.",
            "~~**********~~..",
            "~***********~~..",
            "~~***********~~.",
            "~~************~~",
            "~~*~~~~******~~~",
            "~~....~~~~~~~~~~",
        },
        terrain = {
            ["~"] = "t_water_sh",
            ["*"] = "t_water_dp",
            ["."] = "t_sand",
            d = "t_dock",
            [";"] = "t_strconc_floor",
            ["|"] = "t_concrete_wall",
            X = "t_laminated_glass",
            ["-"] = "t_reinforced_door_glass_lab_c",
            ["<"] = "t_stairs_up",
        },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_RIVER",
                x = { 0, 6 },
                y = { 0, 6 },
                density = 0.1,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- A nested map for lab mutagen research areas. Zombie shark tank.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 100,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "^^^^^^^^^^^^^^^^",
            "^**************^",
            "^**************^",
            "^**************^",
            "^**************^",
            "^*****^^^^*****^",
            "^^^^^^^**^^^^^^^",
            "^^^^^^^**^^^^^^^",
            "^*****^^^^*****^",
            "^**************^",
            "^**************^",
            "^**************^",
            "^**************^",
            "^^^^^^^^^^^^^^^^",
        },
        terrain = {
            ["*"] = "t_water_pool",
            ["^"] = "t_grate",
            ["|"] = "t_concrete_wall",
            X = "t_laminated_glass",
        },
        rotation = { 0, 3 },
        monster_placements = { { id = "mon_zhark", x = { 1, 14 }, y = { 1, 14 }, chance = 100, pack_size = { 1, 3 } } },
    },
}

-- A nested map for lab mutagen research areas. Incinerated variant
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_16x16_animal_pen",
    weight = 20,
    layout = {
        size = { width = 16, height = 16 },
        rows = {
            "                ",
            "||XX|||XX|||XX||",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
            "................",
        },
        terrain = { ["."] = "t_strconc_floor", ["|"] = "t_concrete_wall", X = "t_laminated_glass" },
        furniture = { ["."] = { { id = "f_ash", copies = 30 }, { id = "f_null", copies = 10 } } },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_16x1_bash", weight = 80 }, { id = "null", weight = 20 } },
                x = 0,
                y = 0,
            },
        },
        monster_group_placements = {
            {
                group = "GROUP_ZOMBIE_SCORCHED",
                x = { 5, 14 },
                y = { 5, 14 },
                density = 0.1,
                repetitions = { 1, 3 },
            },
        },
    },
}

-- 撤销 PR #86581 — 恢复僵尸尸体的实用性
-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_8x8_east",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "X     ] ",
            "X     ) ",
            "X     ] ",
            "-     ]|",
            "-     ] ",
            "X     ) ",
            "X     ] ",
            "X     ] ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_mutagen_5x5_open", weight = 100 }, { id = "null", weight = 0 } },
                x = 1,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 7,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 7,
                y = 2,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 7,
                y = 4,
            },
        },
        sign_placements = {
            { snippet = "lab_safety_snippet", x = 6, y = { 2, 4 } },
            { snippet = "lab_safety_snippet", x = 0, y = { 0, 2 } },
        },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_8x8_west",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " ]     X",
            " )     X",
            " ]     X",
            "|]     -",
            " ]     -",
            " )     X",
            " ]     X",
            " ]     X",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_mutagen_5x5_open", weight = 100 }, { id = "null", weight = 0 } },
                x = 2,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 2,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 4,
            },
        },
        sign_placements = {
            { snippet = "lab_safety_snippet", x = 1, y = 2 },
            { snippet = "lab_safety_snippet", x = 1, y = 4 },
        },
    },
}

-- A nested map for lab mutagen research areas. Center of room design for the 8x6 rooms.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_8x8_east_B",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "X     ] ",
            "X     ) ",
            "X     ] ",
            "-     ]|",
            "-     ] ",
            "X     ) ",
            "        ",
            "        ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_mutagen_5x5_open", weight = 100 }, { id = "null", weight = 0 } },
                x = 1,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 7,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 7,
                y = 2,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 7,
                y = 4,
            },
        },
        sign_placements = {
            { snippet = "lab_safety_snippet", x = 6, y = { 2, 4 } },
            { snippet = "lab_safety_snippet", x = 0, y = { 0, 2 } },
        },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.  Center of room design for the 8x6 rooms.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_8x8_west_B",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " ]     X",
            " )     X",
            " ]     X",
            "|]     -",
            " ]     -",
            " )     X",
            "        ",
            "        ",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_mutagen_5x5_open", weight = 100 }, { id = "null", weight = 0 } },
                x = 2,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 1,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 2,
            },
            {
                choices = { { id = "lab_small_animal_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 4,
            },
        },
        sign_placements = {
            { snippet = "lab_safety_snippet", x = 1, y = 2 },
            { snippet = "lab_safety_snippet", x = 1, y = 4 },
        },
    },
}

-- A nested map for lab mutagen research areas. Center of room design.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_mutagen_8x8_west",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            " ]     X",
            " )     X",
            " ]     X",
            "|]     -",
            " ]     -",
            " )     X",
            " ]     X",
            " ]     X",
        },
        palettes = { "lab_mutagen_palette" },
        rotation = { 0, 3 },
        nested = {
            {
                choices = { { id = "lab_mutagen_5x5_open", weight = 100 }, { id = "null", weight = 0 } },
                x = 2,
                y = 1,
            },
            {
                choices = { { id = "lab_alpha_rat_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 1,
            },
            {
                choices = { { id = "lab_alpha_rat_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 2,
            },
            {
                choices = { { id = "lab_alpha_rat_1x1", weight = 100 }, { id = "null", weight = 0 } },
                x = 0,
                y = 4,
            },
        },
        sign_placements = {
            { snippet = "lab_safety_alpha_snippet", x = 1, y = 2 },
            { snippet = "lab_safety_alpha_snippet", x = 1, y = 4 },
        },
    },
}

-- A nested map bash damage..
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_16x1_bash",
    layout = {
        size = { width = 16, height = 16 },
        tile_edits = { { shape = "point", operation = "bash", x = { 1, 15 }, y = 1 } },
    },
}
