local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_safehouse_bathroom_roof",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "    ",
            "    ",
            "    ",
            "    ",
        },
        terrain = { T = "t_wood_stairs_down" },
        rotation = { 0, 0 },
        nested = { { id = "bloodthorne_druid_safehouse_bathroom_roof_z1", x = 0, y = 0, z = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_safehouse_bathroom_roof_z1",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "----",
            "...-",
            "...-",
            "...-",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_tar_flat_roof" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "bloodthorne_druid_11x11_basement_stairs",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "           ",
            "        T  ",
            "           ",
        },
        terrain = { T = "t_wood_stairs_down" },
        rotation = { 0, 0 },
        nested = { { id = "bloodthorne_druid_11x11_basement", x = 0, y = 0, z = -1 } },
    },
}
