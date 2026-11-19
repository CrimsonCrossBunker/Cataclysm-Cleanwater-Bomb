local ccb = require("ccb")

-- Top level 'lab_spawn_XXXXX' templates are for use in floorplans.
-- Spawn for a room at least 7x7, walls often but not guaranteed.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_spawn_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = {
            {
                choices = { { id = "lab_room_7x7", weight = 97 }, { id = "lab_room_7x7_rare", weight = 3 } },
                x = 0,
                y = 0,
            },
            { id = "lab_maybe_effects_7x7", x = 0, y = 0 },
        },
    },
}

-- Spawn for a room exactly 7x7 with doors only in the center of each wall.
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_spawn_7x7_crossdoors",
    layout = {
        size = { width = 9, height = 9 },
        nested = {
            {
                choices = {
                    { id = "lab_room_7x7", weight = 33 },
                    { id = "lab_room_7x7_crossdoors", weight = 63 },
                    { id = "lab_room_7x7_rare", weight = 3 },
                },
                x = 0,
                y = 0,
            },
            { id = "lab_maybe_effects_7x7", x = 0, y = 0 },
        },
    },
}

-- Places a crate, 25% chance of being pre-opened.
ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_f_crate",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "X",
        },
        palettes = { "lab_palette", "lab_loot_research" },
        furniture = {
            X = {
                { id = "f_crate_c" },
                { id = "f_crate_c" },
                { id = "f_crate_c" },
                { id = "f_crate_o" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_t_machinery",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "A",
        },
        furniture = {
            A = {
                { id = "f_machinery_heavy" },
                { id = "f_machinery_heavy" },
                { id = "f_machinery_electronic" },
                { id = "f_machinery_light" },
                { id = "f_centrifuge" },
                { id = "f_console_broken" },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_maybe_effects_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = {
            {
                choices = { { id = "null", weight = 98 }, { id = "lab_add_spiders_7x7", weight = 2 } },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "glass_monster_cage",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "ggggg",
            "g,STg",
            "g,,,g",
            "g,,,g",
            "ggGgg",
        },
        palettes = { "lab_palette" },
        terrain = { [","] = "t_floor_blue" },
        rotation = { 0, 3 },
        monster_placements = {
            {
                choices = {
                    "mon_zombie_brute",
                    "mon_zombie_screecher",
                    "mon_zombie_hollow",
                    "mon_zombie_master",
                    "mon_zombie_necro",
                },
                x = { 2, 3 },
                y = { 1, 3 },
                chance = 80,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "glass_monster_cage",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "ggggg",
            "g,,,g",
            "g,,,G",
            "g,,,g",
            "ggggg",
        },
        palettes = { "lab_palette" },
        terrain = { [","] = "t_floor_blue" },
        rotation = { 0, 3 },
        monster_placements = {
            {
                choices = { "mon_zombie_pig", "mon_zombear", "mon_zoose", "mon_zolf", "mon_zombie_dog" },
                x = { 1, 3 },
                y = { 1, 3 },
                chance = 80,
            },
        },
    },
}

-- big ash pile (shovel-needed) with a chance of science gear
ccb.content.define_mapgen {
    kind = "nested",
    id = "sub_f_ash",
    layout = {
        size = { width = 1, height = 1 },
        rows = {
            "a",
        },
        furniture = { a = "f_ash" },
        item_spawns = {
            a = {
                { id = "ash", amount = 4, chance = 100 },
                { id = "bone_human", amount = { 3, 5 }, chance = 50 },
            },
        },
        item_groups = { a = { group = "science", chance = 10 } },
    },
}

-- 7x7 bulk chemical storage
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_rare",
    layout = {
        size = { width = 7, height = 7 },
        nested = { { id = "lab_filltank_chem", x = 3, y = 3 } },
        furniture_placements = { { id = "f_standing_tank", x = 3, y = 3 } },
    },
}

-- 7x7 glass monster cage
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_rare",
    layout = {
        size = { width = 7, height = 7 },
        nested = { { id = "glass_monster_cage", x = 1, y = 1 } },
    },
}

-- 7x7 spider overlay
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_add_spiders_7x7",
    layout = {
        size = { width = 7, height = 7 },
        monster_group_placements = { { group = "GROUP_SPIDER", x = { 0, 6 }, y = { 0, 6 }, density = 0.1 } },
        field_placements = { { id = "fd_web", x = { 0, 6 }, y = { 0, 6 }, repetitions = 40 } },
    },
}

-- 7x7 cyborg & dissector
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            "ccccccc",
            ".......",
            ".......",
            ".......",
            ".......",
            ".......",
        },
        palettes = { "lab_palette", "lab_loot_research" },
        rotation = { 0, 3 },
        trap_placements = { { id = "tr_dissector", x = { 1, 5 }, y = { 2, 5 } } },
        monster_placements = { { id = "mon_broken_cyborg", x = { 0, 6 }, y = { 0, 6 }, chance = 33 } },
    },
}

