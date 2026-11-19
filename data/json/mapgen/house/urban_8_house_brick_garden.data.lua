local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "urban_8_6",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "         ------         ",
            "    ------....------    ",
            "    -.0............-    ",
            "    -..............-    ",
            "    -.........N....-    ",
            "    -...........=..-    ",
            "    -..............-    ",
            "    5....X.....&...5    ",
            "    -..............-    ",
            "    ----------------    ",
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
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_shingle_flat_roof" },
        fill_terrain = "t_shingle_flat_roof",
        nested_glyphs = {
            ["0"] = {
                choices = { { id = "residential_6kW_solar", weight = 125 }, { id = "null", weight = 873 } },
            },
        },
    },
}
