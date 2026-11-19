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

ccb.content.define_mapgen {
    kind = "overmap",
    id = "inner_cabins_depths_entrance",
    layout = {
        rows = {
            "888888888888888888888888",
            "8~8888888888888888888888",
            "888888888888888888~88888",
            "88888888888888~888888888",
            "888888888888888888888888",
            "8888888888##ww#+#ww##888",
            "8888888888#14&   OOO#888",
            "8888888888wF       Ow888",
            "8888888888w2   cc  Ow888",
            "8888888888#S   tt  A#888",
            "8888888888#35  cc  A#888",
            "8888888888####      w888",
            "8888~88880#s +    BBw888",
            "888888888%#T #   DBB#888",
            "8888888888#####+#ww##888",
            "88888888888>888888888888",
            "888888888888888888888888",
            "888888888888888888888888",
            "888888888888888888888888",
            "888888~88888888888888888",
            "88888888888888888888~888",
            "888888888888888888888888",
            "88~888888888888888888888",
            "888888888888888888888888",
        },
        palettes = { "cabin_palette_abandoned" },
        terrain = {
            ["0"] = "t_region_soil",
            b = "t_region_groundcover",
            ["8"] = { { id = "t_grass_tall", copies = 85 }, { id = "t_grass_dead", copies = 15 } },
            V = "t_grass_tall",
            [">"] = "t_stairs_down",
        },
        furniture = {
            ["8"] = {
                { id = "f_null", copies = 410 },
                { id = "f_black_eyed_susan", copies = 1 },
                { id = "f_bluebell", copies = 1 },
                { id = "f_lily", copies = 1 },
                { id = "f_flower_tulip", copies = 1 },
            },
        },
        fill_terrain = "t_floor",
        nested = {
            { id = "inner_cabins_depths_entrance_stairs_-1", x = 10, y = 14, z = -1 },
            { id = "inner_cabins_depths_entrance_stairs_-2", x = 10, y = 14, z = -2 },
            { id = "inner_cabins_depths_entrance_stairs_-3", x = 10, y = 14, z = -3 },
            { id = "inner_cabins_depths_entrance_stairs_-4", x = 10, y = 14, z = -4 },
            { id = "inner_cabins_depths_entrance_stairs_-5", x = 10, y = 14, z = -5 },
            { id = "inner_cabins_depths_entrance_stairs_-6", x = 10, y = 14, z = -6 },
            { id = "inner_cabins_depths_entrance_stairs_-7", x = 10, y = 14, z = -7 },
            { id = "inner_cabins_depths_entrance_stairs_-8", x = 10, y = 14, z = -8 },
            { id = "inner_cabins_depths_entrance_stairs_-9", x = 10, y = 14, z = -9 },
        },
        loot_placements = { { id = "inner_cabins_depths_note_2", x = 10, y = 15 } },
        monster_placements = { { id = "mon_inner_cabins_interstice_mutant_ignoring", x = 15, y = 7, chance = 100 } },
    },
}

-- A cellar filled with various bits of hobby equipment for hiking, hunting, or camping
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "NNNNNN",
            "Nnnnn ",
            "Nn    ",
            "Nn nn ",
            "Nn nn ",
            "N     ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        nested_glyphs = {
            N = {
                choices = { { id = "cabin_cellar_1x1_junk_box", weight = 20 }, { id = "null", weight = 5 } },
            },
            n = {
                choices = { { id = "cabin_cellar_1x1_junk_box", weight = 1 }, { id = "null", weight = 1 } },
            },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar filled with preserved food
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    weight = 900,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            " R  R ",
            " R  R ",
            " R  R ",
            " R  R ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        item_groups = { R = { group = "preserved_food", chance = 1, repetitions = { 1, 2 } } },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar that's totally empty
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    weight = 600,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar with booze.  Drink up!
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    weight = 500,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "R     ",
            "R   c ",
            "R ctt ",
            "R ctt ",
            "   c  ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        nested = {
            {
                choices = {
                    { id = "null", weight = 2 },
                    { id = "cabin_cellar_2x2_moonshine_still", weight = 1 },
                },
                x = 1,
                y = 0,
            },
        },
        item_groups = { R = { group = "liquor_and_spirits", chance = 80, repetitions = { 1, 4 } } },
        item_placements = {
            { id = "bottle_glass", x = 3, y = 2, chance = 80 },
            { id = "bottle_glass", x = 3, y = 3, chance = 80 },
            { id = "bottle_glass", x = 4, y = 2, chance = 80 },
            { id = "bottle_glass", x = 4, y = 3, chance = 80 },
            { id = "deck_of_cards", x = 4, y = 3, chance = 50 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar with stored furniture
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    weight = 450,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "ttttcc",
            "ttcccc",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        item_placements = {
            { id = "tourist_table", x = 0, y = 2, chance = 50 },
            { id = "tourist_table", x = 1, y = 2, chance = 50 },
            { id = "box_large_wood", x = 0, y = 3, chance = 50 },
            { id = "box_large_wood", x = 0, y = 4, chance = 50 },
            { id = "box_large_wood", x = 0, y = 5, chance = 50 },
            { id = "box_large_wood", x = 1, y = 3, chance = 50 },
            { id = "box_large_wood", x = 1, y = 4, chance = 50 },
            { id = "box_large_wood", x = 1, y = 5, chance = 50 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}

-- A cellar that's totally empty and also has no dust.  Mysterious!
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    weight = 50,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
    },
}

-- A cellar with bones on a table and candles on the floor around it.  What happened here?
ccb.content.define_mapgen {
    kind = "nested",
    id = "inner_cabins_depths_6x6_cellar_nested",
    weight = 25,
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "      ",
            "      ",
            "  tt  ",
            "  tt  ",
            "      ",
            "      ",
        },
        palettes = { "cabin_cellar" },
        rotation = { 0, 0 },
        item_placements = {
            { id = "bone", x = 2, y = 2, repetitions = { 1, 2 } },
            { id = "bone", x = 3, y = 2, repetitions = { 1, 2 } },
            { id = "bone", x = 2, y = 3, repetitions = { 1, 2 } },
            { id = "bone", x = 3, y = 3, repetitions = { 1, 2 } },
            { id = "candle", x = 1, y = 1, chance = 2 },
            { id = "candle", x = 4, y = 1, chance = 2 },
            { id = "candle", x = 1, y = 4, chance = 2 },
            { id = "candle", x = 4, y = 4, chance = 2 },
        },
        field_placements = { { id = "fd_dust", x = { 0, 5 }, y = { 0, 5 }, repetitions = { 10, 20 } } },
    },
}
