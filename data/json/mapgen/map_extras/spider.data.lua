local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_spider",
    layout = {
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            { id = "spider_nest", x = { 0, 6 }, y = { 0, 6 } },
            { choices = { "spider_nest", "null" }, x = { 0, 6 }, y = { 0, 6 } },
        },
    },
}

-- Null terrain definitions to avoid error
ccb.content.define_mapgen {
    kind = "nested",
    id = "spider_nest",
    layout = {
        size = { width = 17, height = 17 },
        rows = {
            "      .....      ",
            "    .........    ",
            "   ...,,,,,...   ",
            "  ...,,,,,,,...  ",
            " ...,,,ooo,,,... ",
            " ..,,,ooooo,,,.. ",
            "..,,,oooxooo,,,..",
            "..,,oooxxxooo,,..",
            "..,,ooxxXxxoo,,..",
            "..,,oooxxxooo,,..",
            "..,,,oooxooo,,,..",
            " ..,,,ooooo,,,.. ",
            " ...,,,ooo,,,... ",
            "  ...,,,,,,,...  ",
            "   ...,,,,,...   ",
            "    .........    ",
            "      .....      ",
        },
        terrain = { x = "t_null", o = "t_null", [","] = "t_null", ["."] = "t_null" },
        furniture = { X = "f_egg_sackws" },
        flags = { "ALLOW_TERRAIN_UNDER_FURNITURE" },
        nested_glyphs = {
            X = { id = "spider_webs" },
            x = {
                choices = { { id = "spider_webs", weight = 800 }, { id = "void_spider_webs", weight = 1 } },
            },
            o = {
                choices = {
                    { id = "spider_webs", weight = 2 },
                    { id = "spider_webs_weak", weight = 2 },
                    { id = "null", weight = 1 },
                },
            },
            [","] = { choices = { "spider_webs", "spider_webs_weak", "null" } },
            ["."] = { choices = { { id = "spider_webs_weak", weight = 1 }, { id = "null", weight = 2 } } },
        },
        monster_group_glyphs = { X = { group = "GROUP_SPIDER", chance = 1, density = 0.5 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "spider_webs",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_web", x = 0, y = 0, intensity = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "spider_webs_weak",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_web", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "spider_webs_nostick",
    layout = {
        size = { width = 1, height = 1 },
        field_placements = { { id = "fd_web_nostick", repetitions = { 0, 3 }, x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_basement_spider",
    layout = {
        rows = {
            "                        ",
            "          !             ",
            "                   !    ",
            "                        ",
            "       !                ",
            "                        ",
            "            !           ",
            "                        ",
            "       !         !      ",
            "                        ",
            "                        ",
            "             !          ",
            "                        ",
            "    !                   ",
            "                        ",
            "           !            ",
            "                   !    ",
            "                        ",
            "                        ",
            "          !             ",
            "                        ",
            "                        ",
            "     !            !     ",
            "                        ",
        },
        nested_glyphs = {
            [" "] = {
                choices = {
                    { id = "spider_webs_nostick", weight = 1 },
                    { id = "wasp_gibs", weight = 1 },
                    { id = "damaged_door_nested_no_junk", weight = 3 },
                    { id = "destroyed_door_nested_no_junk", weight = 3 },
                },
            },
        },
        monster_glyphs = { ["!"] = { group = "GROUP_SPIDER_BASEMENT", chance = 50, pack_size = { 1, 3 } } },
        tile_edits = {
            {
                shape = "point",
                operation = "bash",
                x = { 3, 20 },
                y = { 3, 20 },
                repetitions = { 5, 10 },
            },
        },
    },
}
