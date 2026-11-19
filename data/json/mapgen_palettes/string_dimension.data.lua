local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "string_dimension_palette",
    layout = {
        terrain = { ["|"] = "t_string_y", ["-"] = "t_string_x", ["+"] = "t_string_xy", ["."] = "t_string_z" },
    },
}

ccb.content.define_mapgen_palette {
    id = "string_dimension_plane_palette",
    layout = {
        terrain = {
            ["+"] = {
                { id = "t_string_xy_plane_1", copies = 85 },
                { id = "t_string_xy_plane_2", copies = 10 },
                { id = "t_string_xy_plane_3", copies = 5 },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "string_dimension_field_palette",
    layout = {
        terrain = {
            ["1"] = { { id = "t_string_xyz", copies = 85 }, { id = "t_rock_floor_no_roof", copies = 10 } },
            ["2"] = { { id = "t_string_xyz", copies = 50 }, { id = "t_string_void", copies = 50 } },
            ["+"] = {
                { id = "t_rock_floor_no_roof", copies = 90 },
                { id = "t_railroad_rubble", copies = 9 },
                { id = "t_tree_deadpine_warped", copies = 1 },
            },
        },
        furniture = {
            ["+"] = {
                { id = "f_null", copies = 194 },
                { id = "f_boulder_small_volc", copies = 3 },
                { id = "f_boulder_medium_volc", copies = 2 },
                { id = "f_boulder_large_volc", copies = 1 },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "string_dimension_field_vent_palette",
    layout = {
        terrain = {
            ["1"] = {
                { id = "t_string_grass_alien", copies = 99 },
                { id = "t_rock_floor_no_roof", copies = 1 },
            },
            ["2"] = {
                { id = "t_string_grass_alien", copies = 75 },
                { id = "t_rock_floor_no_roof", copies = 50 },
            },
            ["3"] = {
                { id = "t_string_grass_alien", copies = 50 },
                { id = "t_rock_floor_no_roof", copies = 50 },
            },
            [" "] = {
                { id = "t_string_grass_alien", copies = 4 },
                { id = "t_tree_deadpine_warped", copies = 1 },
                { id = "t_rock_floor_no_roof", copies = 95 },
                { id = "t_railroad_rubble", copies = 1 },
            },
            v = "t_open_air",
        },
        furniture = { v = "f_tall_vent_pipe" },
    },
}

ccb.content.define_mapgen_palette {
    id = "string_dimension_small_ziggurat_palette",
    layout = {
        terrain = {
            [" "] = "t_string_xyz",
            ["."] = "t_metal_floor",
            c = "t_metal_floor",
            ["#"] = "t_wall_metal",
            ["-"] = "t_open_air",
            [">"] = "t_slope_down",
            ["<"] = "t_slope_up",
            [","] = "t_string_xyz",
            d = "t_stairs_down",
            u = "t_stairs_up",
            ["1"] = { { id = "t_string_void", copies = 10 }, { id = "t_string_xyz", copies = 90 } },
            ["2"] = { { id = "t_string_void", copies = 66 }, { id = "t_string_xyz", copies = 33 } },
            ["+"] = "t_door_metal_locked",
        },
        furniture = { c = "f_electrical_conduit" },
    },
}

ccb.content.define_mapgen_palette {
    id = "string_dimension_utility_tunnel",
    layout = {
        terrain = {
            [" "] = {
                { id = "t_string_void", copies = 194 },
                { id = "t_string_point_big", copies = 1 },
                { id = "t_string_point_big", copies = 1 },
                { id = "t_string_point_small_gray", copies = 2 },
                { id = "t_string_point_small_gray", copies = 2 },
            },
            ["."] = {
                { id = "t_string_void", copies = 92 },
                { id = "t_strconc_floor_no_roof", copies = 92 },
                { id = "t_string_point_big", copies = 1 },
                { id = "t_string_point_big", copies = 1 },
                { id = "t_string_point_small_gray", copies = 2 },
                { id = "t_string_point_small_gray", copies = 2 },
            },
            [","] = "t_strconc_floor_no_roof",
            I = "t_strconc_floor_no_roof",
            o = {
                { id = "t_string_dimension_strconc_red_light", copies = 1 },
                { id = "t_sewage_pipe", copies = 999 },
            },
            ["|"] = "t_strconc_wall",
            [">"] = "t_ladder_down",
            ["<"] = "t_ladder_up",
        },
        furniture = { I = "f_ground_cable" },
    },
}
