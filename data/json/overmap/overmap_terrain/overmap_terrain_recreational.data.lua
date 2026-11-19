local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_park",
    copy_from = "generic_city_building",
    name = ccb.content.text("park"),
    symbol = "O",
    color = "green",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = {
        "park", "park_roof", "park_2", "park_3", "park_4", "park_5", "park_5_roof", "park_6", "park_7",
        "park_7_roof",
    },
    copy_from = "generic_park",
}

ccb.content.define_overmap_terrain {
    id = { "playground", "playground_roof", "playground_1" },
    copy_from = "generic_park",
    name = ccb.content.text("playground"),
}

ccb.content.define_overmap_terrain {
    id = { "dog_park" },
    copy_from = "generic_park",
    name = ccb.content.text("dog park"),
}

ccb.content.define_overmap_terrain {
    abstract = "sports_court",
    copy_from = "generic_city_building",
    symbol = "O",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = { "volleyball_court" },
    copy_from = "sports_court",
    name = ccb.content.text("volleyball court"),
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = { "tennis_court" },
    copy_from = "sports_court",
    name = ccb.content.text("tennis court"),
}

ccb.content.define_overmap_terrain {
    id = { "baskeball_court" },
    copy_from = "sports_court",
    name = ccb.content.text("basketball court"),
}