-- 7x7 teleporter room
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = { { id = "lab_telepad_counter_2x2", x = { 2, 3 }, y = { 2, 3 } } },
        trap_placements = { { id = "tr_telepad", x = { 1, 5 }, y = { 1, 5 } } },
    },
}

-- 2x2 counter with teleporter loot on it
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_telepad_counter_2x2",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "cc",
            "cc",
        },
        palettes = { "lab_palette" },
        glyph_mappings = { c = { item_groups = { { group = "teleport", chance = 20 } } } },
    },
}

-- 7x7 desks
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_crossdoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "ccc.ccc",
            ".h...h.",
            "...c...",
            "..hx...",
            "...c...",
            ".h...h.",
            "ccc.ccc",
        },
        palettes = { "lab_palette" },
        rotation = { 0, 3 },
        glyph_mappings = {
            c = {
                item_groups = {
                    { group = "SUS_office_desk", chance = 30 },
                    { group = "SUS_science_personal_effects", chance = 10 },
                    { group = "textbooks", chance = 3 },
                    { group = "science", chance = 3 },
                },
            },
            h = { item_spawns = { { id = "coat_lab", chance = 10 } } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_filltank_chem",
    layout = {
        size = { width = 1, height = 1 },
        liquid_placements = { { amount = { 200, 800 }, x = 0, y = 0, id = "bleach" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_filltank_chem",
    layout = {
        size = { width = 1, height = 1 },
        liquid_placements = { { amount = { 100, 400 }, x = 0, y = 0, id = "water_clean" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_filltank_chem",
    layout = {
        size = { width = 1, height = 1 },
        liquid_placements = { { amount = { 100, 400 }, x = 0, y = 0, id = "salt_water" } },
    },
}

-- 7x7 chem_storage
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_crossdoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "c.c.c.c",
            "c.c.c.c",
            "c.c.c.c",
            ".......",
            "c.c.c.c",
            "c.c.c.c",
            "c.c.c.c",
        },
        palettes = { "lab_palette", "lab_loot_research" },
        rotation = { 0, 3 },
    },
}

-- 7x7 chem_storage
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_crossdoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            ".c.c.c.",
            ".c.c.c.",
            ".c.c.c.",
            ".c.c.c.",
            ".c.c.c.",
            ".......",
        },
        palettes = { "lab_palette", "lab_loot_research" },
        rotation = { 0, 3 },
    },
}

-- 7x7 hydroponics
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            ".c~~~~.",
            ".c.....",
            ".c~~~~.",
            ".c.....",
            ".c~~~~.",
            ".......",
        },
        palettes = { "lab_palette" },
        terrain = { ["~"] = { { id = "t_water_sh" } } },
        rotation = { 0, 3 },
        glyph_mappings = {
            c = { item_groups = { { group = "chem_lab", chance = 10 } } },
            ["~"] = { item_groups = { { group = "hydro", chance = 20 } } },
        },
    },
}

-- 7x7 chem_storage and office
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            ".ccccc.",
            ".c.....",
            ".c...d.",
            ".c..hd.",
            ".c..xd.",
            ".......",
        },
        palettes = { "lab_palette", "lab_loot_research" },
        rotation = { 0, 3 },
    },
}

-- 7x7 u-conference room
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            "..hhhh.",
            "..tttt.",
            "..t....",
            "..tttt.",
            "..hhhh.",
            "x......",
        },
        palettes = { "lab_palette" },
        rotation = { 0, 3 },
        glyph_mappings = { t = { item_groups = { { group = "SUS_office_desk", chance = 15 } } } },
    },
}

