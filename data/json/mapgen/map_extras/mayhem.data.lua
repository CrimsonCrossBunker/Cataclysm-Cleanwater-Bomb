local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_mayhem",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = { "24x24_mayhem_crash", "24x24_mayhem_limo", "24x24_mayhem_tire_change" },
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_mayhem_crash_start",
    layout = {
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = { { id = "24x24_mayhem_crash", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_tire_change_robbed",
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
            "                C    ,  ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        item_spawns = { [","] = { id = "shot_hull", chance = 100 } },
        item_groups = { C = { group = "everyday_corpse", chance = 100 } },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_tire_change_wolves_north",
    layout = {
        size = { width = 24, height = 24 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { id = "1x1_dead_wolf", x = { 10, 14 }, y = { 10, 14 } },
            { choices = { "1x1_dead_wolf", "null" }, x = { 10, 14 }, y = { 10, 14 } },
            { choices = { "1x1_dead_wolf", "null" }, x = { 10, 14 }, y = { 10, 14 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_tire_change_wolves_south",
    layout = {
        size = { width = 24, height = 24 },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            { id = "1x1_dead_wolf", x = { 10, 14 }, y = { 16, 20 } },
            { choices = { "1x1_dead_wolf", "null" }, x = { 10, 14 }, y = { 16, 20 } },
            { choices = { "1x1_dead_wolf", "null" }, x = { 10, 14 }, y = { 16, 20 } },
        },
    },
}
