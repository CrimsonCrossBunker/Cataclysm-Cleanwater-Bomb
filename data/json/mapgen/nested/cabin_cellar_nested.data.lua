local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar_stairs",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "          ",
            "       >  ",
            "          ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "cabin_cellar", x = 0, y = 0, z = -1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            "#--------#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#-......-#",
            "#------.-#",
            "######-<-#",
            "######---#",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "cabin_6x6_cellar_nested", x = 2, y = 1 },
            {
                choices = {
                    { id = "null", weight = 90 },
                    { id = "cabin_6x6_cellar_nested_zombies", weight = 15 },
                    { id = "cabin_6x6_cellar_nested_spiders", weight = 5 },
                    { id = "cabin_6x6_cellar_nested_mycus", weight = 1 },
                },
                x = 2,
                y = 1,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_cellar_2x2_moonshine_still",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "SV",
            "  ",
        },
        furniture = { S = "f_still", V = "f_fvat_empty" },
        rotation = { 0, 0 },
    },
}
