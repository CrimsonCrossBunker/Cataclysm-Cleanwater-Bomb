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
