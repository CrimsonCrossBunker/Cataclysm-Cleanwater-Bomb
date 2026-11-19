local ccb = require("ccb")

ccb.content.define_start_location {
    id = "sloc_fort",
    name = ccb.content.text("Bastion Fort"),
    targets = { { overmap_terrain = "fort", match = "prefix" } },
}

ccb.content.define_start_location {
    id = "sloc_shelter_safe",
    name = ccb.content.text("Evacuation Shelter"),
    targets = { { overmap_terrain = "shelter", parameters = { shelter_palette = "shelter_basic" } } },
}

ccb.content.define_start_location {
    id = "sloc_shelter_vandal",
    name = ccb.content.text("Vandalized Evacuation Shelter"),
    targets = { { overmap_terrain = "shelter", parameters = { shelter_palette = "shelter_vandal" } } },
}

ccb.content.define_start_location {
    id = "sloc_shelter_under_infested",
    name = ccb.content.text("Infested Evacuation Shelter Basement"),
    targets = {
        { overmap_terrain = "shelter_under", parameters = { shelter_palette = "shelter_infested_scenario" } },
    },
}

ccb.content.define_start_location {
    id = "sloc_town_hall",
    name = ccb.content.text("Town Hall"),
    targets = {
        "town_hall_0_0_0",
        "town_hall_1_0_0",
        "town_hall_0_1_0",
        "town_hall_1_1_0",
        "town_hall_0_0_1",
        "town_hall_1_0_1",
        "town_hall_0_1_1",
        "town_hall_1_1_1",
        "town_hall_0_0_roof",
    },
}

