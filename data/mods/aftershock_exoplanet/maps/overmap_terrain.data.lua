local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "basement_bionic" },
    copy_from = "generic_city_house_basement",
    spawns = { group = "GROUP_BASEMENT_HOUSE", population = { 1, 1 }, chance = 80 },
}

ccb.content.define_overmap_terrain {
    id = "municipal_reactor",
    name = ccb.content.text("municipal reactor"),
    symbol = "O",
    color = "light_green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "prepnet_orchard",
    copy_from = "generic_city_building",
    name = ccb.content.text("PrepNet orchard"),
    symbol = "#",
    color = "i_green",
    flags = { "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "afs_crashed_escape_pod",
    name = ccb.content.text("crashed escape pod"),
    symbol = "+",
    color = "i_red",
    see_cost = "medium",
    flags = { "SOURCE_FOOD", "SOURCE_GUN", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("old landing pad"),
    id = { "afs_shuttlepad_salvors_old_pad" },
    symbol = "0",
    color = "red",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "afs_landed_shuttle",
    name = ccb.content.text("drone shuttle landing site"),
    symbol = "^",
    color = "yellow",
    see_cost = "low",
    flags = { "SOURCE_SAFETY", "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = "municipal_reactor_ware",
    name = ccb.content.text("warehouse"),
    symbol = "w",
    color = "pink",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    id = "municipal_reactor_ware_b",
    name = ccb.content.text("waste storage"),
    symbol = "O",
    color = "light_red",
    see_cost = "high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "municipal_reactor_b",
    name = ccb.content.text("waste storage"),
    symbol = "O",
    color = "light_red",
    see_cost = "high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "municipal_reactor_b2",
    name = ccb.content.text("reactor control"),
    symbol = "O",
    color = "light_red",
    see_cost = "high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "municipal_reactor_b3",
    name = ccb.content.text("reactor room"),
    symbol = "O",
    color = "light_red",
    see_cost = "high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "sieged_fungal_tower",
    name = ccb.content.text("fungal tower"),
    symbol = "T",
    color = "pink",
    see_cost = "spaced_high",
    extras = "marloss",
    flags = { "NO_ROTATE", "RISK_EXTREME" },
}

ccb.content.define_overmap_terrain {
    id = "afs_crashed_cargo_shuttle",
    name = ccb.content.text("crashed cargo droneship"),
    symbol = "s",
    color = "i_red",
    see_cost = "medium",
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = "afs_crashed_cargo_shuttle_wraitheon",
    name = ccb.content.text("crashed military droneship"),
    symbol = "s",
    color = "light_green",
    see_cost = "medium",
    flags = { "RISK_EXTREME", "SOURCE_GUN", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    id = "afs_ruins_dynamic",
    name = ccb.content.text("ruined building"),
    symbol = "r",
    color = "light_gray",
    flags = { "SIDEWALK", "NO_ROTATE" },
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_formless_ruins_dynamic" },
    name = ccb.content.text("formless ruins"),
    spawns = { group = "GROUP_ZOMBIE", population = { 1, 4 }, chance = 50 },
    symbol = "r",
    color = "light_gray",
    flags = { "SIDEWALK" },
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_formless_ruins_aeolian" },
    name = ccb.content.text("lonely ruins"),
    symbol = "r",
    color = "light_gray",
    looks_like = "afs_formless_ruins_dynamic",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_formless_ruins_industrial", "afs_formless_ruins_pipe" },
    name = ccb.content.text("industrial ruins"),
    symbol = "r",
    color = "light_gray",
    looks_like = "afs_formless_ruins_dynamic",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = {
        "afs_augmentation_clinic_n1", "afs_augmentation_clinic_n2", "afs_augmentation_clinic_n3",
        "afs_augmentation_clinic_n4",
    },
    name = ccb.content.text("augmentation clinic"),
    spawns = { group = "AFS_GROUP_AUG_CLINIC", population = { 4, 10 }, chance = 80 },
    symbol = "P",
    color = "yellow",
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "maintenance_outpost_a1", "maintenance_outpost_a2", "maintenance_outpost_b1",
        "maintenance_outpost_b2", "maintenance_outpost_a1_roof", "maintenance_outpost_a2_roof",
        "maintenance_outpost_b1_roof", "maintenance_outpost_b2_roof",
    },
    name = ccb.content.text("maintenance outpost"),
    symbol = "i",
    color = "cyan",
    flags = { "SOURCE_FABRICATION", "SOURCE_ELECTRONICS", "SOURCE_CONSTRUCTION", "PP_GENERATE_RUINED" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_urban_aquaponicsw_n1", "afs_urban_aquaponicsw_n2", "afs_urban_aquaponicsw_n3" },
    name = ccb.content.text("aquacultural farm"),
    spawns = { group = "AFS_GROUP_AUG_CLINIC", population = { 4, 10 }, chance = 80 },
    symbol = "Q",
    color = "cyan",
    flags = { "SIDEWALK", "SOURCE_FOOD", "PP_GENERATE_RUINED" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_stratoscomm_relay_s1", "afs_stratoscomm_relay_n1", "afs_stratoscomm_relay_n2" },
    name = ccb.content.text("stratoscomm relay station"),
    symbol = "t",
    color = "yellow",
    flags = { "SIDEWALK" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "afs_modular_greenhouse", "afs_modular_greenhouse_moxie", "afs_modular_greenhouse_algae",
        "afs_modular_greenhouse_slurry", "afs_modular_greenhouse_hydro",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("biotechnical flats"),
    symbol = "^",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = { "afs_astrobiology_lab_n1", "afs_astrobiology_lab_n2" },
    name = ccb.content.text("astrobiology lab"),
    spawns = { group = "GROUP_ZOMBIE", population = { 2, 5 }, chance = 80 },
    symbol = "L",
    color = "light_green",
    flags = { "SIDEWALK", "SOURCE_FOOD", "PP_GENERATE_RUINED" },
    see_cost = "high",
    monster_density = 3,
}

ccb.content.define_overmap_terrain {
    id = "mortuary_2story",
    name = ccb.content.text("county mortuary"),
    symbol = "M",
    color = "light_green",
    see_cost = "high",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "mortuary_basement",
    name = ccb.content.text("county mortuary basement"),
    symbol = "M",
    color = "white",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "mortuary_2story_second",
    name = ccb.content.text("county mortuary second floor"),
    symbol = "M",
    color = "light_green",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "mortuary_2story_roof",
    name = ccb.content.text("county mortuary roof"),
    symbol = "M",
    color = "light_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = "whately_lmoe",
    name = ccb.content.text("LMOE shelter"),
    symbol = "+",
    color = "red",
    see_cost = "spaced_high",
    flags = { "KNOWN_DOWN", "SOURCE_PEOPLE", "SOURCE_SAFETY", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "whately_lmoe_roof",
    name = ccb.content.text("LMOE shelter"),
    symbol = ".",
    color = "brown",
    see_cost = "none",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = "whately_lmoe_under_first_floor",
    name = ccb.content.text("LMOE shelter"),
    symbol = "+",
    color = "red",
    see_cost = "full_high",
    flags = { "KNOWN_UP", "SOURCE_PEOPLE", "SOURCE_SAFETY", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "whately_lmoe_under_second_floor",
    name = ccb.content.text("LMOE shelter"),
    symbol = "+",
    color = "red",
    see_cost = "full_high",
    flags = { "KNOWN_UP", "SOURCE_PEOPLE", "SOURCE_SAFETY", "SOURCE_GUN", "SOURCE_AMMO", "SOURCE_FOOD" },
}

ccb.content.define_overmap_terrain {
    id = "robot_dispatch_first",
    name = ccb.content.text("robot dispatch center"),
    symbol = "R",
    color = "i_pink",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    id = { "robot_dispatch_second", "robot_dispatch_roof" },
    name = ccb.content.text("robot dispatch center"),
    flags = { "PP_GENERATE_RUINED" },
    symbol = "R",
    color = "i_pink",
    see_cost = "high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = {
        "land_pad_outpost_a1",
        "land_pad_outpost_a2",
        "land_pad_outpost_a1_roof",
        "land_pad_outpost_a2_roof",
    },
    name = ccb.content.text("landing pad outpost"),
    symbol = "+",
    color = "red",
    see_cost = "low",
    flags = { "SOURCE_PEOPLE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = "afs_pipe_ramp_down_ruins",
    name = ccb.content.text("conduit"),
    symbol = "v",
    color = "light_blue",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "afs_pipe_ramp_up",
    name = ccb.content.text("conduit"),
    symbol = "^",
    color = "light_blue",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "afs_pipe",
    name = ccb.content.text("conduit"),
    color = "light_blue",
    see_cost = "spaced_high",
    spawns = { group = "AFS_GROUP_FAUNA_TUNNELS", population = { 4, 10 }, chance = 30 },
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = { "afs_player_ship" },
    name = ccb.content.text("Vanishing Arc"),
    symbol = "+",
    color = "red",
    see_cost = "low",
    flags = { "SOURCE_PEOPLE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = {
        "land_pad_outpost_basement_a1", "land_pad_outpost_basement_a2", "land_pad_tunnel_a1",
        "land_pad_tunnel_a2", "land_pad_a1_above", "land_pad_a2_above", "land_pad_a1", "land_pad_a2",
        "land_pad_b1", "land_pad_b2", "land_pad_b1_above", "land_pad_b2_above",
    },
    name = ccb.content.text("landing pad"),
    symbol = "#",
    color = "light_gray",
    see_cost = "high",
    flags = { "SOURCE_PEOPLE", "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    id = { "afs_shelter_1" },
    name = ccb.content.text("house"),
    symbol = "<",
    color = "green",
    spawns = { group = "GROUP_ZOMBIE", population = { 1, 4 }, chance = 50 },
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "afs_shelter_1_roof" },
    name = ccb.content.text("house roof"),
    symbol = "<",
    color = "green",
    flags = { "PP_GENERATE_RUINED" },
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "arcology_interior_center_robots", "arcology_interior_w_side_robots",
        "arcology_interior_e_side_robots", "arcology_interior_n_side_robots",
        "arcology_interior_s_side_robots", "arcology_interior_ne_corner_robots",
        "arcology_interior_nw_corner_robots", "arcology_interior_se_corner_robots",
        "arcology_interior_sw_corner_robots", "arcology_exterior_e_side_robots",
        "arcology_exterior_n_side_robots", "arcology_exterior_s_side_robots",
        "arcology_exterior_w_side_robots", "arcology_exterior_ne_corner_robots",
        "arcology_exterior_nw_corner_robots", "arcology_exterior_se_corner_robots",
        "arcology_exterior_sw_corner_robots", "arcology_exterior_n_entrance_robots",
        "arcology_exterior_s_entrance_robots", "arcology_exterior_e_entrance_robots",
        "arcology_exterior_w_entrance_robots",
    },
    name = ccb.content.text("Desolate Arcology - Ground Level"),
    symbol = "A",
    color = "light_blue",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = {
        "arcology_interior_center_uplifts", "arcology_interior_w_side_uplifts",
        "arcology_interior_e_side_uplifts", "arcology_interior_n_side_uplifts",
        "arcology_interior_s_side_uplifts", "arcology_interior_ne_corner_uplifts",
        "arcology_interior_nw_corner_uplifts", "arcology_interior_se_corner_uplifts",
        "arcology_interior_sw_corner_uplifts", "arcology_exterior_e_side_uplifts",
        "arcology_exterior_n_side_uplifts", "arcology_exterior_s_side_uplifts",
        "arcology_exterior_w_side_uplifts", "arcology_exterior_ne_corner_uplifts",
        "arcology_exterior_nw_corner_uplifts", "arcology_exterior_se_corner_uplifts",
        "arcology_exterior_sw_corner_uplifts", "arcology_exterior_n_entrance_uplifts",
        "arcology_exterior_s_entrance_uplifts", "arcology_exterior_e_entrance_uplifts",
        "arcology_exterior_w_entrance_uplifts",
    },
    name = ccb.content.text("Arcology - Ground Level"),
    symbol = "A",
    color = "light_blue",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Crashing Ship"),
    id = {
        "crashing_ship_3", "crashing_ship_2", "crashing_ship_1", "crashing_ship_6", "crashing_ship_5",
        "crashing_ship_4", "crashing_ship_9", "crashing_ship_8", "crashing_ship_7",
    },
    symbol = "+",
    color = "i_red",
    see_cost = "high",
    flags = { "SOURCE_FOOD", "SOURCE_GUN", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Shuttle Landing Pad"),
    spawns = { group = "GROUP_ZOMBIE", population = { 2, 5 }, chance = 80 },
    id = {
        "afs_shuttle_pad_a1",
        "afs_shuttle_pad_a2",
        "afs_shuttle_pad_a1_roof",
        "afs_shuttle_pad_a2_roof",
    },
    symbol = "-",
    color = "light_blue",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("vehicle bay"),
    spawns = { group = "GROUP_ZOMBIE", population = { 2, 5 }, chance = 80 },
    id = {
        "afs_vehicle_bay_a1",
        "afs_vehicle_bay_a2",
        "afs_vehicle_bay_a1_roof",
        "afs_vehicle_bay_a2_roof",
    },
    symbol = "0",
    looks_like = "s_lot",
    color = "light_blue",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Solar Array"),
    id = {
        "afs_solar_arrary_a1",
        "afs_solar_array_a2",
        "afs_solar_arrary_a1_roof",
        "afs_solar_array_a2_roof",
    },
    symbol = "S",
    color = "light_blue",
    see_cost = "medium",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Malamute Transport Wreck"),
    spawns = { group = "GROUP_ZOMBIE", population = { 2, 5 }, chance = 80 },
    id = {
        "afs_freight_transport_a1", "afs_freight_transport_a2", "afs_freight_transport_roof_a1",
        "afs_freight_transport_roof_a2",
    },
    symbol = "M",
    color = "light_gray",
    see_cost = "medium",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Habitat Block"),
    id = {
        "afs_habblock_1_a1", "afs_hablock_1_a2", "afs_habblock_1_floor2_a1", "afs_hablock_1_floor2_a2",
        "afs_habblock_1_roof_a1", "afs_hablock_1_roof_a2", "afs_habblock_2_a1", "afs_hablock_2_a2",
        "afs_habblock_2_a3", "afs_habblock_2_a4", "afs_habblock_2_floor2_a1", "afs_hablock_2_floor2_a2",
        "afs_habblock_2_floor2_a3", "afs_habblock_2_floor2_a4", "afs_habblock_2_floor3_a1",
        "afs_hablock_2_floor3_a2", "afs_habblock_2_floor3_a3", "afs_habblock_2_floor3_a4",
        "afs_habblock_2_floor4_a1", "afs_hablock_2_floor4_a2", "afs_habblock_2_floor4_a3",
        "afs_habblock_2_floor4_a4", "afs_habblock_2_floor5_a1", "afs_hablock_2_floor5_a2",
        "afs_habblock_2_floor5_a3", "afs_habblock_2_floor5_a4", "afs_habblock_2_roof_a1",
        "afs_habblock_2_roof_a2", "afs_habblock_3_ground", "afs_habblock_3_floor_2",
        "afs_habblock_3_floor_3", "afs_habblock_3_floor_4", "afs_habblock_3_roof",
    },
    symbol = "H",
    color = "light_green",
    see_cost = "full_high",
    monster_density = 3,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("General Store"),
    spawns = { group = "GROUP_ZOMBIE", population = { 2, 5 }, chance = 80 },
    id = { "afs_general_store_n1", "afs_general_store_n2", "afs_general_store_n3" },
    symbol = "g",
    color = "light_green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Enclosed Park"),
    id = { "afs_park_dome_ground_floor", "afs_park_dome_2nd_floor", "afs_park_dome_roof" },
    symbol = "P",
    color = "green",
    see_cost = "spaced_high",
    monster_density = 1,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Enforcer Station"),
    id = { "afs_enforcer_station_a1", "afs_enforcer_station_a1_floor2", "afs_enforcer_station_a1_roof" },
    symbol = "E",
    color = "blue",
    see_cost = "high",
    monster_density = 3,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    id = { "afs_pwr_sub_s", "afs_pwr_sub_s_roof" },
    name = ccb.content.text("small power substation"),
    symbol = "H",
    color = "light_cyan",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = {
        "afs_pwr_large_entrance", "afs_pwr_large_2", "afs_pwr_large_3", "afs_pwr_large_4",
        "afs_pwr_large_entrance_roof", "afs_pwr_large_2_roof",
    },
    name = ccb.content.text("large power substation"),
    symbol = "H",
    color = "cyan",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Exosuit Garage"),
    id = {
        "afs_exosuit_garage_a1", "afs_exosuit_garage_a1_roof", "afs_exosuit_garage_2_a1",
        "afs_exosuit_garage_2_a1_roof",
    },
    symbol = "e",
    color = "yellow",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("UICA Shuttle Base"),
    id = {
        "afs_uica_shuttle_base_x0y0z0", "afs_uica_shuttle_base_x1y0z0", "afs_uica_shuttle_base_x0y1z0",
        "afs_uica_shuttle_base_x1y1z0", "afs_uica_shuttle_base_x0y0z1", "afs_uica_shuttle_base_x1y0z1",
        "afs_uica_shuttle_base_x0y1z1", "afs_uica_shuttle_base_x1y1z1", "afs_uica_shuttle_base_x0y0z2",
        "afs_uica_shuttle_base_x1y0z2", "afs_uica_shuttle_base_x0y1z2", "afs_uica_shuttle_base_x1y1z2",
    },
    symbol = "U",
    color = "blue",
    see_cost = "high",
    monster_density = 2,
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Salvor Encampment"),
    id = {
        "afs_shuttlepad_salvors_a1_1", "afs_shuttlepad_salvors_a2_1", "afs_shuttlepad_salvors_b1_1",
        "afs_shuttlepad_salvors_b2_1", "afs_shuttlepad_salvors_a1_2", "afs_shuttlepad_salvors_a2_2",
        "afs_shuttlepad_salvors_b1_2", "afs_shuttlepad_salvors_b2_2", "afs_shuttlepad_salvors_a1_3",
        "afs_shuttlepad_salvors_a2_3", "afs_shuttlepad_salvors_b1_3", "afs_shuttlepad_salvors_b2_3",
        "afs_shuttlepad_salvors_a1_4", "afs_shuttlepad_salvors_a2_4", "afs_shuttlepad_salvors_b1_4",
        "afs_shuttlepad_salvors_b2_4",
    },
    symbol = "S",
    color = "red",
    see_cost = "high",
    monster_density = 2,
    flags = { "SOURCE_SAFETY" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Mercurial Gene Clinic"),
    id = {
        "afs_gene_clinic_1_a1",
        "afs_gene_clinic_1_a2",
        "afs_gene_clinic_1_a3",
        "afs_gene_clinic_1_a4",
    },
    symbol = "G",
    color = "green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Cafe"),
    id = { "afs_cafe_a1_floor_1", "afs_cafe_a1_floor_2" },
    symbol = "c",
    color = "light_cyan",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Saloon"),
    id = { "afs_saloon_1_floor_1", "afs_saloon_1_floor_2" },
    symbol = "s",
    color = "light_cyan",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Garage"),
    id = {
        "afs_garage_a1_floor_1",
        "afs_garage_a1_floor_2",
        "afs_garage_2_a1_floor_1",
        "afs_garage_2_a1_floor_2",
    },
    symbol = "g",
    color = "yellow",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Catalytic Reactor Ruins"),
    id = {
        "afs_catalytic_react_r1", "afs_catalytic_react_r2", "afs_catalytic_react_u1",
        "afs_catalytic_react_u2", "afs_catalytic_react_m1", "afs_catalytic_react_m2",
        "afs_catalytic_react_g1", "afs_catalytic_react_g2", "afs_catalytic_react_sub1",
        "afs_catalytic_react_sub2",
    },
    symbol = "R",
    color = "yellow",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("EV Charging Station"),
    id = { "afs_ev_station_a1_floor_1", "afs_ev_station_a1_floor_2" },
    symbol = "e",
    color = "light_blue",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Aerodrone Landing Pad"),
    id = { "afs_aerodrone_landing_pad_a1_floor_1", "afs_aerodrone_landing_pad_a1_floor_2" },
    on_entry = "mark_spaceport_discovered",
    symbol = "H",
    color = "light_blue",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Clothing Store"),
    id = { "afs_clothing_store_a1_floor_1", "afs_clothing_store_a1_floor_2" },
    symbol = "c",
    color = "light_green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Sporting Goods"),
    id = { "afs_sporting_goods_store_a1_floor_1", "afs_sporting_goods_store_a1_floor_2" },
    symbol = "S",
    color = "cyan",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Urban Farm"),
    id = {
        "afs_small_urban_farm_a1_floor_1",
        "afs_small_urban_farm_a1_floor_2",
        "afs_small_urban_farm_a1_floor_3",
    },
    symbol = "F",
    color = "green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Office"),
    id = { "afs_small_office_a1_floor_1", "afs_small_office_a1_floor_2", "afs_small_office_a1_floor_3" },
    symbol = "o",
    color = "light_cyan",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Grocer"),
    id = { "afs_grocer_a1_floor_1", "afs_grocer_a1_floor_2", "afs_grocer_a1_floor_3" },
    symbol = "g",
    color = "light_green",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}

ccb.content.define_overmap_terrain {
    name = ccb.content.text("Clinic"),
    id = { "afs_clinic_a1_floor_1", "afs_clinic_a1_floor_2" },
    symbol = "C",
    color = "light_red",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "PP_GENERATE_RUINED" },
}
