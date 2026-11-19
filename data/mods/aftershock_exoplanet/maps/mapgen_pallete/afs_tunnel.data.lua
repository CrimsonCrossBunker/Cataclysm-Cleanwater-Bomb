local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "afs_tunnel_any",
    layout = {
        palettes = {
            "afs_tunnel",
            {
                weighted = {
                    { id = "afs_tunnel_volcanic", weight = 1 },
                    { id = "afs_tunnel_forested", weight = 1 },
                },
            },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_tunnel",
    layout = {
        terrain = {
            ["#"] = "t_ice_wall",
            ["'"] = "t_open_air",
            ["."] = "t_rock_floor",
            ["0"] = { { id = "t_rock", copies = 5 }, { id = "t_rock_floor_no_roof", copies = 5 } },
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_tunnel_volcanic",
    layout = {
        glyph_mappings = {
            ["*"] = {
                terrain = {
                    { id = "t_null", copies = 40 },
                    { id = "t_basaltfloor", copies = 5 },
                    { id = "t_lichen", copies = 4 },
                    { id = "t_lichendirt", copies = 5 },
                },
                furniture = {
                    { id = "f_basaltspike", copies = 10 },
                    { id = "f_null", copies = 200 },
                    { id = "f_geo_vent", copies = 1 },
                },
            },
        },
        terrain = {
            w = "t_water_hot",
            W = "t_water_hot",
            [","] = {
                { id = "t_basaltfloor", copies = 5 },
                { id = "t_lichen", copies = 1 },
                { id = "t_lichendirt", copies = 1 },
            },
            s = { { id = "t_lichen", copies = 5 }, { id = "t_lichendirt", copies = 5 } },
            I = {
                { id = "t_fumarole", copies = 5 },
                { id = "t_basalt_wall", copies = 5 },
                { id = "t_lichenyum", copies = 1 },
                { id = "t_basaltfloor", copies = 5 },
            },
        },
        furniture = {
            s = { { id = "f_basaltspike", copies = 5 }, { id = "f_null", copies = 5 } },
            F = { { id = "f_geo_vent", copies = 5 }, { id = "f_null", copies = 5 } },
            W = "f_clear",
            w = "f_clear",
        },
    },
}

ccb.content.define_mapgen_palette {
    id = "afs_tunnel_forested",
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
            w = "t_water_hot",
            W = "t_water_hot",
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
            w = "f_clear",
        },
    },
}
