local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "afs_aeolian_plain",
    layout = {
        glyph_mappings = {
            ["*"] = {
                terrain = {
                    { id = "t_null", copies = 40 },
                    { id = "t_lichen", copies = 5 },
                    { id = "t_lichendirt", copies = 15 },
                },
                furniture = {
                    { id = "f_shrub_moss", copies = 20 },
                    { id = "f_null", copies = 120 },
                    { id = "f_geo_vent", copies = 1 },
                },
            },
        },
        terrain = {
            ["#"] = "t_ice_wall",
            ["'"] = "t_open_air",
            ["."] = "t_snow",
            o = "t_snow",
            w = "t_water_hot",
            [">"] = "t_snowslope_down",
            ["<"] = "t_snowslope_up",
            [","] = { { id = "t_lichen", copies = 5 }, { id = "t_lichendirt", copies = 5 } },
            s = { { id = "t_lichen", copies = 5 }, { id = "t_lichendirt", copies = 5 } },
            F = { { id = "t_lichen", copies = 5 }, { id = "t_lichendirt", copies = 5 } },
            I = {
                { id = "t_tree_worm", copies = 5 },
                { id = "t_tree_lichen", copies = 5 },
                { id = "t_lichenyum", copies = 5 },
                { id = "t_lichendirt", copies = 5 },
            },
        },
        furniture = {
            s = { { id = "f_shrub_moss", copies = 5 }, { id = "f_null", copies = 5 } },
            F = { { id = "f_geo_vent", copies = 5 }, { id = "f_null", copies = 5 } },
            W = "f_clear",
            o = "f_icebold_large",
            w = "f_clear",
        },
    },
}
