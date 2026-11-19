local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "cabin_nether_cult_roof",
    layout = {
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "  -5------------------  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -..................-  ",
            "  -................~.-  ",
            "  -..................-  ",
            "  --------------------  ",
            "  ....................  ",
            "  ....................  ",
            "  ....................  ",
            "  ....................  ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "roof_palette" },
        terrain = { ["."] = "t_tar_flat_roof" },
        fill_terrain = "t_tar_flat_roof",
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "cabin_nether_cult" },
    layout = {
        rows = {
            "...........~~...........",
            "...........~~...........",
            "...%.......~~...........",
            "**######w##++#########**",
            "**#R  d#sT#  #A DBBD #**",
            "**#R  c#  #  #A  BB  w**",
            "**wR   #  =  =       w**",
            "**wR   #  #  #########**",
            "**#R   ####  =  DBBD #**",
            "**#R   L#>A  #A  BB  w**",
            "**####=####  #A      w**",
            "**#ttb  uu#  #########**",
            "**wttb   u#  #a OOO  w**",
            "**wbb     =  =       w**",
            "**#      u#  #     S #**",
            "**#1F5V234#  #a      #**",
            "**###ww####++####ww###**",
            "..o bbbb             o..",
            "..-                  -..",
            "..-                  -..",
            "..o-------o  o-------o..",
            "...........~~...........",
            "...........~~...........",
            "...........~~...........",
        },
        palettes = { "cabin_palette" },
        terrain = { ["-"] = "t_railing", [">"] = "t_wood_stairs_down", w = "t_window_bars_curtains" },
        fill_terrain = "t_floor",
        item_groups = {
            A = {
                { group = "homebooks", chance = 60, repetitions = { 1, 3 } },
                { group = "magazines", chance = 60, repetitions = { 1, 8 } },
                { group = "manuals", chance = 30 },
                { group = "esoteric_books", chance = 25 },
                { group = "hedge_magic_books", chance = 5 },
            },
        },
        loot_placements = { { group = "homeguns", x = 7, y = 9, chance = 30, ammo = 90, magazine = 100 } },
        monster_group_placements = {
            { group = "GROUP_ZOMBIE", x = 11, y = 12 },
            { group = "GROUP_NETHER_CULT", x = { 4, 20 }, y = { 4, 14 }, repetitions = 2 },
        },
    },
}

-- Headless corpse inside a locked room. Spooky!
ccb.content.define_mapgen {
    kind = "nested",
    id = "cabin_nether_cult_basement_4x4_library_lies",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            "     ",
            "     ",
            "     ",
            "     ",
        },
        item_placements = {
            { id = "book_deduction_lies", x = 3, y = 3, chance = 100 },
            { id = "corpse_painful", x = 3, y = 4, chance = 100 },
        },
        item_group_placements = { { group = "default_zombie_death_drops", x = 3, y = 4, chance = 100 } },
    },
}
