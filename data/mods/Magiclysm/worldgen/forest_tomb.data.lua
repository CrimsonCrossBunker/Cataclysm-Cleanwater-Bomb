local ccb = require("ccb")

ccb.content.define_mapgen_palette {
    id = "tomb",
    layout = {
        item_groups = {
            H = { group = "forest_tomb_spellbook", chance = 100 },
            R = { group = "animist_items", chance = 25 },
        },
        monster_glyphs = { x = { id = "mon_skeleton", chance = 50 }, Z = { id = "mon_zombie_necro", chance = 100 } },
        terrain = {
            ["."] = "t_rock_floor",
            [" "] = {
                { id = "t_grass_dead", copies = 15 },
                { id = "t_dirt", copies = 4 },
                { id = "t_dirtmound", copies = 3 },
                { id = "t_rock_floor_no_roof", copies = 4 },
            },
            T = "t_tree_dead",
            R = "t_railroad_rubble",
            S = "t_shrub",
            ["<"] = "t_slope_up",
            [">"] = "t_slope_down",
            ["#"] = "t_rock",
        },
        furniture = { H = "f_altar", C = "f_coffin_c" },
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
            "   S                    ",
            "                    S   ",
            "        S               ",
            "   S            S       ",
            "   ##<###############   ",
            "   ##################   ",
            " S ####C.##>>##..C###   ",
            "   ###x..........###<S  ",
            "   ###...##..##..C###   ",
            "   ###.####..########   ",
            "   ###..###..x..#####   ",
            "   ###..C##..#...R### S ",
            "  S####R###..########   ",
            "   ########..###<####   ",
            "          T  T     S    ",
            "     S                  ",
            "          T  T       S  ",
            "      S                 ",
            "          T  T          ",
            "                 S      ",
            "    S                   ",
            "                S       ",
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
            "########################",
            "########################",
            "########################",
            "########################",
            "######.R################",
            "######.####.......######",
            "######.####..###.x######",
            "#####C..C##<<##R.C######",
            "#######.###..###########",
            "#######.....############",
            "###########..###########",
            "###########..###########",
            "############.###########",
            "###########..###########",
            "###########..###########",
            "###########.############",
            "########C......C########",
            "########........########",
            "########...HZ...########",
            "########R......R########",
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
            "                        ",
            "                        ",
            "   ..>...............   ",
            "   ..................   ",
            "   ..................   ",
            "   .................>   ",
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
            "                        ",
            "                        ",
        },
        palettes = { "tomb_roof" },
    },
}
