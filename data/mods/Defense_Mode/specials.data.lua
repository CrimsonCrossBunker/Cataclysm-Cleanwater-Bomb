local ccb = require("ccb")

ccb.content.define_fixed_overmap_special {
    id = "bar",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bar_north" },
        { point = { 0, 0, 1 }, terrain = "bar_roof_north" },
    },
    locations = { "field" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "hospital",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dm_hospital_3_north" },
        { point = { 1, 0, 0 }, terrain = "dm_hospital_2_north" },
        { point = { 2, 0, 0 }, terrain = "dm_hospital_1_north" },
        { point = { 0, 1, 0 }, terrain = "dm_hospital_6_north" },
        { point = { 1, 1, 0 }, terrain = "dm_hospital_5_north" },
        { point = { 2, 1, 0 }, terrain = "dm_hospital_4_north" },
        { point = { 0, 2, 0 }, terrain = "dm_hospital_9_north" },
        { point = { 1, 2, 0 }, terrain = "dm_hospital_8_north" },
        { point = { 2, 2, 0 }, terrain = "dm_hospital_7_north" },
        { point = { 0, 0, 1 }, terrain = "hospital_3_roof_north" },
        { point = { 1, 0, 1 }, terrain = "hospital_2_roof_north" },
        { point = { 2, 0, 1 }, terrain = "hospital_1_roof_north" },
        { point = { 0, 1, 1 }, terrain = "hospital_6_roof_north" },
        { point = { 1, 1, 1 }, terrain = "hospital_5_roof_north" },
        { point = { 2, 1, 1 }, terrain = "hospital_4_roof_north" },
        { point = { 0, 2, 1 }, terrain = "hospital_9_roof_north" },
        { point = { 1, 2, 1 }, terrain = "hospital_8_roof_north" },
        { point = { 2, 2, 1 }, terrain = "hospital_7_roof_north" },
    },
    locations = { "field" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "public_works",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dm_public_works_NW_north" },
        { point = { 0, 0, 1 }, terrain = "public_works_NW_roof_north" },
        { point = { 1, 0, 0 }, terrain = "dm_public_works_NE_north" },
        { point = { 1, 0, 1 }, terrain = "public_works_NE_roof_north" },
        { point = { 0, 1, 0 }, terrain = "dm_public_works_SW_north" },
        { point = { 0, 1, 1 }, terrain = "public_works_SW_roof_north" },
        { point = { 1, 1, 0 }, terrain = "dm_public_works_SE_north" },
        { point = { 1, 1, 1 }, terrain = "public_works_SE_roof_north" },
    },
    locations = { "field" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "megastore",
    tiles = {
        { point = { 0, 4, 0 }, terrain = "megastore_parking_0_4_south" },
        { point = { 0, 3, 0 }, terrain = "megastore_parking_0_3_south" },
        { point = { 0, 2, 0 }, terrain = "megastore_parking_0_2_south" },
        { point = { 3, 1, 0 }, terrain = "megastore_parking_3_1_south" },
        { point = { 2, 1, 0 }, terrain = "megastore_parking_2_1_south" },
        { point = { 1, 1, 0 }, terrain = "megastore_parking_1_1_south" },
        { point = { 0, 1, 0 }, terrain = "megastore_parking_0_1_south" },
        { point = { 3, 0, 0 }, terrain = "megastore_parking_3_0_south" },
        { point = { 2, 0, 0 }, terrain = "megastore_parking_2_0_south" },
        { point = { 1, 0, 0 }, terrain = "megastore_parking_1_0_south" },
        { point = { 0, 0, 0 }, terrain = "megastore_parking_0_0_south" },
        { point = { 3, 4, 0 }, terrain = "megastore_0_0_0_south" },
        { point = { 2, 4, 0 }, terrain = "megastore_1_0_0_south" },
        { point = { 1, 4, 0 }, terrain = "megastore_2_0_0_south" },
        { point = { 3, 3, 0 }, terrain = "megastore_0_1_0_south" },
        { point = { 2, 3, 0 }, terrain = "megastore_1_1_0_south" },
        { point = { 1, 3, 0 }, terrain = "megastore_2_1_0_south" },
        { point = { 3, 2, 0 }, terrain = "megastore_0_2_0_south" },
        { point = { 2, 2, 0 }, terrain = "megastore_1_2_0_south" },
        { point = { 1, 2, 0 }, terrain = "megastore_2_2_0_south" },
        { point = { 3, 4, 1 }, terrain = "megastore_0_0_1_south" },
        { point = { 2, 4, 1 }, terrain = "megastore_1_0_1_south" },
        { point = { 1, 4, 1 }, terrain = "megastore_2_0_1_south" },
        { point = { 3, 3, 1 }, terrain = "megastore_0_1_1_south" },
        { point = { 2, 3, 1 }, terrain = "megastore_1_1_1_south" },
        { point = { 1, 3, 1 }, terrain = "megastore_2_1_1_south" },
        { point = { 3, 2, 1 }, terrain = "megastore_0_2_1_south" },
        { point = { 2, 2, 1 }, terrain = "megastore_1_2_1_south" },
        { point = { 1, 2, 1 }, terrain = "megastore_2_2_1_south" },
        { point = { 3, 4, 2 }, terrain = "megastore_0_0_roof_south" },
        { point = { 2, 4, 2 }, terrain = "megastore_1_0_roof_south" },
        { point = { 1, 4, 2 }, terrain = "megastore_2_0_roof_south" },
        { point = { 3, 3, 2 }, terrain = "megastore_0_1_roof_south" },
        { point = { 2, 3, 2 }, terrain = "megastore_1_1_roof_south" },
        { point = { 1, 3, 2 }, terrain = "megastore_2_1_roof_south" },
        { point = { 3, 2, 2 }, terrain = "megastore_0_2_roof_south" },
        { point = { 2, 2, 2 }, terrain = "megastore_1_2_roof_south" },
        { point = { 1, 2, 2 }, terrain = "megastore_2_2_roof_south" },
    },
    locations = { "field" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "mansion",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dm_mansion_c5_north" },
        { point = { 0, 0, 2 }, terrain = "mansion_c5_roof_north" },
        { point = { 1, 0, 0 }, terrain = "dm_mansion_e2_north" },
        { point = { 1, 0, 2 }, terrain = "mansion_e2_roof_north" },
        { point = { 2, 0, 0 }, terrain = "dm_mansion_c3_east" },
        { point = { 2, 0, 2 }, terrain = "mansion_c3_roof_east" },
        { point = { 0, 1, 0 }, terrain = "dm_mansion_t2_east" },
        { point = { 0, 1, 2 }, terrain = "mansion_t2_roof_east" },
        { point = { 1, 1, 0 }, terrain = "dm_mansion_+2_north" },
        { point = { 1, 1, 2 }, terrain = "mansion_+2_roof_north" },
        { point = { 2, 1, 0 }, terrain = "dm_mansion_t6_west" },
        { point = { 2, 1, 2 }, terrain = "mansion_t6_roof_west" },
        { point = { 0, 2, 0 }, terrain = "dm_mansion_c4_west" },
        { point = { 0, 2, 2 }, terrain = "mansion_c4_roof_west" },
        { point = { 1, 2, 0 }, terrain = "dm_mansion_t7_north" },
        { point = { 1, 2, 2 }, terrain = "mansion_t7_roof_north" },
        { point = { 2, 2, 0 }, terrain = "dm_mansion_c1_south" },
        { point = { 2, 2, 2 }, terrain = "mansion_c1_roof_south" },
        { point = { 0, 0, 1 }, terrain = "dm_mansion_c5u_north" },
        { point = { 1, 0, 1 }, terrain = "dm_mansion_e2u_north" },
        { point = { 2, 0, 1 }, terrain = "dm_mansion_c3u_east" },
        { point = { 0, 1, 1 }, terrain = "dm_mansion_t2u_east" },
        { point = { 1, 1, 1 }, terrain = "dm_mansion_+2u_north" },
        { point = { 2, 1, 1 }, terrain = "dm_mansion_t6u_west" },
        { point = { 0, 2, 1 }, terrain = "dm_mansion_c4u_west" },
        { point = { 1, 2, 1 }, terrain = "dm_mansion_t7u_north" },
        { point = { 2, 2, 1 }, terrain = "dm_mansion_c1u_south" },
        { point = { 0, 0, -1 }, terrain = "dm_mansion_c5d_north" },
        { point = { 1, 0, -1 }, terrain = "dm_mansion_e2d_north" },
        { point = { 2, 0, -1 }, terrain = "dm_mansion_c3d_east" },
        { point = { 0, 1, -1 }, terrain = "dm_mansion_t2d_east" },
        { point = { 1, 1, -1 }, terrain = "dm_mansion_+2d_north" },
        { point = { 2, 1, -1 }, terrain = "dm_mansion_t6d_west" },
        { point = { 0, 2, -1 }, terrain = "dm_mansion_c4d_west" },
        { point = { 1, 2, -1 }, terrain = "dm_mansion_t7d_north" },
        { point = { 2, 2, -1 }, terrain = "dm_mansion_c1d_south" },
    },
    locations = { "field" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "survivor_forest_camp",
    tiles = { { point = { 0, 0, 0 }, terrain = "dm_survivor_forest_camp_north" } },
    locations = { "forest_center" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "Evac Shelter",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "shelter_north" },
        { point = { 0, 0, -1 }, terrain = "shelter_under_north" },
        { point = { 0, 0, 1 }, terrain = "shelter_roof_north" },
    },
    locations = { "wilderness" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "Cabin",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cabin_north" },
        { point = { 0, 0, 1 }, terrain = "cabin_roof_north" },
    },
    locations = { "forest" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "Cave",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cave" },
        { point = { 0, 0, -1 }, terrain = "cave_underground" },
    },
    locations = { "forest" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "Sugar House",
    tiles = {
        { point = { 0, -1, 0 }, terrain = "sugar_house_parking_north" },
        { point = { 0, 0, 0 }, terrain = "sugar_house_north" },
        { point = { 0, 0, 1 }, terrain = "sugar_house_roof_north" },
    },
    locations = { "forest" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "motel-twd",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "motel_twd_1_north" },
        { point = { 1, 0, 0 }, terrain = "motel_twd_2_north" },
        { point = { 0, 0, 1 }, terrain = "motel_twd_1_f1_north" },
        { point = { 1, 0, 1 }, terrain = "motel_twd_2_f1_north" },
        { point = { 0, 0, 2 }, terrain = "motel_twd_1_f2_north" },
    },
    locations = { "land" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "bank",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bank_north" },
        { point = { 0, 0, 1 }, terrain = "bank_roof_north" },
    },
    locations = { "land" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "pawn_shop",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pawn_north" },
        { point = { 0, 0, 1 }, terrain = "pawn_roof_north" },
    },
    locations = { "land" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}

ccb.content.define_fixed_overmap_special {
    id = "restraunt",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_roof_north" },
    },
    locations = { "land" },
    city_distance = { 40, -1 },
    occurrences = { 100, 100 },
    flags = { "DEFENSE_MODE", "GLOBALLY_UNIQUE" },
}
