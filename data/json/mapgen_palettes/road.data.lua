local ccb = require("ccb")

-- mapgendata::first_predecessor doesn't work perfectly so use 9 to overwrite other nests
ccb.content.define_mapgen_palette {
    id = "road_palette",
    layout = {
        sign_glyphs = { ["@"] = { text = ccb.content.text("<statue_plaque>"), furniture = "f_statue" } },
        terrain = {
            ["."] = "t_pavement",
            _ = "t_sidewalk",
            ["*"] = "t_pavement_y",
            ["│"] = "t_zebra",
            ["─"] = "t_zebra",
            c = "t_concrete",
            b = "t_concrete",
            x = "t_concrete",
            n = "t_concrete",
            g = "t_region_grass",
            f = "t_region_grass",
            ["#"] = "t_sconc_wall_halfway",
            ["~"] = "t_water_sh",
            s = "t_region_shrub_decorative",
            ["6"] = "t_region_tree",
            ["9"] = "t_region_groundcover_urban",
        },
        furniture = {
            Y = "f_street_light",
            T = "f_traffic_light",
            S = "f_sign_stop",
            f = { { id = "f_region_flower_decorative", copies = 2 }, { id = "f_null", copies = 1 } },
            b = "f_bench",
            x = "f_trashcan",
            n = "f_bike_rack",
        },
    },
}
