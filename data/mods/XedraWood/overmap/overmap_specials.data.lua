local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "xedrawood_scenario_wise_one_hut",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "xedrawood_scenario_wise_one_hut_north" },
        { point = { 0, 0, 1 }, terrain = "xedrawood_scenario_wise_one_hut_roof_north" },
    },
    connections = { { point = { 0, -1, 0 }, terrain = "forest_trail", connection = "forest_trail" } },
    locations = { "forest" },
    city_distance = { 25, -1 },
    city_sizes = { 0, 20 },
    occurrences = { 5, 100 },
    flags = { "GLOBALLY_UNIQUE", "SAFE_AT_WORLDGEN" },
}

ccb.content.define_fixed_overmap_special {
    id = "forest_tomb",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "forest_tomb_north" },
        { point = { 0, 0, 1 }, terrain = "forest_tomb_roof_north" },
        { point = { 0, 0, -1 }, terrain = "forest_tomb_bottom_north" },
    },
    locations = { "forest_center" },
    city_distance = { 20, -1 },
    city_sizes = { 0, 20 },
    occurrences = { 5, 100 },
    flags = { "OVERMAP_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "ruined_tower",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "ruined_tower_basement_north" },
        { point = { 0, 0, 0 }, terrain = "ruined_tower_ground_north" },
        { point = { 0, 0, 1 }, terrain = "ruined_tower_z1_north" },
        { point = { 0, 0, 2 }, terrain = "ruined_tower_z2_north" },
        { point = { 0, 0, 3 }, terrain = "ruined_tower_z3_north" },
        { point = { 0, 0, 4 }, terrain = "ruined_tower_z4_north" },
        { point = { 0, 0, 5 }, terrain = "ruined_tower_z5_north" },
    },
    locations = { "wilderness" },
    city_distance = { 20, -1 },
    city_sizes = { 0, 20 },
    occurrences = { 15, 100 },
    flags = { "OVERMAP_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "hollow_village",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hollow_village1_north" },
        { point = { 1, 0, 0 }, terrain = "hollow_village2_north" },
        { point = { 2, 0, 0 }, terrain = "hollow_village3_north" },
        { point = { 0, 1, 0 }, terrain = "hollow_village4_north" },
        { point = { 1, 1, 0 }, terrain = "hollow_village5_north" },
        { point = { 2, 1, 0 }, terrain = "hollow_village6_north" },
        { point = { 0, 2, 0 }, terrain = "hollow_village7_north" },
        {
            point = { 1, 2, 0 },
            terrain = "hollow_village8_north",
            locations = { "forest_edge", "field", "lake_shore", "ocean_shore", "river_bank" },
        },
        { point = { 2, 2, 0 }, terrain = "hollow_village9_north" },
        { point = { 1, 1, 1 }, terrain = "hollow_village5_roofs_north" },
        { point = { 2, 1, 1 }, terrain = "hollow_village6_roofs_north" },
        { point = { 0, 2, 1 }, terrain = "hollow_village7_roofs_north" },
        { point = { 1, 2, 1 }, terrain = "hollow_village8_roofs_north" },
        { point = { 2, 2, 1 }, terrain = "hollow_village9_roofs_north" },
    },
    locations = { "wilderness" },
    city_distance = { 20, -5 },
    city_sizes = { 0, 13 },
    occurrences = { 50, 100 },
    flags = { "OVERMAP_UNIQUE" },
    spawns = { group = "GROUP_HOLLOW_TRIBAL_OUTRIDERS", population = { 15, 30 }, radius = { 4, 30 } },
}

ccb.content.define_fixed_overmap_special {
    id = "hollow_village_zombed",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hollow_village_zomb_1_north" },
        { point = { 1, 0, 0 }, terrain = "hollow_village_zomb_2_north" },
        { point = { 2, 0, 0 }, terrain = "hollow_village_zomb_3_north" },
        { point = { 0, 1, 0 }, terrain = "hollow_village_zomb_4_north" },
        { point = { 1, 1, 0 }, terrain = "hollow_village_zomb_5_north" },
        { point = { 2, 1, 0 }, terrain = "hollow_village_zomb_6_north" },
        { point = { 0, 2, 0 }, terrain = "hollow_village_zomb_7_north" },
        {
            point = { 1, 2, 0 },
            terrain = "hollow_village_zomb_8_north",
            locations = { "forest_edge", "field", "lake_shore" },
        },
        { point = { 2, 2, 0 }, terrain = "hollow_village_zomb_9_north" },
        { point = { 1, 1, 1 }, terrain = "hollow_village5_roofs_north" },
        { point = { 2, 1, 1 }, terrain = "hollow_village6_roofs_north" },
        { point = { 0, 2, 1 }, terrain = "hollow_village7_roofs_north" },
        { point = { 1, 2, 1 }, terrain = "hollow_village8_roofs_north" },
        { point = { 2, 2, 1 }, terrain = "hollow_village9_roofs_north" },
    },
    locations = { "wilderness" },
    city_distance = { 20, -5 },
    city_sizes = { 0, 13 },
    occurrences = { 33, 100 },
    flags = { "OVERMAP_UNIQUE" },
    spawns = { group = "GROUP_HOLLOW_ZOMBIES", population = { 15, 30 }, radius = { 2, 10 } },
}