-- 7x7 security desk
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            "..d....",
            "..d....",
            "..ch...",
            "..ccdd.",
            ".......",
            ".x.....",
        },
        palettes = { "lab_palette", "lab_loot_home_office" },
        rotation = { 0, 3 },
        glyph_mappings = { c = { item_groups = { { group = "museum_security", chance = 66 } } } },
    },
}

-- 7x7 crate room
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = { { id = "sub_f_crate", x = { 0, 6 }, y = { 0, 6 }, repetitions = 10 } },
    },
}

-- 7x7 machine room
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        nested = {
            { id = "sub_t_machinery", x = { 0, 6 }, y = { 0, 6 }, repetitions = 10 },
            {
                choices = { "sub_t_machinery", "sub_f_crate" },
                x = { 0, 6 },
                y = { 0, 6 },
                repetitions = 5,
            },
        },
    },
}

-- 7x7 bathrooms
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_crossdoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "Tl|.|Tl",
            "S.|.|.S",
            "-W-.-W-",
            ".......",
            "-W-.-W-",
            "S.|.|.S",
            "lT|.|Tl",
        },
        palettes = { "lab_palette" },
        rotation = { 0, 3 },
        glyph_mappings = {
            l = { item_groups = { { group = "cleaning", chance = 60, repetitions = 2 } } },
            S = {
                item_groups = {
                    { group = "drugs_heal_simple", chance = 10 },
                    { group = "harddrugs", chance = 5 },
                },
            },
        },
    },
}

-- 7x7 vr mat, using safety glasses to suggest vr goggles
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ".......",
            ".,,,,,.",
            ".,,,,,.",
            ".,,,,,.",
            ".,,,,,.",
            ".,,,,x.",
            ".......",
        },
        palettes = { "lab_palette" },
        terrain = { [","] = "t_floor_green" },
        rotation = { 0, 3 },
        glyph_mappings = { [","] = { item_spawns = { { id = "ar_glasses_advanced", chance = 4 } } } },
    },
}

-- 7x7 barracks
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "s.....s",
            "bb...bb",
            ".......",
            ".......",
            ".......",
            "bb...bb",
            "s.....s",
        },
        palettes = { "lab_palette", "lab_loot_home_office" },
        rotation = { 0, 3 },
    },
}

-- 7x7 kennel
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_crossdoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            ",,=.=,,",
            ",,=.=,,",
            "=^=.=^=",
            ".......",
            "=^=....",
            ",,=..hl",
            ",,=.ccx",
        },
        palettes = { "lab_palette", "lab_loot_home_office" },
        terrain = {
            ["="] = "t_chainfence",
            ["^"] = { { id = "t_chaingate_c", copies = 3 }, { id = "t_chaingate_o", copies = 1 } },
        },
        rotation = { 0, 3 },
        monster_placements = {
            {
                id = "mon_zombie_dog",
                x = { 0, 1 },
                y = { 0, 1 },
                chance = 50,
                pack_size = { 1, 2 },
                one_or_none = true,
            },
            {
                id = "mon_zombie_dog",
                x = { 0, 1 },
                y = { 5, 6 },
                chance = 50,
                pack_size = { 1, 2 },
                one_or_none = true,
            },
            {
                id = "mon_zombie_dog",
                x = { 5, 6 },
                y = { 0, 1 },
                chance = 50,
                pack_size = { 1, 2 },
                one_or_none = true,
            },
        },
        glyph_mappings = { l = { item_groups = { { group = "vet_softdrug", chance = 80, repetitions = 2 } } } },
    },
}

-- incinerated room - using crossdoors to ensure no extra space in the room not covered in ash
ccb.content.define_mapgen {
    kind = "nested",
    id = "lab_room_7x7_crossdoors",
    layout = {
        size = { width = 7, height = 7 },
        rows = {
            "aaaaaaa",
            "aaaaaaa",
            "aaaaaaa",
            "aaaaaaa",
            "aaaaaaa",
            "aaaaaaa",
            "aaaaaaa",
        },
        terrain = { a = "t_thconc_floor" },
        nested = { { id = "sub_f_ash", x = { 0, 6 }, y = { 0, 6 }, repetitions = { 2, 4 } } },
        item_spawns = { a = { id = "ash", chance = 90 } },
    },
}
