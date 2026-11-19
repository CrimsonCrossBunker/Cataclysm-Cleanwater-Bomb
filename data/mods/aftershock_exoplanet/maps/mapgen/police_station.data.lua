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

ccb.content.define_mapgen {
    kind = "overmap",
    id = { "afs_enforcer_station_a1" },
    layout = {
        rows = {
            "                        ",
            " //=///=///////=////#// ",
            " /h.v/v.h/<</3c.3c=4.4/ ",
            " /ck./.kc/../..'..=4'4/ ",
            " /.'./.'./''/ccê..!..4/ ",
            " //:///://..////:///!// ",
            " =.....'..........'...= ",
            " =.....'..........'..%= ",
            " ////:////--12--..//:// ",
            " /k....vkc-....-../h.h/ ",
            " =ch..'..h-....-../.'./ ",
            " =...h..h.-..'.-''/.kc/ ",
            " /..%ckvck-...--../v.h/ ",
            " -12-))))----..-..///// ",
            " -.-°$..$°°ë-..-../~/~/ ",
            " -.-°$''$°°-----/!/:/:/ ",
            " -!-°$..$°°ë-pynn...../ ",
            " -°°°$..$°°--b...'.jjJ/ ",
            " -°°°$..$°°ë-b.....ch./ ",
            " -°°°$''$°°--bb//!//nn/ ",
            " -°°°$..$°°ë-==/b'l/==/ ",
            " -°°°$..$°5--℗℗/b.l/℗℗  ",
            " ---666666---  //!//    ",
            "                        ",
        },
        nested = {
            { x = 0, y = 0, id = { parameter = "lightstatus", fallback = "null" } },
            {
                x = 0,
                y = 0,
                id = { parameter = "enemies", fallback = "afs_enforcer_station_a1_floor1_moxies" },
            },
            {
                x = 0,
                y = 0,
                choices = {
                    { id = "afs_enforcer_station_a1_armory_unlooted", weight = 70 },
                    { id = "afs_enforcer_station_a1_armory_looted", weight = 30 },
                },
            },
            {
                x = 0,
                y = 0,
                choices = {
                    { id = "afs_enforcer_station_a1_garage_open", weight = 20 },
                    { id = "afs_enforcer_station_a1_garage_patrol_car", weight = 40 },
                    { id = "afs_enforcer_station_a1_garage_cycles", weight = 40 },
                },
            },
        },
        item_groups = {
            ["ë"] = { group = "afs_police_bot_storage", chance = 15 },
            ["ê"] = { group = "afs_police_hacker_gear", chance = 75, repetitions = { 1, 3 } },
        },
        fill_terrain = "t_metal_floor",
        palettes = {
            "afs_habitat_structure", "afs_habitat_exterior", "afs_habitat_residential_furnishing",
            "afs_enforcer_station_a1_parrameter_palette", "afs_light_param_palette",
        },
        terrain = {
            ["1"] = "t_door_metal_locked",
            ["2"] = "t_afs_enforcer_card_reader",
            ["6"] = "t_afs_security_gate_closed",
            ["ë"] = "t_thconc_floor_no_roof",
            ["5"] = "t_thconc_floor_no_roof",
        },
        furniture = {
            ["3"] = "f_hacker_chair",
            ["4"] = "f_server",
            ["ë"] = "f_drone_recharge_station",
            ["5"] = "f_security_panel",
            ["ê"] = "f_locker",
        },
    },
}
