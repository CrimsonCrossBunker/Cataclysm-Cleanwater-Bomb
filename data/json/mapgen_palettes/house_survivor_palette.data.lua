local ccb = require("ccb")

-- Intended as a palette for non-nested survivor houses.  Barricades doors and windows, replaces glass walls with sandbags, adds traps to doormat tiles, changes item groups to survivor variants, clutters floor with empty cans.
-- Symbols still open for use: 0 ! $ % & _ = ~ ? / , ` and some symbols that conflict with json (like brackets).
ccb.content.define_mapgen_palette {
    id = "house_survivor_palette",
    layout = {
        nested_glyphs = {
            ["¶"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 50 }, { id = "null", weight = 50 } },
            },
            [":"] = {
                choices = { { id = "destroyed_glass_door_wall", weight = 50 }, { id = "null", weight = 50 } },
            },
        },
        clear_glyphs = { f = {}, m = {}, F = {}, ["6"] = {} },
        item_groups = {
            ["6"] = {
                { group = "SUS_pantry", chance = 12 },
                { group = "cannedfood", chance = 10, repetitions = { 1, 2 } },
            },
            F = { group = "SUS_fridge_survivor", chance = 60 },
            J = { { group = "cannedfood", chance = 50, repetitions = { 1, 2 } } },
            f = {
                { group = "groce_condiment", chance = 10, repetitions = { 1, 2 } },
                { group = "dining", chance = 10 },
                { group = "cannedfood", chance = 20, repetitions = { 1, 2 } },
            },
            m = { group = "SUS_fridge_survivor", chance = 48 },
        },
        glyph_mappings = {
            ["÷"] = {
                traps = {
                    { id = "tr_nailboard", copies = 3 },
                    { id = "tr_tripwire", copies = 3 },
                    { id = "tr_bubblewrap", copies = 2 },
                    { id = "tr_beartrap", copies = 2 },
                    { id = "tr_shotgun_2", copies = 1 },
                    { id = "tr_shotgun_2_1", copies = 1 },
                    { id = "tr_shotgun_1", copies = 1 },
                    { id = "tr_null", copies = 4 },
                },
            },
            [" "] = {
                item_spawns = {
                    { id = "can_food", chance = 4 },
                    { id = "can_medium", chance = 1 },
                    { id = "can_food_big", chance = 1 },
                    { id = "jar_glass_sealed", chance = 1 },
                    { id = "jar_3l_glass_sealed", chance = 1 },
                    { id = "can_drink", chance = 1 },
                    { id = "bottle_glass", chance = 1 },
                    { id = "bottle_plastic", chance = 1 },
                },
            },
        },
        palettes = { "standard_domestic_palette" },
        furniture = {
            f = "f_table",
            m = "f_glass_fridge",
            F = "f_fridge",
            ["6"] = "f_rack_wood",
            [":"] = "f_sandbag_wall",
            ["¶"] = "f_sandbag_wall",
        },
        terrain = {
            ["+"] = {
                { id = "t_door_c", copies = 3 },
                { id = "t_door_o", copies = 3 },
                { id = "t_door_b", copies = 1 },
                { id = "t_door_frame", copies = 1 },
                { id = "t_door_boarded" },
            },
            ["*"] = {
                { id = "t_door_boarded", copies = 5 },
                { id = "t_rdoor_boarded", copies = 2 },
                { id = "t_rdoor_b" },
                { id = "t_door_b" },
                { id = "t_door_frame" },
            },
            o = {
                { id = "t_window_boarded", copies = 7 },
                { id = "t_window_boarded_noglass", copies = 5 },
                { id = "t_window_reinforced", copies = 3 },
                { id = "t_window_reinforced_noglass", copies = 2 },
                { id = "t_window_frame" },
                { id = "t_window_empty" },
            },
        },
    },
}
