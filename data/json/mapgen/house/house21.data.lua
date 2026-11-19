local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "house_21_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "             --------   ",
            "             -......-   ",
            "   -----------......-   ",
            "   -............X...-   ",
            "   -................-   ",
            "   -................-   ",
            "   -....=.......&...-   ",
            "   -................-   ",
            "   5.....-------....5   ",
            "   -0....-     -....-   ",
            "   -.....-     ------   ",
            "   -.....-              ",
            "   -.....-              ",
            "   -.....-              ",
            "   -------              ",
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
