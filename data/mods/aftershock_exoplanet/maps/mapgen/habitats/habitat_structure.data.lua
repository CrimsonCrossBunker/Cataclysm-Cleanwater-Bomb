local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_roof",
    layout = {
        fill_terrain = "t_metal_floor_no_roof",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_pillars_ground_walkway",
    layout = {
        fill_terrain = "t_region_groundcover_urban",
        nested = {
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "formless_ruins_empty1", weight = 5 },
                    { id = "formless_ruins_empty2", weight = 5 },
                    { id = "formless_ruins_empty3", weight = 5 },
                    { id = "formless_ruins_empty4", weight = 5 },
                },
                x = 0,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "formless_ruins_empty1", weight = 5 },
                    { id = "formless_ruins_empty2", weight = 5 },
                    { id = "formless_ruins_empty3", weight = 5 },
                    { id = "formless_ruins_empty4", weight = 5 },
                },
                x = 12,
                y = 0,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "formless_ruins_empty1", weight = 5 },
                    { id = "formless_ruins_empty2", weight = 5 },
                    { id = "formless_ruins_empty3", weight = 5 },
                    { id = "formless_ruins_empty4", weight = 5 },
                },
                x = 0,
                y = 12,
            },
            {
                choices = {
                    { id = "null", weight = 80 },
                    { id = "formless_ruins_empty1", weight = 5 },
                    { id = "formless_ruins_empty2", weight = 5 },
                    { id = "formless_ruins_empty3", weight = 5 },
                    { id = "formless_ruins_empty4", weight = 5 },
                },
                x = 12,
                y = 12,
            },
            { id = "afs_modular_habitat_end_pillars_ground_walkway", x = 0, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_pillars_ground",
    layout = {
        fill_terrain = "t_region_groundcover_urban",
        nested = { { id = "afs_modular_habitat_end_pillars", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_end_pillars_above_walkway",
    layout = {
        fill_terrain = "t_open_air",
        nested = { { id = "afs_modular_habitat_end_pillars_above_walkway", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "afs_modular_habitat_pillars",
    layout = {
        fill_terrain = "t_open_air",
        nested = { { id = "afs_modular_habitat_end_pillars", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_end_pillars",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "  //                //  ",
            "  /                  /  ",
            "  //                //  ",
            "                        ",
            "                        ",
            "                        ",
            "  //                //  ",
            "  /                  /  ",
            "  /                  /  ",
            "  //                //  ",
            "                        ",
            "                        ",
            "                        ",
            "  //                //  ",
            "  /                  /  ",
            "  //                //  ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = { ["/"] = "t_wall_metal" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_end_pillars_ground_walkway",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            " 1]]1                   ",
            " 1__1                   ",
            " 1__1                   ",
            " /__/               //  ",
            " /../2              2/  ",
            " /__/               //  ",
            " 1__1                   ",
            "/1__1/                  ",
            " 1__1                   ",
            " /__/               //  ",
            " /../                /  ",
            " /../2              2/  ",
            " /__/               //  ",
            " 1__1                   ",
            "/1__1/                  ",
            " 1__1                   ",
            " /__/               //  ",
            " /../2              2/  ",
            " /__/               //  ",
            " 1__1                   ",
            "/1__1/                  ",
            " 1__1                   ",
            " 1__1                   ",
        },
        terrain = {
            ["/"] = "t_wall_metal",
            ["1"] = "t_wall_glass",
            _ = "t_metal_floor_no_roof",
            ["]"] = "t_door_glass_c",
            ["."] = "t_metal_floor_olight",
        },
        furniture = { ["2"] = "f_habitat_floodlight" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_modular_habitat_end_pillars_above_walkway",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            " 1111                   ",
            " 1111                   ",
            " 1111                   ",
            " 1//.               //  ",
            " 1/..                /  ",
            " 1//.               //  ",
            " 1111                   ",
            ".1111.                  ",
            " 1111                   ",
            " 1//.               //  ",
            " 1/..                /  ",
            " 1/..                /  ",
            " 1//.               //  ",
            " 1111                   ",
            ".1111.                  ",
            " 1111                   ",
            " 1//.               //  ",
            " 1/..                /  ",
            " 1//.               //  ",
            " 1111                   ",
            ".1111.                  ",
            " 1111                   ",
            " 1111                   ",
        },
        terrain = { ["/"] = "t_wall_metal", ["1"] = "t_glass_roof", ["."] = "t_metal_floor_no_roof" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