ccb.content.define_overmap_terrain {
    id = {
        "pool", "pool_roof", "pool_1", "pool_roof_1", "pool_2", "pool_roof_2", "pool_3", "pool_roof_3",
        "pool_4", "pool_roof_4", "pool_5", "pool_6",
    },
    name = ccb.content.text("pool"),
    symbol = "O",
    color = "blue",
    vision_levels = "single_water",
    see_cost = "none",
    monster_density = 2,
    flags = { "SIDEWALK", "SOURCE_DRINK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "art_gallery",
    copy_from = "generic_city_building",
    name = ccb.content.text("art gallery"),
    symbol = "a",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = "art_gallery_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("art gallery roof"),
    symbol = "a",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "state_park_0_0", "state_park_0_1", "state_park_1_0", "state_park_1_1", "state_park_1_0_1" },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("state park"),
    symbol = "S",
    color = "i_green",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "fishing_pond_0_0", "fishing_pond_0_1", "fishing_pond_1_0", "fishing_pond_1_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("fishing pond"),
    symbol = "S",
    color = "i_blue",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = { "skate_park", "skate_park_up", "skate_park_down" },
    copy_from = "generic_city_building",
    name = ccb.content.text("skate park"),
    symbol = "O",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = { "small_wooded_trail", "small_wooded_trail_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("small wooded trail"),
    symbol = "S",
    color = "i_green",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = { "pavilion", "pavilion_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("pavilion"),
    symbol = "A",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "trailer_public_10",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("pavilion"),
    symbol = "A",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = { "pavilion_roof", "pavilion_roof_1", "trailer_public_10_roof" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("pavilion roof"),
    symbol = "A",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = "hunting_blind",
    name = ccb.content.text("hunting blind"),
    symbol = "H",
    color = "i_green",
    vision_levels = "blends_till_details",
    see_cost = "medium",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "NatureTrail_1a", "NatureTrail_1b" },
    copy_from = "generic_city_building",
    name = ccb.content.text("nature trail"),
    symbol = "S",
    color = "i_green",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = { "PublicPond_1a", "PublicPond_1b" },
    copy_from = "generic_city_building",
    name = ccb.content.text("public pond"),
    symbol = "P",
    color = "i_green",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = { "communitygarden", "communitygarden_2", "communitygarden_3" },
    name = ccb.content.text("community garden"),
    symbol = "g",
    color = "yellow",
    vision_levels = "blends_till_details",
    see_cost = "low",
    monster_density = 2,
    flags = { "SIDEWALK", "SOURCE_FARMING" },
    extras = "park",
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "publicgarden", "publicgarden_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("public garden"),
    looks_like = "publicgarden",
    symbol = "g",
    color = "light_green",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = { "BotanicalGarden_1a", "BotanicalGarden_1b" },
    name = ccb.content.text("botanical garden"),
    symbol = "g",
    color = "i_green",
    vision_levels = "city_building",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "SOURCE_FARMING" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = { "BotanicalGarden_1a_roof", "BotanicalGarden_1b_roof" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("botanical garden"),
    symbol = "g",
    color = "i_green",
    see_cost = "none",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "TreeFarm_1a",
    vision_levels = "forested",
    name = ccb.content.text("tree farm"),
    symbol = "T",
    color = "i_green",
    see_cost = "spaced_high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = "TreeFarm_1a_roof",
    vision_levels = "forested",
    name = ccb.content.text("tree farm"),
    symbol = "T",
    color = "i_green",
    see_cost = "spaced_high",
}

ccb.content.define_overmap_terrain {
    id = { "shootingrange_1a", "shootingrange_2a" },
    name = ccb.content.text("shooting range"),
    symbol = "S",
    color = "red",
    vision_levels = "open_land",
    see_cost = "low",
    monster_density = 2,
    flags = { "SOURCE_GUN", "SOURCE_AMMO" },
}

ccb.content.define_overmap_terrain {
    id = "shootingrange_1a_roof",
    name = ccb.content.text("shooting range roof"),
    vision_levels = "roof_or_air",
    symbol = "S",
    color = "red",
    see_cost = "none",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = {
        "miniaturerailway_0_0_0", "miniaturerailway_0_1_0", "miniaturerailway_1_0_0",
        "miniaturerailway_1_1_0", "miniaturerailway_0_0_1", "miniaturerailway_0_1_1",
        "miniaturerailway_1_0_1", "miniaturerailway_1_1_1",
    },
    vision_levels = "isolated_building",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("miniature railway"),
    symbol = "R",
    color = "green",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "luna_park_0_0_0", "luna_park_1_0_0", "luna_park_2_0_0", "luna_park_0_1_0", "luna_park_1_1_0",
        "luna_park_2_1_0", "luna_park_0_0_1", "luna_park_1_0_1", "luna_park_2_0_1", "luna_park_0_1_1",
        "luna_park_1_1_1", "luna_park_2_1_1",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "isolated_building",
    name = ccb.content.text("miniature railway park"),
    symbol = "P",
    color = "light_green",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "golfcourse_00", "golfcourse_01", "golfcourse_02", "golfcourse_10", "golfcourse_11",
        "golfcourse_12", "golfcourse_20", "golfcourse_21", "golfcourse_22", "golfcourse_32",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "open_land",
    name = ccb.content.text("golf course"),
    symbol = "G",
    color = "green",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "golfcourse_30",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("golf course parking lot"),
    vision_levels = "large_pavement",
    symbol = "G",
    color = "light_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "golfcourse_31",
    vision_levels = "isolated_building",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("golf course service building"),
    symbol = "G",
    color = "light_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "golfcourse_31_2ndfloor",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("golf course bar"),
    symbol = "G",
    color = "light_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "golfcourse_31_roof",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("golf course service building roof"),
    symbol = "G",
    color = "light_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "zoo_0_0", "zoo_1_0" },
    copy_from = "generic_city_building",
    name = ccb.content.text("zoo parking"),
    symbol = "P",
    color = "i_green",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = { "zoo_2_0", "zoo_3_0" },
    copy_from = "generic_city_building",
    name = ccb.content.text("zoo entrance"),
    symbol = "P",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "zoo_0_1", "zoo_1_1", "zoo_2_1", "zoo_3_1", "zoo_0_2", "zoo_1_2", "zoo_2_2", "zoo_3_2",
        "zoo_0_3", "zoo_1_3", "zoo_2_3", "zoo_3_3",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("zoo"),
    symbol = "Z",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = { "zoo_3_2_basement", "zoo_3_3_basement" },
    copy_from = "generic_city_building",
    name = ccb.content.text("zoo cave"),
    symbol = "Z",
    color = "light_gray",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "zoo_0_0_roof", "zoo_1_0_roof", "zoo_2_0_roof", "zoo_3_0_roof", "zoo_0_1_roof", "zoo_1_1_roof",
        "zoo_2_1_roof", "zoo_3_1_roof", "zoo_0_2_roof", "zoo_1_2_roof", "zoo_2_2_roof", "zoo_3_2_roof",
        "zoo_0_3_roof", "zoo_1_3_roof", "zoo_2_3_roof", "zoo_3_3_roof",
    },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("zoo roof"),
    symbol = "Z",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "s_baseballfield_a1", "s_baseballfield_a2", "s_baseballfield_a2_2", "s_baseballfield_b1",
        "s_baseballfield_b2", "stadium_1_2", "stadium_2_2", "stadium_1_3", "stadium_2_3",
    },
    copy_from = "generic_city_building",
    vision_levels = "blends_till_details",
    name = ccb.content.text("baseball field"),
    symbol = "#",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "football_field_a1", "football_field_a2", "football_field_a3", "football_field_a4",
        "football_field_a5", "football_field_b1", "football_field_b2", "football_field_b3",
        "football_field_b4", "football_field_b5", "football_field_c1", "football_field_c2",
        "football_field_c3", "football_field_c4", "football_field_c5", "football_field_B1",
        "football_field_B5", "football_field_C5", "stadium_football_2_2", "stadium_football_3_2",
        "stadium_football_4_2", "stadium_football_5_2", "stadium_football_6_2", "stadium_football_2_3",
        "stadium_football_3_3", "stadium_football_4_3", "stadium_football_5_3", "stadium_football_6_3",
        "stadium_football_2_4", "stadium_football_3_4", "stadium_football_4_4", "stadium_football_5_4",
        "stadium_football_6_4",
    },
    copy_from = "generic_city_building",
    vision_levels = "blends_till_details",
    name = ccb.content.text("football field"),
    symbol = "O",
    color = "light_green",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "stadium_0_1", "stadium_3_1", "stadium_0_2", "stadium_0_3", "stadium_0_4", "stadium_3_2",
        "stadium_3_3", "stadium_1_4", "stadium_2_4", "stadium_3_4", "stadium_0_1_1", "stadium_1_1_1",
        "stadium_2_1_1", "stadium_3_1_1", "stadium_0_2_1", "stadium_0_3_1", "stadium_0_4_1",
        "stadium_3_2_1", "stadium_3_3_1", "stadium_1_4_1", "stadium_2_4_1", "stadium_3_4_1",
        "stadium_0_1_2", "stadium_1_1_2", "stadium_2_1_2", "stadium_3_1_2", "stadium_0_2_2",
        "stadium_0_3_2", "stadium_0_4_2", "stadium_3_2_2", "stadium_3_3_2", "stadium_1_4_2",
        "stadium_2_4_2", "stadium_3_4_2", "stadium_1_1_3", "stadium_2_1_3", "stadium_0_3_3",
        "stadium_football_1_1", "stadium_football_3_1", "stadium_football_4_1", "stadium_football_5_1",
        "stadium_football_7_1", "stadium_football_1_5", "stadium_football_2_5", "stadium_football_3_5",
        "stadium_football_5_5", "stadium_football_6_5", "stadium_football_7_5", "stadium_football_1_2",
        "stadium_football_1_4", "stadium_football_7_2", "stadium_football_7_4",
        "stadium_football_2_1_1", "stadium_football_6_1_1", "stadium_football_1_3_1",
        "stadium_football_7_3_1", "stadium_football_4_5_1", "stadium_football_1_1_1",
        "stadium_football_3_1_1", "stadium_football_4_1_1", "stadium_football_5_1_1",
        "stadium_football_7_1_1", "stadium_football_1_5_1", "stadium_football_2_5_1",
        "stadium_football_3_5_1", "stadium_football_5_5_1", "stadium_football_6_5_1",
        "stadium_football_7_5_1", "stadium_football_1_2_1", "stadium_football_1_4_1",
        "stadium_football_7_2_1", "stadium_football_7_4_1", "stadium_football_2_1_2",
        "stadium_football_6_1_2", "stadium_football_1_3_2", "stadium_football_7_3_2",
        "stadium_football_4_5_2", "stadium_football_1_1_2", "stadium_football_3_1_2",
        "stadium_football_4_1_2", "stadium_football_5_1_2", "stadium_football_7_1_2",
        "stadium_football_1_5_2", "stadium_football_2_5_2", "stadium_football_3_5_2",
        "stadium_football_5_5_2", "stadium_football_6_5_2", "stadium_football_7_5_2",
        "stadium_football_1_2_2", "stadium_football_1_4_2", "stadium_football_7_2_2",
        "stadium_football_7_4_2", "stadium_football_2_1_3", "stadium_football_6_1_3",
        "stadium_football_1_3_3", "stadium_football_7_3_3", "stadium_football_4_5_3",
        "stadium_football_1_1_3", "stadium_football_3_1_3", "stadium_football_4_1_3",
        "stadium_football_5_1_3", "stadium_football_7_1_3", "stadium_football_1_5_3",
        "stadium_football_2_5_3", "stadium_football_3_5_3", "stadium_football_5_5_3",
        "stadium_football_6_5_3", "stadium_football_7_5_3", "stadium_football_1_2_3",
        "stadium_football_1_4_3", "stadium_football_7_2_3", "stadium_football_7_4_3",
        "stadium_football_2_1_4", "stadium_football_3_1_4", "stadium_football_4_1_4",
        "stadium_football_5_1_4", "stadium_football_6_1_4", "stadium_football_2_5_4",
        "stadium_football_3_5_4", "stadium_football_4_5_4", "stadium_football_5_5_4",
        "stadium_football_6_5_4", "stadium_football_2_1_5", "stadium_football_3_1_5",
        "stadium_football_4_1_5", "stadium_football_5_1_5", "stadium_football_6_1_5",
        "stadium_football_2_5_5", "stadium_football_3_5_5", "stadium_football_4_5_5",
        "stadium_football_5_5_5", "stadium_football_6_5_5",
    },
    copy_from = "generic_city_building",
    vision_levels = "large_city_building",
    name = ccb.content.text("stadium"),
    symbol = "0",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "stadium_football_2_1", "stadium_football_6_1", "stadium_football_1_3", "stadium_football_7_3",
        "stadium_football_4_5", "stadium_1_1", "stadium_2_1",
    },
    copy_from = "generic_city_building",
    vision_levels = "large_city_building",
    name = ccb.content.text("stadium entrance"),
    symbol = "0",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "stadium_1_2_1", "stadium_2_2_1", "stadium_1_3_1", "stadium_2_3_1", "stadium_1_2_2",
        "stadium_2_2_2", "stadium_1_3_2", "stadium_2_3_2", "stadium_football_2_3_1",
        "stadium_football_6_3_1",
    },
    name = ccb.content.text("open air"),
    vision_levels = "roof_or_air",
    symbol = ".",
    color = "blue",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_stadium_park",
    vision_levels = "large_pavement",
    name = ccb.content.text("stadium parking"),
    color = "dark_gray",
    see_cost = "none",
    monster_density = 2,
    flags = { "SIDEWALK" },
    post_process_generators = { "riot_damage" },
}

