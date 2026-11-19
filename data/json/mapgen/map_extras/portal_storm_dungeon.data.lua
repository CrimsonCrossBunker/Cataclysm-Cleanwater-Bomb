local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal_distortion_item",
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
        nested = { { id = "11x11_portal_dungeon_distortion", x = { 0, 11 }, y = { 0, 11 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_portal_dungeon_distortion",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "    qqq    ",
            "   qqqqq   ",
            "  qqqqqqq  ",
            " qqqqqqqqq ",
            "qqqqqqqqqqq",
            "qqqqq@qqqqq",
            "qqqqqqqqqqq",
            " qqqqqqqqq ",
            "  qqqqqqq  ",
            "   qqqqq   ",
            "    qqq    ",
        },
        terrain = {
            ["@"] = "t_floor_warped",
            q = { { id = "t_floor_warped", copies = 50 }, { id = "t_wall_warped", copies = 50 } },
        },
        item_groups = { ["@"] = { group = "portal_storm_dungeon_items", chance = 100 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_portal_ingress",
    layout = {
        monster_placements = { { group = "GROUP_NETHER", x = { 0, 23 }, y = { 0, 23 }, repetitions = { 2, 3 } } },
    },
}
