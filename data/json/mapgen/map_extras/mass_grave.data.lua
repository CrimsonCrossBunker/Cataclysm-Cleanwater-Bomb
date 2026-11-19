local ccb = require("ccb")

-- This is the 'base' mass grave, and doesn't actually contain anything. Variants are generated via the place_nested field.
ccb.content.define_mapgen {
    kind = "update",
    id = "mx_mass_grave",
    layout = {
        nested = {
            {
                choices = {
                    { id = "mass_grave_abandoned", weight = 30 },
                    { id = "mass_grave_partial", weight = 20 },
                    { id = "mass_grave_finished", weight = 10 },
                },
                x = 0,
                y = 0,
            },
        },
    },
}

-- Variant 2 - wasn't finished being buried, but cleanup was mostly packed up. some remnants of conflict
ccb.content.define_mapgen {
    kind = "nested",
    id = "mass_grave_partial",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "   ##  ##  aa  #a  aa   ",
            "   ##  ##  aa  aa  aa   ",
            "   ##  ##  aa  aa  aa   ",
            "   ##  ##  aa  aa  ##   ",
            "   ##  ##  #a  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ## X ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  aa  ##   ",
            "   ##  ##  ##  a#  ##   ",
            "   ##  ##  ##  a#  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "                        ",
        },
        terrain = { a = { { id = "t_pit_corpsed" } }, ["#"] = { { id = "t_dirt" } } },
        furniture = { X = { { id = "f_null", copies = 3 }, { id = "f_battlefield_cross", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            {
                group = "mass_grave_casings",
                repetitions = { 10, 15 },
                x = { 2, 22 },
                y = { 18, 23 },
            },
            { group = "SUS_trash_floor", repetitions = { 5, 6 }, x = { 1, 23 }, y = { 18, 23 } },
        },
        monster_group_placements = {
            { group = "GROUP_MASS_GRAVE", density = 0.5, x = { 1, 22 }, y = { 1, 22 } },
            { group = "GROUP_SCHOOL", chance = 35, density = 0.5, x = { 1, 22 }, y = { 1, 22 } },
        },
        monster_glyphs = { a = { id = "mon_zombie_scorched", chance = 1 } },
    },
}

-- Variant 2 - buried and left. some zombie stragglers have clawed up. these trenches are shallow by time constraints, so they aren't completely smothered
-- casings all around the site hint at soldiers shooting zombies that started to reanimate by now that weren't damaged enough
-- lotta scorched zombies here - we're presuming that the military set fire to the trenches before burying them
ccb.content.define_mapgen {
    kind = "nested",
    id = "mass_grave_finished",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##  X",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ## X ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##  X",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ## X ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##  X",
            "   ##  ##  ##  ##  ##   ",
            "   ##  ##  ##  ##  ##   ",
            "                        ",
        },
        terrain = { ["#"] = { { id = "t_dirt", copies = 24 }, { id = "t_pit_shallow", copies = 1 } } },
        furniture = { X = { { id = "f_null", copies = 19 }, { id = "f_battlefield_cross", copies = 1 } } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { group = "mass_grave_casings", repetitions = { 20, 30 }, x = { 1, 23 }, y = { 1, 17 } },
            {
                group = "mass_grave_casings",
                repetitions = { 10, 15 },
                x = { 1, 23 },
                y = { 18, 23 },
            },
            { group = "SUS_trash_floor", repetitions = { 1, 3 }, x = { 1, 23 }, y = { 18, 23 } },
        },
        monster_group_placements = { { group = "GROUP_MASS_GRAVE", density = 0.1, x = { 1, 22 }, y = { 1, 22 } } },
        monster_glyphs = { ["#"] = { id = "mon_zombie_scorched", chance = 1 } },
    },
}