ccb.content.define_overmap_terrain {
    id = "stadium_football_0_0",
    copy_from = "generic_stadium_park",
    symbol = "┌",
}

ccb.content.define_overmap_terrain {
    id = {
        "stadium_football_1_0", "stadium_football_3_0", "stadium_football_4_0", "stadium_football_5_0",
        "stadium_football_7_0", "stadium_football_1_6", "stadium_football_2_6", "stadium_football_3_6",
        "stadium_football_4_6", "stadium_football_5_6", "stadium_football_6_6", "stadium_football_7_6",
    },
    copy_from = "generic_stadium_park",
    symbol = "─",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = { "stadium_football_0_3", "stadium_football_8_3" },
    copy_from = "generic_stadium_park",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = {
        "stadium_football_0_1", "stadium_football_0_2", "stadium_football_0_4", "stadium_football_0_5",
        "stadium_football_8_1", "stadium_football_8_2", "stadium_football_8_4", "stadium_football_8_5",
    },
    copy_from = "stadium_football_0_3",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = { "stadium_1_0", "stadium_2_0", "stadium_0_0", "stadium_3_0" },
    copy_from = "generic_stadium_park",
    symbol = "O",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = { "stadium_football_0_6" },
    copy_from = "generic_stadium_park",
    symbol = "└",
}

