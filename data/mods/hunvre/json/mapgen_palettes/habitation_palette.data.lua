local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "micro_apartment_palette_shower",
    layout = { furniture = { ["1"] = "f_shower_retractable", ["2"] = "f_null" } },
}

ccb.content.define_mapgen_palette {
    id = "micro_apartment_palette_bed",
    layout = { furniture = { ["1"] = "f_bed_retractable", ["2"] = "f_bed" } },
}

ccb.content.define_mapgen_palette {
    id = "micro_apartment_palette_null",
    layout = { furniture = { ["1"] = "f_null", ["2"] = "f_null" } },
}

ccb.content.define_mapgen_palette {
    id = "base",
    layout = {
        item_groups = {
            ["3"] = {
                { group = "locker_gym", chance = 50, repetitions = 3 },
                { group = "oneirosis_countermeasures", chance = 5 },
            },
            L = { { group = "locker_gym", chance = 50, repetitions = 3 } },
        },
        terrain = {
            ["#"] = "t_concrete_wall",
            ["3"] = "t_floor_container",
            ["+"] = "t_door_c",
            ["."] = "t_concrete_light",
            ["$"] = "t_wall_control",
            ["%"] = "t_ret_furn_target",
            i = "t_metal_railing",
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
            ["0"] = "t_open_air",
            ["-"] = "t_door_metal_c",
        },
        furniture = {
            ["4"] = "f_dumpster",
            T = "f_table",
            ["="] = "f_utility_shelf",
            h = "f_chair",
            c = "f_counter",
        },
    },
}
