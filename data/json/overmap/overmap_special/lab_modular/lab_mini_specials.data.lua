local ccb = require("ccb")

-- This file consists of chunks of mapgen intended to be reusable for other labs, they don't spawn as is.
-- A secure parking lot and concrete wall.
ccb.content.define_fixed_overmap_special {
    id = "Lab_Parking_Lot",
    tiles = {
        { point = { -2, -2, 0 }, terrain = "lab_surface_parking_blockE1_west" },
        { point = { -3, -2, 0 }, terrain = "lab_surface_parking_blockE0_west" },
        { point = { -2, -1, 0 }, terrain = "lab_surface_parking_blockD1_west" },
        { point = { -3, -1, 0 }, terrain = "lab_surface_parking_blockD0_west" },
        { point = { -1, -2, 0 }, terrain = "lab_surface_parking_blockE2_west" },
        { point = { -1, -2, 1 }, terrain = "lab_surface_parking_blockE2_roof_west" },
        { point = { -1, 2, 0 }, terrain = "lab_surface_parking_blockA2_west" },
        { point = { -1, 2, 1 }, terrain = "lab_surface_parking_blockA2_roof_west" },
        { point = { -2, 0, 0 }, terrain = "lab_surface_parking_blockC1_west" },
        { point = { -3, 0, 0 }, terrain = "lab_surface_parking_blockC0_west" },
        { point = { -2, 2, 1 }, terrain = "lab_surface_parking_blockC0_roof_west" },
        { point = { -2, 1, 0 }, terrain = "lab_surface_parking_blockB1_west" },
        { point = { -3, 1, 0 }, terrain = "lab_surface_parking_blockB0_west" },
        { point = { -2, 2, 0 }, terrain = "lab_surface_parking_blockA1_west" },
        { point = { -3, 2, 0 }, terrain = "lab_surface_parking_blockA0_west" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- 2 z-level mutagen lab research area. This is the final floor version with no access to lower floors.
ccb.content.define_fixed_overmap_special {
    id = "Lab_MUTAGEN_2x2x2",
    tiles = {
        { point = { 0, 0, -5 }, terrain = "lab_2x2_MUT_tier_1_NW_north" },
        { point = { 1, 0, -5 }, terrain = "lab_2x2_MUT_tier_1_NE_north" },
        { point = { 0, 1, -5 }, terrain = "lab_2x2_MUT_tier_1_SW_north" },
        { point = { 1, 1, -5 }, terrain = "lab_2x2_MUT_tier_1_SE_north" },
        { point = { 0, 0, -6 }, terrain = "lab_2x2_MUT_tier_2_NW_final_flr_north" },
        { point = { 1, 0, -6 }, terrain = "lab_2x2_MUT_tier_2_NE_north" },
        { point = { 0, 1, -6 }, terrain = "lab_2x2_MUT_tier_2_SW_north" },
        { point = { 1, 1, -6 }, terrain = "lab_2x2_MUT_tier_2_SE_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- 2 z-level central transition area for mutagen labs.  Has a small balcony overlooking a concorse.
ccb.content.define_fixed_overmap_special {
    id = "Lab_CORE_2x1x2",
    tiles = {
        { point = { 0, -1, -2 }, terrain = "lab_CORE_2x1_1UP_north" },
        { point = { 1, -1, -2 }, terrain = "lab_CORE_2x1_2UP_north" },
        { point = { 0, -1, -3 }, terrain = "lab_CORE_2x1_1DN_north" },
        { point = { 1, -1, -3 }, terrain = "lab_CORE_2x1_2DN_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- 3 z-level central transition area for mutagen labs.  This is the lower ramp-access segment with a subway & mini-rail connector, security areas.
ccb.content.define_fixed_overmap_special {
    id = "Lab_CORE_2x1x3",
    tiles = {
        { point = { 0, -1, -4 }, terrain = "underground_lab_cargo_stationB_east" },
        { point = { 1, -1, -4 }, terrain = "underground_lab_cargo_stationA_east" },
        { point = { 2, -1, -4 }, terrain = "microlab_sub_connector_east" },
        { point = { 0, -1, -5 }, terrain = "underground_lab_central_-5W_east" },
        { point = { 1, -1, -5 }, terrain = "underground_lab_central_-5E_east" },
        { point = { 0, -1, -6 }, terrain = "underground_lab_central_-6W_east" },
        { point = { 1, -1, -6 }, terrain = "underground_lab_central_-6E_east" },
        { point = { 0, -1, -7 }, terrain = "underground_lab_central_-7W_east" },
        { point = { 1, -1, -7 }, terrain = "underground_lab_central_-7E_east" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- 2x2 single level lab area consisting of cargo areas and mini railroad. This acts as a central connecting point for the mutagen lab.
ccb.content.define_fixed_overmap_special {
    id = "Lab_CARGO_2x2x1",
    tiles = {
        { point = { 0, 0, -4 }, terrain = "lab_2x2_cargo_NW_north" },
        { point = { 1, 0, -4 }, terrain = "lab_2x2_cargo_NE_north" },
        { point = { 0, 1, -4 }, terrain = "lab_2x2_cargo_SW_north" },
        { point = { 1, 1, -4 }, terrain = "lab_2x2_cargo_SE_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- A 2 z level residential area. This includes segments of cargo/maintenance and retail areas.  This complements the mutagen lab.
ccb.content.define_fixed_overmap_special {
    id = "Lab_RES_2x2x2",
    tiles = {
        { point = { 0, 0, -2 }, terrain = "lab_res_8_NW_north" },
        { point = { 1, 0, -2 }, terrain = "lab_res_8_NE_north" },
        { point = { 0, 1, -2 }, terrain = "lab_res_8_SW_north" },
        { point = { 1, 1, -2 }, terrain = "lab_res_8_SE_north" },
        { point = { 0, 0, -3 }, terrain = "lab_res_8_NWD_north" },
        { point = { 1, 0, -3 }, terrain = "lab_res_8_NED_north" },
        { point = { 0, 1, -3 }, terrain = "lab_res_8_SWD_north" },
        { point = { 1, 1, -3 }, terrain = "lab_res_8_SED_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- A 2 z level residential area. This is self-contained and mimics the apartments in old labs.  Includes possible maintenance access points.
ccb.content.define_fixed_overmap_special {
    id = "Lab_APARTMENTS_1x1x2",
    tiles = {
        { point = { 2, -1, -2 }, terrain = "lab_1x1x2_RES_8_apartments_upper_north" },
        { point = { 2, -1, -3 }, terrain = "lab_1x1x2_RES_8_apartments_lower_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- A 2 z level residential area. This is self-contained and has 9 bedrooms with a common area.  Includes possible maintenance access points.
ccb.content.define_fixed_overmap_special {
    id = "Lab_RES_1x1x2_maintenance",
    tiles = {
        { point = { 2, 1, -2 }, terrain = "lab_1x1_RES_8_bedrooms_maintenance_north" },
        { point = { 2, 1, -3 }, terrain = "lab_1x1_RES_8_commons_MAINT_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- A 2 z level residential area. This is self-contained and has 9 bedrooms with a common area.  Includes possible maintenance access points.
ccb.content.define_fixed_overmap_special {
    id = "Lab_RES_1x1x2_security",
    tiles = {
        { point = { 2, 1, -2 }, terrain = "lab_1x1_RES_8_bedrooms_security_north" },
        { point = { 2, 1, -3 }, terrain = "lab_1x1_RES_8_commons_SEC_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- 6 z-level security tower. This includes the main lab entrance and security themed floors.
ccb.content.define_fixed_overmap_special {
    id = "Lab_SECURITY_1x1x6",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "lab_security_z0_north" },
        { point = { 0, 0, -1 }, terrain = "lab_security_z-1_north" },
        { point = { 0, 0, -2 }, terrain = "lab_security_z-2_north" },
        { point = { 0, 0, -3 }, terrain = "lab_security_z-3_north" },
        { point = { 0, 0, -4 }, terrain = "lab_security_z-4_north" },
        { point = { 0, 0, -5 }, terrain = "lab_security_z-5_north" },
        { point = { 0, 0, -6 }, terrain = "lab_security_z-6_final_flr_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- Ground level for the freight/cargo company lab top and -1 connecting ramp/maintenance access.
ccb.content.define_fixed_overmap_special {
    id = "Lab_CARGO_Surface",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "lab_CORE_2x1_WC_ground_north" },
        { point = { 0, -1, 0 }, terrain = "lab_CORE_2x1_NED_ground_north" },
        { point = { -1, -1, 0 }, terrain = "lab_security_z0N_north" },
        { point = { -1, 1, 0 }, terrain = "lab_security_z0S_north" },
        { point = { 0, -2, 0 }, terrain = "lab_res_8_SEU_ground_south", locations = { "land" } },
        { point = { 0, 2, 0 }, terrain = "lab_res_8_SWD_ground_north", locations = { "land" } },
        { point = { 0, 1, 0 }, terrain = "lab_CORE_2x1_SED_ground_north" },
        { point = { 1, -2, 0 }, terrain = "lab_res_8_SWU_ground_south", locations = { "land" } },
        { point = { 1, 2, 0 }, terrain = "lab_res_8_SED_ground_north", locations = { "land" } },
        { point = { 1, -1, 0 }, terrain = "lab_CORE_2x1_NWD_ground_north" },
        { point = { 1, 0, 0 }, terrain = "lab_CORE_2x1_EC_ground_north" },
        { point = { 1, 1, 0 }, terrain = "lab_CORE_2x1_SWD_ground_north" },
        { point = { 0, 2, -1 }, terrain = "lab_2x1_CORE_-1W_north" },
        { point = { 1, 2, -1 }, terrain = "lab_2x1_CORE_-1E_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- A 2 z level medical clinic. This is self-contained and designed for regular healthcare needs.  Includes possible maintenance access points.
ccb.content.define_fixed_overmap_special {
    id = "Lab_MEDICAL_2x1x2",
    tiles = {
        { point = { 2, 0, -2 }, terrain = "lab_health_z-2_A_north" },
        { point = { 3, 0, -2 }, terrain = "lab_health_z-2_B_north" },
        { point = { 2, 0, -3 }, terrain = "lab_health_z-3_A_north" },
        { point = { 3, 0, -3 }, terrain = "lab_health_z-3_B_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}

-- Lab maintenance areas that connect to other lab zones.
ccb.content.define_fixed_overmap_special {
    id = "Lab_MAINTENANCE_areas",
    tiles = {
        { point = { -1, 2, -2 }, terrain = "lab_maintenance_z-2&3_A_north" },
        { point = { 2, 2, -2 }, terrain = "lab_maintenance_z-2&3_B_north" },
        { point = { -1, 2, -3 }, terrain = "lab_maintenance_z-2&3_A_north" },
        { point = { 2, 2, -3 }, terrain = "lab_maintenance_z-2&3_B_north" },
    },
    locations = { "land" },
    city_distance = { 3, -1 },
    city_sizes = { 1, 16 },
    occurrences = { 0, 0 },
}
