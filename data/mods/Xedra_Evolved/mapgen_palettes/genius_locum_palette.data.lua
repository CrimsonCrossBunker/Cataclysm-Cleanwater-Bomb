local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "xe_genius_locum",
    layout = {
        terrain = {
            [" "] = "t_region_groundcover_urban",
            ["."] = "t_rock_floor",
            X = "t_rock_floor",
            b = "t_rock_floor",
            ["1"] = "t_dirt",
            ["4"] = "t_dirt",
            ["-"] = { { id = "t_region_groundcover_urban", copies = 5 }, { id = "t_region_tree_shade" } },
            ["#"] = "t_rock_wall",
        },
        furniture = {
            b = "f_bench",
            h = "f_bench",
            X = "f_elemental_altar",
            ["1"] = "f_brazier",
            ["2"] = "f_topiary_animal",
            ["3"] = "f_topiary_abstract",
            ["4"] = "f_topiary_dragon",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "xe_genius_locum_homullus",
    layout = {
        terrain = {
            ["~"] = {
                { id = "t_metal_floor_no_roof", copies = 2 },
                { id = "t_floor_noroof", copies = 10 },
                { id = "t_pavement", copies = 5 },
            },
            ["|"] = {
                { id = "t_scrap_wall", copies = 10 },
                { id = "t_scrap_wall_halfway", copies = 2 },
                { id = "t_brick_wall", copies = 10 },
                { id = "t_brick_wall_halfway", copies = 2 },
            },
        },
    },
}
