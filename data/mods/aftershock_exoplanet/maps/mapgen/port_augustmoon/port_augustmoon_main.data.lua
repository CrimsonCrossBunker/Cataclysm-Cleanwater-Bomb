local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "augustmoon_outer_space",
    layout = {
        fill_terrain = "t_hard_vacuum",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { { "augustmoon_solar_array1" }, { "augustmoon_solar_array2" } },
    layout = {
        rows = {
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "  pp  pppppppppppppppppp",
            "  pp  pppppppppppppppppp",
            "|...........            ",
            "  pp  pppppppppppppppppp",
            "  pp  pppppppppppppppppp",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "  pp  pppppppppppppppppp",
            "  pp  pppppppppppppppppp",
            "|...........            ",
            "  pp  pppppppppppppppppp",
            "  pp  pppppppppppppppppp",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "  pp                    ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "afs_habitat_structure", "afs_habitat_residential_furnishing" },
        terrain = {
            ["1"] = "t_dirtmound",
            [" "] = "t_hard_vacuum",
            ["2"] = "t_bars",
            ["5"] = "t_ramp_down_high",
            ["6"] = "t_ramp_down_low",
        },
        furniture = { p = "f_solar_unit" },
        fill_terrain = "t_hard_vacuum",
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "augustmoon_concourse_vending1",
    layout = {
        nested = { { id = "augustmoon_concourse_vending1", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "augustmoon_concourse_vending2",
    layout = {
        nested = { { id = "augustmoon_concourse_vending2", x = 0, y = 0 } },
    },
}
