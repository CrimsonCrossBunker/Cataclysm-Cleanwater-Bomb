local ccb = require("ccb")

-- For medieval buildings the Exodii have repurposed.
ccb.content.define_mapgen_palette {
    id = "exodii_stone_palette",
    layout = {
        monster_glyphs = {
            ["1"] = { id = "mon_exodii_turret" },
            ["2"] = { id = "mon_exodii_turret" },
            ["3"] = { id = "mon_exodii_worker" },
            ["5"] = { id = "mon_exodii_worker" },
        },
        item_groups = {
            C = { { group = "SUS_exodii_storage_highvalue", chance = 50 } },
            c = { { group = "SUS_exodii_storage_medvalue", chance = 50 } },
        },
        terrain = {
            [" "] = { { id = "t_region_groundcover", copies = 500 }, { id = "t_region_tree" } },
            ["."] = "t_glassed_sand",
            [","] = { { id = "t_glassed_sand", copies = 3 }, { id = "t_sandmound" }, { id = "t_sand" } },
            [";"] = "t_sand",
            ["#"] = "t_rock_wall",
            _ = "t_dirtfloor",
            ["-"] = "t_dirt",
            ["2"] = "t_dirt",
            ["5"] = "t_dirt",
            ["'"] = "t_junk_floor",
            ["<"] = "t_ladder_up",
            [">"] = "t_ladder_down",
            ["^"] = "t_tile_flat_roof",
            ["|"] = "t_junk_wall",
            M = "t_door_metal_c",
            v = "t_open_air",
            S = "t_sand",
            x = "t_rock_wall_half",
            ["4"] = "t_sand",
        },
        furniture = {
            c = { { id = "f_metal_crate_r" }, { id = "f_metal_crate_c" } },
            C = { { id = "f_metal_crate_r" }, { id = "f_metal_crate_c" } },
            g = "f_capacitor",
            S = "f_exodii_signpost",
            ["{"] = "f_ground_cable",
            ["."] = { { id = "f_null", copies = 2000 }, { id = "f_rubble_rock", copies = 100 } },
            [","] = {
                { id = "f_null", copies = 2000 },
                { id = "f_rubble_rock", copies = 100 },
                { id = "f_boulder_small", copies = 12 },
                { id = "f_boulder_medium" },
            },
        },
    },
}