ccb.content.define_overmap_terrain {
    id = "stadium_football_8_0",
    copy_from = "generic_stadium_park",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = { "stadium_football_2_0", "stadium_football_6_0" },
    copy_from = "generic_stadium_park",
    symbol = "┴",
}

ccb.content.define_overmap_terrain {
    id = { "stadium_football_8_6" },
    copy_from = "generic_stadium_park",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = "natural_spring",
    copy_from = "pond_field",
    name = ccb.content.text("natural spring"),
    symbol = "o",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = {
        "karting_0_0_0", "karting_0_0_1", "karting_0_0_2", "karting_0_1_0", "karting_0_1_1",
        "karting_0_1_2", "karting_0_2_0", "karting_0_2_1", "karting_0_2_2", "karting_1_0_0",
        "karting_1_0_1", "karting_1_0_2", "karting_1_1_0", "karting_1_1_1", "karting_1_1_2",
        "karting_1_2_0", "karting_1_2_1", "karting_1_2_2", "karting_2_0_0", "karting_2_0_1",
        "karting_2_0_2", "karting_2_1_0", "karting_2_1_1", "karting_2_1_2", "karting_2_2_0",
        "karting_2_2_1", "karting_2_2_2",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("go-kart track"),
    symbol = "M",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "movietheater_0_0", "movietheater_2_0", "movietheater_0_1", "movietheater_1_1",
        "movietheater_2_1", "movietheater_0_2", "movietheater_1_2", "movietheater_2_2",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("movie theater"),
    symbol = "M",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = "movietheater_1_0",
    copy_from = "generic_city_building",
    name = ccb.content.text("movie theater entrance"),
    symbol = "+",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "movietheater_roof_0_0", "movietheater_roof_1_0", "movietheater_roof_2_0",
        "movietheater_2_2_0", "movietheater_roof_0_1", "movietheater_roof_1_1",
        "movietheater_roof_2_1", "movietheater_2_2_1", "movietheater_roof_0_2",
        "movietheater_roof_1_2", "movietheater_roof_2_2",
    },
    copy_from = "generic_city_building_roof",
    vision_levels = "large_building",
    name = ccb.content.text("movie theater roof"),
    symbol = "M",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "car_theater_0_0", "car_theater_1_0", "car_theater_2_0", "car_theater_0_1", "car_theater_1_1",
        "car_theater_2_1", "car_theater_0_2", "car_theater_1_2", "car_theater_1_2_1",
        "car_theater_1_2_2", "car_theater_2_2", "car_theater_0_0_1", "car_theater_1_0_1",
        "car_theater_2_0_1", "car_theater_0_0_2", "car_theater_1_0_2", "car_theater_2_0_2",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "large_pavement",
    name = ccb.content.text("drive-in theater"),
    symbol = "M",
    color = "i_yellow",
}

