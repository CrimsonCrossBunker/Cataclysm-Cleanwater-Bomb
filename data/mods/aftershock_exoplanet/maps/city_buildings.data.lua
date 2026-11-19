local ccb = require("ccb")

ccb.content.define_city_building {
    id = "house_09",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_09_north" },
        { point = { 0, 0, 1 }, terrain = "house_09_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_bionic_north" },
    },
}

ccb.content.define_city_building {
    id = "afs_augmentation_clinic_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_augmentation_clinic_n1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_augmentation_clinic_n2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_augmentation_clinic_n3_north" },
        { point = { 0, 0, 3 }, terrain = "afs_augmentation_clinic_n4_north" },
        { point = { 1, 0, 0 }, terrain = "afs_urban_aquaponicsw_n1_north" },
        { point = { 1, 0, 1 }, terrain = "afs_urban_aquaponicsw_n2_north" },
        { point = { 1, 0, 2 }, terrain = "afs_urban_aquaponicsw_n3_north" },
    },
    locations = { "land" },
}

-- needs work.  remember to check against notes on phone
ccb.content.define_city_building {
    id = "afs_city_arcology1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "arcology_interior_center_robots_north" },
        { point = { -1, 0, 0 }, terrain = "arcology_interior_w_side_robots_north" },
        { point = { 1, 0, 0 }, terrain = "arcology_interior_e_side_robots_north" },
        { point = { 0, -1, 0 }, terrain = "arcology_interior_n_side_robots_north" },
        { point = { 0, 1, 0 }, terrain = "arcology_interior_s_side_robots_north" },
        { point = { 1, -1, 0 }, terrain = "arcology_interior_ne_corner_robots_north" },
        { point = { -1, -1, 0 }, terrain = "arcology_interior_nw_corner_robots_north" },
        { point = { 1, 1, 0 }, terrain = "arcology_interior_se_corner_robots_north" },
        { point = { -1, 1, 0 }, terrain = "arcology_interior_sw_corner_robots_north" },
        { point = { -2, 1, 0 }, terrain = "arcology_exterior_w_side_robots_north" },
        { point = { -2, 0, 0 }, terrain = "arcology_exterior_w_entrance_robots_north" },
        { point = { -2, -1, 0 }, terrain = "arcology_exterior_w_side_robots_north" },
        { point = { 2, 1, 0 }, terrain = "arcology_exterior_e_side_robots_north" },
        { point = { 2, 0, 0 }, terrain = "arcology_exterior_e_entrance_robots_north" },
        { point = { 2, -1, 0 }, terrain = "arcology_exterior_e_side_robots_north" },
        { point = { -1, -2, 0 }, terrain = "arcology_exterior_n_side_robots_north" },
        { point = { 0, -2, 0 }, terrain = "arcology_exterior_n_entrance_robots_north" },
        { point = { 1, -2, 0 }, terrain = "arcology_exterior_n_side_robots_north" },
        { point = { 1, 2, 0 }, terrain = "arcology_exterior_s_side_robots_north" },
        { point = { 0, 2, 0 }, terrain = "arcology_exterior_s_entrance_robots_north" },
        { point = { -1, 2, 0 }, terrain = "arcology_exterior_s_side_robots_north" },
        { point = { 2, -2, 0 }, terrain = "arcology_exterior_ne_corner_robots_north" },
        { point = { -2, -2, 0 }, terrain = "arcology_exterior_nw_corner_robots_north" },
        { point = { 2, 2, 0 }, terrain = "arcology_exterior_se_corner_robots_north" },
        { point = { -2, 2, 0 }, terrain = "arcology_exterior_sw_corner_robots_north" },
    },
    locations = { "land" },
}

