local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "tomb",
    layout = {
        item_groups = {
            H = { group = "xedrawood_forest_tomb_artifact_wield", chance = 100 },
            ["¢"] = { group = "xedrawood_forest_tomb_artifact_worn", chance = 33 },
        },
        monster_glyphs = {
            x = { id = "mon_skeleton_animated", chance = 50 },
            Z = { id = "mon_darkman", chance = 100 },
        },
        terrain = {
            ["."] = "t_rock_floor",
            [" "] = {
                { id = "t_region_groundcover_forest", copies = 15 },
                { id = "t_grass_dead", copies = 1 },
            },
            ["-"] = "t_dirt",
            _ = { { id = "t_region_groundcover_forest", copies = 1 }, { id = "t_dirt", copies = 1 } },
            T = "t_tree_dead",
            R = "t_railroad_rubble",
            S = "t_shrub",
            ["<"] = "t_slope_up",
            [">"] = "t_slope_down",
            ["#"] = "t_rock",
            D = { { id = "t_door_stone_c", copies = 20 }, { id = "t_door_stone_o", copies = 1 } },
        },
        furniture = { H = "f_altar", C = "f_coffin_c", ["¢"] = "f_coffin_c" },
    },
}

ccb.content.define_mapgen_palette {
    id = "tomb_roof",
    layout = { terrain = { ["."] = "t_rock_roof", [" "] = "t_open_air", [">"] = "t_slope_down" } },
}

-- Ground level - Z-0.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "forest_tomb" },
    layout = {
        rows = {
            "                  S     ",
            "            S           ",
            " _______S______________ ",
            " _-S------------S-----_ ",
            " _-##<###############-_ ",
            " _-####C..x###C..C###-_ ",
            " _-#####.#######.####-_ ",
            " _-#####.#######.####-_ ",
            " S-####C.##>>##..C###-_ ",
            " _-###x..........###<S_ ",
            " _-###...##..##..C###-_ ",
            " _-###.####..########-_ ",
            " _-###..###..x..#####-_ ",
            " _-###..C##..#...R###-S ",
            " _S########..########-_ ",
            " _-########..########-_ ",
            " _-########..########-_ ",
            " _-########DD###<####-_ ",
            " _--------TRRT-----S--_ ",
            " ____S_____RR__________ ",
            "          TRRT       S  ",
            "      S    RR           ",
            "          TRRT          ",
            "            R    S      ",
        },
        palettes = { "tomb" },
        fill_terrain = "t_rock_floor",
    },
}

-- Underground level - Z -1.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "forest_tomb_bottom" },
    layout = {
        rows = {
            "########################",
            "##¢..C##################",
            "##..x..#################",
            "##Cx...#################",
            "######.#################",
            "######.R################",
            "######.####.......######",
            "######.####..###.x######",
            "#####C..C##<<##R.C######",
            "#######.###..######C####",
            "###......x..###....x####",
            "###.#######..##.###.####",
            "###.###.........###.####",
            "###D###C###########.####",
            "#.....#####x.###....####",
            "#.x.x.#####......#######",
            "#..¢..#####D############",
            "#.x.x.##C......C########",
            "#.....###.x..x...#######",
            "########...HZ...########",
            "########¢......C########",
            "########################",
            "########################",
            "########################",
        },
        palettes = { "tomb" },
        fill_terrain = "t_rock_floor",
    },
}

-- Roof level - Z +1.
ccb.content.define_mapgen {
    kind = "overmap",
    id = { "forest_tomb_roof" },
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "   ..>...............   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   .................>   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   ..................   ",
            "   .............>....   ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "tomb_roof" },
    },
}