-- Variant 1 - overrun early. lots of zombies, still remnants of the cleanup
ccb.content.define_mapgen {
    kind = "nested",
    id = "mass_grave_abandoned",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "   ##  aa  ##  O#X OO   ",
            "   #a  aa  ## XOOX OO   ",
            "   aa  aa  #a XOO  OO   ",
            "   aa  aa  aa XOOX OO   ",
            "   aa  aa  aa  OOX OO   ",
            "   aa  aa  aa  aaX OO   ",
            "   aa  aa  aa  aaX OO   ",
            "   aa  aa  aa  aaX OO   ",
            "   aa  aa  aa  aa  OO   ",
            "   aa  aa  aa  a#  OO   ",
            "   aa  aa  aa  ##  OO   ",
            "   aa  aa  aa  ##  OO   ",
            "   aa  aa  aa X#a  OO   ",
            "n  aa  aa  aa Xaa  OO   ",
            "n  aa  aa  aa Xaa  OO   ",
            "n  aa  aa  aa Xaa  OO   ",
            "   aa  aa  aa  a#  OO   ",
            "                        ",
            " |||||||#               ",
            " |nnnn#D##n             ",
            " |#####D#cn             ",
            " |cB#B#D#nn             ",
            " |||||||##              ",
        },
        terrain = {
            a = { { id = "t_pit_corpsed" } },
            O = { { id = "t_pit_shallow" } },
            ["#"] = { { id = "t_dirt" } },
            X = { { id = "t_dirt" } },
        },
        furniture = {
            ["|"] = "f_large_canvas_wall",
            D = "f_large_canvas_door_o",
            n = "f_tourist_table",
            B = "f_makeshift_bed",
            c = "f_camp_chair",
            X = "f_plastic_groundsheet",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        loot_placements = {
            { group = "corpse_in_body_bag", x = 14, y = { 2, 18 }, repetitions = { 5, 20 } },
            { group = "corpse_in_body_bag", x = 17, y = { 2, 18 }, repetitions = { 5, 20 } },
            { group = "everyday_corpse", x = 14, y = { 2, 18 }, repetitions = { 0, 4 } },
            { group = "everyday_corpse", x = 17, y = { 2, 18 }, repetitions = { 0, 4 } },
            {
                group = "mass_grave_casings",
                repetitions = { 10, 15 },
                x = { 2, 22 },
                y = { 18, 23 },
            },
            { group = "guns_launcher_flame", chance = 40, x = { 2, 5 }, y = 20 },
            { id = "stanag30", repetitions = { 0, 2 }, x = { 2, 22 }, y = { 18, 23 } },
            { id = "mask_gas", chance = 50, repetitions = { 0, 3 }, x = { 2, 5 }, y = 20 },
            { id = "military_papr_mask", chance = 50, repetitions = { 0, 3 }, x = { 2, 5 }, y = 20 },
            {
                id = "military_papr_blower_off",
                chance = 50,
                repetitions = { 0, 3 },
                x = { 2, 5 },
                y = 20,
            },
            { id = "oxygen_tank", repetitions = { 1, 6 }, x = 10, y = { 20, 22 } },
            { id = "gasfilter_med", repetitions = { 1, 4 }, x = 10, y = { 20, 22 } },
        },
        monster_group_placements = {
            { group = "GROUP_MASS_GRAVE", density = 1, x = { 1, 22 }, y = { 1, 22 } },
            { group = "GROUP_SCHOOL", chance = 35, density = 1, x = { 1, 22 }, y = { 1, 22 } },
            { group = "GROUP_MIL_MASS_GRAVE", density = 0.25, x = { 1, 22 }, y = { 1, 22 } },
        },
        field_placements = {
            { id = "fd_blood", x = { 2, 22 }, y = { 18, 23 }, repetitions = { 8, 12 } },
            { id = "fd_gibs_flesh", x = { 2, 22 }, y = { 18, 23 }, repetitions = { 1, 5 } },
            { id = "fd_blood", x = { 2, 22 }, y = { 18, 23 }, repetitions = { 4, 8 } },
        },
        vehicle_placements = {
            { id = "military_cargo_trucks", x = { 16, 17 }, y = { 19, 20 }, chance = 25 },
            { id = "trencher", x = { 19, 22 }, y = { 3, 13 }, chance = 40, rotation = { 90, 270 } },
        },
    },
}
