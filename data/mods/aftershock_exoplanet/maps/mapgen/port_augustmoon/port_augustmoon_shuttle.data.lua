local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "augustmoon_shuttle_ground",
    layout = {
        nested = { { id = "augustmoon_shuttle_ground_tile", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "augustmoon_shuttle_ground_left",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ### ##          ",
            "        #######         ",
            "       #########        ",
            "       #########        ",
            "       ##########       ",
            "       #########        ",
            "      #######           ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { ["#"] = "t_dirtmound" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_landed_shuttle",
    layout = {
        predecessor_mapgen = "glacial_field",
        nested = { { id = "augustmoon_shuttle_ground_tile", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "augustmoon_shuttle_ground_tile",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "        ### ##          ",
            "        ##|||##         ",
            "       ##||A||##        ",
            "       #||313||#        ",
            "       #|||2|||##       ",
            "       ##||2||##        ",
            "      ####              ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            ["|"] = "t_afs_space_ship_hull_wall",
            ["2"] = "t_afs_space_ship_hatch_c",
            ["1"] = "t_intermodal_crate_scripted_source",
            ["3"] = "t_metal_floor",
            A = "t_augustmoon_shuttle_console",
            ["#"] = "t_dirtmound",
        },
        furniture = { ["3"] = "f_afs_shuttle_seat" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