-- needs work.  remember to check against notes on phone
ccb.content.define_city_building {
    id = "afs_city_arcology2",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "arcology_interior_center_uplifts_north" },
        { point = { -1, 0, 0 }, terrain = "arcology_interior_w_side_uplifts_north" },
        { point = { 1, 0, 0 }, terrain = "arcology_interior_e_side_uplifts_north" },
        { point = { 0, -1, 0 }, terrain = "arcology_interior_n_side_uplifts_north" },
        { point = { 0, 1, 0 }, terrain = "arcology_interior_s_side_uplifts_north" },
        { point = { 1, -1, 0 }, terrain = "arcology_interior_ne_corner_uplifts_north" },
        { point = { -1, -1, 0 }, terrain = "arcology_interior_nw_corner_uplifts_north" },
        { point = { 1, 1, 0 }, terrain = "arcology_interior_se_corner_uplifts_north" },
        { point = { -1, 1, 0 }, terrain = "arcology_interior_sw_corner_uplifts_north" },
        { point = { -2, 1, 0 }, terrain = "arcology_exterior_w_side_uplifts_north" },
        { point = { -2, 0, 0 }, terrain = "arcology_exterior_w_entrance_uplifts_north" },
        { point = { -2, -1, 0 }, terrain = "arcology_exterior_w_side_uplifts_north" },
        { point = { 2, 1, 0 }, terrain = "arcology_exterior_e_side_uplifts_north" },
        { point = { 2, 0, 0 }, terrain = "arcology_exterior_e_entrance_uplifts_north" },
        { point = { 2, -1, 0 }, terrain = "arcology_exterior_e_side_uplifts_north" },
        { point = { -1, -2, 0 }, terrain = "arcology_exterior_n_side_uplifts_north" },
        { point = { 0, -2, 0 }, terrain = "arcology_exterior_n_entrance_uplifts_north" },
        { point = { 1, -2, 0 }, terrain = "arcology_exterior_n_side_uplifts_north" },
        { point = { 1, 2, 0 }, terrain = "arcology_exterior_s_side_uplifts_north" },
        { point = { 0, 2, 0 }, terrain = "arcology_exterior_s_entrance_uplifts_north" },
        { point = { -1, 2, 0 }, terrain = "arcology_exterior_s_side_uplifts_north" },
        { point = { 2, -2, 0 }, terrain = "arcology_exterior_ne_corner_uplifts_north" },
        { point = { -2, -2, 0 }, terrain = "arcology_exterior_nw_corner_uplifts_north" },
        { point = { 2, 2, 0 }, terrain = "arcology_exterior_se_corner_uplifts_north" },
        { point = { -2, 2, 0 }, terrain = "arcology_exterior_sw_corner_uplifts_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_astrobiology_lab",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_astrobiology_lab_n1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_astrobiology_lab_n2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_city_ruinfield",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { 1, 0, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { -1, 0, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { 0, 1, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { 1, 1, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { -1, 1, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { 0, 2, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { 1, 2, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
        { point = { -1, 2, 0 }, terrain = "afs_formless_ruins_dynamic_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_city_urban_farm_small",
    tiles = {
        { point = { 0, 1, 0 }, terrain = "afs_modular_habitat_center_small_ground_level_north" },
        { point = { 0, 1, 1 }, terrain = "afs_modular_habitat_center_small_ground_level_above_north" },
        { point = { 0, 1, 2 }, terrain = "afs_modular_habitat_center_maintenance_tiny_north" },
        { point = { 0, 1, 3 }, terrain = "afs_modular_habitat_center_farm_north" },
        { point = { 0, 1, 4 }, terrain = "afs_modular_habitat_greenhouse_control_ramp_north" },
        { point = { 0, 1, 5 }, terrain = "afs_modular_habitat_roof_north" },
        { point = { 0, 0, 0 }, terrain = "afs_modular_habitat_pillars_ground_walkway_north" },
        { point = { 0, 0, 1 }, terrain = "afs_modular_habitat_end_pillars_above_walkway_north" },
        { point = { 0, 0, 2 }, terrain = "afs_modular_habitat_pillars_north" },
        { point = { 0, 0, 3 }, terrain = "afs_modular_habitat_greenhouse_ramp_up_north" },
        { point = { 0, 0, 4 }, terrain = "afs_modular_habitat_roof_north" },
        { point = { 1, 1, 0 }, terrain = "afs_modular_habitat_pillars_ground_east" },
        { point = { 1, 1, 1 }, terrain = "afs_modular_habitat_pillars_east" },
        { point = { 1, 1, 2 }, terrain = "afs_modular_habitat_pillars_east" },
        { point = { 1, 1, 3 }, terrain = "afs_modular_habitat_greenhouse_east" },
        { point = { 1, 1, 4 }, terrain = "afs_modular_habitat_roof_east" },
        { point = { -1, 1, 0 }, terrain = "afs_modular_habitat_pillars_ground_west" },
        { point = { -1, 1, 1 }, terrain = "afs_modular_habitat_pillars_west" },
        { point = { -1, 1, 2 }, terrain = "afs_modular_habitat_pillars_west" },
        { point = { -1, 1, 3 }, terrain = "afs_modular_habitat_greenhouse_west" },
        { point = { -1, 1, 4 }, terrain = "afs_modular_habitat_roof_west" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_city_urban_industrial_habitat",
    tiles = {
        { point = { 0, 1, 0 }, terrain = "afs_modular_habitat_center_small_ground_level_north" },
        { point = { 0, 1, 1 }, terrain = "afs_modular_habitat_center_small_ground_level_above_north" },
        { point = { 0, 1, 2 }, terrain = "afs_modular_habitat_center_maintenance_tiny_north" },
        { point = { 0, 1, 3 }, terrain = "afs_modular_habitat_center_industry_north" },
        { point = { 0, 1, 4 }, terrain = "afs_modular_habitat_roof_north" },
        { point = { 0, 1, 5 }, terrain = "afs_modular_habitat_roof_north" },
        { point = { 0, 0, 0 }, terrain = "afs_modular_habitat_pillars_ground_walkway_north" },
        { point = { 0, 0, 1 }, terrain = "afs_modular_habitat_end_pillars_above_walkway_north" },
        { point = { 0, 0, 2 }, terrain = "afs_modular_habitat_pillars_north" },
        { point = { 0, 0, 3 }, terrain = "afs_modular_habitat_industry_north" },
        { point = { 0, 0, 4 }, terrain = "afs_modular_habitat_roof_north" },
        { point = { 1, 1, 0 }, terrain = "afs_modular_habitat_pillars_ground_east" },
        { point = { 1, 1, 1 }, terrain = "afs_modular_habitat_pillars_east" },
        { point = { 1, 1, 2 }, terrain = "afs_modular_habitat_pillars_east" },
        { point = { 1, 1, 3 }, terrain = "afs_modular_habitat_industry_east" },
        { point = { 1, 1, 4 }, terrain = "afs_modular_habitat_roof_east" },
        { point = { 0, 2, 0 }, terrain = "afs_modular_habitat_pillars_ground_south" },
        { point = { 0, 2, 1 }, terrain = "afs_modular_habitat_pillars_south" },
        { point = { 0, 2, 2 }, terrain = "afs_modular_habitat_pillars_south" },
        { point = { 0, 2, 3 }, terrain = "afs_modular_habitat_industry_south" },
        { point = { 0, 2, 4 }, terrain = "afs_modular_habitat_roof_south" },
        { point = { -1, 1, 0 }, terrain = "afs_modular_habitat_pillars_ground_west" },
        { point = { -1, 1, 1 }, terrain = "afs_modular_habitat_pillars_west" },
        { point = { -1, 1, 2 }, terrain = "afs_modular_habitat_pillars_west" },
        { point = { -1, 1, 3 }, terrain = "afs_modular_habitat_biodiesel_straight_west" },
        { point = { -1, 1, 4 }, terrain = "afs_modular_habitat_roof_west" },
        { point = { -2, 1, 0 }, terrain = "afs_modular_habitat_pillars_ground_west" },
        { point = { -2, 1, 1 }, terrain = "afs_modular_habitat_pillars_west" },
        { point = { -2, 1, 2 }, terrain = "afs_modular_habitat_pillars_west" },
        { point = { -2, 1, 3 }, terrain = "afs_modular_habitat_biodiesel_end_west" },
        { point = { -2, 1, 4 }, terrain = "afs_modular_habitat_roof_west" },
        { point = { -2, 1, 5 }, terrain = "afs_modular_habitat_roof_west" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "bio_tech_flats_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 0, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 0, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { 0, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -1, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -1, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -1, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -1, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -2, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -2, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -2, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -2, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -3, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -3, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -3, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -3, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -4, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -4, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -4, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -4, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { 0, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 0, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 0, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { 0, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -1, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -1, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -1, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -1, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -2, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -2, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -2, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -2, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -3, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -3, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -3, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -3, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -4, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -4, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -4, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -4, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "bio_tech_flats_2",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 0, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 0, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { 0, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -1, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -1, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -1, 0, -1 }, terrain = "afs_modular_greenhouse_moxie_north" },
        { point = { -1, 1, -1 }, terrain = "afs_modular_greenhouse_moxie_south" },
        { point = { -2, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -2, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -2, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -2, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -3, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -3, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -3, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -3, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -4, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -4, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -4, 0, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -4, 1, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { 0, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 0, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 0, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { 0, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -1, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -1, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -1, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -1, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -2, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -2, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -2, 2, -1 }, terrain = "afs_modular_greenhouse_moxie_north" },
        { point = { -2, 3, -1 }, terrain = "afs_modular_greenhouse_moxie_south" },
        { point = { -3, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -3, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -3, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -3, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
        { point = { -4, 2, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { -4, 3, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { -4, 2, -1 }, terrain = "afs_modular_greenhouse_algae_north" },
        { point = { -4, 3, -1 }, terrain = "afs_modular_greenhouse_algae_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "bio_tech_flats_3",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 0, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 0, 0, -1 }, terrain = "afs_modular_greenhouse_slurry_north" },
        { point = { 0, 1, -1 }, terrain = "afs_modular_greenhouse_slurry_south" },
        { point = { 1, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 1, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 1, 0, -1 }, terrain = "afs_modular_greenhouse_slurry_north" },
        { point = { 1, 1, -1 }, terrain = "afs_modular_greenhouse_slurry_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "bio_tech_flats_4",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 0, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 0, 0, -1 }, terrain = "afs_modular_greenhouse_hydro_north" },
        { point = { 0, 1, -1 }, terrain = "afs_modular_greenhouse_hydro_south" },
        { point = { 1, 0, 0 }, terrain = "afs_modular_greenhouse_north" },
        { point = { 1, 1, 0 }, terrain = "afs_modular_greenhouse_south" },
        { point = { 1, 0, -1 }, terrain = "afs_modular_greenhouse_hydro_north" },
        { point = { 1, 1, -1 }, terrain = "afs_modular_greenhouse_hydro_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_house_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_shelter_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_shelter_1_roof_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_general_store_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_general_store_n1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_general_store_n2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_general_store_n3_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_grocer",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_grocer_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_grocer_a1_floor_2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_grocer_a1_floor_3_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_clothing_store",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_clothing_store_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_clothing_store_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_sporting_goods_store",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_sporting_goods_store_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_sporting_goods_store_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_clinic_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_clinic_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_clinic_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_small_urban_farm_ground",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_small_urban_farm_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_small_urban_farm_a1_floor_2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_small_urban_farm_a1_floor_3_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_small_office",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_small_office_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_small_office_a1_floor_2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_small_office_a1_floor_3_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_cafe_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_cafe_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_cafe_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_saloon_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_saloon_1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_saloon_1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_garage_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_garage_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_garage_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_garage_2",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_garage_2_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_garage_2_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_ev_station",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_ev_station_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_ev_station_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_aerodrone_landing_pad",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_aerodrone_landing_pad_a1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_aerodrone_landing_pad_a1_floor_2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_enclosed_park",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_park_dome_ground_floor_north" },
        { point = { 0, 0, 1 }, terrain = "afs_park_dome_2nd_floor_north" },
        { point = { 0, 0, 2 }, terrain = "afs_park_dome_roof_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_enforcer_station_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_enforcer_station_a1_south" },
        { point = { 0, 0, 1 }, terrain = "afs_enforcer_station_a1_floor2_south" },
        { point = { 0, 0, 2 }, terrain = "afs_enforcer_station_a1_roof_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_exosuit_garage_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_exosuit_garage_a1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_exosuit_garage_a1_roof_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_exosuit_garage_2",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_exosuit_garage_2_a1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_exosuit_garage_2_a1_roof_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_habitat_block_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_habblock_1_a1_north" },
        { point = { 1, 0, 0 }, terrain = "afs_hablock_1_a2_north" },
        { point = { 0, 0, 1 }, terrain = "afs_habblock_1_floor2_a1_north" },
        { point = { 1, 0, 1 }, terrain = "afs_hablock_1_floor2_a2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_habblock_1_roof_a1_north" },
        { point = { 1, 0, 2 }, terrain = "afs_hablock_1_roof_a2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_habitat_block_2",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_habblock_2_a1_north" },
        { point = { 1, 0, 0 }, terrain = "afs_hablock_2_a2_north" },
        { point = { 0, 1, 0 }, terrain = "afs_habblock_2_a3_north" },
        { point = { 1, 1, 0 }, terrain = "afs_habblock_2_a4_north" },
        { point = { 0, 0, 1 }, terrain = "afs_habblock_2_floor2_a1_north" },
        { point = { 1, 0, 1 }, terrain = "afs_hablock_2_floor2_a2_north" },
        { point = { 0, 1, 1 }, terrain = "afs_habblock_2_floor2_a3_north" },
        { point = { 1, 1, 1 }, terrain = "afs_habblock_2_floor2_a4_north" },
        { point = { 0, 0, 2 }, terrain = "afs_habblock_2_floor3_a1_north" },
        { point = { 1, 0, 2 }, terrain = "afs_hablock_2_floor3_a2_north" },
        { point = { 0, 1, 2 }, terrain = "afs_habblock_2_floor3_a3_north" },
        { point = { 1, 1, 2 }, terrain = "afs_habblock_2_floor3_a4_north" },
        { point = { 0, 0, 3 }, terrain = "afs_habblock_2_floor4_a1_north" },
        { point = { 1, 0, 3 }, terrain = "afs_hablock_2_floor4_a2_north" },
        { point = { 0, 1, 3 }, terrain = "afs_habblock_2_floor4_a3_north" },
        { point = { 1, 1, 3 }, terrain = "afs_habblock_2_floor4_a4_north" },
        { point = { 0, 0, 4 }, terrain = "afs_habblock_2_floor5_a1_north" },
        { point = { 1, 0, 4 }, terrain = "afs_hablock_2_floor5_a2_north" },
        { point = { 0, 1, 4 }, terrain = "afs_habblock_2_floor5_a3_north" },
        { point = { 1, 1, 4 }, terrain = "afs_habblock_2_floor5_a4_north" },
        { point = { 0, 0, 5 }, terrain = "afs_habblock_2_roof_a1_north" },
        { point = { 0, 1, 5 }, terrain = "afs_habblock_2_roof_a2_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_habitat_block_3",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_habblock_3_ground_north" },
        { point = { 0, 0, 1 }, terrain = "afs_habblock_3_floor_2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_habblock_3_floor_3_north" },
        { point = { 0, 0, 3 }, terrain = "afs_habblock_3_floor_4_north" },
        { point = { 0, 0, 4 }, terrain = "afs_habblock_3_roof_north" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_shuttle_pad",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "afs_shuttle_pad_a1_south" },
        { point = { 0, 0, 0 }, terrain = "afs_shuttle_pad_a2_south" },
        { point = { 1, 0, 1 }, terrain = "afs_shuttle_pad_a1_roof_south" },
        { point = { 0, 0, 1 }, terrain = "afs_shuttle_pad_a2_roof_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_vehicle_bay",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "afs_vehicle_bay_a1_south" },
        { point = { 0, 0, 0 }, terrain = "afs_vehicle_bay_a2_south" },
        { point = { 1, 0, 1 }, terrain = "afs_vehicle_bay_a1_roof_south" },
        { point = { 0, 0, 1 }, terrain = "afs_vehicle_bay_a2_roof_south" },
    },
    locations = { "land" },
}

ccb.content.define_city_building {
    id = "afs_gene_clinic_1",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "afs_gene_clinic_1_a1_north" },
        { point = { 0, 0, 1 }, terrain = "afs_gene_clinic_1_a2_north" },
        { point = { 0, 0, 2 }, terrain = "afs_gene_clinic_1_a3_north" },
        { point = { 0, 0, 3 }, terrain = "afs_gene_clinic_1_a4_north" },
    },
    locations = { "land" },
}