ccb.content.define_overmap_terrain {
    id = {
        "car_theater_3_1", "car_theater_3_2", "car_theater_3_1_1", "car_theater_3_2_1",
        "car_theater_4_1", "car_theater_4_2",
    },
    copy_from = "generic_city_building_no_sidewalk",
    vision_levels = "isolated_building",
    name = ccb.content.text("drive-in theater entrance"),
    symbol = "+",
    color = "yellow",
}

ccb.content.define_overmap_terrain {
    id = "car_theater_3_0",
    copy_from = "road_abstract",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "paintball_field", "paintball_field_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("paintball field"),
    symbol = "p",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "paintball_field_roof", "paintball_field_roof_1" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("paintball field roof"),
    symbol = "p",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = { "smoke_lounge", "smoke_lounge_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("smoking lounge"),
    symbol = "s",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "smoke_lounge_roof", "smoke_lounge_roof_1" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("smoking lounge roof"),
    symbol = "s",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "music_venue", "music_venue_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("music venue"),
    symbol = "M",
    color = "i_light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "music_venue_roof", "music_venue_1_roof", "music_venue_1_roof_top" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("music venue roof"),
    symbol = "M",
    color = "i_light_blue",
}

ccb.content.define_overmap_terrain {
    id = { "gambling_hall", "gambling_hall_1" },
    copy_from = "generic_city_building",
    name = ccb.content.text("gambling hall"),
    symbol = "g",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "gambling_hall_roof", "gambling_hall_upper_roof", "gambling_hall_roof_1" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("gambling hall roof"),
    symbol = "g",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "stripclub", "stripclub_1", "stripclub_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("strip club"),
    symbol = "s",
    color = "i_red",
}

ccb.content.define_overmap_terrain {
    id = { "stripclub_roof", "stripclub_roof_1", "stripclub_roof_2" },
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("strip club roof"),
    symbol = "s",
    color = "i_red",
}

ccb.content.define_overmap_terrain {
    id = "museum",
    name = ccb.content.text("museum"),
    copy_from = "generic_city_building",
    symbol = "M",
    color = "white",
    extend = { flags = { "SOURCE_LUXURY" } },
}

ccb.content.define_overmap_terrain {
    id = "museum_roof",
    name = ccb.content.text("museum roof"),
    copy_from = "generic_city_building_roof",
    symbol = "M",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "bowling_alley",
    name = ccb.content.text("bowling alley"),
    copy_from = "generic_city_building",
    symbol = "B",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "bowling_alley_roof",
    name = ccb.content.text("bowling alley roof"),
    copy_from = "generic_city_building_roof",
    symbol = "B",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "gym",
    name = ccb.content.text("boxing gym"),
    copy_from = "generic_city_building",
    color = "yellow_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "gym_roof", "gym_upper_roof" },
    name = ccb.content.text("boxing gym roof"),
    copy_from = "generic_city_building_roof",
    color = "yellow_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "gym_fitness", "gym_fitness_1", "gym_fitness_2ndFloor_1" },
    name = ccb.content.text("fitness gym"),
    copy_from = "generic_city_building",
    color = "i_light_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "gym_fitness_roof", "gym_fitness_roof_1" },
    name = ccb.content.text("fitness gym roof"),
    copy_from = "generic_city_building_roof",
    color = "i_light_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "dojo", "dojo_1" },
    name = ccb.content.text("dojo"),
    copy_from = "generic_city_building",
    color = "i_light_cyan",
}

ccb.content.define_overmap_terrain {
    id = { "dojo_roof", "dojo_upper_roof", "dojo_roof_1", "dojo_upper_roof_1" },
    name = ccb.content.text("dojo roof"),
    copy_from = "generic_city_building_roof",
    color = "i_light_cyan",
}

ccb.content.define_overmap_terrain {
    id = "cs_private_park",
    copy_from = "generic_city_building",
    name = ccb.content.text("private park"),
    symbol = "p",
    color = "light_green_red",
}

ccb.content.define_overmap_terrain {
    id = "cs_private_park_roof",
    copy_from = "generic_city_building_roof",
    name = ccb.content.text("private park roof"),
    symbol = "p",
    color = "light_green_red",
    extras = "park",
}

ccb.content.define_overmap_terrain {
    id = "cs_public_art_piece",
    copy_from = "generic_city_building",
    name = ccb.content.text("public art piece"),
    symbol = "a",
    color = "i_white",
}

ccb.content.define_overmap_terrain {
    id = "lake_dock_small",
    copy_from = "generic_recreation_water",
    vision_levels = "blends_till_details",
    name = ccb.content.text("dock"),
    symbol = "d",
    color = "white",
    see_cost = "none",
    flags = { "LAKE" },
}

ccb.content.define_overmap_terrain {
    id = "lake_shore_dock_small",
    copy_from = "generic_recreation_water",
    vision_levels = "blends_till_details",
    name = ccb.content.text("dock"),
    symbol = "d",
    color = "white",
    see_cost = "none",
    flags = { "LAKE_SHORE" },
}

ccb.content.define_overmap_terrain {
    id = {
        "marina_1", "marina_2", "marina_3", "marina_4", "marina_5", "marina_6", "marina_7", "marina_8",
        "marina_9", "marina_10",
    },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("marina"),
    color = "cyan",
    symbol = "~",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "marina_11", "marina_12", "marina_13", "marina_14", "marina_15", "marina_11_roof",
        "marina_12_roof", "marina_15_roof",
    },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("marina"),
    color = "cyan",
    symbol = "m",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "marina_16", "marina_17", "marina_18", "marina_19", "marina_20" },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("marina parking"),
    color = "cyan",
    symbol = "m",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "park_maze", "park_maze_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("hedge maze"),
    symbol = "g",
    color = "light_green",
}
