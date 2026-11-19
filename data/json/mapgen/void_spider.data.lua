local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "void_spider_lair_corpses",
    layout = {
        nested = { { id = "void_spider_lair_corpses", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "void_spider_lair_corpses",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "     ,,,,,,,,,       ,  ",
            "         ,,,,,,    ,,,  ",
            "          ,,,,,,,,,,,   ",
            ",    ,,   ,,,,  ,o,,,   ",
            ",  ,,,,,,,ooo    ,bo    ",
            ",    ,,,ooo,    ,,o     ",
            ",  ,,,,,b,,o  ,,,,,,, ,,",
            ",,,  ,,,,,o,,,,o#,,,#o,,",
            ", ,,,,,,,,,,,  ##,,,##,,",
            ",,, ,,bo,, ,,,,,,,A,,,,,",
            ", ,,,,o,,   oo ##,,,##,,",
            " ,, ,,,,     ooo#,,,#o,,",
            ",,,,,,,,,    # ,,,,    ,",
            ",  ,,,o,,,  ,  ,,,     ,",
            ",  ,bo,,   ,,,,,      ,,",
            " ,  ,     ,,bo,,      , ",
            "          ,oo,#      ,,,",
            "         ,o,,      ,,,,,",
            "   ,,  ,,b,o,     ,,,,,,",
            "       , , ,,,  ,,,,, ,,",
            "    ,,  ,,,,,,,,,,,,o,, ",
            "     ,,,,,,,,,,,,,,,,,  ",
            "          ,,,,o,,,,,,   ",
            "  ,,,,,,,,,,,,,,,,,     ",
        },
        terrain = {
            ["#"] = "t_rock",
            o = "t_nether_glass_floor",
            ["|"] = "t_nether_basalt",
            [","] = "t_nether_glass_floor",
            B = "t_nether_glass_wall",
            A = "t_nether_glass_floor_clairvoyance",
            b = "t_nether_glass_floor_clairvoyance",
        },
        item_groups = {
            o = { group = "void_spider_nest", chance = 100 },
            A = { group = "void_spider_corpse_mayor_loot", chance = 100 },
            b = { group = "void_spider_corpse_minor_loot", chance = 100 },
        },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "void_spider_lair_eggs",
    layout = {
        nested = { { id = "void_spider_lair_eggs", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "void_spider_lair_eggs",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "       ##,,,,,,,        ",
            "      ,,,,,,,,,,,       ",
            "      ,,,,o,oo,,,,,     ",
            "     ##,,ooo,,,,,,,,    ",
            "    ##,,oo,,, ww,ooo    ",
            "    ,,,,o,,,,www,,ooo   ",
            "    o,,,o o,www##,,oo   ",
            "    o ,,, o,o,,w##,,    ",
            "    oo,,,,,,o ,,,,oo    ",
            "     ##,,,,,,,,,,,o,    ",
            "     # o,,,,,,,,,,,     ",
            "       ooo,,,,,,,,      ",
            "         ooo,,###       ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        terrain = {
            ["#"] = "t_rock",
            ["|"] = "t_nether_basalt",
            [","] = "t_nether_glass_floor",
            w = "t_water_sh",
            o = "t_nether_glass_floor",
        },
        item_groups = { o = { group = "void_spider_nest", chance = 100 } },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
