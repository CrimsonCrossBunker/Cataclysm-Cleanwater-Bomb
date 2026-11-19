local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_enforcer_station_a1_roof" },
    layout = {
        rows = {
            "                        ",
            " [[[[[[[[[[[[[[[[[[[[[[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [££££££££££££££££££££[ ",
            " [[[[[[[[[[[[£££££££££[ ",
            "            [£££££££££[ ",
            "            [£££££££££[ ",
            "            [££[[[[[££[ ",
            "            [[[[   [[[[ ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
            "                        ",
        },
        palettes = { "afs_habitat_structure", "afs_habitat_exterior" },
        terrain = { [" "] = "t_open_air" },
        fill_terrain = "t_metal_floor",
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_armory_looted",
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
            "            2           ",
            "           1 yy         ",
            "           1  1         ",
            "           1  1         ",
            "           yy           ",
            "              1         ",
            "              1         ",
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
        palettes = { "afs_habitat_residential_furnishing" },
        terrain = { ["2"] = "t_mdoor_frame" },
        furniture = { ["1"] = "f_locker" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_garage_open",
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
            "    111111              ",
            "                        ",
        },
        terrain = { ["1"] = "t_afs_security_door_frame" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_floor1_moxies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "AFS_GROUP_RUIN_MOXIE",
                x = { 0, 23 },
                y = { 0, 23 },
                pack_size = { 1, 5 },
                chance = 50,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_floor1_robots",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_ROBOT_COPS_HOSTILE",
                x = { 0, 23 },
                y = { 0, 23 },
                pack_size = { 2, 5 },
                chance = 70,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_floor2_moxies",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "AFS_GROUP_RUIN_MOXIE",
                x = { 2, 21 },
                y = { 2, 19 },
                z = 1,
                pack_size = { 1, 5 },
                chance = 50,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_floor2_robots",
    layout = {
        size = { width = 24, height = 24 },
        monster_placements = {
            {
                group = "GROUP_ROBOT_COPS_HOSTILE",
                x = { 2, 21 },
                y = { 2, 19 },
                z = 1,
                pack_size = { 1, 4 },
                chance = 70,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_armory_unlooted",
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
            "           á yy         ",
            "           á  â         ",
            "           á  â         ",
            "           yy           ",
            "              ä         ",
            "              é         ",
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
        palettes = { "afs_habitat_residential_furnishing" },
        furniture = { ["á"] = "f_locker", ["â"] = "f_locker", ["ä"] = "f_locker", ["é"] = "f_locker" },
        item_groups = {
            ["á"] = { group = "afs_police_armor", chance = 80, repetitions = { 1, 4 } },
            ["â"] = { group = "afs_police_armory", chance = 80, repetitions = { 8, 18 } },
            ["ä"] = { group = "afs_anti_robot_grenades", chance = 60, repetitions = { 2, 4 } },
            ["é"] = { group = "afs_police_anti_robot_armory", chance = 40, repetitions = { 3, 8 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_garage_patrol_car",
    layout = {
        size = { width = 24, height = 24 },
        vehicle_placements = { { id = "policecar_atomic", x = 7, y = 18, chance = 20, rotation = 90 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "afs_enforcer_station_a1_garage_cycles",
    layout = {
        size = { width = 24, height = 24 },
        vehicle_placements = {
            { id = "light_cycle", x = 5, y = 18, chance = 10, rotation = 90 },
            { id = "light_cycle", x = 8, y = 18, chance = 10, rotation = 90 },
        },
    },
}
