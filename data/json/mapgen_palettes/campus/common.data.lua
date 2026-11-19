local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "campus_common",
    layout = {
        terrain = {
            [","] = "t_floor",
            ["|"] = "t_brick_wall",
            ["#"] = "t_wall_w",
            R = "t_flat_roof",
            ["."] = "t_region_groundcover_urban",
            _ = "t_concrete",
            ["'"] = "t_pavement",
            [":"] = "t_wall_glass",
            ["%"] = "t_door_glass_c",
            ["0"] = "t_door_locked_interior",
            b = "t_rock_wall_half",
            ["`"] = "t_pavement_y",
            ["?"] = {
                { id = "t_region_shrub" },
                { id = "t_region_shrub_fruit" },
                { id = "t_region_shrub_decorative" },
            },
            ["["] = {
                { id = "t_region_tree_fruit", copies = 2 },
                { id = "t_region_tree_nut", copies = 2 },
                { id = "t_region_tree_shade" },
            },
            [">"] = "t_stairs_down",
            ["<"] = "t_stairs_up",
            E = "t_elevator",
        },
        furniture = {},
    },
}
