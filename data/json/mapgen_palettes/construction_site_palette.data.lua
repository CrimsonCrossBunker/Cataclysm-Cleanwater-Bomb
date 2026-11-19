local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "construction_site_palette",
    layout = {
        item_groups = {
            T = {
                { group = "power_tools", chance = 10 },
                { group = "tools_construction", chance = 25 },
                { group = "tools_carpentry", chance = 10 },
                { group = "tools_earthworking", chance = 5 },
                { group = "hardware_plumbing", chance = 5 },
                { group = "paint", chance = 3 },
            },
            X = {
                { group = "hardware_bulk", chance = 80, repetitions = { 1, 4 } },
                { group = "plumbing_bulk", chance = 60, repetitions = { 1, 3 } },
            },
            c = {
                { group = "clothing_work_hat", chance = 33 },
                { group = "clothing_work_gloves", chance = 25 },
                { group = "magazines", chance = 3 },
                { group = "misc_smoking", chance = 10 },
            },
            ["{"] = { group = "SUS_trash_hardware", chance = 66, repetitions = { 1, 4 } },
        },
        parameters = {
            wall_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_concrete", weight = 12 },
                        { id = "t_pit_shallow", weight = 3 },
                        { id = "t_pit", weight = 2 },
                        { id = "t_brick_wall_halfway", weight = 10 },
                        { id = "t_brick_wall", weight = 5 },
                        { id = "t_adobe_brick_wall_halfway", weight = 4 },
                        { id = "t_adobe_brick_wall", weight = 2 },
                        { id = "t_wall_half", weight = 8 },
                        { id = "t_wall", weight = 4 },
                        { id = "t_reb_cage", weight = 4 },
                        { id = "t_concrete_wall", weight = 2 },
                    },
                },
            },
            lawn_type = {
                value_type = "terrain",
                default = {
                    weighted = {
                        { id = "t_region_soil", weight = 5 },
                        { id = "t_region_groundcover", weight = 3 },
                    },
                },
            },
            ["block-or-not"] = {
                value_type = "furniture",
                default = {
                    weighted = { { id = "f_barricade_road", weight = 1 }, { id = "f_null", weight = 1 } },
                },
            },
        },
        terrain = {
            [" "] = { parameter = "lawn_type", fallback = "t_region_soil" },
            ["|"] = { parameter = "wall_type", fallback = "t_brick_wall_halfway" },
            ["-"] = {
                select = { parameter = "lawn_type", fallback = "t_region_soil" },
                cases = { t_region_soil = "t_region_soil", t_region_groundcover = "t_region_groundcover" },
            },
            ["."] = {
                select = { parameter = "wall_type", fallback = "t_brick_wall_halfway" },
                cases = {
                    t_concrete = "t_concrete",
                    t_pit_shallow = "t_region_soil",
                    t_pit = "t_pit_shallow",
                    t_brick_wall_halfway = "t_concrete",
                    t_brick_wall = "t_concrete",
                    t_adobe_brick_wall_halfway = "t_concrete",
                    t_adobe_brick_wall = "t_concrete",
                    t_wall_half = "t_concrete",
                    t_wall = "t_concrete",
                    t_reb_cage = "t_concrete",
                    t_concrete_wall = "t_concrete",
                },
            },
            ["#"] = {
                select = { parameter = "wall_type", fallback = "t_brick_wall_halfway" },
                cases = {
                    t_concrete = "t_concrete",
                    t_pit_shallow = "t_pit_shallow",
                    t_pit = "t_pit",
                    t_brick_wall_halfway = "t_brick_wall_halfway",
                    t_brick_wall = "t_brick_wall_halfway",
                    t_adobe_brick_wall_halfway = "t_adobe_brick_wall_halfway",
                    t_adobe_brick_wall = "t_adobe_brick_wall_halfway",
                    t_wall_half = "t_wall_half",
                    t_wall = "t_wall_half",
                    t_reb_cage = "t_reb_cage",
                    t_concrete_wall = "t_reb_cage",
                },
            },
            s = "t_sandmound",
            ["@"] = "t_dirtmound",
        },
        furniture = {
            X = { { id = "f_crate_c", copies = 2 }, { id = "f_crate_o" }, { id = "f_cardboard_box" } },
            ["-"] = { parameter = "block-or-not", fallback = "f_null" },
            T = "f_tourist_table",
            c = "f_camp_chair",
            ["{"] = "f_dumpster",
            ["1"] = "f_pallet_cement",
            ["2"] = {
                select = { parameter = "wall_type", fallback = "t_brick_wall_halfway" },
                cases = {
                    t_concrete = "f_pallet_brick",
                    t_pit_shallow = "f_pallet_cement",
                    t_pit = "f_pallet_cement",
                    t_brick_wall_halfway = "f_pallet_brick",
                    t_brick_wall = "f_pallet_brick",
                    t_adobe_brick_wall_halfway = "f_pallet_brick_adobe",
                    t_adobe_brick_wall = "f_pallet_brick_adobe",
                    t_wall_half = "f_stack_plank",
                    t_wall = "f_stack_plank",
                    t_reb_cage = "f_pallet_cement",
                    t_concrete_wall = "f_pallet_cement",
                },
            },
        },
    },
}
