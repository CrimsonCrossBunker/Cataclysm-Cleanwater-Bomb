local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-1",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            " >",
            " <",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-2",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "><",
            "  ",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-3",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "< ",
            "> ",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-4",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "<>",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-5",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            " >",
            " <",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-6",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "><",
            "  ",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-7",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "< ",
            "> ",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-8",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            "<>",
        },
        terrain = { ["<"] = "t_stairs_up", [">"] = "t_stairs_down" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_entrance_stairs_-9",
    layout = {
        size = { width = 2, height = 2 },
        rows = {
            "  ",
            " <",
        },
        terrain = { ["<"] = "t_stairs_up" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
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
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 2 }, { id = "inner_cabins_depths_24x24", weight = 98 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 12,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 0,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 12,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 6,
                y = 6,
            },
            {
                choices = { { id = "null", weight = 94 }, { id = "inner_cabins_depths_10x10", weight = 6 } },
                x = 12,
                y = 6,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
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
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 3 }, { id = "inner_cabins_depths_24x24", weight = 97 } },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
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
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 20 }, { id = "inner_cabins_depths_24x24", weight = 80 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 20 }, { id = "inner_cabins_depths_24x24", weight = 80 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 20 }, { id = "inner_cabins_depths_24x24", weight = 80 } },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
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
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 85 }, { id = "inner_cabins_depths_10x10", weight = 15 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 85 }, { id = "inner_cabins_depths_10x10", weight = 15 } },
                x = 12,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 85 }, { id = "inner_cabins_depths_10x10", weight = 15 } },
                x = 0,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 85 }, { id = "inner_cabins_depths_10x10", weight = 15 } },
                x = 12,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 85 }, { id = "inner_cabins_depths_10x10", weight = 15 } },
                x = 6,
                y = 6,
            },
            {
                choices = { { id = "null", weight = 85 }, { id = "inner_cabins_depths_10x10", weight = 15 } },
                x = 12,
                y = 6,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
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
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 1,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 12,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 1,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 12,
                y = 12,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
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
            "                        ",
            "                        ",
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 2,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 5,
                y = 12,
            },
            {
                choices = { { id = "null", weight = 5 }, { id = "inner_cabins_depths_10x10", weight = 95 } },
                x = 0,
                y = 12,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "||+||                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "||+||                   ",
        },
        palettes = { "standard_domestic_palette", "inner_cabins_standard_domestic_basement_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "inner_cabins_depths_24x24", weight = 50 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 90 }, { id = "inner_cabins_depths_10x10", weight = 10 } },
                x = 6,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 90 }, { id = "inner_cabins_depths_10x10", weight = 10 } },
                x = 6,
                y = 11,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "         ||+||          ",
            "         |...|          ",
            "         |...|          ",
            "         +...+          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         +...+          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         +...+          ",
            "         |...|          ",
            "         |...|          ",
            "         |...|          ",
            "         +...+          ",
            "         |...|          ",
            "         |...|          ",
            "         ||+||          ",
        },
        palettes = { "standard_domestic_palette", "inner_cabins_standard_domestic_basement_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "inner_cabins_depths_24x24", weight = 50 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 20 }, { id = "inner_cabins_depths_10x10", weight = 80 } },
                x = 12,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 20 }, { id = "inner_cabins_depths_10x10", weight = 80 } },
                x = 12,
                y = 11,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "||+||                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "||+||                   ",
            "                   ||+||",
            "                   |...|",
            "                   |...|",
            "                   |...|",
            "                   +...+",
            "                   |...|",
            "                   |...|",
            "                   |...|",
            "                   +...+",
            "                   |...|",
            "                   |...|",
            "                   ||+||",
        },
        palettes = { "standard_domestic_palette", "inner_cabins_standard_domestic_basement_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 50 }, { id = "inner_cabins_depths_24x24", weight = 50 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 25 }, { id = "inner_cabins_depths_10x10", weight = 75 } },
                x = 4,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 25 }, { id = "inner_cabins_depths_10x10", weight = 75 } },
                x = 4,
                y = 10,
            },
            {
                choices = { { id = "null", weight = 25 }, { id = "inner_cabins_depths_10x10", weight = 75 } },
                x = 12,
                y = 11,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "     ||+||              ",
            "     |...|              ",
            "     |...|              ",
            "     +...+              ",
            "     |...|              ",
            "     |...|              ",
            "     |...|              ",
            "     +...+              ",
            "     |...|              ",
            "     |...|              ",
            "     |...|              ",
            "     ||+||              ",
            "              ||+||     ",
            "              |...|     ",
            "              |...|     ",
            "              |...|     ",
            "              +...+     ",
            "              |...|     ",
            "              |...|     ",
            "              |...|     ",
            "              +...+     ",
            "              |...|     ",
            "              |...|     ",
            "              ||+||     ",
        },
        palettes = { "standard_domestic_palette", "inner_cabins_standard_domestic_basement_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 25 }, { id = "inner_cabins_depths_24x24", weight = 75 } },
                x = 0,
                y = 0,
            },
            {
                choices = { { id = "null", weight = 25 }, { id = "inner_cabins_depths_10x10", weight = 75 } },
                x = 4,
                y = 10,
            },
            {
                choices = { { id = "null", weight = 25 }, { id = "inner_cabins_depths_10x10", weight = 75 } },
                x = 12,
                y = 11,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_nest",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "||+||                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "+...+                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|                   ",
            "|...|||||||+|||||||||+||",
            "|......................|",
            "|......................|",
            "|......................|",
            "||+||||||||+||||||||...+",
            "                   |...|",
            "                   |...|",
            "                   |...|",
            "                   +...+",
            "                   |...|",
            "                   |...|",
            "                   ||+||",
        },
        palettes = { "standard_domestic_palette", "inner_cabins_standard_domestic_basement_palette" },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = { { id = "null", weight = 20 }, { id = "inner_cabins_depths_10x10", weight = 80 } },
                x = 4,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "inner_cabins_depths",
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
            "                        ",
            "                        ",
        },
        terrain = { [" "] = "t_inner_cabins_nether_glass_floor" },
        nested = { { id = "inner_cabins_depths_nest", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_10x10",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            " - ------ ",
            " -......- ",
            " -......- ",
            " -......- ",
            " -......- ",
            " -......- ",
            " -......- ",
            " ------.- ",
            "      -.- ",
            "      - - ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "inner_cabins_depths_6x6_cellar_nested", x = 2, y = 1 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_10x10",
    layout = {
        size = { width = 10, height = 10 },
        rows = {
            " -------- ",
            " -......- ",
            " -......- ",
            "  ......- ",
            " -......- ",
            " -......- ",
            " -......- ",
            " -------- ",
            "          ",
            "          ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = { { id = "cabin_6x6_cellar_nested", x = 2, y = 1 } },
    },
}
