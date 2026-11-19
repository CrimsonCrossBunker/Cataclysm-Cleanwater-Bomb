local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "s_gas_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("gas station"),
    looks_like = "s_gas",
    color = "light_blue",
    spawns = { group = "GROUP_ZOMBIE", population = { 6, 12 }, chance = 100 },
    extend = { flags = { "SOURCE_FUEL", "SOURCE_VEHICLES" }, post_process_generators = { "riot_damage" } },
    land_use_code = "commercial",
}

ccb.content.define_overmap_terrain {
    id = { "s_gas_0_0", "s_gas_1_0", "s_gas_0_1", "s_gas_1_1", "s_gas_g1" },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("gas station"),
    looks_like = "s_gas",
    color = "light_blue",
    spawns = { group = "GROUP_ZOMBIE", population = { 6, 12 }, chance = 100 },
    extend = { flags = { "SOURCE_FUEL", "SOURCE_VEHICLES" }, post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_gas_rural" },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("gas station"),
    looks_like = "s_gas",
    color = "light_blue",
    extend = { flags = { "SOURCE_FUEL", "SOURCE_VEHICLES" } },
    delete = { flags = { "RISK_HIGH" }, post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_gas_g0" },
    copy_from = "s_gas_0_0",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_gas_0_0_roof", "s_gas_1_0_roof", "s_gas_0_1_roof", "s_gas_1_1_roof", "s_gas_roof_1",
        "s_gas_g1_roof",
    },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("gas station roof"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_gas_rural_roof" },
    copy_from = "generic_city_building",
    name = ccb.content.text("gas station roof"),
    color = "light_blue",
    delete = { flags = { "RISK_HIGH" }, post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_pharm", "s_pharm_1" },
    copy_from = "generic_city_building",
    looks_like = "s_pharm",
    name = ccb.content.text("pharmacy"),
    color = "light_red",
    extend = { flags = { "SOURCE_MEDICINE" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_pharm_roof", "s_pharm_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_pharm_roof",
    name = ccb.content.text("pharmacy roof"),
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = { "office_doctor", "office_doctor_1", "office_doctor_2" },
    copy_from = "generic_city_building_roof",
    looks_like = "office_doctor",
    name = ccb.content.text("doctor's office"),
    color = "i_light_red",
    extend = { flags = { "SOURCE_MEDICINE" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "office_doctor_roof", "office_doctor_access_roof", "office_doctor_roof_1",
        "office_doctor_access_roof_1", "office_doctor_roof_2", "office_doctor_upper_roof_2",
    },
    copy_from = "generic_city_building_roof",
    looks_like = "office_doctor_roof",
    name = ccb.content.text("doctor's office roof"),
    color = "i_light_red",
}

ccb.content.define_overmap_terrain {
    id = { "office_cubical", "office_cubical_1", "small_office" },
    copy_from = "generic_city_building",
    looks_like = "office_cubical",
    name = ccb.content.text("office"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "office_cubical_roof", "office_cubical_roof_1", "small_office_roof", "small_office_upper_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "office_cubical_roof",
    name = ccb.content.text("office roof"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "office_tower_ne" },
    copy_from = "generic_city_building",
    vision_levels = "large_city_building",
    name = ccb.content.text("office building"),
    symbol = "T",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "office_tower_nw", "office_tower_sw", "office_tower_se" },
    copy_from = "office_tower_ne",
    symbol = "t",
}

ccb.content.define_overmap_terrain {
    id = {
        "office_tower_underground_nw", "office_tower_underground_ne", "office_tower_underground_sw",
        "office_tower_underground_se",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "large_pavement",
    name = ccb.content.text("office building parking"),
    symbol = "p",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "office_tower_roof_nw", "office_tower_roof_ne", "office_tower_roof_sw", "office_tower_roof_se",
        "office_tower_roof_ne_roof", "office_tower_roof_se_roof",
    },
    copy_from = "generic_city_building_roof",
    vision_levels = "roof_or_air",
    name = ccb.content.text("office building roof"),
    symbol = "t",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "office_tower_2_a1", "office_tower_2_a2", "office_tower_2_b1", "office_tower_2_b2",
        "office_tower_2_b3", "office_tower_2_a1_1", "office_tower_2_a2_1", "office_tower_2_a3_1",
        "office_tower_2_b1_1", "office_tower_2_b2_1", "office_tower_2_b3_1", "office_tower_2_a1_2",
        "office_tower_2_a2_2", "office_tower_2_b1_2", "office_tower_2_b2_2", "office_tower_2_b3_2",
        "office_tower_2_a1_roof", "office_tower_2_a2_roof", "office_tower_2_b1_roof",
        "office_tower_2_b2_roof", "office_tower_2_b3_roof", "office_tower_collapse_a1",
        "office_tower_collapse_b_a1",
    },
    name = ccb.content.text("office tower"),
    vision_levels = "large_city_building",
    symbol = "t",
    color = "i_light_gray",
    see_cost = "full_high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "office_tower_2_a3",
    name = ccb.content.text("office courtyard"),
    vision_levels = "large_pavement",
    symbol = "O",
    color = "light_gray",
    see_cost = "low",
    monster_density = 2,
    flags = { "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "office_tower_collapse_a0", "office_tower_collapse_b0", "office_tower_collapse_b1",
        "office_tower_collapse_b2", "office_tower_collapse_b_a0", "office_tower_collapse_b_b0",
        "office_tower_collapse_b_b1", "office_tower_collapse_b_b2",
    },
    name = ccb.content.text("collapsed tower"),
    vision_levels = "wreckage",
    symbol = "t",
    color = "i_light_gray",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "office_tower_collapse_a2",
    vision_levels = "wreckage",
    name = ccb.content.text("collapsed tower"),
    symbol = "O",
    color = "light_gray",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = "office_tower_collapse_b_a2",
    name = ccb.content.text("collapsed tower"),
    vision_levels = "wreckage",
    symbol = "t",
    color = "light_gray",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = { "s_grocery", "s_grocery_1" },
    copy_from = "generic_city_building",
    looks_like = "s_grocery",
    name = ccb.content.text("grocery store"),
    color = "green",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_grocery_roof", "s_grocery_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_grocery_roof",
    name = ccb.content.text("grocery store roof"),
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = "trailer_commercial_10",
    copy_from = "s_grocery",
    name = ccb.content.text("convenience store"),
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = "trailer_commercial_10_roof",
    copy_from = "s_grocery_roof",
    name = ccb.content.text("convenience store roof"),
}

ccb.content.define_overmap_terrain {
    id = { "s_cosmetic" },
    copy_from = "generic_city_building",
    looks_like = "s_grocery",
    name = ccb.content.text("cosmetics store"),
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "s_cosmetic_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_grocery_roof",
    name = ccb.content.text("cosmetics store roof"),
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "s_hardware", "s_hardware_1", "s_hardware_2", "s_hardware_3" },
    copy_from = "generic_city_building",
    looks_like = "s_hardware",
    name = ccb.content.text("hardware store"),
    color = "cyan",
    extend = { flags = { "SOURCE_WEAPON", "SOURCE_CONSTRUCTION", "SOURCE_FABRICATION" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_hardware_roof", "s_hardware_roof_1", "s_hardware_roof_2", "s_hardware_roof_3" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_hardware_roof",
    name = ccb.content.text("hardware store roof"),
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = { "s_weldingstore" },
    copy_from = "generic_city_building",
    name = ccb.content.text("welding store"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_weldingstore_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("welding store roof"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_electronics", "s_electronics_1", "s_electronicstore" },
    copy_from = "generic_city_building",
    looks_like = "s_electronics",
    name = ccb.content.text("electronics store"),
    color = "yellow",
    extend = { flags = { "SOURCE_ELECTRONICS", "SOURCE_FABRICATION", "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_electronics_roof", "s_electronics_roof_1", "s_electronicstore_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_electronics_roof",
    name = ccb.content.text("electronics store roof"),
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = "s_electronicstore_2ndfloor",
    name = ccb.content.text("electronics store 2nd floor"),
    copy_from = "generic_city_building",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = "s_sports",
    name = ccb.content.text("sporting goods store"),
    copy_from = "generic_city_building",
    color = "light_cyan",
    extend = { flags = { "SOURCE_WEAPON", "SOURCE_CLOTHING" } },
}

ccb.content.define_overmap_terrain {
    id = "s_sports_roof",
    name = ccb.content.text("sporting goods store roof"),
    copy_from = "generic_city_building_roof",
    color = "light_cyan",
}

ccb.content.define_overmap_terrain {
    id = "s_liquor",
    name = ccb.content.text("liquor store"),
    copy_from = "generic_city_building",
    color = "magenta",
    extend = { flags = { "SOURCE_DRINK", "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "s_liquor_roof",
    name = ccb.content.text("liquor store roof"),
    copy_from = "generic_city_building_roof",
    color = "magenta",
}

ccb.content.define_overmap_terrain {
    id = { "s_gun_a", "s_gun_b_range", "s_gun_b_store" },
    copy_from = "generic_city_building",
    looks_like = "s_gun_a",
    name = ccb.content.text("gun store"),
    color = "red",
    extend = { flags = { "SOURCE_GUN", "SOURCE_AMMO" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_gun_a_roof", "s_gun_b_roof", "s_gun_b_range_roof" },
    name = ccb.content.text("gun store roof"),
    looks_like = "s_gun_roof_a",
    copy_from = "generic_city_building_roof",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_clothes", "s_clothes_1", "s_clothes_2", "s_clothes_3", "s_clothes_4", "s_clothes_5",
        "s_clothes_6",
    },
    copy_from = "generic_city_building",
    looks_like = "s_clothes",
    name = ccb.content.text("clothing store"),
    color = "blue",
    extend = { flags = { "SOURCE_CLOTHING", "SOURCE_LUXURY", "SOURCE_TAILORING" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_clothes_roof", "s_clothes_roof_1", "s_clothes_roof_2", "s_clothes_roof_3",
        "s_clothes_roof_4", "s_clothes_roof_5", "s_clothes_roof_6", "s_clothes_upper_roof_4",
    },
    copy_from = "generic_city_building_roof",
    looks_like = "s_clothes_roof",
    name = ccb.content.text("clothing store"),
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_fabricstore" },
    copy_from = "generic_city_building",
    looks_like = "s_clothes",
    name = ccb.content.text("fabric store"),
    color = "blue",
    extend = { flags = { "SOURCE_TAILORING" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_fabricstore_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_clothes_roof",
    name = ccb.content.text("fabric store roof"),
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_bookstore", "s_bookstore_1", "s_bookstore_2" },
    copy_from = "generic_city_building",
    looks_like = "s_bookstore",
    name = ccb.content.text("bookstore"),
    color = "i_brown",
    extend = { flags = { "SOURCE_BOOKS" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_bookstore_roof", "s_bookstore_roof_1", "s_bookstore_roof_2", "s_bookstore_upper_roof",
        "s_bookstore_upper_roof_1",
    },
    copy_from = "generic_city_building_roof",
    looks_like = "s_bookstore_roof",
    name = ccb.content.text("bookstore roof"),
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = "s_diner",
    name = ccb.content.text("diner"),
    copy_from = "generic_city_building",
    looks_like = "s_restaurant",
    color = "pink",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK", "SOURCE_COOKING" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_diner_2ndfloor", "s_diner_roof" },
    name = ccb.content.text("diner"),
    copy_from = "generic_city_building_roof",
    looks_like = "s_restaurant",
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = { "s_restaurant", "s_restaurant_1", "s_restaurant_2", "s_restaurant_3" },
    copy_from = "generic_city_building",
    looks_like = "s_restaurant",
    name = ccb.content.text("restaurant"),
    color = "pink",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK", "SOURCE_COOKING" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_restaurant_foodplace_roof", "s_restaurant_foodplace_upper_roof", "s_restaurant_roof",
        "s_restaurant_roof_1", "s_restaurant_roof_2", "s_restaurant_upper_roof_2",
        "s_restaurant_roof_3",
    },
    copy_from = "generic_city_building_roof",
    looks_like = "s_restaurant_roof",
    name = ccb.content.text("restaurant roof"),
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_restaurant_fast", "s_restaurant_fast_1", "drive_through_0_0", "drive_through_1_0",
        "drive_through_2_0", "drive_through_0_1", "drive_through_1_1", "drive_through_2_1",
    },
    copy_from = "generic_city_building",
    looks_like = "s_restaurant_fast",
    name = ccb.content.text("fast food restaurant"),
    color = "yellow_magenta",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK", "SOURCE_COOKING" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_restaurant_fast_roof", "s_restaurant_fast_roof_1", "drive_through_roof_0_0",
        "drive_through_roof_1_0", "drive_through_roof_2_0", "drive_through_roof_0_1",
        "drive_through_roof_1_1", "drive_through_roof_2_1",
    },
    copy_from = "generic_city_building_roof",
    looks_like = "s_restaurant_fast_roof",
    name = ccb.content.text("fast food restaurant roof"),
    color = "yellow_magenta",
}

ccb.content.define_overmap_terrain {
    id = { "s_restaurant_coffee", "s_restaurant_coffee_1", "s_restaurant_coffee_2" },
    copy_from = "generic_city_building",
    looks_like = "s_restaurant_coffee",
    name = ccb.content.text("coffee shop"),
    color = "white_magenta",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_restaurant_coffee_roof", "s_restaurant_coffee_roof_1", "s_restaurant_coffee_roof_2" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_restaurant_coffee_roof",
    name = ccb.content.text("coffee shop"),
    color = "white_magenta",
}

ccb.content.define_overmap_terrain {
    id = { "s_teashop", "s_teashop_1" },
    copy_from = "generic_city_building",
    looks_like = "s_teashop",
    name = ccb.content.text("teashop"),
    color = "light_cyan_magenta",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_teashop_roof", "s_teashop_roof_1", "s_teashop_upper_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_teashop_roof",
    name = ccb.content.text("teashop roof"),
    color = "light_cyan_magenta",
}

ccb.content.define_overmap_terrain {
    id = { "bar", "bar_1" },
    copy_from = "generic_city_building",
    looks_like = "bar",
    name = ccb.content.text("bar"),
    color = "i_magenta",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_DRINK", "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = { "bar_roof", "bar_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "bar_roof",
    name = ccb.content.text("bar roof"),
    color = "i_magenta",
}

ccb.content.define_overmap_terrain {
    id = { "s_butcher", "s_butcher_1", "s_butcher_2" },
    copy_from = "generic_city_building",
    looks_like = "s_butcher",
    name = ccb.content.text("butcher shop"),
    color = "i_red",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 2, 6 }, chance = 20 },
    extend = { flags = { "SOURCE_FOOD", "SOURCE_COOKING" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "s_butcher_roof", "s_butcher_roof_1", "s_butcher_roof_2", "s_butcher_upper_roof",
        "s_butcher_upper_roof_1",
    },
    copy_from = "generic_city_building_roof",
    looks_like = "s_butcher_roof",
    name = ccb.content.text("butcher shop roof"),
    color = "i_red",
}

ccb.content.define_overmap_terrain {
    id = { "s_bike_shop", "s_bike_shop_1" },
    copy_from = "generic_city_building",
    looks_like = "s_bike_shop",
    name = ccb.content.text("bike shop"),
    color = "i_cyan",
    extend = { flags = { "SOURCE_VEHICLES", "SOURCE_FABRICATION" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_bike_shop_roof", "s_bike_shop_roof_1", "s_bike_shop_roof_1_shack_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_bike_shop_roof",
    name = ccb.content.text("bike shop roof"),
    color = "i_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "s_pizza_parlor", "s_pizza_parlor_1" },
    copy_from = "generic_city_building",
    looks_like = "s_pizza_parlor",
    name = ccb.content.text("pizza parlor"),
    color = "pink_magenta",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_COOKING" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_pizza_parlor_roof", "s_pizza_parlor_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_pizza_parlor_roof",
    name = ccb.content.text("pizza parlor roof"),
    color = "pink_magenta",
}

ccb.content.define_overmap_terrain {
    id = { "bank", "bank_1" },
    vision_levels = "city_building",
    looks_like = "bank",
    name = ccb.content.text("bank"),
    symbol = "$",
    color = "light_gray",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "SOURCE_LUXURY" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "bank_roof", "bank_roof_1" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("bank roof"),
    looks_like = "bank_roof",
    symbol = "$",
    color = "light_gray",
    see_cost = "none",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "pawn", "pawn_1", "pawn_pf", "pawn_pf_under" },
    copy_from = "generic_city_building",
    looks_like = "pawn",
    name = ccb.content.text("pawn shop"),
    color = "white",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = { "pawn_roof", "pawn_roof_1", "pawn_pf_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "pawn_roof",
    name = ccb.content.text("pawn shop roof"),
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "mil_surplus", "mil_surplus_1", "mil_surplus_2" },
    copy_from = "generic_city_building",
    looks_like = "mil_surplus",
    -- not a period
    name = ccb.content.text("mil. surplus"),
    symbol = "M",
    color = "i_light_gray",
    extend = { flags = { "SOURCE_FOOD", "SOURCE_CLOTHING" } },
}

ccb.content.define_overmap_terrain {
    id = { "mil_surplus_roof", "mil_surplus_roof_1", "mil_surplus_roof_2" },
    looks_like = "mil_surplus_roof",
    copy_from = "generic_city_building_roof",
    -- not a period
    name = ccb.content.text("mil. surplus roof"),
    symbol = "M",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = "furniture",
    copy_from = "generic_city_building",
    name = ccb.content.text("furniture store"),
    color = "brown",
    extend = { flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION" } },
}

ccb.content.define_overmap_terrain {
    id = { "furniture_roof", "furniture_upper_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("furniture store roof"),
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "s_music",
    copy_from = "generic_city_building",
    name = ccb.content.text("music store"),
    symbol = "m",
    color = "brown",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "s_music_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("music store roof"),
    symbol = "m",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = {
        "megastore_parking_0_0", "megastore_parking_1_0", "megastore_parking_2_0",
        "megastore_parking_3_0", "megastore_parking_0_1", "megastore_parking_1_1",
        "megastore_parking_2_1", "megastore_parking_3_1", "megastore_parking_0_2",
        "megastore_parking_0_3", "megastore_parking_0_4",
    },
    copy_from = "s_lot",
}

ccb.content.define_overmap_terrain {
    id = {
        "megastore_0_0_0", "megastore_1_0_0", "megastore_2_0_0", "megastore_0_1_0", "megastore_1_1_0",
        "megastore_2_1_0", "megastore_0_2_0", "megastore_2_2_0",
    },
    name = ccb.content.text("megastore"),
    vision_levels = "large_city_building",
    symbol = "M",
    color = "blue",
    copy_from = "generic_city_building",
    spawns = { group = "GROUP_VANILLA", population = { 10, 20 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = "megastore_1_2_0",
    name = ccb.content.text("megastore"),
    vision_levels = "large_city_building",
    symbol = "+",
    color = "light_blue",
    copy_from = "generic_city_building",
    spawns = { group = "GROUP_VANILLA", population = { 10, 20 }, chance = 100 },
    flags = {
        "SIDEWALK", "RISK_EXTREME", "SOURCE_FOOD", "SOURCE_DRINK", "SOURCE_GUN", "SOURCE_AMMO",
        "SOURCE_FABRICATION", "SOURCE_COOKING", "SOURCE_TAILORING", "SOURCE_CONSTRUCTION",
        "SOURCE_WEAPON", "SOURCE_VEHICLES", "SOURCE_CLOTHING", "SOURCE_MEDICINE", "SOURCE_BOOKS",
        "SOURCE_LUXURY",
    },
}

ccb.content.define_overmap_terrain {
    id = {
        "megastore_0_0_1", "megastore_0_1_1", "megastore_0_2_1", "megastore_1_0_1", "megastore_1_1_1",
        "megastore_1_2_1", "megastore_2_0_1", "megastore_2_1_1", "megastore_2_2_1",
    },
    name = ccb.content.text("megastore, second floor"),
    vision_levels = "large_city_building",
    symbol = "M",
    color = "blue",
    extras = "build",
    see_cost = "full_high",
    flags = {},
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "megastore_0_0_roof", "megastore_0_1_roof", "megastore_0_2_roof", "megastore_1_0_roof",
        "megastore_1_2_roof", "megastore_2_0_roof", "megastore_2_1_roof", "megastore_2_2_roof",
    },
    name = ccb.content.text("megastore roof"),
    vision_levels = "roof_or_air",
    symbol = "M",
    color = "blue",
    extras = "build",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "megastore_1_1_roof",
    copy_from = "megastore_0_0_roof",
    monster_density = 2,
    spawns = { group = "GROUP_VANILLA", population = { 8, 12 }, chance = 100 },
}

ccb.content.define_overmap_terrain {
    id = {
        "hotel_tower_1_1", "hotel_tower_1_2", "hotel_tower_1_3", "hotel_tower_1_4",
        "hotel_tower_flr2_1_4", "hotel_tower_flr3_1_4", "hotel_tower_flr4_1_4", "hotel_tower_flr2_1_6",
        "hotel_tower_flr3_1_6", "hotel_tower_flr4_1_6",
    },
    copy_from = "generic_city_building",
    vision_levels = "large_pavement",
    name = ccb.content.text("hotel parking"),
    symbol = "h",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "hotel_tower_roof_1_4", "hotel_tower_flr2_1_5", "hotel_tower_flr3_1_5", "hotel_tower_flr4_1_5",
        "hotel_tower_flr2_1_5B", "hotel_tower_flr2_1_5C", "hotel_tower_1_6", "hotel_tower_roof_1_6",
        "hotel_tower_1_7", "hotel_tower_1_8", "hotel_tower_1_9", "hotel_tower_flr2_1_7",
        "hotel_tower_flr2_1_8", "hotel_tower_flr2_1_9", "hotel_tower_flr3_1_7", "hotel_tower_flr3_1_8",
        "hotel_tower_flr3_1_9", "hotel_tower_flr4_1_7", "hotel_tower_flr4_1_8", "hotel_tower_flr4_1_9",
        "hotel_tower_roof_1_7", "hotel_tower_roof_1_8", "hotel_tower_roof_1_9", "hotel_tower_6_1_7",
        "hotel_tower_6_1_8", "hotel_tower_6_1_9",
    },
    copy_from = "generic_city_building",
    vision_levels = "large_building",
    name = ccb.content.text("hotel"),
    symbol = "h",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "hotel_tower_1_5", "hotel_tower_roof_1_5", "hotel_tower_1_5B", "hotel_tower_1_5C" },
    copy_from = "generic_city_building",
    vision_levels = "isolated_building",
    name = ccb.content.text("hotel entrance"),
    symbol = "H",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "hotel_tower_b_1", "hotel_tower_b_2", "hotel_tower_b_3" },
    vision_levels = "underground_dirt",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("hotel basement"),
    symbol = "B",
    color = "light_blue",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_motel",
    name = ccb.content.text("motel"),
    vision_levels = "isolated_building",
    copy_from = "generic_city_building_no_sidewalk",
    symbol = "m",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "motel_entrance" },
    copy_from = "generic_motel",
    extend = { flags = { "SOURCE_SAFETY", "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = { "motel_1", "motel_2", "motel_3" },
    copy_from = "generic_motel",
    extend = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = { "motel_twd_1", "motel_entrance_no_sidewalk" },
    copy_from = "generic_motel",
    extend = { flags = { "SOURCE_SAFETY" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "motel_twd_2", "motel_twd_1_f1", "motel_1_no_sidewalk", "motel_2_no_sidewalk",
        "motel_3_no_sidewalk", "2fmotel_entrance_f2", "2fmotel_1_f2", "2fmotel_2_f2", "2fmotel_3_f2",
    },
    copy_from = "generic_motel",
}

ccb.content.define_overmap_terrain {
    id = {
        "motel_twd_2_f1", "motel_twd_1_f2", "motel_entrance_roof", "motel_1_roof", "motel_2_roof",
        "motel_3_roof", "2fmotel_1_r", "2fmotel_2_r", "2fmotel_3_r",
    },
    copy_from = "generic_motel",
    name = ccb.content.text("motel roof"),
}

ccb.content.define_overmap_terrain {
    id = {
        "hdwr_large_0_0_0", "hdwr_large_0_1_0", "hdwr_large_0_2_0", "hdwr_large_1_0_0",
        "hdwr_large_1_1_0", "hdwr_large_1_2_0",
    },
    vision_levels = "large_city_building",
    name = ccb.content.text("home improvement superstore"),
    symbol = "H",
    color = "light_green_yellow",
    see_cost = "full_high",
    flags = { "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = {
        "hdwr_large_0_0_1", "hdwr_large_1_0_1", "hdwr_large_0_1_1", "hdwr_large_1_1_1",
        "hdwr_large_0_2_1", "hdwr_large_1_2_1", "hdwr_large_1_1_2",
    },
    vision_levels = "roof_or_air",
    name = ccb.content.text("home improvement superstore roof"),
    symbol = "H",
    color = "light_green_yellow",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "garage_gas_1",
    copy_from = "generic_city_building",
    name = ccb.content.text("garage - gas station"),
    color = "light_blue",
    extend = { flags = { "SOURCE_FUEL", "SOURCE_VEHICLES" } },
}

ccb.content.define_overmap_terrain {
    id = { "garage_gas_2", "garage_gas_3" },
    copy_from = "generic_city_building",
    looks_like = "garage_gas_2",
    name = ccb.content.text("garage"),
    symbol = "O",
    color = "white",
    extend = { flags = { "SOURCE_FUEL", "SOURCE_VEHICLES" } },
}

ccb.content.define_overmap_terrain {
    id = { "garage_gas_roof_1", "garage_gas_roof_2", "garage_gas_roof_3" },
    copy_from = "generic_city_building_roof",
    looks_like = "garage_gas_roof_1",
    name = ccb.content.text("garage roof"),
    symbol = "O",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "dispensary", "dispensary_1", "dispensary_2" },
    copy_from = "generic_city_building",
    looks_like = "dispensary",
    name = ccb.content.text("dispensary"),
    symbol = "D",
    color = "i_green",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = { "dispensary_roof", "dispensary_roof_1", "dispensary_roof_2" },
    copy_from = "generic_city_building_roof",
    looks_like = "dispensary_roof",
    name = ccb.content.text("dispensary roof"),
    symbol = "D",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = { "candy_shop", "candy_shop_1" },
    copy_from = "generic_city_building",
    looks_like = "candy_shop",
    name = ccb.content.text("candy shop"),
    color = "red_white",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 2, 6 }, chance = 20 },
    extend = { flags = { "SOURCE_LUXURY", "SOURCE_FOOD" } },
}

ccb.content.define_overmap_terrain {
    id = { "candy_shop_roof", "candy_shop_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "candy_shop_roof",
    name = ccb.content.text("candy shop roof"),
    color = "red_white",
}

ccb.content.define_overmap_terrain {
    id = "bakery",
    name = ccb.content.text("bakery"),
    copy_from = "generic_city_building",
    color = "yellow_white",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 2, 6 }, chance = 20 },
    extend = { flags = { "SOURCE_LUXURY", "SOURCE_FOOD" } },
}

ccb.content.define_overmap_terrain {
    id = "bakery_roof",
    name = ccb.content.text("bakery roof"),
    copy_from = "generic_city_building_roof",
    color = "yellow_white",
}

ccb.content.define_overmap_terrain {
    id = "bakery_upper_roof",
    name = ccb.content.text("bakery roof"),
    copy_from = "generic_city_building_roof",
    color = "yellow_white",
}

ccb.content.define_overmap_terrain {
    id = "icecream_shop",
    name = ccb.content.text("icecream shop"),
    copy_from = "generic_city_building",
    color = "blue_white",
    spawns = { group = "GROUP_WASP_FORAGER", population = { 3, 6 }, chance = 20 },
    extend = { flags = { "SOURCE_LUXURY", "SOURCE_FOOD" } },
}

ccb.content.define_overmap_terrain {
    id = "icecream_shop_roof",
    name = ccb.content.text("icecream shop roof"),
    copy_from = "generic_city_building_roof",
    color = "blue_white",
}

ccb.content.define_overmap_terrain {
    id = { "dollarstore", "dollarstore_1" },
    copy_from = "generic_city_building",
    looks_like = "dollarstore",
    name = ccb.content.text("dollar store"),
    symbol = "$",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = { "dollarstore_roof", "dollarstore_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "dollarstore_roof",
    name = ccb.content.text("dollar store roof"),
    symbol = "$",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = "lancenter",
    name = ccb.content.text("LAN center"),
    copy_from = "generic_city_building",
    symbol = "L",
    color = "light_gray",
    extend = { flags = { "SOURCE_ELECTRONICS" } },
}

ccb.content.define_overmap_terrain {
    id = "lancenter_roof",
    name = ccb.content.text("LAN center roof"),
    copy_from = "generic_city_building_roof",
    symbol = "L",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "lancenter_1",
    name = ccb.content.text("LAN center"),
    copy_from = "generic_city_building",
    symbol = "L",
    color = "light_gray",
    extend = { flags = { "SOURCE_ELECTRONICS" } },
}

ccb.content.define_overmap_terrain {
    id = "lancenter_roof_1",
    name = ccb.content.text("LAN center roof"),
    copy_from = "generic_city_building_roof",
    symbol = "L",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "landscapingsupplyco_1a",
    copy_from = "generic_city_building",
    name = ccb.content.text("landscaping supply co"),
    symbol = "L",
    color = "i_green",
    extend = { flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION" } },
}

ccb.content.define_overmap_terrain {
    id = "landscapingsupplyco_1b",
    copy_from = "generic_city_building",
    name = ccb.content.text("landscaping supply co"),
    symbol = "L",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "landscapingsupplyco_1b_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("landscaping supply co roof"),
    symbol = "L",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "s_vfw",
    copy_from = "generic_city_building",
    name = ccb.content.text("veterans of foreign wars"),
    symbol = "w",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "s_vfw_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("veterans of foreign wars center roof"),
    symbol = "w",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "s_thrift",
    copy_from = "generic_city_building",
    name = ccb.content.text("thrift store"),
    color = "light_gray",
    extend = { flags = { "SOURCE_CLOTHING" } },
}

ccb.content.define_overmap_terrain {
    id = "s_thrift_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("thrift store roof"),
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "s_daycare",
    copy_from = "generic_city_building",
    name = ccb.content.text("daycare center"),
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = "s_daycare_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("daycare center roof"),
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_petstore", "s_petstore_1", "s_petstore_2" },
    copy_from = "generic_city_building",
    looks_like = "s_petstore",
    name = ccb.content.text("pet supply store"),
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "s_petstore_roof", "s_petstore_roof_1", "s_petstore_roof_2" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_petstore_roof",
    name = ccb.content.text("pet supply store roof"),
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_shoppingplaza_a1", "s_shoppingplaza_a2", "s_shoppingplaza_a3", "s_shoppingplaza_a4",
        "s_shoppingplaza_a5",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("abandoned shopping plaza"),
    symbol = "+",
    color = "red",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_shoppingplaza_a6", "s_shoppingplaza_b1", "s_shoppingplaza_b2", "s_shoppingplaza_b3",
        "s_shoppingplaza_b4", "s_shoppingplaza_b5", "s_shoppingplaza_b6",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("abandoned shopping plaza"),
    symbol = "M",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_shoppingplaza_A6", "s_shoppingplaza_B1", "s_shoppingplaza_B2", "s_shoppingplaza_B3",
        "s_shoppingplaza_B4", "s_shoppingplaza_B5", "s_shoppingplaza_B6",
    },
    copy_from = "s_shoppingplaza_a6",
    name = ccb.content.text("abandoned shopping plaza roof"),
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "veterinarian",
    name = ccb.content.text("veterinarian clinic"),
    copy_from = "generic_city_building",
    color = "i_pink",
    extend = { flags = { "SOURCE_MEDICINE" } },
}

ccb.content.define_overmap_terrain {
    id = "veterinarian_roof",
    name = ccb.content.text("veterinarian clinic roof"),
    copy_from = "generic_city_building_roof",
    color = "i_pink",
}

ccb.content.define_overmap_terrain {
    id = { "s_laundromat", "s_laundromat_1" },
    copy_from = "generic_city_building",
    looks_like = "s_laundromat",
    name = ccb.content.text("laundromat"),
    color = "white_white",
    extend = { flags = { "SOURCE_CLOTHING" } },
}

ccb.content.define_overmap_terrain {
    id = { "s_laundromat_roof", "s_laundromat_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "s_laundromat_roof",
    name = ccb.content.text("laundromat roof"),
    color = "white_white",
}

ccb.content.define_overmap_terrain {
    id = "trailer_commercial_00",
    copy_from = "s_laundromat",
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = "trailer_commercial_00_roof",
    copy_from = "s_laundromat_roof",
}

ccb.content.define_overmap_terrain {
    id = "s_jewelry",
    name = ccb.content.text("jewelry store"),
    copy_from = "generic_city_building",
    symbol = "J",
    color = "white",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "s_jewelry_roof",
    name = ccb.content.text("jewelry store roof"),
    copy_from = "generic_city_building_roof",
    symbol = "J",
    color = "white",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_large_office_tower",
    vision_levels = "large_city_building",
    see_cost = "full_high",
    name = ccb.content.text("office tower"),
    copy_from = "generic_city_building",
    symbol = "T",
    color = "white",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_office_skyscraper",
    vision_levels = "large_city_building",
    name = ccb.content.text("office skyscraper"),
    copy_from = "generic_city_building",
    symbol = "S",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "home_improvement",
    name = ccb.content.text("home improvement store"),
    vision_levels = "large_city_building",
    copy_from = "generic_city_building",
    color = "yellow_green",
    extend = { flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION" } },
}

ccb.content.define_overmap_terrain {
    id = "home_improvement_roof",
    name = ccb.content.text("home improvement store roof"),
    vision_levels = "roof_or_air",
    copy_from = "generic_city_building_roof",
    color = "yellow_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "loffice_tower_1", "loffice_tower_2", "loffice_tower_3", "loffice_tower_4", "loffice_tower_5",
        "loffice_tower_6", "loffice_tower_7", "loffice_tower_8", "loffice_tower_9", "loffice_tower_9b",
        "loffice_tower_10", "loffice_tower_10b", "loffice_tower_11", "loffice_tower_12",
        "loffice_tower_13", "loffice_tower_14", "loffice_tower_15", "loffice_tower_16",
    },
    copy_from = "generic_large_office_tower",
}

ccb.content.define_overmap_terrain {
    id = { "loffice_tower_17", "loffice_tower_18", "loffice_tower_19", "loffice_tower_20" },
    vision_levels = "roof_or_air",
    see_cost = "none",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "office_skyscraper_1", "office_skyscraper_2", "office_skyscraper_3", "office_skyscraper_4",
        "office_skyscraper_5", "office_skyscraper_6", "office_skyscraper_7", "office_skyscraper_8",
        "office_skyscraper_apartments_111", "office_skyscraper_apartments_011",
        "office_skyscraper_apartments_101", "office_skyscraper_apartments_001",
        "office_skyscraper_apartments_112", "office_skyscraper_apartments_012",
        "office_skyscraper_apartments_102", "office_skyscraper_apartments_002", "office_skyscraper_9",
        "office_skyscraper_9b", "office_skyscraper_10", "office_skyscraper_10b",
        "office_skyscraper_11", "office_skyscraper_12", "office_skyscraper_13", "office_skyscraper_14",
        "office_skyscraper_15", "office_skyscraper_16",
    },
    copy_from = "generic_office_skyscraper",
}

ccb.content.define_overmap_terrain {
    id = { "office_skyscraper_17", "office_skyscraper_18", "office_skyscraper_19", "office_skyscraper_20" },
    vision_levels = "roof_or_air",
    see_cost = "none",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = "s_antique",
    name = ccb.content.text("antique store"),
    copy_from = "generic_city_building",
    symbol = "A",
    color = "brown",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "s_antique_roof",
    name = ccb.content.text("antique store roof"),
    copy_from = "generic_city_building_roof",
    symbol = "A",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "s_dive_shop",
    name = ccb.content.text("dive shop"),
    copy_from = "generic_city_building",
    symbol = "D",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = "s_dive_shop_roof",
    name = ccb.content.text("dive shop roof"),
    copy_from = "generic_city_building_roof",
    symbol = "D",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = "s_arcade",
    name = ccb.content.text("arcade"),
    copy_from = "generic_city_building",
    symbol = "A",
    color = "cyan",
    extend = { flags = { "SOURCE_ELECTRONICS" } },
}

ccb.content.define_overmap_terrain {
    id = "s_arcade_roof",
    name = ccb.content.text("arcade roof"),
    copy_from = "generic_city_building_roof",
    symbol = "A",
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = "s_gardening",
    name = ccb.content.text("gardening supply"),
    copy_from = "generic_city_building",
    symbol = "F",
    color = "green",
    extend = { flags = { "SOURCE_FARMING" } },
}

ccb.content.define_overmap_terrain {
    id = "s_gardening_roof",
    name = ccb.content.text("gardening supply roof"),
    copy_from = "generic_city_building_roof",
    symbol = "F",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "craft_shop", "craft_shop_1", "craft_shop_2", "craft_shop_3" },
    copy_from = "generic_city_building",
    looks_like = "craft_shop",
    name = ccb.content.text("craft shop"),
    symbol = "s",
    color = "cyan",
    extend = { flags = { "SOURCE_FABRICATION" } },
}

ccb.content.define_overmap_terrain {
    id = "craft_shop_upper_roof",
    name = ccb.content.text("craft shop upper roof"),
    copy_from = "generic_city_building_roof",
    symbol = "s",
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = { "craft_shop_roof", "craft_shop_roof_1", "craft_shop_roof_2", "craft_shop_roof_3" },
    copy_from = "generic_city_building_roof",
    looks_like = "craft_shop_roof",
    name = ccb.content.text("craft shop roof"),
    symbol = "s",
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = { "craft_shop_2ndfloor_2", "craft_shop_2ndfloor_3" },
    name = ccb.content.text("craft shop 2nd floor"),
    copy_from = "generic_city_building",
    looks_like = "craft_shop_2ndfloor_2",
    symbol = "s",
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = "cs_market_small",
    name = ccb.content.text("small market"),
    copy_from = "generic_city_building",
    symbol = "m",
    color = "i_light_gray",
}

-- Obsolete 2024-06-24. Remains to work in existing saves
ccb.content.define_overmap_terrain {
    id = "cs_market_small_roof",
    name = ccb.content.text("small market roof"),
    copy_from = "generic_city_building",
    symbol = "m",
    color = "i_light_gray",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = "cs_sex_shop",
    copy_from = "generic_city_building",
    name = ccb.content.text("sex shop"),
    symbol = "x",
    color = "i_pink",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "cs_sex_shop_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("sex shop roof"),
    symbol = "x",
    color = "i_pink",
}

ccb.content.define_overmap_terrain {
    id = "cs_internet_cafe",
    copy_from = "generic_city_building",
    name = ccb.content.text("internet cafe"),
    symbol = "i",
    color = "light_green_cyan",
    extend = { flags = { "SOURCE_ELECTRONICS" } },
}

ccb.content.define_overmap_terrain {
    id = { "cs_internet_cafe_roof", "cs_internet_cafe_upper_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("internet cafe roof"),
    symbol = "i",
    color = "light_green_cyan",
}

ccb.content.define_overmap_terrain {
    id = "cs_car_showroom",
    copy_from = "generic_city_building",
    name = ccb.content.text("car showroom"),
    symbol = "c",
    color = "i_cyan",
    extend = { flags = { "SOURCE_VEHICLES" } },
}

ccb.content.define_overmap_terrain {
    id = "cs_car_showroom_2ndfloor",
    copy_from = "generic_city_building",
    name = ccb.content.text("car showroom 2nd floor"),
    symbol = "c",
    color = "i_cyan",
}

ccb.content.define_overmap_terrain {
    id = "cs_car_showroom_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("car showroom roof"),
    symbol = "c",
    color = "i_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "cs_car_dealership", "s_cardealer" },
    copy_from = "generic_city_building",
    looks_like = "cs_car_dealership",
    name = ccb.content.text("car dealership"),
    symbol = "c",
    color = "i_cyan",
    extend = { flags = { "SOURCE_VEHICLES" } },
}

ccb.content.define_overmap_terrain {
    id = { "cs_car_dealership_roof", "s_cardealer_roof" },
    copy_from = "generic_city_building_roof",
    looks_like = "cs_car_dealership_roof",
    name = ccb.content.text("car dealership"),
    symbol = "c",
    color = "i_cyan",
}

ccb.content.define_overmap_terrain {
    id = "cs_tire_shop",
    copy_from = "generic_city_building",
    name = ccb.content.text("tire shop"),
    symbol = "O",
    color = "white",
    extend = { flags = { "SOURCE_VEHICLES" } },
}

ccb.content.define_overmap_terrain {
    id = "cs_tire_shop_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("tire shop roof"),
    symbol = "O",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "headshop",
    copy_from = "generic_city_building",
    name = ccb.content.text("head shop"),
    symbol = "0",
    color = "i_white",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = { "headshop_roof", "headshop_upper_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("head shop roof"),
    symbol = "0",
    color = "i_white",
}

ccb.content.define_overmap_terrain {
    id = { "abstorefront", "abstorefront_1", "abstorefront_2" },
    copy_from = "generic_city_building",
    looks_like = "abstorefront",
    name = ccb.content.text("abandoned storefront"),
    color = "h_dark_gray",
}

ccb.content.define_overmap_terrain {
    id = { "abstorefront_roof", "abstorefront_roof_1", "abstorefront_roof_2" },
    copy_from = "generic_city_building_roof",
    looks_like = "abstorefront_roof",
    name = ccb.content.text("abandoned storefront roof"),
    color = "h_dark_gray",
}

ccb.content.define_overmap_terrain {
    id = { "station_radio", "station_radio_1" },
    copy_from = "generic_city_building",
    looks_like = "station_radio",
    name = ccb.content.text("radio station"),
    symbol = "X",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "station_radio_roof", "station_radio_roof_1" },
    copy_from = "generic_city_building_roof",
    looks_like = "station_radio_roof",
    name = ccb.content.text("radio station roof"),
    symbol = "X",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "station_radio_tower_even", "station_radio_tower_odd", "station_radio_tower_top",
        "station_radio_1_tower_even", "station_radio_1_tower_odd", "station_radio_1_tower_top",
    },
    vision_levels = "isolated_tower",
    name = ccb.content.text("radio tower"),
    symbol = "X",
    color = "light_gray",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = "cs_gardening_allotment",
    copy_from = "generic_city_building",
    name = ccb.content.text("gardening allotment"),
    symbol = "a",
    color = "brown_green",
    extend = { flags = { "SOURCE_FARMING" } },
}

ccb.content.define_overmap_terrain {
    id = "cs_gardening_allotment_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("gardening allotment roof"),
    symbol = "a",
    color = "brown_green",
}

ccb.content.define_overmap_terrain {
    id = "animalpound",
    name = ccb.content.text("animal pound"),
    copy_from = "generic_city_building",
    symbol = "T",
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = "animalpound_roof",
    name = ccb.content.text("animal pound roof"),
    copy_from = "generic_city_building_roof",
    symbol = "T",
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = "animalshelter",
    name = ccb.content.text("animal shelter"),
    copy_from = "generic_city_building",
    color = "i_pink",
}

ccb.content.define_overmap_terrain {
    id = "animalshelter_roof",
    name = ccb.content.text("animal shelter roof"),
    copy_from = "generic_city_building_roof",
    color = "i_pink",
}

ccb.content.define_overmap_terrain {
    id = "emptycommerciallot",
    copy_from = "generic_city_building",
    name = ccb.content.text("empty commercial lot"),
    symbol = "O",
    color = "i_light_gray",
}

ccb.content.define_overmap_terrain {
    id = "s_hunting",
    copy_from = "generic_city_building",
    name = ccb.content.text("hunting supply store"),
    symbol = "H",
    color = "brown",
    extend = { flags = { "SOURCE_WEAPON", "SOURCE_CLOTHING" } },
}

ccb.content.define_overmap_terrain {
    id = "s_hunting_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("hunting supply store roof"),
    symbol = "H",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "s_camping",
    name = ccb.content.text("outdoorsman's store"),
    copy_from = "generic_city_building",
    symbol = "o",
    color = "brown",
    extend = { flags = { "SOURCE_WEAPON", "SOURCE_CLOTHING" } },
}

ccb.content.define_overmap_terrain {
    id = "s_camping_roof",
    name = ccb.content.text("outdoorsman's store"),
    copy_from = "generic_city_building_roof",
    symbol = "o",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = {
        "city_block2_1", "city_block2_2", "city_block2_3", "city_block2_4", "city_block2_flr2_1",
        "city_block2_flr2_2", "city_block2_flr2_3", "city_block2_flr2_4",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("urban city block"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "city_block2_roof_1", "city_block2_roof_2", "city_block2_roof_3", "city_block2_roof_4" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("urban city block"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "textile_mill_museum_0a0", "textile_mill_museum_0a1", "textile_mill_museum_0a2",
        "textile_mill_museum_0b0", "textile_mill_museum_0b1", "textile_mill_museum_0b2",
        "textile_mill_museum_1a0", "textile_mill_museum_1a1", "textile_mill_museum_1a2",
        "textile_mill_museum_1b0", "textile_mill_museum_1b1", "textile_mill_museum_1b2",
        "textile_mill_museum_2a0", "textile_mill_museum_2a1", "textile_mill_museum_2a2",
        "textile_mill_museum_2b0", "textile_mill_museum_2b1", "textile_mill_museum_2b2",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("textile mill museum"),
    color = "light_blue",
    extend = { flags = { "SOURCE_TAILORING" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "urban_25_3", "urban_25_4", "urban_25_5", "urban_25_6", "urban_25_7", "urban_25_8",
        "urban_25_9", "urban_25_10", "urban_25_12",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("urban city block"),
    color = "light_blue",
    symbol = "v",
}

ccb.content.define_overmap_terrain {
    id = { "urban_14_1", "urban_14_2", "urban_25_1", "urban_25_2" },
    spawns = { group = "GROUP_BASEMENT_HOUSE", population = { 1, 1 }, chance = 80 },
    copy_from = "generic_city_house_basement",
}

ccb.content.define_overmap_terrain {
    id = {
        "urban_14_10", "urban_14_11", "urban_14_12", "urban_14_13", "urban_14_14", "urban_14_3",
        "urban_14_4", "urban_14_5", "urban_14_6", "urban_14_7", "urban_14_8", "urban_14_9",
    },
    copy_from = "generic_city_house",
    name = ccb.content.text("dense urban"),
    color = "i_white",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "s_games",
    name = ccb.content.text("gaming store"),
    copy_from = "generic_city_building",
    symbol = "g",
    color = "cyan",
}

ccb.content.define_overmap_terrain {
    id = "s_games_roof",
    name = ccb.content.text("gaming store roof"),
    copy_from = "s_games",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "s_gas_b11",
    name = ccb.content.text("bunker reception"),
    copy_from = "generic_city_building_no_sidewalk",
    symbol = "R",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "s_gas_b20", "s_gas_b21" },
    name = ccb.content.text("bunker"),
    copy_from = "generic_city_building_no_sidewalk",
    symbol = "B",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "salon",
    copy_from = "generic_city_building",
    name = ccb.content.text("salon"),
    symbol = "s",
    color = "pink",
    looks_like = "salon",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "salon_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("salon roof"),
    looks_like = "salon_roof",
    symbol = "s",
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = { "strip_mall_1", "strip_mall_2", "strip_mall_3", "strip_mall_4" },
    name = ccb.content.text("strip mall"),
    symbol = "v",
    color = "light_red",
    monster_density = 1,
    copy_from = "generic_city_building",
    flags = { "SIDEWALK" },
}

ccb.content.define_overmap_terrain {
    id = { "strip_mall_roof_1", "strip_mall_roof_2", "strip_mall_roof_3", "strip_mall_roof_4" },
    name = ccb.content.text("strip mall roof"),
    symbol = "v",
    color = "light_red",
    copy_from = "generic_city_building_roof",
}

ccb.content.define_overmap_terrain {
    id = "strip_mall_5",
    name = ccb.content.text("parking lot"),
    symbol = "O",
    color = "dark_gray",
    monster_density = 1,
    flags = { "SIDEWALK" },
    copy_from = "generic_city_building",
}

ccb.content.define_overmap_terrain {
    id = "strip_mall_roof_5",
    name = ccb.content.text("open air"),
    copy_from = "generic_city_building_roof",
    symbol = ".",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "convention_0_0_0", "convention_1_0_0", "convention_2_0_0", "convention_3_0_0",
        "convention_4_0_0", "convention_0_1_0", "convention_1_1_0", "convention_2_1_0",
        "convention_3_1_0", "convention_4_1_0", "convention_0_2_0", "convention_1_2_0",
        "convention_2_2_0", "convention_3_2_0", "convention_4_2_0", "convention_0_0_1",
        "convention_1_0_1", "convention_2_0_1", "convention_3_0_1", "convention_4_0_1",
        "convention_0_1_1", "convention_1_1_1", "convention_2_1_1", "convention_3_1_1",
        "convention_4_1_1", "convention_0_2_1", "convention_1_2_1", "convention_2_2_1",
        "convention_3_2_1", "convention_4_2_1", "convention_0_0_2", "convention_1_0_2",
        "convention_2_0_2", "convention_3_0_2", "convention_4_0_2", "convention_0_1_2",
        "convention_1_1_2", "convention_2_1_2", "convention_3_1_2", "convention_4_1_2",
        "convention_0_2_2", "convention_1_2_2", "convention_2_2_2", "convention_3_2_2",
        "convention_4_2_2",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("convention center"),
    symbol = "C",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = { "barber_shop" },
    copy_from = "generic_city_building",
    name = ccb.content.text("barber shop"),
    looks_like = "barber_shop",
    symbol = "b",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "barber_shop_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("barber shop roof"),
    looks_like = "barber_shop_roof",
    symbol = "b",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "s_airsoft" },
    copy_from = "generic_city_building",
    name = ccb.content.text("airsoft store"),
    symbol = "a",
    color = "red_white",
}

ccb.content.define_overmap_terrain {
    id = { "s_airsoft_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("airsoft store roof"),
    symbol = "a",
    color = "red_white",
}
