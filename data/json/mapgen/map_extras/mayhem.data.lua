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

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_crash",
    layout = {
        size = { width = 24, height = 24 },
        rows = {
            "                        ",
            "                      ~2",
            "                    ~~  ",
            "                ~~~~    ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                1       ",
            "                s       ",
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
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = {
            { id = "car", x = 18, y = 9, fuel = 0, status = 1, rotation = 270 },
            { id = "4x4_car", x = 20, y = 5, fuel = 0, status = 1, rotation = 0 },
        },
        item_spawns = { s = { id = "shot_hull", chance = 100 } },
        item_groups = {
            ["1"] = {
                { group = "corpses", chance = 100 },
                { group = "guns_shotgun_common_display", chance = 80 },
            },
            ["2"] = {
                { group = "corpses", chance = 100 },
                { group = "guns_pistol_common_display", chance = 80 },
            },
        },
        item_placements = { { id = "9mm_casing", x = { 15, 17 }, y = { 2, 4 }, chance = 50, repetitions = 9 } },
        zone_placements = { { id = "ZONE_START_POINT", faction = "your_followers", x = { 18, 18 }, y = { 9, 9 } } },
        field_glyphs = {
            ["1"] = { id = "fd_blood", intensity = { 1, 3 } },
            ["~"] = { id = "fd_blood" },
            ["2"] = { id = "fd_blood" },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_limo",
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
            "                ~       ",
            "                C       ",
            "                ~       ",
            "                C       ",
            "                C       ",
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
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        vehicle_placements = { { id = "limousine", x = 18, y = 9, fuel = 0, status = 1, rotation = 270 } },
        item_groups = { C = { group = "corpses", chance = 100 } },
        item_placements = { { id = "223_casing", x = { 10, 14 }, y = { 9, 13 }, chance = 33, repetitions = 25 } },
        field_glyphs = { C = { id = "fd_blood" }, ["~"] = { id = "fd_blood" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_tire_change",
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
            "               ~I       ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = { "24x24_mayhem_tire_change_robbed", "24x24_mayhem_tire_change_wolves" },
                x = 0,
                y = 0,
            },
        },
        vehicle_placements = { { id = "car_mayhem_tire_change", x = 18, y = 12, fuel = 0, status = 1, rotation = 270 } },
        item_spawns = { I = { { id = "jack_small", chance = 100 }, { id = "lug_wrench", chance = 100 } } },
        item_groups = {
            I = { { group = "wheel_spare", chance = 100 }, { group = "wheel_busted", chance = 100 } },
        },
        field_glyphs = { ["~"] = { id = "fd_blood", intensity = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "24x24_mayhem_tire_change_wolves",
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
            "                ~       ",
            "              ~~C~      ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        flags = { "ALLOW_TERRAIN_UNDER_OTHER_DATA" },
        nested = {
            {
                choices = { "24x24_mayhem_tire_change_wolves_north", "24x24_mayhem_tire_change_wolves_south" },
                x = 0,
                y = 0,
            },
        },
        item_groups = {
            C = {
                { group = "corpses", chance = 100 },
                { group = "guns_shotgun_common_display", chance = 80 },
            },
        },
        item_placements = { { id = "9mm_casing", x = { 15, 17 }, y = { 14, 16 }, repetitions = 9, chance = 50 } },
        field_glyphs = {
            ["~"] = { id = "fd_gibs_flesh", intensity = { 1, 3 } },
            C = { id = "fd_gibs_flesh", intensity = { 1, 3 } },
        },
    },
}