ccb.content.define_start_location {
    id = "sloc_refugee_center",
    name = ccb.content.text("Refugee Center"),
    targets = { "evac_center_18" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_exodii_castle",
    name = ccb.content.text("Exodii castle"),
    targets = { "exodii_base_x0y3z0" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_house_boarded",
    copy_from = "sloc_house",
    name = ccb.content.text("House (boarded up)"),
    extend_flags = { "BOARDED" },
}

ccb.content.define_start_location {
    id = "sloc_field",
    name = ccb.content.text("Field"),
    targets = { "field" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_ocean_shore",
    name = ccb.content.text("Beach"),
    targets = { "ocean_shore" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_house",
    name = ccb.content.text("House"),
    targets = {
        "house_w_1",
        "house_2story_basement",
        "house_crack1",
        "house_crack2",
        "house_crack3",
        "house_wooded",
        "house_prepper",
        "house_prepper2",
        "house_fortified",
        "duplex",
        "house_duplex2",
        "house_duplex3",
        "house_duplex4",
        "house_duplex5",
        "house_duplex6",
        "house_duplex7",
        "house_duplex8",
        "house_duplex9",
        "house_duplex10",
        "house_duplex11",
        "house_w_2",
        "house_w_3",
        "house_w_4",
        "house_w_5",
        "house_w_6",
        "house_01",
        "house_02",
        "house_03",
        "house_04",
        "house_05",
        "house_06",
        "house_07",
        "house_08",
        "house_09",
        "house_10",
        "house_11",
        "house_12",
        "house_13",
        "house_14",
        "house_15",
        "house_16",
        "house_17",
        "house_18",
        "house_19",
        "house_20",
        "house_21",
        "house_22",
        "house_23",
        "house_24",
        "house_25",
        "house_26",
        "house_27",
        "house_28",
        "house_29",
        "house_30",
        "house_31",
        "house_32",
        "house_garage",
        "house_garage2",
        "house_garage3",
        "house_garage4",
        "house_garage5",
        "house_garage6",
        "house_garage7",
        "house_garage8",
        "rural_house1",
        "rural_house2",
        "house_toolshed",
        "house_suicide",
        "house_quiverfull",
        "house_rv",
        "house_porch",
        "house_patio",
        "house_modern_1",
        "house_library",
        "house_detatched1",
        "house_detatched2",
        "house_detatched3",
        "house_detatched4",
        "house_detatched5",
        "house_detatched6",
        "house_detatched7",
        "house_detatched8",
        "house_detatched9",
        "house_detatched10",
        "house_dogs",
        "house_gardener",
        "house_inner_garden",
        "house_vacant",
        "house_vacant2",
    },
}

ccb.content.define_start_location {
    id = "sloc_grocery_store",
    name = ccb.content.text("Grocery Store"),
    targets = { "s_grocery", "s_grocery_1" },
}

ccb.content.define_start_location {
    id = "sloc_gun_store",
    name = ccb.content.text("Gun Store"),
    targets = { "s_gun_a", "s_gun_b_store" },
}

ccb.content.define_start_location {
    id = "sloc_garage",
    name = ccb.content.text("Garage"),
    targets = { "s_garage", "s_garage_1", "s_garage_2", "garage_gas_1", "garage_gas_2", "garage_gas_3" },
}

ccb.content.define_start_location {
    id = "sloc_pawn_shop",
    name = ccb.content.text("Pawn Shop"),
    targets = { "pawn", "pawn_1", "pawn_pf" },
}

ccb.content.define_start_location {
    id = "sloc_bank",
    name = ccb.content.text("Bank"),
    targets = { "bank", "bank_1" },
}

ccb.content.define_start_location {
    id = "sloc_pharm",
    name = ccb.content.text("Pharmacy"),
    targets = { "s_pharm", "s_pharm_1" },
}

ccb.content.define_start_location {
    id = "sloc_hardware",
    name = ccb.content.text("Hardware Store"),
    targets = { "s_hardware", "s_hardware_1", "s_hardware_2", "s_hardware_3" },
}

ccb.content.define_start_location {
    id = "sloc_dojo",
    name = ccb.content.text("Dojo"),
    targets = { "dojo", "dojo_1" },
}

ccb.content.define_start_location {
    id = "sloc_gym",
    name = ccb.content.text("Gym"),
    targets = { "gym", "gym_fitness", "gym_fitness_1" },
}

ccb.content.define_start_location {
    id = "sloc_clothes",
    name = ccb.content.text("Clothing Store"),
    targets = {
        "s_clothes",
        "s_clothes_1",
        "s_clothes_2",
        "s_clothes_3",
        "s_clothes_4",
        "s_clothes_5",
        "s_clothes_6",
    },
}

ccb.content.define_start_location {
    id = "sloc_restaurant",
    name = ccb.content.text("Restaurant"),
    targets = { "s_restaurant", "s_restaurant_1", "s_restaurant_2", "s_restaurant_3" },
}

ccb.content.define_start_location {
    id = "sloc_bar",
    name = ccb.content.text("Bar"),
    targets = { "bar", "bar_1" },
}

ccb.content.define_start_location {
    id = "sloc_electronics",
    name = ccb.content.text("Electronics Store"),
    targets = { "s_electronics", "s_electronics_1", "s_electronicstore" },
}

ccb.content.define_start_location {
    id = "sloc_arcade",
    name = ccb.content.text("Arcade"),
    targets = { "s_arcade" },
}

ccb.content.define_start_location {
    id = "sloc_animalshelter",
    name = ccb.content.text("Animal Shelter"),
    targets = { "animalshelter" },
}

ccb.content.define_start_location {
    id = "sloc_laundromat",
    name = ccb.content.text("Laundromat"),
    targets = { "s_laundromat", "s_laundromat_1" },
}

ccb.content.define_start_location {
    id = "sloc_stripclub",
    name = ccb.content.text("Strip Club"),
    targets = { "stripclub", "stripclub_1", "stripclub_2" },
}

ccb.content.define_start_location {
    id = "sloc_sexshop",
    name = ccb.content.text("Sex Shop"),
    targets = { "cs_sex_shop" },
}

ccb.content.define_start_location {
    id = "sloc_candyshop",
    name = ccb.content.text("Candy Shop"),
    targets = { "candy_shop", "candy_shop_1" },
}

ccb.content.define_start_location {
    id = "sloc_bikeshop",
    name = ccb.content.text("Bike Shop"),
    targets = { "s_bike_shop", "s_bike_shop_1" },
}

ccb.content.define_start_location {
    id = "sloc_petstore",
    name = ccb.content.text("Pet Store"),
    targets = { "s_petstore", "s_petstore_1", "s_petstore_2" },
}

ccb.content.define_start_location {
    id = "sloc_military_surplus",
    name = ccb.content.text("Military Surplus"),
    targets = { "mil_surplus", "mil_surplus_1", "mil_surplus_2" },
}

ccb.content.define_start_location {
    id = "sloc_furniture_store",
    name = ccb.content.text("Furniture Store"),
    targets = { "furniture" },
}

ccb.content.define_start_location {
    id = "sloc_library",
    name = ccb.content.text("Library"),
    targets = {
        "s_library",
        "s_library_1",
        "s_library_2",
        "s_library_3",
        { overmap_terrain = "urban_library", match = "prefix" },
    },
}

ccb.content.define_start_location {
    id = "sloc_bookstore",
    name = ccb.content.text("Bookstore"),
    targets = { "s_bookstore", "s_bookstore_1", "s_bookstore_2" },
}

ccb.content.define_start_location {
    id = "sloc_cabin",
    name = ccb.content.text("Cabin"),
    targets = { "cabin_3", "cabin_4", "cabin_5", "cabin_6", "cabin_7" },
}

ccb.content.define_start_location {
    id = "sloc_liam_cabin",
    name = ccb.content.text("Liam's Cabin"),
    targets = { "cabin_liam" },
}

ccb.content.define_start_location {
    id = "sloc_hospital",
    name = ccb.content.text("Hospital"),
    targets = { "hospital_5" },
}

ccb.content.define_start_location {
    id = "sloc_lmoe",
    name = ccb.content.text("LMOE shelter (surface)"),
    targets = { "lmoe" },
}

ccb.content.define_start_location {
    id = "sloc_lmoe_under",
    name = ccb.content.text("LMOE shelter (underground)"),
    targets = { "lmoe_under" },
}

ccb.content.define_start_location {
    id = "sloc_forest",
    name = ccb.content.text("Middle of Nowhere"),
    targets = { "forest" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_river",
    name = ccb.content.text("River"),
    targets = { "river" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_bridge",
    name = ccb.content.text("Bridge"),
    targets = { "bridgehead_ground" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_desert_island",
    name = ccb.content.text("Desert Island"),
    targets = { "island_sand", "island_forest", "island_forest_thick", "island_forest_water", "island_field" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_lab_concourse_area",
    name = ccb.content.text("Cargo area Trans-Coast Logistics"),
    targets = { { overmap_terrain = "lab_CORE_2x1_1DN", match = "type" } },
}

ccb.content.define_start_location {
    id = "sloc_lab_medical",
    name = ccb.content.text("Medical area Trans-Coast Logistics"),
    targets = { { overmap_terrain = "lab_health_z-3_B", match = "type" } },
}

ccb.content.define_start_location {
    id = "sloc_mall_loading_area",
    name = ccb.content.text("Mall (loading area)"),
    targets = { "mall_a_12" },
}

ccb.content.define_start_location {
    id = "sloc_mall_food_court",
    name = ccb.content.text("Mall (food court)"),
    targets = { "mall_a_30" },
}

ccb.content.define_start_location {
    id = "sloc_fire_station",
    name = ccb.content.text("Fire Station"),
    targets = {
        { overmap_terrain = "fire_station", match = "type" },
        { overmap_terrain = "fire_station_1", match = "type" },
    },
}

ccb.content.define_start_location {
    id = "sloc_police",
    name = ccb.content.text("Police Station"),
    targets = {
        { overmap_terrain = "police", match = "type" },
        { overmap_terrain = "police_1", match = "type" },
        { overmap_terrain = "police_2", match = "type" },
    },
}

ccb.content.define_start_location {
    id = "sloc_restaraunt_foodplace_break_room",
    name = ccb.content.text("Foodplace Break Room"),
    targets = { "s_restaurant_foodplace_roof" },
}

ccb.content.define_start_location {
    id = "sloc_school",
    name = ccb.content.text("School"),
    targets = {
        { overmap_terrain = "school_1", match = "prefix" },
        { overmap_terrain = "school_2", match = "prefix" },
        { overmap_terrain = "school_3", match = "prefix" },
    },
}

ccb.content.define_start_location {
    id = "sloc_school_rooftop",
    name = ccb.content.text("School Rooftop"),
    targets = { "school_4_6", "school_4_5", "school_4_4", "school_4_9", "school_4_8", "school_4_7" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_mine_finale",
    name = ccb.content.text("Bottom of a mine"),
    targets = { "mine_finale" },
}

ccb.content.define_start_location {
    id = "sloc_prison",
    name = ccb.content.text("Prison"),
    targets = { "prison_1_5" },
}

ccb.content.define_start_location {
    id = "sloc_prison_alcatraz",
    name = ccb.content.text("Island prison type A"),
    targets = { "prison_alcatraz_3" },
}

ccb.content.define_start_location {
    id = "sloc_prison_island",
    name = ccb.content.text("Island prison type B"),
    targets = { "prison_island_1_1" },
}

ccb.content.define_start_location {
    id = "sloc_mi-go_camp",
    name = ccb.content.text("Mi-go camp"),
    targets = { "mi-go_camp1" },
}

ccb.content.define_start_location {
    id = "sloc_hermit_shack",
    name = ccb.content.text("Hermit Shack"),
    targets = { "hunter_shack" },
}

ccb.content.define_start_location {
    id = "sloc_campsite",
    name = ccb.content.text("Campsite"),
    targets = { { overmap_terrain = "campsite", match = "contains" } },
}

ccb.content.define_start_location {
    id = "sloc_campground",
    name = ccb.content.text("Campground"),
    targets = { "campground_1a", "campground_1b", "campground_2a", "campground_2b" },
}

ccb.content.define_start_location {
    id = "sloc_farm_survivalist",
    name = ccb.content.text("Farm"),
    targets = { "farm_2" },
}

ccb.content.define_start_location {
    id = "sloc_church",
    name = ccb.content.text("Church"),
    targets = { "church_3rdfloor_1", "church_1", "church_steeple_end", "church" },
}

ccb.content.define_start_location {
    id = "sloc_cemetery",
    name = ccb.content.text("Cemetery"),
    targets = {
        { overmap_terrain = "cemetery_4square", match = "prefix" },
        { overmap_terrain = "Cemetery", match = "prefix" },
        { overmap_terrain = "cemetery_small", match = "prefix" },
    },
}

ccb.content.define_start_location {
    id = "sloc_zoo_cafeteria",
    name = ccb.content.text("Zoo (Cafeteria)"),
    targets = { "zoo_0_1" },
}

ccb.content.define_start_location {
    id = "sloc_golfcourse_mid_course",
    name = ccb.content.text("Golf Course (mid course)"),
    targets = { "golfcourse_11" },
}

ccb.content.define_start_location {
    id = "sloc_golfcourse_clubhouse",
    name = ccb.content.text("Golf Course (clubhouse)"),
    targets = { "golfcourse_31" },
}

ccb.content.define_start_location {
    id = "sloc_apartments_rooftop",
    name = ccb.content.text("Apartment Building (rooftop)"),
    targets = {
        "apartments_con_tower_114",
        "apartments_con_tower_014",
        "apartments_con_tower_104",
        "apartments_con_tower_004",
    },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_apartments_rooftop2",
    name = ccb.content.text("Apartment Building Alternate (rooftop)"),
    targets = {
        "apartments_mod_tower_113",
        "apartments_mod_tower_013",
        "apartments_mod_tower_103",
        "apartments_mod_tower_003",
    },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_apartment_complex_roof",
    name = ccb.content.text("Apartment Complex (rooftop)"),
    targets = {
        "apartment_complex_corner_roof",
        "apartment_complex_corner_inner_roof",
        "apartment_complex_straight_roof",
        "apartment_complex_straight_stairs_even_roof",
        "apartment_complex_straight_stairs_odd_roof",
    },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_convention_center_rooftop",
    name = ccb.content.text("Convention Center Rooftop"),
    targets = {
        "convention_0_0_2",
        "convention_1_0_2",
        "convention_2_0_2",
        "convention_3_0_2",
        "convention_4_0_2",
        "convention_0_1_2",
        "convention_1_1_2",
        "convention_2_1_2",
        "convention_3_1_2",
        "convention_4_1_2",
        "convention_0_2_2",
        "convention_1_2_2",
        "convention_2_2_2",
        "convention_3_2_2",
        "convention_4_2_2",
    },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_horse_ranch",
    name = ccb.content.text("Horse Ranch"),
    targets = { "farm_horse_stable_1" },
}

ccb.content.define_start_location {
    id = "sloc_cabin_lake",
    name = ccb.content.text("Lake Cabin"),
    targets = { "cabin_lake" },
}

ccb.content.define_start_location {
    id = "sloc_freshwater_research_station",
    name = ccb.content.text("Freshwater Research Station"),
    targets = { "sealab_small_surface" },
}

ccb.content.define_start_location {
    id = "sloc_lodge_ground",
    name = ccb.content.text("Hunting Lodge"),
    targets = { "lodge_ground1" },
}

ccb.content.define_start_location {
    id = "sloc_gas_station",
    name = ccb.content.text("Gas Station"),
    targets = { "s_gas_rural" },
}

ccb.content.define_start_location {
    id = "sloc_lighthouse_ground",
    name = ccb.content.text("Lighthouse Island"),
    targets = { "lighthouse_ground" },
}

ccb.content.define_start_location {
    id = "sloc_lighthouse_small_ground",
    name = ccb.content.text("Small lighthouse island"),
    targets = { "lighthouse_small_ground" },
}

ccb.content.define_start_location {
    id = "sloc_military_base_warehouse",
    name = ccb.content.text("Military Base Warehouse"),
    targets = { "mil_base_2g" },
}

ccb.content.define_start_location {
    id = "aircraft_carrier_berth",
    name = ccb.content.text("Aircraft Carrier Berth"),
    targets = { "aircraft_carrier_1b" },
}

ccb.content.define_start_location {
    id = "aircraft_carrier_bridge",
    name = ccb.content.text("Aircraft Carrier Captain's Bridge"),
    targets = { "aircraft_carrier_1b" },
}

ccb.content.define_start_location {
    id = "sloc_private_resort",
    name = ccb.content.text("Private resort"),
    targets = { "p_resort_2ss" },
}

ccb.content.define_start_location {
    id = "sloc_road",
    name = ccb.content.text("Road"),
    city_distance = { 10, -1 },
    targets = { { overmap_terrain = "road", match = "type" } },
}

ccb.content.define_start_location {
    id = "sloc_light_industry_scen",
    name = ccb.content.text("Industrial Offices"),
    targets = { { overmap_terrain = "s_lightindustry_10", parameters = { safe = "true" } } },
}

ccb.content.define_start_location {
    id = "sloc_mansion_basement",
    name = ccb.content.text("Normal Mansion Basement (Random)"),
    targets = { "mansion_t2d", "mansion_t6d", "mansion_+2d" },
}

ccb.content.define_start_location {
    id = "sloc_enclosed_mansion_panic_room",
    name = ccb.content.text("Enclosed Mansion Panic Room"),
    targets = { "mansion_boarded_t2_start" },
}

ccb.content.define_start_location {
    id = "sloc_enclosed_mansion_sex_lair",
    name = ccb.content.text("Enclosed Mansion Sex Lair"),
    targets = { "mansion_boarded_t2d_start" },
}

ccb.content.define_start_location {
    id = "sloc_hotel_rooftop",
    name = ccb.content.text("Hotel Rooftop"),
    targets = { "hotel_tower_roof_1_9", "hotel_tower_roof_1_8", "hotel_tower_roof_1_7" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_office_tower_rooftop",
    name = ccb.content.text("Office Tower Rooftop"),
    targets = { "loffice_tower_13", "loffice_tower_14", "loffice_tower_15", "loffice_tower_16" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_office_tower_2_rooftop",
    name = ccb.content.text("Office Tower 2 Rooftop"),
    targets = {
        "office_tower_2_a1_roof",
        "office_tower_2_a2_roof",
        "office_tower_2_b1_roof",
        "office_tower_2_b2_roof",
        "office_tower_2_b3_roof",
    },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_cathedral_rooftop",
    name = ccb.content.text("Cathedral Rooftop"),
    targets = { "cathedral_3_NW", "cathedral_3_NE", "cathedral_3_SW", "cathedral_3_SE" },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_retirement_community",
    name = ccb.content.text("Retirement Community - Townhouse"),
    targets = { "retirement_community_b_5" },
}

ccb.content.define_start_location {
    id = "nuclear_plant",
    name = ccb.content.text("Nuclear Power Plant"),
    targets = { "nuclear_plant_5_5_1", "nuclear_plant_10_5_1" },
}

ccb.content.define_start_location {
    id = "sloc_motel",
    name = ccb.content.text("Motel"),
    targets = { "motel_twd_1_f1" },
}

ccb.content.define_start_location {
    id = "sloc_mobile_home",
    name = ccb.content.text("Mobile Home"),
    targets = { "trailer_hub_00", "trailer_hub_11", "trailer_caravan_00", "trailer_public_00" },
}

ccb.content.define_start_location {
    id = "sloc_stadium",
    name = ccb.content.text("Stadium"),
    targets = {
        "stadium_football_1_1",
        "stadium_football_2_1",
        "stadium_football_3_1",
        "stadium_football_4_1",
        "stadium_football_5_1",
        "stadium_football_6_1",
        "stadium_football_7_1",
        "stadium_football_1_2",
        "stadium_football_7_2",
        "stadium_football_1_3",
        "stadium_football_7_3",
        "stadium_football_1_4",
        "stadium_football_7_4",
        "stadium_football_1_5",
        "stadium_football_2_5",
        "stadium_football_3_5",
        "stadium_football_4_5",
        "stadium_football_6_5",
        "stadium_football_7_5",
    },
}

ccb.content.define_start_location {
    id = "sloc_middle_of_nowhere",
    name = ccb.content.text("Middle of Nowhere"),
    targets = {
        "state_park_1_0",
        "sewage_treatment_1_0_0",
        "pwr_sub_s",
        { overmap_terrain = "derelict_property", match = "type" },
        "ws_regional_dump_2_0",
        "waiting_area",
    },
}

ccb.content.define_start_location {
    id = "sloc_sewer",
    name = ccb.content.text("Sewer"),
    targets = { "sewer" },
}

ccb.content.define_start_location {
    id = "sloc_nesw_manhole",
    name = ccb.content.text("Intersection"),
    targets = { { overmap_terrain = "road_nesw_manhole", match = "prefix" } },
    flags = { "ALLOW_OUTSIDE" },
}

ccb.content.define_start_location {
    id = "sloc_town_in_the_open",
    name = ccb.content.text("Town, in the open"),
    targets = {
        { overmap_terrain = "road_nesw_manhole", match = "prefix" },
        { overmap_terrain = "playground", match = "type" },
        { overmap_terrain = "park", match = "type" },
    },
    flags = { "ALLOW_OUTSIDE" },
}
