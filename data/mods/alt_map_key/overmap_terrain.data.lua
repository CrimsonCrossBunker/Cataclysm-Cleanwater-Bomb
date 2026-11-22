local ccb = require("ccb")
local content = ccb.content

content.patch_overmap_terrain {
    ids = { "paintball_field", "paintball_field_1" },
    copy_from = "paintball_field",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("paintball field"),
}

content.patch_overmap_terrain {
    ids = { "paintball_field_roof", "paintball_field_roof_1" },
    copy_from = "paintball_field_roof",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("paintball field roof"),
}

content.patch_overmap_terrain {
    ids = { "gambling_hall", "gambling_hall_1" },
    copy_from = "gambling_hall",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("gambling hall"),
}

content.patch_overmap_terrain {
    ids = { "gambling_hall_roof", "gambling_hall_upper_roof", "gambling_hall_roof_1" },
    copy_from = "gambling_hall_roof",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("gambling hall roof"),
}

content.patch_overmap_terrain {
    ids = { "pool", "pool_1", "pool_2", "pool_3", "pool_4", "pool_5", "pool_6" },
    copy_from = "pool",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("pool"),
}

content.patch_overmap_terrain {
    ids = { "pool_roof", "pool_roof_1", "pool_roof_2", "pool_roof_3", "pool_roof_4" },
    copy_from = "pool_roof",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("pool roof"),
}

content.patch_overmap_terrain {
    ids = {
        "convention_0_0_0", "convention_1_0_0", "convention_2_0_0", "convention_3_0_0", "convention_4_0_0",
        "convention_0_1_0", "convention_1_1_0", "convention_2_1_0", "convention_3_1_0", "convention_4_1_0",
        "convention_0_2_0", "convention_1_2_0", "convention_2_2_0", "convention_3_2_0", "convention_4_2_0",
        "convention_0_0_1", "convention_1_0_1", "convention_2_0_1", "convention_3_0_1", "convention_4_0_1",
        "convention_0_1_1", "convention_1_1_1", "convention_2_1_1", "convention_3_1_1", "convention_4_1_1",
        "convention_0_2_1", "convention_1_2_1", "convention_2_2_1", "convention_3_2_1", "convention_4_2_1",
        "convention_0_0_2", "convention_1_0_2", "convention_2_0_2", "convention_3_0_2", "convention_4_0_2",
        "convention_0_1_2", "convention_1_1_2", "convention_2_1_2", "convention_3_1_2", "convention_4_1_2",
        "convention_0_2_2", "convention_1_2_2", "convention_2_2_2", "convention_3_2_2", "convention_4_2_2",
    },
    copy_from = "convention_0_0_0",
    symbol = "C",
    color = "blue",
    name = ccb.content.text("convention center"),
}

content.patch_overmap_terrain {
    ids = { "animalshelter" },
    copy_from = "animalshelter",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("animal shelter"),
}

content.patch_overmap_terrain {
    ids = { "animalshelter_roof" },
    copy_from = "animalshelter_roof",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("animal shelter roof"),
}

content.patch_overmap_terrain {
    ids = { "animalpound" },
    copy_from = "animalpound",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("animal pound"),
}

content.patch_overmap_terrain {
    ids = { "animalpound_roof" },
    copy_from = "animalpound_roof",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("animal pound roof"),
}

content.patch_overmap_terrain {
    ids = { "station_radio", "station_radio_1" },
    copy_from = "station_radio",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("radio station"),
}

content.patch_overmap_terrain {
    ids = { "station_radio_roof", "station_radio_roof_1" },
    copy_from = "station_radio_roof",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("radio station roof"),
}

content.patch_overmap_terrain {
    ids = {
        "station_radio_tower_even", "station_radio_tower_odd", "station_radio_tower_top",
        "station_radio_1_tower_even", "station_radio_1_tower_odd", "station_radio_1_tower_top",
    },
    copy_from = "station_radio_tower_even",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("radio tower"),
}

content.patch_overmap_terrain {
    ids = {
        "radio_tower", "radio_tower_even", "radio_tower_even_stair_only", "radio_tower_odd",
        "radio_tower_top", "radio_tower_1", "radio_tower_roof_1", "radio_tower_reverberation_mp3",
    },
    copy_from = "radio_tower",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("radio tower"),
}

content.patch_overmap_terrain {
    ids = {
        "wasp_tower", "wasp_tower_1", "wasp_tower_roof_1", "wasp_tower_odd_1", "wasp_tower_odd_2",
        "wasp_tower_even_1", "wasp_tower_even_2", "wasp_tower_top",
    },
    copy_from = "wasp_tower",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("radio tower"),
}

content.patch_overmap_terrain {
    ids = { "p_resort_1nw", "p_resort_pm" },
    copy_from = "p_resort_1nw",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("private resort"),
}

content.patch_overmap_terrain {
    ids = {
        "p_resort_0nw", "p_resort_0se", "p_resort_1ee", "p_resort_1mm", "p_resort_1ne", "p_resort_1nn",
        "p_resort_1se", "p_resort_1ss", "p_resort_1sw", "p_resort_1ww", "p_resort_2ee", "p_resort_2mm",
        "p_resort_2ne", "p_resort_2nn", "p_resort_2nw", "p_resort_2se", "p_resort_2ss", "p_resort_2sw",
        "p_resort_2ww", "p_resort_pe", "p_resort_pw", "p_resort_ree", "p_resort_rmm", "p_resort_rne",
        "p_resort_rnn", "p_resort_rnw", "p_resort_rse", "p_resort_rss", "p_resort_rsw", "p_resort_rww",
    },
    copy_from = "p_resort_0nw",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("private resort"),
}

content.patch_overmap_terrain {
    ids = {
        "control_tower_0", "control_tower_1", "control_tower_2", "s_air_atc", "s_air_atc_2", "s_air_atc_3",
        "s_air_atc_4",
    },
    copy_from = "control_tower_0",
    symbol = "C",
    color = "blue",
    name = ccb.content.text("control tower"),
}

content.patch_overmap_terrain {
    ids = { "control_tower_roof" },
    copy_from = "control_tower_roof",
    symbol = "C",
    color = "blue",
    name = ccb.content.text("control tower roof"),
}

content.patch_overmap_terrain {
    ids = { "s_air_term" },
    copy_from = "s_air_term",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("private airport terminal"),
}

content.patch_overmap_terrain {
    ids = { "s_air_term_roof" },
    copy_from = "s_air_term_roof",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("private airport terminal roof"),
}

content.patch_overmap_terrain {
    ids = { "waiting_area" },
    copy_from = "waiting_area",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("regional airport terminal"),
}

content.patch_overmap_terrain {
    ids = { "waiting_area_roof" },
    copy_from = "waiting_area_roof",
    symbol = "R",
    color = "blue",
    name = ccb.content.text("regional airport terminal roof"),
}

content.patch_overmap_terrain {
    ids = { "lancenter" },
    copy_from = "lancenter",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("LAN center"),
}

content.patch_overmap_terrain {
    ids = { "lancenter_roof" },
    copy_from = "lancenter_roof",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("LAN center roof"),
}

content.patch_overmap_terrain {
    ids = { "lancenter_1" },
    copy_from = "lancenter_1",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("LAN center"),
}

content.patch_overmap_terrain {
    ids = { "lancenter_roof_1" },
    copy_from = "lancenter_roof_1",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("LAN center roof"),
}

content.patch_overmap_terrain {
    ids = { "skate_park", "skate_park_up", "skate_park_down" },
    copy_from = "skate_park",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("skate park"),
}

content.patch_overmap_terrain {
    ids = { "pavilion", "pavilion_1" },
    copy_from = "pavilion",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("pavilion"),
}

content.patch_overmap_terrain {
    ids = { "trailer_public_10" },
    copy_from = "trailer_public_10",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("pavilion"),
}

content.patch_overmap_terrain {
    ids = { "pavilion_roof", "pavilion_roof_1", "trailer_public_10_roof" },
    copy_from = "pavilion_roof",
    symbol = "P",
    color = "blue",
    name = ccb.content.text("pavilion roof"),
}

content.patch_overmap_terrain {
    ids = { "fishing_pond_0_0", "fishing_pond_0_1", "fishing_pond_1_0", "fishing_pond_1_1" },
    copy_from = "fishing_pond_0_0",
    symbol = "#",
    color = "blue",
    name = ccb.content.text("fishing pond"),
}

content.patch_overmap_terrain {
    ids = { "s_arcade" },
    copy_from = "s_arcade",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("arcade"),
}

content.patch_overmap_terrain {
    ids = { "s_arcade_roof" },
    copy_from = "s_arcade_roof",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("arcade roof"),
}

content.patch_overmap_terrain {
    ids = { "cs_internet_cafe" },
    copy_from = "cs_internet_cafe",
    symbol = "I",
    color = "blue",
    name = ccb.content.text("internet cafe"),
}

content.patch_overmap_terrain {
    ids = { "cs_internet_cafe_roof", "cs_internet_cafe_upper_roof" },
    copy_from = "cs_internet_cafe_roof",
    symbol = "I",
    color = "blue",
    name = ccb.content.text("internet cafe roof"),
}

content.patch_overmap_terrain {
    ids = { "bowling_alley" },
    copy_from = "bowling_alley",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("bowling alley"),
}

content.patch_overmap_terrain {
    ids = { "bowling_alley_roof" },
    copy_from = "bowling_alley_roof",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("bowling alley roof"),
}

content.patch_overmap_terrain {
    ids = { "gym" },
    copy_from = "gym",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("boxing gym"),
}

content.patch_overmap_terrain {
    ids = { "gym_roof", "gym_upper_roof" },
    copy_from = "gym_roof",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("boxing gym roof"),
}

content.patch_overmap_terrain {
    ids = { "gym_fitness", "gym_fitness_1", "gym_fitness_2ndFloor_1" },
    copy_from = "gym_fitness",
    symbol = "F",
    color = "blue",
    name = ccb.content.text("fitness gym"),
}

content.patch_overmap_terrain {
    ids = { "gym_fitness_roof", "gym_fitness_roof_1" },
    copy_from = "gym_fitness_roof",
    symbol = "F",
    color = "blue",
    name = ccb.content.text("fitness gym roof"),
}

content.patch_overmap_terrain {
    ids = { "mortuary" },
    copy_from = "mortuary",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("mortuary"),
}

content.patch_overmap_terrain {
    ids = { "mortuary_roof" },
    copy_from = "mortuary_roof",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("mortuary roof"),
}

content.patch_overmap_terrain {
    ids = { "trailer_hub_10" },
    copy_from = "trailer_hub_10",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("administration building"),
}

content.patch_overmap_terrain {
    ids = { "trailer_hub_10_roof" },
    copy_from = "trailer_hub_10_roof",
    symbol = "A",
    color = "blue",
    name = ccb.content.text("administration building roof"),
}

content.patch_overmap_terrain {
    ids = { "dojo", "dojo_1" },
    copy_from = "dojo",
    symbol = "D",
    color = "blue",
    name = ccb.content.text("dojo"),
}

content.patch_overmap_terrain {
    ids = { "dojo_roof", "dojo_upper_roof", "dojo_roof_1", "dojo_upper_roof_1" },
    copy_from = "dojo_roof",
    symbol = "D",
    color = "blue",
    name = ccb.content.text("dojo roof"),
}

content.patch_overmap_terrain {
    ids = { "s_laundromat", "s_laundromat_1" },
    copy_from = "s_laundromat",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("laundromat"),
}

content.patch_overmap_terrain {
    ids = { "s_laundromat_roof", "s_laundromat_roof_1" },
    copy_from = "s_laundromat_roof",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("laundromat roof"),
}

content.patch_overmap_terrain {
    ids = { "trailer_commercial_00" },
    copy_from = "trailer_commercial_00",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("laundromat roof"),
}

content.patch_overmap_terrain {
    ids = { "trailer_commercial_00_roof" },
    copy_from = "trailer_commercial_00_roof",
    symbol = "L",
    color = "blue",
    name = ccb.content.text("laundromat"),
}

content.patch_overmap_terrain {
    ids = { "bank", "bank_1" },
    copy_from = "bank",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("bank"),
}

content.patch_overmap_terrain {
    ids = { "bank_roof", "bank_roof_1" },
    copy_from = "bank",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("bank roof"),
}

content.patch_overmap_terrain {
    ids = { "smoke_lounge", "smoke_lounge_1" },
    copy_from = "smoke_lounge",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("smoking lounge"),
}

content.patch_overmap_terrain {
    ids = { "smoke_lounge_roof", "smoke_lounge_roof_1" },
    copy_from = "smoke_lounge_roof",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("smoking lounge roof"),
}

content.patch_overmap_terrain {
    ids = { "s_cosmetic" },
    copy_from = "s_cosmetic",
    symbol = "C",
    color = "blue",
    name = ccb.content.text("cosmetics store"),
}

content.patch_overmap_terrain {
    ids = { "s_cosmetic_roof" },
    copy_from = "s_cosmetic_roof",
    symbol = "C",
    color = "blue",
    name = ccb.content.text("cosmetics store roof"),
}

content.patch_overmap_terrain {
    ids = { "barber_shop" },
    copy_from = "barber_shop",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("barber shop"),
}

content.patch_overmap_terrain {
    ids = { "barber_shop_roof" },
    copy_from = "barber_shop_roof",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("barber shop roof"),
}

content.patch_overmap_terrain {
    ids = { "stripclub", "stripclub_1", "stripclub_2" },
    copy_from = "stripclub",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("strip club"),
}

content.patch_overmap_terrain {
    ids = { "stripclub_roof", "stripclub_roof_1", "stripclub_roof_2" },
    copy_from = "generic_city_building_roof",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("strip club roof"),
}

content.patch_overmap_terrain {
    ids = { "music_venue", "music_venue_1" },
    copy_from = "music_venue",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("music venue"),
}

content.patch_overmap_terrain {
    ids = { "music_venue_roof", "music_venue_1_roof", "music_venue_1_roof_top" },
    copy_from = "music_venue_roof",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("music venue roof"),
}

content.patch_overmap_terrain {
    ids = { "volleyball_court" },
    copy_from = "volleyball_court",
    symbol = "V",
    color = "blue",
    name = ccb.content.text("volleyball court"),
}

content.patch_overmap_terrain {
    ids = { "tennis_court" },
    copy_from = "tennis_court",
    symbol = "T",
    color = "blue",
    name = ccb.content.text("tennis court"),
}

content.patch_overmap_terrain {
    ids = { "baskeball_court" },
    copy_from = "baskeball_court",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("basketball court"),
}

content.patch_overmap_terrain {
    ids = { "natural_spring" },
    copy_from = "natural_spring",
    symbol = "N",
    color = "blue",
    name = ccb.content.text("natural spring"),
}

content.patch_overmap_terrain {
    ids = { "PublicPond_1a", "PublicPond_1b" },
    copy_from = "PublicPond_1a",
    symbol = "#",
    color = "blue",
    name = ccb.content.text("public pond"),
}

content.patch_overmap_terrain {
    ids = {
        "karting_0_0_0", "karting_0_0_1", "karting_0_0_2", "karting_0_1_0", "karting_0_1_1", "karting_0_1_2",
        "karting_0_2_0", "karting_0_2_1", "karting_0_2_2", "karting_1_0_0", "karting_1_0_1", "karting_1_0_2",
        "karting_1_1_0", "karting_1_1_1", "karting_1_1_2", "karting_1_2_0", "karting_1_2_1", "karting_1_2_2",
        "karting_2_0_0", "karting_2_0_1", "karting_2_0_2", "karting_2_1_0", "karting_2_1_1", "karting_2_1_2",
        "karting_2_2_0", "karting_2_2_1", "karting_2_2_2",
    },
    copy_from = "karting_0_0_0",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("go-kart track"),
}

content.patch_overmap_terrain {
    ids = {
        "movietheater_0_0", "movietheater_2_0", "movietheater_0_1", "movietheater_1_1", "movietheater_2_1",
        "movietheater_0_2", "movietheater_1_2", "movietheater_2_2",
    },
    copy_from = "movietheater_0_0",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("movie theater"),
}

content.patch_overmap_terrain {
    ids = { "movietheater_1_0" },
    copy_from = "movietheater_1_0",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("movie theater entrance"),
}

content.patch_overmap_terrain {
    ids = {
        "miniaturerailway_0_0_0", "miniaturerailway_0_1_0", "miniaturerailway_1_0_0",
        "miniaturerailway_1_1_0", "miniaturerailway_0_0_1", "miniaturerailway_0_1_1",
        "miniaturerailway_1_0_1", "miniaturerailway_1_1_1",
    },
    copy_from = "miniaturerailway_0_0_0",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("miniature railway"),
}

content.patch_overmap_terrain {
    ids = {
        "luna_park_0_0_0", "luna_park_1_0_0", "luna_park_2_0_0", "luna_park_0_1_0", "luna_park_1_1_0",
        "luna_park_2_1_0", "luna_park_0_0_1", "luna_park_1_0_1", "luna_park_2_0_1", "luna_park_0_1_1",
        "luna_park_1_1_1", "luna_park_2_1_1",
    },
    copy_from = "luna_park_0_0_0",
    symbol = "M",
    color = "blue",
    name = ccb.content.text("miniature railway park"),
}

content.patch_overmap_terrain {
    ids = {
        "golfcourse_00", "golfcourse_01", "golfcourse_02", "golfcourse_10", "golfcourse_11", "golfcourse_12",
        "golfcourse_20", "golfcourse_21", "golfcourse_22", "golfcourse_32",
    },
    copy_from = "golfcourse_00",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("golf course"),
}

content.patch_overmap_terrain {
    ids = { "golfcourse_31" },
    copy_from = "golfcourse_31",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("golf course service building"),
}

content.patch_overmap_terrain {
    ids = { "golfcourse_31_2ndfloor" },
    copy_from = "golfcourse_31_2ndfloor",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("golf course bar"),
}

content.patch_overmap_terrain {
    ids = { "golfcourse_31_roof" },
    copy_from = "golfcourse_31_roof",
    symbol = "G",
    color = "blue",
    name = ccb.content.text("golf course service building roof"),
}

content.patch_overmap_terrain {
    ids = { "zoo_2_0", "zoo_3_0" },
    copy_from = "zoo_2_0",
    symbol = "Z",
    color = "blue",
    name = ccb.content.text("zoo entrance"),
}

content.patch_overmap_terrain {
    ids = {
        "zoo_0_1", "zoo_1_1", "zoo_2_1", "zoo_3_1", "zoo_0_2", "zoo_1_2", "zoo_2_2", "zoo_3_2", "zoo_0_3",
        "zoo_1_3", "zoo_2_3", "zoo_3_3",
    },
    copy_from = "zoo_0_1",
    symbol = "Z",
    color = "blue",
    name = ccb.content.text("zoo"),
}

content.patch_overmap_terrain {
    ids = { "zoo_3_2_basement", "zoo_3_3_basement" },
    copy_from = "zoo_3_2_basement",
    symbol = "Z",
    color = "blue",
    name = ccb.content.text("zoo"),
}

content.patch_overmap_terrain {
    ids = {
        "zoo_0_0_roof", "zoo_1_0_roof", "zoo_2_0_roof", "zoo_3_0_roof", "zoo_0_1_roof", "zoo_1_1_roof",
        "zoo_2_1_roof", "zoo_3_1_roof", "zoo_0_2_roof", "zoo_1_2_roof", "zoo_2_2_roof", "zoo_3_2_roof",
        "zoo_0_3_roof", "zoo_1_3_roof", "zoo_2_3_roof", "zoo_3_3_roof",
    },
    copy_from = "zoo_0_0_roof",
    symbol = "Z",
    color = "blue",
    name = ccb.content.text("zoo roof"),
}

content.patch_overmap_terrain {
    ids = {
        "s_baseballfield_a1", "s_baseballfield_a2", "s_baseballfield_a2_2", "s_baseballfield_b1",
        "s_baseballfield_b2", "stadium_1_2", "stadium_2_2", "stadium_1_3", "stadium_2_3",
    },
    copy_from = "s_baseballfield_a1",
    symbol = "B",
    color = "blue",
    name = ccb.content.text("baseball field"),
}

content.patch_overmap_terrain {
    ids = {
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
    copy_from = "football_field_a1",
    symbol = "F",
    color = "blue",
    name = ccb.content.text("football field"),
}

content.patch_overmap_terrain {
    ids = {
        "stadium_0_1", "stadium_3_1", "stadium_0_2", "stadium_0_3", "stadium_0_4", "stadium_3_2",
        "stadium_3_3", "stadium_1_4", "stadium_2_4", "stadium_3_4", "stadium_0_1_1", "stadium_1_1_1",
        "stadium_2_1_1", "stadium_3_1_1", "stadium_0_2_1", "stadium_0_3_1", "stadium_0_4_1", "stadium_3_2_1",
        "stadium_3_3_1", "stadium_1_4_1", "stadium_2_4_1", "stadium_3_4_1", "stadium_0_1_2", "stadium_1_1_2",
        "stadium_2_1_2", "stadium_3_1_2", "stadium_0_2_2", "stadium_0_3_2", "stadium_0_4_2", "stadium_3_2_2",
        "stadium_3_3_2", "stadium_1_4_2", "stadium_2_4_2", "stadium_3_4_2", "stadium_1_1_3", "stadium_2_1_3",
        "stadium_0_3_3", "stadium_football_1_1", "stadium_football_3_1", "stadium_football_4_1",
        "stadium_football_5_1", "stadium_football_7_1", "stadium_football_1_5", "stadium_football_2_5",
        "stadium_football_3_5", "stadium_football_5_5", "stadium_football_6_5", "stadium_football_7_5",
        "stadium_football_1_2", "stadium_football_1_4", "stadium_football_7_2", "stadium_football_7_4",
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
    copy_from = "stadium_0_1",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("stadium"),
}

content.patch_overmap_terrain {
    ids = {
        "stadium_football_2_1", "stadium_football_6_1", "stadium_football_1_3", "stadium_football_7_3",
        "stadium_football_4_5", "stadium_1_1", "stadium_2_1",
    },
    copy_from = "stadium_football_2_1",
    symbol = "S",
    color = "blue",
    name = ccb.content.text("stadium entrance"),
}

content.patch_overmap_terrain {
    ids = { "bandit_camp_1", "bandit_camp_2", "bandit_camp_3", "bandit_camp_4" },
    copy_from = "bandit_camp_1",
    symbol = "W",
    color = "brown",
    name = ccb.content.text("wooden fort"),
}

content.patch_overmap_terrain {
    ids = { "bandit_camp_1_roof", "bandit_camp_2_roof", "bandit_camp_3_roof", "bandit_camp_4_roof" },
    copy_from = "bandit_camp_1_roof",
    symbol = "W",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = {
        "bandit_farm_3", "bandit_farm_2", "bandit_farm_1", "bandit_farm_6", "bandit_farm_5", "bandit_farm_4",
        "bandit_farm_9", "bandit_farm_8", "bandit_farm_7",
    },
    copy_from = "bandit_farm_3",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("farm"),
}

content.patch_overmap_terrain {
    ids = { "bandit_farm_3_roof", "bandit_farm_2_roof" },
    copy_from = "bandit_farm_3_roof",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("farm roof"),
}

content.patch_overmap_terrain {
    ids = {
        "ranch_camp_11", "ranch_camp_12", "ranch_camp_13", "ranch_camp_14", "ranch_camp_15", "ranch_camp_16",
        "ranch_camp_20", "ranch_camp_21", "ranch_camp_22", "ranch_camp_23", "ranch_camp_24", "ranch_camp_25",
        "ranch_camp_26", "ranch_camp_29", "ranch_camp_30", "ranch_camp_31", "ranch_camp_32", "ranch_camp_33",
        "ranch_camp_34", "ranch_camp_35", "ranch_camp_38", "ranch_camp_39", "ranch_camp_40", "ranch_camp_41",
        "ranch_camp_42", "ranch_camp_43", "ranch_camp_44", "ranch_camp_47", "ranch_camp_48", "ranch_camp_49",
        "ranch_camp_50", "ranch_camp_51", "ranch_camp_52", "ranch_camp_53", "ranch_camp_56", "ranch_camp_58",
        "ranch_camp_59", "ranch_camp_60", "ranch_camp_61", "ranch_camp_62", "ranch_camp_65", "ranch_camp_70",
        "ranch_camp_71",
    },
    copy_from = "ranch_camp_11",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("ranch field"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_57" },
    copy_from = "ranch_camp_57",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("silo"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_57_silo" },
    copy_from = "ranch_camp_57_silo",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("silo"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_57_silocap" },
    copy_from = "ranch_camp_57_silocap",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("silo cap"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_65_roof" },
    copy_from = "ranch_camp_65_roof",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn roof"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_66" },
    copy_from = "ranch_camp_66",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_66_roof" },
    copy_from = "ranch_camp_66_roof",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn roof"),
}

content.patch_overmap_terrain {
    ids = { "cave" },
    copy_from = "cave",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cave"),
}

content.patch_overmap_terrain {
    ids = { "cave_rat" },
    copy_from = "cave_rat",
    symbol = "R",
    color = "brown",
    name = ccb.content.text("rat cave"),
}

content.patch_overmap_terrain {
    ids = { "cave_underground" },
    copy_from = "cave_underground",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cave"),
}

content.patch_overmap_terrain {
    ids = { "cave_rat_underground" },
    copy_from = "cave_rat_underground",
    symbol = "R",
    color = "brown",
    name = ccb.content.text("rat cave"),
}

content.patch_overmap_terrain {
    ids = { "nest_dermatik", "nest_dermatik_roof" },
    copy_from = "nest_dermatik",
    symbol = "M",
    color = "brown",
    name = ccb.content.text("mound of dirt"),
}

content.patch_overmap_terrain {
    ids = { "spider_pit" },
    copy_from = "spider_pit",
    symbol = "S",
    color = "white",
    name = ccb.content.text("spider pit"),
}

content.patch_overmap_terrain {
    ids = { "spider_pit_under" },
    copy_from = "spider_pit_under",
    symbol = "S",
    color = "white",
    name = ccb.content.text("spider pit"),
}

content.patch_overmap_terrain {
    ids = { "chemical_lab_ocu", "chemical_lab_roof_ocu" },
    copy_from = "chemical_lab_ocu",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "campsite", "campsite_a" },
    copy_from = "campsite",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("campsite"),
}

content.patch_overmap_terrain {
    ids = { "campsite_cabin_incomplete" },
    copy_from = "campsite_cabin_incomplete",
    symbol = "I",
    color = "brown",
    name = ccb.content.text("incomplete cabin"),
}

content.patch_overmap_terrain {
    ids = { "campsite_cabin_incomplete_roof" },
    copy_from = "campsite_cabin_incomplete_roof",
    symbol = "I",
    color = "brown",
    name = ccb.content.text("incomplete cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "campsite_field_biker", "campsite_field_biker_destroyed" },
    copy_from = "campsite_field_biker",
    symbol = "F",
    color = "brown",
    name = ccb.content.text("field campsite"),
}

content.patch_overmap_terrain {
    ids = { "hunter_shack", "hunter_shack_1" },
    copy_from = "hunter_shack",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("swamp shack"),
}

content.patch_overmap_terrain {
    ids = { "hunter_shack_roof", "hunter_shack_roof_1" },
    copy_from = "hunter_shack_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("swamp shack roof"),
}

content.patch_overmap_terrain {
    ids = { "campground_1a", "campground_1b", "campground_2a", "campground_2b" },
    copy_from = "campground_1a",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("campground"),
}

content.patch_overmap_terrain {
    ids = { "campground_roof" },
    copy_from = "campground_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("campground roof"),
}

content.patch_overmap_terrain {
    ids = {
        "godco_1", "godco_2", "godco_3", "godco_4", "godco_5", "godco_6", "godco_7", "godco_8", "godco_9",
    },
    copy_from = "godco_1",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("church retreat"),
}

content.patch_overmap_terrain {
    ids = {
        "godco_1_1", "godco_2_1", "godco_3_1", "godco_4_1", "godco_5_1", "godco_6_1", "godco_7_1",
        "godco_8_1", "godco_9_1", "godco_1_2", "godco_2_2", "godco_1_3",
    },
    copy_from = "godco_1_1",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("church retreat roof"),
}

content.patch_overmap_terrain {
    ids = {
        "cabin", "cabin_1", "cabin_2", "cabin_3", "cabin_3_reverberation_hint", "cabin_4", "cabin_5",
        "cabin_6", "cabin_7", "cabin_lapin", "bandit_cabin", "cabin_prepper",
    },
    copy_from = "cabin",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "cabin_liam" },
    copy_from = "cabin_liam",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = {
        "cabin_roof", "cabin_roof_1", "cabin_roof_2", "cabin_roof_3", "cabin_roof_3_reverberation_hint",
        "cabin_roof_4", "cabin_roof_5", "cabin_roof_6", "cabin_roof_7", "cabin_roof_lapin",
        "bandit_cabin_roof",
    },
    copy_from = "cabin_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "cabin_3_reverberation" },
    copy_from = "cabin_3_reverberation",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "cabin_roof_3_reverberation" },
    copy_from = "cabin_roof_3_reverberation",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "cabin_lake", "lake_cabin_boathouse", "cabin_strange" },
    copy_from = "cabin_lake",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "cabin_lake_roof", "lake_cabin_boathouse_roof" },
    copy_from = "cabin_lake_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "cabin_strange_b" },
    copy_from = "cabin_strange_b",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin basement"),
}

content.patch_overmap_terrain {
    ids = { "cabin_strange_roof" },
    copy_from = "cabin_strange_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "cabin_cellar" },
    copy_from = "cabin_cellar",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin cellar"),
}

content.patch_overmap_terrain {
    ids = {
        "cabin_lakeside", "cabin_lakeside1", "cabin_lakeside2", "cabin_lakeside3", "cabin_lakeside4",
        "cabin_lakeside5",
    },
    copy_from = "cabin_lakeside",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lakeside cabin"),
}

content.patch_overmap_terrain {
    ids = {
        "cabin_lakeside_roof", "cabin_lakeside1_roof", "cabin_lakeside2_roof", "cabin_lakeside3_roof",
        "cabin_lakeside4_roof", "cabin_lakeside5_roof",
    },
    copy_from = "cabin_lakeside_roof",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lakeside cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "xedra_fishing_shack_0", "xedra_fishing_shack_1", "xedra_fishing_shack_2" },
    copy_from = "xedra_fishing_shack_0",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lakeside shack"),
}

content.patch_overmap_terrain {
    ids = { "lodge_ground1", "lodge_ground2" },
    copy_from = "lodge_ground1",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("hunting lodge"),
}

content.patch_overmap_terrain {
    ids = { "lodge_ground_glooscap1", "lodge_ground_glooscap2" },
    copy_from = "lodge_ground_glooscap1",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("hunting lodge"),
}

content.patch_overmap_terrain {
    ids = { "lodge_2ndfloor1", "lodge_2ndfloor2" },
    copy_from = "lodge_2ndfloor1",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("second floor hunting lodge"),
}

content.patch_overmap_terrain {
    ids = { "lodge_roof1", "lodge_roof2" },
    copy_from = "lodge_roof1",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("hunting lodge roof"),
}

content.patch_overmap_terrain {
    ids = {
        "lodge_basement_residential1", "lodge_basement_residential2", "lodge_basement_residential3",
        "lodge_basement_residential4",
    },
    copy_from = "lodge_basement_residential1",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("hunting lodge basement"),
}

content.patch_overmap_terrain {
    ids = { "yard" },
    copy_from = "yard",
    symbol = "Y",
    color = "brown",
    name = ccb.content.text("yard"),
}

content.patch_overmap_terrain {
    ids = { "house_farm" },
    copy_from = "house_farm",
    symbol = "R",
    color = "brown",
    name = ccb.content.text("rural house"),
}

content.patch_overmap_terrain {
    ids = { "house_farm_roof" },
    copy_from = "house_farm_roof",
    symbol = "R",
    color = "brown",
    name = ccb.content.text("rural house roof"),
}

content.patch_overmap_terrain {
    ids = { "survivor_forest_camp" },
    copy_from = "survivor_forest_camp",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("survivor forest camp"),
}

content.patch_overmap_terrain {
    ids = { "state_park_0_0", "state_park_0_1", "state_park_1_0", "state_park_1_1", "state_park_1_0_1" },
    copy_from = "state_park_0_0",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("state park"),
}

content.patch_overmap_terrain {
    ids = {
        "GMLODGE1_1", "GMLODGE1_2", "GMLODGE1_3", "GMLODGE1_4", "GMLODGE2_1", "GMLODGE2_2", "GMLODGE2_3",
        "GMLODGE2_4", "GMLODGE3_1", "GMLODGE3_2", "GMLODGE3_3", "GMLODGE3_4", "GMLODGE4_1", "GMLODGE4_2",
        "GMLODGE4_3", "GMLODGE4_4", "GMLODGE2_2_2", "GMLODGE2_3_2", "GMLODGE3_2_2", "GMLODGE3_3_2",
        "GMLODGE2_roof_2", "GMLODGE2_roof_3", "GMLODGE3_roof_2", "GMLODGE3_roof_3",
    },
    copy_from = "GMLODGE1_1",
    symbol = "M",
    color = "brown",
    name = ccb.content.text("Militia Lodge"),
}

content.patch_overmap_terrain {
    ids = { "ws_survivor_bunker_f0", "ws_survivor_bunker_f-1" },
    copy_from = "ws_survivor_bunker_f0",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("survivor's bunker"),
}

content.patch_overmap_terrain {
    ids = { "ws_survivor_camp" },
    copy_from = "ws_survivor_camp",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("survivor's camp"),
}

content.patch_overmap_terrain {
    ids = { "pottery_cottage", "pottery_cottage_2nd", "pottery_cottage_roof" },
    copy_from = "pottery_cottage",
    symbol = "P",
    color = "brown",
    name = ccb.content.text("potters cottage"),
}

content.patch_overmap_terrain {
    ids = { "pottery_cottage_basement" },
    copy_from = "pottery_cottage_basement",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("basement"),
}

content.patch_overmap_terrain {
    ids = { "hunting_blind" },
    copy_from = "hunting_blind",
    symbol = "H",
    color = "brown",
    name = ccb.content.text("hunting blind"),
}

content.patch_overmap_terrain {
    ids = { "lumbermill_0_0", "lumbermill_0_1", "lumbermill_1_0", "lumbermill_1_1" },
    copy_from = "lumbermill_0_0",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lumbermill"),
}

content.patch_overmap_terrain {
    ids = { "lumbermill_0_0_roof", "lumbermill_0_1_roof", "lumbermill_1_0_roof", "lumbermill_1_1_roof" },
    copy_from = "lumbermill_0_0_roof",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lumbermill roof"),
}

content.patch_overmap_terrain {
    ids = { "lumbermill_0_0_ocu", "lumbermill_0_1_ocu", "lumbermill_1_0_ocu", "lumbermill_1_1_ocu" },
    copy_from = "lumbermill_0_0_ocu",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lumbermill"),
}

content.patch_overmap_terrain {
    ids = { "lumberyard_0_0", "lumberyard_0_1", "lumberyard_1_0", "lumberyard_1_1" },
    copy_from = "lumberyard_0_0",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lumberyard"),
}

content.patch_overmap_terrain {
    ids = { "lumberyard_0_0_roof", "lumberyard_0_1_roof", "lumberyard_1_0_roof", "lumberyard_1_1_roof" },
    copy_from = "lumberyard_0_0_roof",
    symbol = "L",
    color = "brown",
    name = ccb.content.text("lumberyard roof"),
}

content.patch_overmap_terrain {
    ids = { "desolatebarn" },
    copy_from = "desolatebarn",
    symbol = "D",
    color = "brown",
    name = ccb.content.text("desolate barn"),
}

content.patch_overmap_terrain {
    ids = { "riverside_dwelling", "riverside_dwelling1", "riverside_dwelling2", "riverside_dwelling3" },
    copy_from = "riverside_dwelling",
    symbol = "R",
    color = "brown",
    name = ccb.content.text("riverside dwelling"),
}

content.patch_overmap_terrain {
    ids = {
        "riverside_dwelling_roof", "riverside_dwelling1_roof", "riverside_dwelling2_roof",
        "riverside_dwelling3_roof",
    },
    copy_from = "riverside_dwelling_roof",
    symbol = "R",
    color = "brown",
}

content.patch_overmap_terrain {
    ids = { "cabin_isherwood" },
    copy_from = "cabin_isherwood",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_1", "farm_dairy_twd_2", "farm_dairy_twd_9", "farm_dairy_twd_10" },
    copy_from = "farm_dairy_twd_1",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("farm"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_7" },
    copy_from = "farm_dairy_twd_7",
    symbol = "┬",
    color = "brown",
    name = ccb.content.text("farm"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_8" },
    copy_from = "farm_dairy_twd_8",
    symbol = "┘",
    color = "brown",
    name = ccb.content.text("farm"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_11" },
    copy_from = "farm_dairy_twd_11",
    symbol = "│",
    color = "brown",
    name = ccb.content.text("farm road"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_5", "farm_dairy_twd_6" },
    copy_from = "farm_dairy_twd_5",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_12" },
    copy_from = "farm_dairy_twd_12",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn"),
}

content.patch_overmap_terrain {
    ids = {
        "farm_dairy_twd_second_floor_5", "farm_dairy_twd_second_floor_6", "farm_dairy_twd_second_floor_12",
    },
    copy_from = "farm_dairy_twd_second_floor_5",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn roof"),
}

content.patch_overmap_terrain {
    ids = { "coop_chicken" },
    copy_from = "coop_chicken",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("chicken coop"),
}

content.patch_overmap_terrain {
    ids = { "farm_1_coop" },
    copy_from = "farm_1_coop",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("chicken coop"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_10" },
    copy_from = "horse_farm_isherwood_10",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("chicken coop"),
}

content.patch_overmap_terrain {
    ids = { "farm_1_coop_roof" },
    copy_from = "farm_1_coop_roof",
    symbol = "O",
    color = "brown",
    name = ccb.content.text("chicken coop roof"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_10_roof" },
    copy_from = "horse_farm_isherwood_10_roof",
    symbol = "O",
    color = "brown",
    name = ccb.content.text("chicken coop roof"),
}

content.patch_overmap_terrain {
    ids = {
        "2silos", "2silos_1", "2silos_2", "farm_1_silo", "farm_1_silo_1", "farm_1_silo_2", "2farm_6",
        "2farm_6_1", "2farm_6_2", "2farm_6_3", "farm_horse_silo", "farm_horse_silo_1",
    },
    copy_from = "2silos",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("silo"),
}

content.patch_overmap_terrain {
    ids = { "2silos_roof", "farm_1_silo_roof", "farm_horse_silo_roof" },
    copy_from = "2silos_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("silo roof"),
}

content.patch_overmap_terrain {
    ids = { "TreeFarm_1a" },
    copy_from = "TreeFarm_1a",
    symbol = "T",
    color = "brown",
    name = ccb.content.text("tree farm"),
}

content.patch_overmap_terrain {
    ids = { "TreeFarm_1a_roof" },
    copy_from = "TreeFarm_1a_roof",
    symbol = "T",
    color = "brown",
    name = ccb.content.text("tree farm"),
}

content.patch_overmap_terrain {
    ids = { "TreeFarm_1b" },
    copy_from = "TreeFarm_1b",
    symbol = "T",
    color = "brown",
    name = ccb.content.text("tree farm"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_carriage_house_1" },
    copy_from = "farm_horse_carriage_house_1",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("carriage house"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_4" },
    copy_from = "horse_farm_isherwood_4",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("carriage house"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_carriage_house_1_roof" },
    copy_from = "farm_horse_carriage_house_1_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("carriage house roof"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_4_roof" },
    copy_from = "horse_farm_isherwood_4_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("carriage house roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_1_greenhouse", "farm_horse_greenhouse" },
    copy_from = "farm_1_greenhouse",
    symbol = "G",
    color = "brown",
    name = ccb.content.text("greenhouse"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_9" },
    copy_from = "horse_farm_isherwood_9",
    symbol = "G",
    color = "brown",
    name = ccb.content.text("greenhouse"),
}

content.patch_overmap_terrain {
    ids = { "farm_1_greenhouse_roof", "farm_horse_greenhouse_roof" },
    copy_from = "farm_1_greenhouse_roof",
    symbol = "G",
    color = "brown",
    name = ccb.content.text("greenhouse roof"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_9_roof" },
    copy_from = "horse_farm_isherwood_9_roof",
    symbol = "G",
    color = "brown",
    name = ccb.content.text("greenhouse roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_stable_1" },
    copy_from = "farm_horse_stable_1",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stable"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_7" },
    copy_from = "horse_farm_isherwood_7",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stable"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_stable_1_hayloft" },
    copy_from = "farm_horse_stable_1_hayloft",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stable hayloft"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_7_hayloft" },
    copy_from = "horse_farm_isherwood_7_hayloft",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stable hayloft"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_stable_1_roof" },
    copy_from = "farm_horse_stable_1_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stable roof"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_7_roof" },
    copy_from = "horse_farm_isherwood_7_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stable roof"),
}

content.patch_overmap_terrain {
    ids = {
        "pasture", "splitrail_fence_butt", "splitrail_fence_gap", "splitrail_fence_UL", "splitrail_fence_UR",
        "splitrail_fence_DL", "splitrail_fence_DR", "splitrail_fence_inner",
    },
    copy_from = "pasture",
    symbol = "+",
    color = "brown",
    name = ccb.content.text("pasture"),
}

content.patch_overmap_terrain {
    ids = {
        "paddock", "paddock_L_butt", "paddock_R_butt", "paddock_L_gap", "paddock_R_gap", "paddock_C",
        "paddock_UL", "paddock_UR", "paddock_DL", "paddock_DR", "paddock_d_D_butt", "paddock_d_U_gap",
        "paddock_d_D_gap", "paddock_d_U_butt", "paddock_special_1", "paddock_special_2", "paddock_special_3",
        "paddock_special_4", "paddock_trailhead_1", "paddock_trailhead_3", "paddock_trailhead_4",
        "paddock_trailhead_6", "paddock_trailhead_7", "paddock_trailhead_9", "paddock_end_UL",
        "paddock_end_UR", "paddock_end_DL", "paddock_end_DR",
    },
    copy_from = "paddock",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("paddock"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_ring_1", "farm_horse_ring_2", "farm_horse_ring_3", "farm_horse_ring_4" },
    copy_from = "farm_horse_ring_1",
    symbol = "R",
    color = "brown",
    name = ccb.content.text("ring"),
}

content.patch_overmap_terrain {
    ids = { "paddock_trailhead_2" },
    copy_from = "paddock_trailhead_2",
    symbol = "T",
    color = "brown",
    name = ccb.content.text("trailhead"),
}

content.patch_overmap_terrain {
    ids = { "trailhead", "trailhead_shack_z0", "trailhead_outhouse_z0" },
    copy_from = "trailhead",
    symbol = "T",
    color = "brown",
    name = ccb.content.text("trailhead"),
}

content.patch_overmap_terrain {
    ids = { "trailhead_shack_z1", "trailhead_outhouse_z1" },
    copy_from = "trailhead_shack_z1",
    symbol = "T",
    color = "brown",
    name = ccb.content.text("trailhead roof"),
}

content.patch_overmap_terrain {
    ids = { "smokehouse" },
    copy_from = "smokehouse",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("smokehouse"),
}

content.patch_overmap_terrain {
    ids = { "smokehouse_roof" },
    copy_from = "smokehouse_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("smokehouse roof"),
}

content.patch_overmap_terrain {
    ids = { "rural_outbuilding" },
    copy_from = "rural_outbuilding",
    symbol = "O",
    color = "brown",
    name = ccb.content.text("outbuilding"),
}

content.patch_overmap_terrain {
    ids = { "rural_outbuilding_roof" },
    copy_from = "rural_outbuilding_roof",
    symbol = "O",
    color = "brown",
    name = ccb.content.text("outbuilding roof"),
}

content.patch_overmap_terrain {
    ids = { "dairy_farm_NW", "dairy_farm_NE", "dairy_farm_SE", "dairy_farm_SW" },
    copy_from = "dairy_farm_NW",
    symbol = "D",
    color = "brown",
    name = ccb.content.text("dairy farm"),
}

content.patch_overmap_terrain {
    ids = {
        "dairy_farm_isherwood_NW", "dairy_farm_isherwood_NE", "dairy_farm_isherwood_W",
        "dairy_farm_isherwood_E", "dairy_farm_isherwood_SE", "dairy_farm_isherwood_SW",
    },
    copy_from = "dairy_farm_isherwood_NW",
    symbol = "D",
    color = "brown",
    name = ccb.content.text("dairy farm"),
}

content.patch_overmap_terrain {
    ids = { "dairy_farm_SE_roof", "dairy_farm_SW_roof" },
    copy_from = "dairy_farm_SE_roof",
    symbol = "D",
    color = "brown",
    name = ccb.content.text("dairy farm roof"),
}

content.patch_overmap_terrain {
    ids = { "dairy_farm_isherwood_SE_roof", "dairy_farm_isherwood_SW_roof" },
    copy_from = "dairy_farm_isherwood_SE_roof",
    symbol = "D",
    color = "brown",
    name = ccb.content.text("dairy farm roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_3_roof" },
    copy_from = "farm_3_roof",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_isherwood_3_roof" },
    copy_from = "farm_isherwood_3_roof",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_isherwood_3_hayloft" },
    copy_from = "farm_isherwood_3_hayloft",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn hayloft"),
}

content.patch_overmap_terrain {
    ids = { "farm_3" },
    copy_from = "farm_3",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn"),
}

content.patch_overmap_terrain {
    ids = { "farm_isherwood_3" },
    copy_from = "farm_isherwood_3",
    symbol = "B",
    color = "brown",
    name = ccb.content.text("barn"),
}

content.patch_overmap_terrain {
    ids = { "farm_stills_4", "2farm_3", "2farm_loft_3", "2farm_4", "2farm_7", "2farm_8" },
    copy_from = "farm_stills_4",
    symbol = "F",
    color = "brown",
    name = ccb.content.text("farm"),
}

content.patch_overmap_terrain {
    ids = { "2farm_roof_3", "2farm_roof_4" },
    copy_from = "2farm_roof_3",
    symbol = "F",
    color = "brown",
    name = ccb.content.text("farm roof"),
}

content.patch_overmap_terrain {
    ids = {
        "farm_stills_8", "farm_stills_12", "farm_stills_1", "farm_stills_2", "farm_stills_5",
        "farm_stills_6", "farm_stills_9", "farm_stills_10",
    },
    copy_from = "farm_stills_8",
    symbol = "%",
    color = "brown",
    name = ccb.content.text("vineyard"),
}

content.patch_overmap_terrain {
    ids = { "farm_stills_7" },
    copy_from = "farm_stills_7",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stills"),
}

content.patch_overmap_terrain {
    ids = { "farm_stills_7_roof" },
    copy_from = "farm_stills_7_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("stills roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_stills_11" },
    copy_from = "farm_stills_11",
    symbol = "O",
    color = "brown",
    name = ccb.content.text("orchard"),
}

content.patch_overmap_terrain {
    ids = { "hayfield_straight", "hayfield_turnL", "hayfield_turnR", "hayfield_end" },
    copy_from = "hayfield_straight",
    symbol = "+",
    color = "brown",
    name = ccb.content.text("hay field"),
}

content.patch_overmap_terrain {
    ids = {
        "2farm_1", "2farm_2", "2farm_5", "2farm_9", "2farm_10", "2farm_12", "2farm_15", "2farm_16", "farm_1",
        "farm_4", "farm_5", "farm_6", "farm_7", "farm_8", "farm_9",
    },
    copy_from = "2farm_1",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("farm field"),
}

content.patch_overmap_terrain {
    ids = {
        "farm_isherwood_1", "farm_isherwood_4", "farm_isherwood_5", "farm_isherwood_6", "farm_isherwood_7",
        "farm_isherwood_8", "farm_isherwood_9", "horse_farm_isherwood_1", "horse_farm_isherwood_2",
        "horse_farm_isherwood_11", "horse_farm_isherwood_12", "horse_farm_isherwood_14",
        "horse_farm_isherwood_15", "horse_farm_isherwood_16", "horse_farm_isherwood_3",
        "horse_farm_isherwood_5", "horse_farm_isherwood_6", "horse_farm_isherwood_8",
    },
    copy_from = "farm_isherwood_1",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("farm field"),
}

content.patch_overmap_terrain {
    ids = {
        "2farm_13", "2farm_14", "2farm_17", "2farm_18", "2farm_19", "2farm_20", "2farm_21", "2farm_22",
        "2farm_23", "2farm_24", "farmland_straight", "farmland_turn", "farmland_turn_inside", "farmland_U",
    },
    copy_from = "2farm_13",
    symbol = "#",
    color = "brown",
    name = ccb.content.text("farm field"),
}

content.patch_overmap_terrain {
    ids = { "standing_stones" },
    copy_from = "standing_stones",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("standing stones"),
}

content.patch_overmap_terrain {
    ids = { "inner_cabins_cabin" },
    copy_from = "inner_cabins_cabin",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "inner_cabins_cabin_roof" },
    copy_from = "inner_cabins_cabin_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "inner_cabins_empty_cabin" },
    copy_from = "inner_cabins_empty_cabin",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "inner_cabins_empty_cabin_roof" },
    copy_from = "inner_cabins_empty_cabin_roof",
    symbol = "C",
    color = "brown",
    name = ccb.content.text("cabin roof"),
}

content.patch_overmap_terrain {
    ids = { "s_grocery", "s_grocery_1" },
    copy_from = "s_grocery",
    symbol = "G",
    color = "green",
    name = ccb.content.text("grocery store"),
}

content.patch_overmap_terrain {
    ids = {
        "supermarket_x0_y0_z0", "supermarket_x0_y1_z0", "supermarket_x0_y2_z0", "supermarket_x1_y0_z0",
        "supermarket_x1_y1_z0", "supermarket_x1_y2_z0", "supermarket_x2_y0_z0", "supermarket_x2_y1_z0",
        "supermarket_x2_y2_z0", "supermarket_x0_y0_z1", "supermarket_x0_y1_z1", "supermarket_x0_y2_z1",
        "supermarket_x1_y0_z1", "supermarket_x1_y1_z1", "supermarket_x1_y2_z1", "supermarket_x2_y0_z1",
        "supermarket_x2_y1_z1", "supermarket_x2_y2_z1",
    },
    copy_from = "supermarket_x0_y0_z0",
    symbol = "S",
    color = "green",
    name = ccb.content.text("supermarket"),
}

content.patch_overmap_terrain {
    ids = { "s_grocery_roof", "s_grocery_roof_1" },
    copy_from = "s_grocery_roof",
    symbol = "G",
    color = "green",
    name = ccb.content.text("grocery store roof"),
}

content.patch_overmap_terrain {
    ids = { "trailer_commercial_10" },
    copy_from = "trailer_commercial_10",
    symbol = "C",
    color = "green",
    name = ccb.content.text("convenience store"),
}

content.patch_overmap_terrain {
    ids = { "trailer_commercial_10_roof" },
    copy_from = "trailer_commercial_10_roof",
    symbol = "C",
    color = "green",
    name = ccb.content.text("convenience store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_liquor" },
    copy_from = "s_liquor",
    symbol = "L",
    color = "green",
    name = ccb.content.text("liquor store"),
}

content.patch_overmap_terrain {
    ids = { "s_liquor_roof" },
    copy_from = "s_liquor_roof",
    symbol = "L",
    color = "green",
    name = ccb.content.text("liquor store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_diner" },
    copy_from = "s_diner",
    symbol = "D",
    color = "green",
    name = ccb.content.text("diner"),
}

content.patch_overmap_terrain {
    ids = { "s_diner_2ndfloor" },
    copy_from = "s_diner_2ndfloor",
    symbol = "D",
    color = "green",
    name = ccb.content.text("diner"),
}

content.patch_overmap_terrain {
    ids = { "s_diner_roof" },
    copy_from = "s_diner_roof",
    symbol = "D",
    color = "green",
    name = ccb.content.text("diner roof"),
}

content.patch_overmap_terrain {
    ids = { "s_restaurant", "s_restaurant_1", "s_restaurant_2", "s_restaurant_3" },
    copy_from = "s_restaurant",
    symbol = "R",
    color = "green",
    name = ccb.content.text("restaurant"),
}

content.patch_overmap_terrain {
    ids = {
        "s_restaurant_foodplace_roof", "s_restaurant_foodplace_upper_roof", "s_restaurant_roof",
        "s_restaurant_roof_1", "s_restaurant_roof_2", "s_restaurant_upper_roof_2", "s_restaurant_roof_3",
    },
    copy_from = "s_restaurant_foodplace_roof",
    symbol = "R",
    color = "green",
    name = ccb.content.text("restaurant roof"),
}

content.patch_overmap_terrain {
    ids = {
        "s_restaurant_fast", "s_restaurant_fast_1", "drive_through_0_0", "drive_through_1_0",
        "drive_through_2_0", "drive_through_0_1", "drive_through_1_1", "drive_through_2_1",
    },
    copy_from = "s_restaurant_fast",
    symbol = "F",
    color = "green",
    name = ccb.content.text("fast food restaurant"),
}

content.patch_overmap_terrain {
    ids = {
        "s_restaurant_fast_roof", "s_restaurant_fast_roof_1", "drive_through_roof_0_0",
        "drive_through_roof_1_0", "drive_through_roof_2_0", "drive_through_roof_0_1",
        "drive_through_roof_1_1", "drive_through_roof_2_1",
    },
    copy_from = "s_restaurant_fast_roof",
    symbol = "F",
    color = "green",
    name = ccb.content.text("fast food restaurant roof"),
}

content.patch_overmap_terrain {
    ids = { "s_restaurant_coffee", "s_restaurant_coffee_1", "s_restaurant_coffee_2" },
    copy_from = "s_restaurant_coffee",
    symbol = "C",
    color = "green",
    name = ccb.content.text("coffee shop"),
}

content.patch_overmap_terrain {
    ids = { "s_restaurant_coffee_roof", "s_restaurant_coffee_roof_1", "s_restaurant_coffee_roof_2" },
    copy_from = "s_restaurant_coffee_roof",
    symbol = "C",
    color = "green",
    name = ccb.content.text("coffee shop"),
}

content.patch_overmap_terrain {
    ids = { "s_teashop", "s_teashop_1" },
    copy_from = "s_teashop",
    symbol = "T",
    color = "green",
    name = ccb.content.text("teashop"),
}

content.patch_overmap_terrain {
    ids = { "s_teashop_roof", "s_teashop_roof_1", "s_teashop_upper_roof_1" },
    copy_from = "s_teashop_roof",
    symbol = "T",
    color = "green",
    name = ccb.content.text("teashop roof"),
}

content.patch_overmap_terrain {
    ids = { "bar", "bar_1" },
    copy_from = "bar",
    symbol = "B",
    color = "green",
    name = ccb.content.text("bar"),
}

content.patch_overmap_terrain {
    ids = { "bar_roof", "bar_roof_1" },
    copy_from = "bar_roof",
    symbol = "B",
    color = "green",
    name = ccb.content.text("bar roof"),
}

content.patch_overmap_terrain {
    ids = { "s_pizza_parlor", "s_pizza_parlor_1" },
    copy_from = "s_pizza_parlor",
    symbol = "P",
    color = "green",
    name = ccb.content.text("pizza parlor"),
}

content.patch_overmap_terrain {
    ids = { "s_pizza_parlor_roof", "s_pizza_parlor_roof_1" },
    copy_from = "s_pizza_parlor_roof",
    symbol = "P",
    color = "green",
    name = ccb.content.text("pizza parlor roof"),
}

content.patch_overmap_terrain {
    ids = { "sewer" },
    copy_from = "sewer",
    color = "green",
    name = ccb.content.text("sewer"),
}

content.patch_overmap_terrain {
    ids = { "roadstop_b", "roadstop_b_roof" },
    copy_from = "roadstop_b",
    symbol = "F",
    color = "green",
    name = ccb.content.text("roadside foodcart"),
}

content.patch_overmap_terrain {
    ids = { "orchard_tree_apple" },
    copy_from = "orchard_tree_apple",
    symbol = "A",
    color = "green",
    name = ccb.content.text("apple orchard"),
}

content.patch_overmap_terrain {
    ids = { "orchard_processing" },
    copy_from = "orchard_processing",
    symbol = "P",
    color = "green",
    name = ccb.content.text("processing"),
}

content.patch_overmap_terrain {
    ids = { "orchard_stall" },
    copy_from = "orchard_stall",
    symbol = "S",
    color = "green",
    name = ccb.content.text("stall"),
}

content.patch_overmap_terrain {
    ids = { "orchard_processing_roof" },
    copy_from = "orchard_processing_roof",
    symbol = "P",
    color = "green",
    name = ccb.content.text("processing roof"),
}

content.patch_overmap_terrain {
    ids = { "orchard_stall_roof" },
    copy_from = "orchard_stall_roof",
    symbol = "S",
    color = "green",
    name = ccb.content.text("stall roof"),
}

content.patch_overmap_terrain {
    ids = { "orchard", "orchard_1" },
    copy_from = "orchard",
    symbol = "O",
    color = "green",
    name = ccb.content.text("orchard"),
}

content.patch_overmap_terrain {
    ids = { "orchard_roof", "orchard_roof_1" },
    copy_from = "orchard_roof",
    symbol = "O",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "candy_shop", "candy_shop_1" },
    copy_from = "candy_shop",
    symbol = "C",
    color = "green",
    name = ccb.content.text("candy shop"),
}

content.patch_overmap_terrain {
    ids = { "candy_shop_roof", "candy_shop_roof_1" },
    copy_from = "candy_shop_roof",
    symbol = "C",
    color = "green",
    name = ccb.content.text("candy shop roof"),
}

content.patch_overmap_terrain {
    ids = { "bakery" },
    copy_from = "bakery",
    symbol = "B",
    color = "green",
    name = ccb.content.text("bakery"),
}

content.patch_overmap_terrain {
    ids = { "bakery_roof" },
    copy_from = "bakery_roof",
    symbol = "B",
    color = "green",
    name = ccb.content.text("bakery roof"),
}

content.patch_overmap_terrain {
    ids = { "bakery_upper_roof" },
    copy_from = "bakery_upper_roof",
    symbol = "B",
    color = "green",
    name = ccb.content.text("bakery roof"),
}

content.patch_overmap_terrain {
    ids = { "icecream_shop" },
    copy_from = "icecream_shop",
    symbol = "I",
    color = "green",
    name = ccb.content.text("icecream shop"),
}

content.patch_overmap_terrain {
    ids = { "icecream_shop_roof" },
    copy_from = "icecream_shop_roof",
    symbol = "I",
    color = "green",
    name = ccb.content.text("icecream shop roof"),
}

content.patch_overmap_terrain {
    ids = { "river_cave_food" },
    copy_from = "river_cave_food",
    symbol = "O",
    color = "green",
    name = ccb.content.text("kraken food storage"),
}

content.patch_overmap_terrain {
    ids = { "s_butcher", "s_butcher_1", "s_butcher_2" },
    copy_from = "s_butcher",
    symbol = "B",
    color = "green",
    name = ccb.content.text("butcher shop"),
}

content.patch_overmap_terrain {
    ids = {
        "s_butcher_roof", "s_butcher_roof_1", "s_butcher_roof_2", "s_butcher_upper_roof",
        "s_butcher_upper_roof_1",
    },
    copy_from = "s_butcher_roof",
    symbol = "B",
    color = "green",
    name = ccb.content.text("butcher shop roof"),
}

content.patch_overmap_terrain {
    ids = { "moonshine_still", "moonshine_still_1", "moonshine_still_2" },
    copy_from = "moonshine_still",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("moonshine still"),
}

content.patch_overmap_terrain {
    ids = { "moonshine_still_roof", "moonshine_still_roof_1", "moonshine_still_roof_2" },
    copy_from = "moonshine_still_roof",
    symbol = "S",
    color = "brown",
    name = ccb.content.text("moonshine still roof"),
}

content.patch_overmap_terrain {
    ids = { "sugar_house" },
    copy_from = "sugar_house",
    symbol = "S",
    color = "green",
    name = ccb.content.text("sugar house"),
}

content.patch_overmap_terrain {
    ids = { "sugar_house_roof" },
    copy_from = "sugar_house_roof",
    symbol = "S",
    color = "green",
    name = ccb.content.text("sugar house roof"),
}

content.patch_overmap_terrain {
    ids = {
        "morgantown_1a", "morgantown_2a", "morgantown_3a", "morgantown_1b", "morgantown_2b", "morgantown_3b",
        "morgantown_1c", "morgantown_2c", "morgantown_3c",
    },
    copy_from = "morgantown_1a",
    symbol = "F",
    color = "green",
    name = ccb.content.text("forested ruins"),
}

content.patch_overmap_terrain {
    ids = {
        "morgantown_forest_fence_s", "morgantown_forest", "morgantown_forest_fence_corner",
        "morgantown_forest_fence_entry", "morgantown_forest_fence_entry_2",
    },
    copy_from = "morgantown_forest_fence_s",
    symbol = "#",
    color = "green",
    name = ccb.content.text("fenced-off forest"),
}

content.patch_overmap_terrain {
    ids = { "lab_subway_vent_shaft_surface" },
    copy_from = "lab_subway_vent_shaft_surface",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("Lab access shaft"),
}

content.patch_overmap_terrain {
    ids = { "lab_surface_brick_blockA0", "lab_surface_brick_blockB0" },
    copy_from = "lab_surface_brick_blockA0",
    symbol = "G",
    color = "light_green",
    name = ccb.content.text("research facility garden"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_brick_blockA1", "lab_surface_brick_blockB1", "lab_surface_brick_blockC0",
        "lab_surface_brick_blockC1", "lab_surface_brick_blockC2", "lab_surface_brick_blockD0",
        "lab_surface_brick_blockD1", "lab_surface_brick_blockE0", "lab_surface_brick_blockE1",
    },
    copy_from = "lab_surface_brick_blockA1",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_parking_blockA2", "lab_surface_parking_blockE2", "lab_surface_parking_blockA0",
        "lab_surface_parking_blockB0", "lab_surface_parking_blockC0", "lab_surface_parking_blockD0",
        "lab_surface_parking_blockE0", "lab_surface_parking_blockA1", "lab_surface_parking_blockB1",
        "lab_surface_parking_blockC1", "lab_surface_parking_blockD1", "lab_surface_parking_blockE1",
    },
    copy_from = "lab_surface_parking_blockA2",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_brick_blockA2", "lab_surface_brick_blockA3", "lab_surface_brick_blockA4",
        "lab_surface_brick_blockB2", "lab_surface_brick_blockB3", "lab_surface_brick_blockB4",
        "lab_surface_brick_blockC4", "lab_surface_brick_blockD2", "lab_surface_brick_blockD3",
        "lab_surface_brick_blockD4", "lab_surface_brick_blockE2", "lab_surface_brick_blockE3",
        "lab_surface_brick_blockE4",
    },
    copy_from = "lab_surface_brick_blockA2",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("research facility"),
}

content.patch_overmap_terrain {
    ids = { "lab_surface_brick_blockC3" },
    copy_from = "lab_surface_brick_blockC3",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("research facility entrance"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_brick_block2A2", "lab_surface_brick_block2A3", "lab_surface_brick_block2A4",
        "lab_surface_brick_block2B2", "lab_surface_brick_block2B3", "lab_surface_brick_block2B4",
        "lab_surface_brick_block2C3", "lab_surface_brick_block2C4", "lab_surface_brick_block2D2",
        "lab_surface_brick_block2D3", "lab_surface_brick_block2D4", "lab_surface_brick_block2E2",
        "lab_surface_brick_block2E3", "lab_surface_brick_block2E4",
    },
    copy_from = "lab_surface_brick_block2A2",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("research facility, second floor"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_brick_block3A2", "lab_surface_brick_block3A3", "lab_surface_brick_block3A4",
        "lab_surface_brick_block3B2", "lab_surface_brick_block3B3", "lab_surface_brick_block3B4",
        "lab_surface_brick_block3C3", "lab_surface_brick_block3C4", "lab_surface_brick_block3D2",
        "lab_surface_brick_block3D3", "lab_surface_brick_block3D4", "lab_surface_brick_block3E2",
        "lab_surface_brick_block3E3", "lab_surface_brick_block3E4",
    },
    copy_from = "lab_surface_brick_block3A2",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("research facility, third floor"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_brick_block4A2", "lab_surface_brick_block4A3", "lab_surface_brick_block4A4",
        "lab_surface_brick_block4B2", "lab_surface_brick_block4B3", "lab_surface_brick_block4B4",
        "lab_surface_brick_block4C3", "lab_surface_brick_block4C4", "lab_surface_brick_block4D2",
        "lab_surface_brick_block4D3", "lab_surface_brick_block4D4", "lab_surface_brick_block4E2",
        "lab_surface_brick_block4E3", "lab_surface_brick_block4E4",
    },
    copy_from = "lab_surface_brick_block4A2",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("research facility, fourth floor"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_surface_brick_block5A2", "lab_surface_brick_block5B2", "lab_surface_brick_block5A3",
        "lab_surface_brick_block5A4", "lab_surface_brick_block5B3", "lab_surface_brick_block5B4",
        "lab_surface_brick_block5C3", "lab_surface_brick_block5C4", "lab_surface_brick_block5D2",
        "lab_surface_brick_block5D3", "lab_surface_brick_block5D4", "lab_surface_brick_block5E2",
        "lab_surface_brick_block5E3", "lab_surface_brick_block5E4",
    },
    copy_from = "lab_surface_brick_block5A2",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("research facility roof"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_2x2_MUT_tier_1_NW", "lab_2x2_MUT_tier_1_NE", "lab_2x2_MUT_tier_1_SW", "lab_2x2_MUT_tier_1_SE",
        "lab_2x2_MUT_tier_2_NW_final_flr", "lab_2x2_MUT_tier_2_NE", "lab_2x2_MUT_tier_2_SW",
        "lab_2x2_MUT_tier_2_SE",
    },
    copy_from = "lab_2x2_MUT_tier_1_NW",
    symbol = "R",
    color = "light_blue",
    name = ccb.content.text("Research Zone"),
}

content.patch_overmap_terrain {
    ids = { "lab_CORE_2x1_1UP", "lab_CORE_2x1_2UP", "lab_CORE_2x1_1DN", "lab_CORE_2x1_2DN" },
    copy_from = "lab_CORE_2x1_1UP",
    symbol = "R",
    color = "white",
    name = ccb.content.text("Recreation Zone"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_security_z-1", "lab_security_z-2", "lab_security_z-3", "lab_security_z-4", "lab_security_z-5",
        "lab_security_z-6_final_flr",
    },
    copy_from = "lab_security_z-1",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("Security Zone"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_2x1_CORE_-1W", "lab_2x1_CORE_-1E", "underground_lab_cargo_stationA",
        "underground_lab_cargo_stationB", "underground_lab_central_-5E", "underground_lab_central_-5W",
        "underground_lab_central_-6W", "underground_lab_central_-6E", "underground_lab_central_-7W",
        "underground_lab_central_-7E", "lab_2x2_cargo_NW", "lab_2x2_cargo_NE", "lab_2x2_cargo_SW",
        "lab_2x2_cargo_SE",
    },
    copy_from = "lab_2x1_CORE_-1W",
    symbol = "C",
    color = "white",
    name = ccb.content.text("Cargo Zone"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_1x1_RES_8_bedrooms_maintenance", "lab_1x1_RES_8_bedrooms_security",
        "lab_1x1_RES_8_commons_MAINT", "lab_1x1_RES_8_commons_SEC", "lab_res_8_NW", "lab_res_8_NE",
        "lab_res_8_SW", "lab_res_8_SE", "lab_res_8_NWD", "lab_res_8_NED", "lab_res_8_SWD", "lab_res_8_SED",
        "lab_1x1x2_RES_8_apartments_upper", "lab_1x1x2_RES_8_apartments_lower",
    },
    copy_from = "lab_1x1_RES_8_bedrooms_maintenance",
    symbol = "R",
    color = "green",
    name = ccb.content.text("Residential Zone"),
}

content.patch_overmap_terrain {
    ids = {
        "lab_res_8_SWD_ground", "lab_res_8_SED_ground", "lab_res_8_SWU_ground", "lab_res_8_SEU_ground",
        "lab_CORE_2x1_SED_ground", "lab_CORE_2x1_SWD_ground", "lab_CORE_2x1_NED_ground",
        "lab_CORE_2x1_NWD_ground", "lab_CORE_2x1_WC_ground", "lab_CORE_2x1_EC_ground", "lab_security_z0",
        "lab_security_z0N", "lab_security_z0S",
    },
    copy_from = "lab_res_8_SWD_ground",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("Trans-Coast Logistics"),
}

content.patch_overmap_terrain {
    ids = { "full_mutagen_lab_roof" },
    copy_from = "full_mutagen_lab_roof",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("Trans-Coast Logistics roof"),
}

content.patch_overmap_terrain {
    ids = { "lab_security_z0S_roof", "lab_security_z0N_roof" },
    copy_from = "lab_security_z0S_roof",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("Trans-Coast Logistics roof"),
}

content.patch_overmap_terrain {
    ids = { "lab_health_z-2_A", "lab_health_z-2_B", "lab_health_z-3_A" },
    copy_from = "lab_health_z-2_A",
    symbol = "H",
    color = "red",
    name = ccb.content.text("Health Clinic"),
}

content.patch_overmap_terrain {
    ids = { "lab_health_z-3_B" },
    copy_from = "lab_health_z-3_B",
    symbol = "H",
    color = "red",
    name = ccb.content.text("Health Clinic"),
}

content.patch_overmap_terrain {
    ids = { "lab_maintenance_z-2&3_B", "lab_maintenance_z-2&3_A" },
    copy_from = "lab_maintenance_z-2&3_B",
    symbol = "M",
    color = "cyan",
    name = ccb.content.text("Maintenance Zone"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_surface_1a", "LIXA_surface_2a", "LIXA_surface_1b", "LIXA_surface_2b" },
    copy_from = "LIXA_surface_1a",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("LIXA research facility"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_roof_1a", "LIXA_roof_2a", "LIXA_roof_1b", "LIXA_roof_2b" },
    copy_from = "LIXA_roof_1a",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("LIXA research facility roof"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_entry_1", "LIXA_entry_2" },
    copy_from = "LIXA_entry_1",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("LIXA research facility gate"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_road" },
    copy_from = "LIXA_road",
    symbol = "│",
    color = "dark_gray",
    name = ccb.content.text("LIXA research facility access road"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_road_guard", "LIXA_road_guard_roof" },
    copy_from = "LIXA_road_guard",
    symbol = "C",
    color = "pink",
    name = ccb.content.text("LIXA research facility checkpoint"),
}

content.patch_overmap_terrain {
    ids = {
        "LIXA_stairshaft_1a", "LIXA_stairshaft_1b", "LIXA_stairshaft_1c", "LIXA_stairshaft_1d",
        "LIXA_stairshaft_2a", "LIXA_stairshaft_2b", "LIXA_stairshaft_2c", "LIXA_stairshaft_2d",
    },
    copy_from = "LIXA_stairshaft_1a",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("LIXA experiment floor access"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_workfloor_1a", "LIXA_workfloor_2a", "LIXA_workfloor_1b", "LIXA_workfloor_2b" },
    copy_from = "LIXA_workfloor_1a",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("LIXA research floor"),
}

content.patch_overmap_terrain {
    ids = { "LIXA_device_1", "LIXA_device_2", "LIXA_device_3", "LIXA_device_2_roof", "LIXA_device_3_roof" },
    copy_from = "LIXA_device_1",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("LIXA device floor"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic" },
    copy_from = "microlab_generic",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic_edge" },
    copy_from = "microlab_generic_edge",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic_surface_connector" },
    copy_from = "microlab_generic_surface_connector",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic_vent_shaft_connector" },
    copy_from = "microlab_generic_vent_shaft_connector",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_sub_station" },
    copy_from = "microlab_sub_station",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway station?"),
}

content.patch_overmap_terrain {
    ids = { "microlab_sub_connector" },
    copy_from = "microlab_sub_connector",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway station?"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic_sub_entry" },
    copy_from = "microlab_generic_sub_entry",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = {
        "microlab_generic_firebreak", "microlab_portal_dressroom", "microlab_generic_stairs_down",
        "microlab_generic_edge_room_connector", "microlab_generic_hallway_blind_end",
        "microlab_generic_isolated_stairs_odd", "microlab_generic_isolated_stairs_up",
        "microlab_generic_isolated_elevator_pit",
    },
    copy_from = "microlab_generic_firebreak",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = {
        "microlab_portal_security1", "microlab_portal_security2", "microlab_portal_security3",
        "microlab_portal_security4", "microlab_portal_security5", "microlab_portal_security6",
        "microlab_portal_security7", "microlab_portal_security8", "microlab_portal_security_hallway1",
        "microlab_portal_security_hallway2",
    },
    copy_from = "microlab_portal_security1",
    symbol = "L",
    color = "red",
    name = ccb.content.text("physics lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_reactor", "microlab_reactor_b" },
    copy_from = "microlab_reactor",
    symbol = "L",
    color = "light_red",
    name = ccb.content.text("science lab reactor"),
}

content.patch_overmap_terrain {
    ids = { "microlab_distorted", "microlab_distorted_edge" },
    copy_from = "microlab_distorted",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("distorted science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_portal_elevator", "microlab_portal_elevator_physics_glass" },
    copy_from = "microlab_portal_elevator",
    symbol = "L",
    color = "light_red",
    name = ccb.content.text("physics department elevator"),
}

content.patch_overmap_terrain {
    ids = { "microlab_portal_MSU14_elevator" },
    copy_from = "microlab_portal_MSU14_elevator",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("Hub 14 elevator"),
}

content.patch_overmap_terrain {
    ids = { "microlab_portal_MSU14" },
    copy_from = "microlab_portal_MSU14",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("Hub 14"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic_surface" },
    copy_from = "microlab_generic_surface",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_generic_surface_roof" },
    copy_from = "microlab_generic_surface_roof",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_ratkin" },
    copy_from = "microlab_ratkin",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_ratkin_edge" },
    copy_from = "microlab_ratkin_edge",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_ratkin_sub_entry" },
    copy_from = "microlab_ratkin_sub_entry",
    symbol = "L",
    color = "magenta",
    name = ccb.content.text("science lab"),
}

content.patch_overmap_terrain {
    ids = { "microlab_sub_station_ratkin" },
    copy_from = "microlab_sub_station_ratkin",
    symbol = "P",
    name = ccb.content.text("pump station?"),
}

content.patch_overmap_terrain {
    ids = {
        "apartment_complex_garage_corner_gate_L", "apartment_complex_garage_corner_gate_R",
        "apartment_complex_garage_corner", "apartment_complex_garage_straight",
        "apartment_complex_garage_straight_wall", "apartment_complex_garage_straight_wallALT",
        "apartment_complex_garage_straight_gate_wallALT", "apartment_complex_garage_corner_inner_wall",
        "apartment_complex_garage_corner_inner_wallALT",
    },
    copy_from = "apartment_complex_garage_corner_gate_L",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking garage"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_67" },
    copy_from = "ranch_camp_67",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_67_roof" },
    copy_from = "ranch_camp_67_roof",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage roof"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_76" },
    copy_from = "ranch_camp_76",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "boat_rental", "boat_rental_1", "boat_rental_2" },
    copy_from = "boat_rental",
    symbol = "B",
    color = "light_blue",
    name = ccb.content.text("boat rental"),
}

content.patch_overmap_terrain {
    ids = { "boat_rental_roof", "boat_rental_1_roof", "boat_rental_2_roof" },
    copy_from = "boat_rental_roof",
    symbol = "B",
    color = "light_blue",
}

content.patch_overmap_terrain {
    ids = { "bandit_garage_1", "bandit_garage_2" },
    copy_from = "bandit_garage_1",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage"),
}

content.patch_overmap_terrain {
    ids = { "bandit_garage_1_roof", "bandit_garage_2_roof" },
    copy_from = "bandit_garage_1_roof",
    symbol = "G",
    color = "light_blue",
}

content.patch_overmap_terrain {
    ids = { "hotel_tower_1_1", "hotel_tower_1_2", "hotel_tower_1_3", "hotel_tower_1_4", "hotel_tower_1_6" },
    copy_from = "hotel_tower_1_1",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("hotel parking"),
}

content.patch_overmap_terrain {
    ids = {
        "parking_garage_down_0", "parking_garage_down_1", "parking_garage_1_0", "parking_garage_1_1",
        "parking_garage2x2_down_0", "parking_garage2x2_down_1", "parking_garage2x2_down_2",
        "parking_garage2x2_down_3", "parking_garage2x2_1_0", "parking_garage2x2_1_1",
        "parking_garage2x2_1_2", "parking_garage2x2_1_3", "parking_garage2x2_2_0", "parking_garage2x2_2_1",
        "parking_garage2x2_2_2", "parking_garage2x2_2_3", "parking_garage2x2_3_0", "parking_garage2x2_3_1",
        "parking_garage2x2_3_2", "parking_garage2x2_3_3", "parking_garage2x2_4_2", "parking_garage2x2_4_3",
        "parking_garage_2_0", "parking_garage_2_1", "parking_garage_roof_0", "parking_garage_roof_1",
        "parking_garage_roof_top",
    },
    copy_from = "parking_garage_down_0",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking garage"),
}

content.patch_overmap_terrain {
    ids = {
        "parking_garage_0_0", "parking_garage_0_1", "parking_garage2x2_0_0", "parking_garage2x2_0_1",
        "parking_garage2x2_0_2", "parking_garage2x2_0_3",
    },
    copy_from = "parking_garage_0_0",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking garage"),
}

content.patch_overmap_terrain {
    ids = { "trailer_caravan_00", "trailer_caravan_10", "trailer_caravan_01", "trailer_caravan_11" },
    copy_from = "trailer_caravan_00",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("caravan parking"),
}

content.patch_overmap_terrain {
    ids = {
        "s_lot", "parking_2x1_0", "parking_2x1_1", "parking_2x2_0_0", "parking_2x2_0_1", "parking_2x2_1_0",
        "parking_2x2_1_1", "parking_3x1_0", "parking_3x1_1", "parking_3x1_2",
    },
    copy_from = "s_lot",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "fema_bus" },
    copy_from = "fema_bus",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("FEMA camp bus stop"),
}

content.patch_overmap_terrain {
    ids = { "nursing_home_sh9", "nursing_home_sh10", "nursing_home_sh11" },
    copy_from = "nursing_home_sh9",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "nursing_home_9", "nursing_home_10", "nursing_home_11" },
    copy_from = "nursing_home_9",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = {
        "mil_base_5a", "mil_base_6a", "mil_base_7a", "mil_base_6h", "mil_base_7h", "mil_base_8h",
        "mil_base_8f", "mil_base_6g", "mil_base_7g",
    },
    copy_from = "mil_base_5a",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("military base"),
}

content.patch_overmap_terrain {
    ids = { "s_lot_no_sidewalk", "trailer_hub_00" },
    copy_from = "s_lot_no_sidewalk",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "s_gas_1" },
    copy_from = "s_gas_1",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("gas station"),
}

content.patch_overmap_terrain {
    ids = { "s_gas_0_0", "s_gas_1_0", "s_gas_0_1", "s_gas_1_1", "s_gas_g1" },
    copy_from = "s_gas_0_0",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("gas station"),
}

content.patch_overmap_terrain {
    ids = {
        "s_gas_0_0_roof", "s_gas_1_0_roof", "s_gas_0_1_roof", "s_gas_1_1_roof", "s_gas_roof_1",
        "s_gas_g1_roof",
    },
    copy_from = "s_gas_0_0_roof",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("gas station roof"),
}

content.patch_overmap_terrain {
    ids = { "strip_mall_5" },
    copy_from = "strip_mall_5",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "s_garage", "s_garage_1", "s_garage_2" },
    copy_from = "s_garage",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage"),
}

content.patch_overmap_terrain {
    ids = { "s_garage_roof", "s_garage_roof_1", "s_garage_roof_2", "s_garage_upper_roof_2" },
    copy_from = "s_garage_roof",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage roof"),
}

content.patch_overmap_terrain {
    ids = { "s_gas_rural" },
    copy_from = "s_gas_rural",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("gas station"),
}

content.patch_overmap_terrain {
    ids = { "s_gas_rural_roof" },
    copy_from = "s_gas_rural_roof",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("gas station roof"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_7" },
    copy_from = "mall_a_7",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_8" },
    copy_from = "mall_a_8",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_9" },
    copy_from = "mall_a_9",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "garage_gas_1" },
    copy_from = "garage_gas_1",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage - gas station"),
}

content.patch_overmap_terrain {
    ids = { "garage_gas_2", "garage_gas_3" },
    copy_from = "garage_gas_2",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage"),
}

content.patch_overmap_terrain {
    ids = { "garage_gas_roof_1", "garage_gas_roof_2", "garage_gas_roof_3" },
    copy_from = "garage_gas_roof_1",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage roof"),
}

content.patch_overmap_terrain {
    ids = { "golfcourse_30" },
    copy_from = "golfcourse_30",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("golf course parking"),
}

content.patch_overmap_terrain {
    ids = { "s_bike_shop", "s_bike_shop_1" },
    copy_from = "s_bike_shop",
    symbol = "B",
    color = "light_blue",
    name = ccb.content.text("bike shop"),
}

content.patch_overmap_terrain {
    ids = { "s_bike_shop_roof", "s_bike_shop_roof_1", "s_bike_shop_roof_1_shack_roof" },
    copy_from = "s_bike_shop_roof",
    symbol = "B",
    color = "light_blue",
    name = ccb.content.text("bike shop roof"),
}

content.patch_overmap_terrain {
    ids = { "cs_car_showroom" },
    copy_from = "cs_car_showroom",
    symbol = "C",
    color = "light_blue",
    name = ccb.content.text("car showroom"),
}

content.patch_overmap_terrain {
    ids = { "cs_car_showroom_2ndfloor" },
    copy_from = "cs_car_showroom_2ndfloor",
    symbol = "C",
    color = "light_blue",
    name = ccb.content.text("car showroom 2nd floor"),
}

content.patch_overmap_terrain {
    ids = { "cs_car_showroom_roof" },
    copy_from = "cs_car_showroom_roof",
    symbol = "C",
    color = "light_blue",
    name = ccb.content.text("car showroom roof"),
}

content.patch_overmap_terrain {
    ids = { "cs_car_dealership", "s_cardealer" },
    copy_from = "cs_car_dealership",
    symbol = "C",
    color = "light_blue",
    name = ccb.content.text("car dealership"),
}

content.patch_overmap_terrain {
    ids = { "cs_car_dealership_roof", "s_cardealer_roof" },
    copy_from = "cs_car_dealership_roof",
    symbol = "C",
    color = "light_blue",
    name = ccb.content.text("car dealership roof"),
}

content.patch_overmap_terrain {
    ids = { "s_restparking_1", "s_restparking_2" },
    copy_from = "s_restparking_1",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("rest area parking"),
}

content.patch_overmap_terrain {
    ids = { "cs_tire_shop" },
    copy_from = "cs_tire_shop",
    symbol = "T",
    color = "light_blue",
    name = ccb.content.text("tire shop"),
}

content.patch_overmap_terrain {
    ids = { "cs_tire_shop_roof" },
    copy_from = "cs_tire_shop_roof",
    symbol = "T",
    color = "light_blue",
    name = ccb.content.text("tire shop roof"),
}

content.patch_overmap_terrain {
    ids = { "roadstop", "roadstop_roof" },
    copy_from = "roadstop",
    symbol = "R",
    color = "light_blue",
    name = ccb.content.text("roadstop"),
}

content.patch_overmap_terrain {
    ids = { "roadstop_a", "roadstop_a_roof" },
    copy_from = "roadstop_a",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("public washroom"),
}

content.patch_overmap_terrain {
    ids = { "s_reststop_1", "s_reststop_2" },
    copy_from = "s_reststop_1",
    symbol = "R",
    color = "light_blue",
    name = ccb.content.text("rest area"),
}

content.patch_overmap_terrain {
    ids = { "s_reststop_1_roof", "s_reststop_2_roof" },
    copy_from = "s_reststop_1_roof",
    symbol = "R",
    color = "light_blue",
    name = ccb.content.text("rest area roof"),
}

content.patch_overmap_terrain {
    ids = { "bus_stat_0", "bus_stat_1" },
    copy_from = "bus_stat_0",
    symbol = "B",
    color = "light_blue",
    name = ccb.content.text("bus station"),
}

content.patch_overmap_terrain {
    ids = { "bus_stat_0_roof", "bus_stat_1_roof" },
    copy_from = "bus_stat_0_roof",
    symbol = "B",
    color = "light_blue",
    name = ccb.content.text("bus station roof"),
}

content.patch_overmap_terrain {
    ids = { "fuel_station" },
    copy_from = "fuel_station",
    symbol = "F",
    color = "light_blue",
    name = ccb.content.text("fuel station"),
}

content.patch_overmap_terrain {
    ids = { "fuel_station_roof" },
    copy_from = "fuel_station_roof",
    symbol = "F",
    color = "light_blue",
    name = ccb.content.text("fuel station roof"),
}

content.patch_overmap_terrain {
    ids = { "airport_lot_0", "airport_lot_1", "s_air_parking" },
    copy_from = "airport_lot_0",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "hangar", "s_air_hangars" },
    copy_from = "hangar",
    symbol = "S",
    color = "light_blue",
    name = ccb.content.text("small hangar"),
}

content.patch_overmap_terrain {
    ids = { "hangar_roof", "s_air_hangars_roof" },
    copy_from = "hangar_roof",
    symbol = "S",
    color = "light_blue",
    name = ccb.content.text("small hangar roof"),
}

content.patch_overmap_terrain {
    ids = { "s_air_helicopter_pad" },
    copy_from = "s_air_helicopter_pad",
    symbol = "H",
    color = "light_blue",
    name = ccb.content.text("helicopter pad"),
}

content.patch_overmap_terrain {
    ids = {
        "s_shoppingplaza_a1", "s_shoppingplaza_a2", "s_shoppingplaza_a3", "s_shoppingplaza_a4",
        "s_shoppingplaza_a5",
    },
    copy_from = "s_shoppingplaza_a1",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = { "lake_dock_small" },
    copy_from = "lake_dock_small",
    symbol = "D",
    color = "light_blue",
    name = ccb.content.text("dock"),
}

content.patch_overmap_terrain {
    ids = { "lake_shore_dock_small" },
    copy_from = "lake_shore_dock_small",
    symbol = "D",
    color = "light_blue",
    name = ccb.content.text("dock"),
}

content.patch_overmap_terrain {
    ids = { "marina_11", "marina_12", "marina_13", "marina_14", "marina_15" },
    copy_from = "marina_11",
    symbol = "M",
    color = "light_blue",
    name = ccb.content.text("marina"),
}

content.patch_overmap_terrain {
    ids = { "marina_11_roof", "marina_12_roof", "marina_15_roof" },
    copy_from = "marina_11_roof",
    symbol = "M",
    color = "light_blue",
    name = ccb.content.text("marina roof"),
}

content.patch_overmap_terrain {
    ids = { "marina_16", "marina_17", "marina_18", "marina_19", "marina_20" },
    copy_from = "marina_16",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("marina parking"),
}

content.patch_overmap_terrain {
    ids = {
        "car_theater_0_0", "car_theater_1_0", "car_theater_2_0", "car_theater_0_1", "car_theater_1_1",
        "car_theater_2_1", "car_theater_0_2", "car_theater_1_2", "car_theater_1_2_1", "car_theater_1_2_2",
        "car_theater_2_2", "car_theater_0_0_1", "car_theater_1_0_1", "car_theater_2_0_1",
        "car_theater_0_0_2", "car_theater_1_0_2", "car_theater_2_0_2",
    },
    copy_from = "car_theater_0_0",
    symbol = "D",
    color = "light_blue",
    name = ccb.content.text("drive-in theater"),
}

content.patch_overmap_terrain {
    ids = {
        "car_theater_3_1", "car_theater_3_2", "car_theater_3_1_1", "car_theater_3_2_1", "car_theater_4_1",
        "car_theater_4_2",
    },
    copy_from = "car_theater_3_1",
    symbol = "D",
    color = "light_blue",
    name = ccb.content.text("drive-in theater entrance"),
}

content.patch_overmap_terrain {
    ids = {
        "stadium_football_8_1", "stadium_football_8_2", "stadium_football_8_3", "stadium_1_0", "stadium_2_0",
        "stadium_0_0", "stadium_3_0",
    },
    copy_from = "stadium_football_8_1",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("stadium parking"),
}

content.patch_overmap_terrain {
    ids = { "robofachq_surface_parking" },
    copy_from = "robofachq_surface_parking",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("hub 01 parking space"),
}

content.patch_overmap_terrain {
    ids = {
        "retirement_community_8", "retirement_community_14", "retirement_community_27",
        "retirement_community_33",
    },
    copy_from = "retirement_community_8",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = {
        "speedway_1_6", "speedway_2_6", "speedway_3_6", "speedway_4_6", "speedway_5_6", "speedway_1_6_1",
        "speedway_2_6_1", "speedway_3_6_1", "speedway_4_6_1", "speedway_5_6_1",
    },
    copy_from = "speedway_1_6",
    symbol = "B",
    color = "light_blue",
    name = ccb.content.text("bleachers"),
}

content.patch_overmap_terrain {
    ids = {
        "speedway_1_7", "speedway_2_7", "speedway_3_7", "speedway_4_7", "speedway_1_8", "speedway_2_8",
        "speedway_3_8", "speedway_4_8", "speedway_1_9", "speedway_2_9", "speedway_3_9", "speedway_4_9",
    },
    copy_from = "speedway_1_7",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("parking lot"),
}

content.patch_overmap_terrain {
    ids = {
        "speedway_9_3", "speedway_9_4", "speedway_9_5", "speedway_9_3_1", "speedway_9_4_1", "speedway_9_5_1",
    },
    copy_from = "speedway_9_3",
    symbol = "G",
    color = "light_blue",
    name = ccb.content.text("garage"),
}

content.patch_overmap_terrain {
    ids = { "speedway_6_7_1", "speedway_6_7_2", "speedway_6_7_3" },
    copy_from = "speedway_6_7_1",
    symbol = "A",
    color = "light_blue",
    name = ccb.content.text("announcer station"),
}

content.patch_overmap_terrain {
    ids = { "zoo_0_0", "zoo_1_0" },
    copy_from = "zoo_0_0",
    symbol = "P",
    color = "light_blue",
    name = ccb.content.text("zoo parking"),
}

content.patch_overmap_terrain {
    ids = { "s_hardware", "s_hardware_1", "s_hardware_2", "s_hardware_3" },
    copy_from = "s_hardware",
    symbol = "H",
    color = "light_cyan",
    name = ccb.content.text("hardware store"),
}

content.patch_overmap_terrain {
    ids = { "s_hardware_roof", "s_hardware_roof_1", "s_hardware_roof_2", "s_hardware_roof_3" },
    copy_from = "s_hardware_roof",
    symbol = "H",
    color = "light_cyan",
    name = ccb.content.text("hardware store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_weldingstore" },
    copy_from = "s_weldingstore",
    symbol = "W",
    color = "light_cyan",
    name = ccb.content.text("welding store"),
}

content.patch_overmap_terrain {
    ids = { "s_weldingstore_roof" },
    copy_from = "s_weldingstore_roof",
    symbol = "W",
    color = "light_cyan",
    name = ccb.content.text("welding store roof"),
}

content.patch_overmap_terrain {
    ids = {
        "hdwr_large_0_0_0", "hdwr_large_0_1_0", "hdwr_large_0_2_0", "hdwr_large_1_0_0", "hdwr_large_1_1_0",
        "hdwr_large_1_2_0",
    },
    copy_from = "hdwr_large_0_0_0",
    symbol = "H",
    color = "light_cyan",
    name = ccb.content.text("home improvement superstore"),
}

content.patch_overmap_terrain {
    ids = {
        "hdwr_large_0_0_1", "hdwr_large_1_0_1", "hdwr_large_0_1_1", "hdwr_large_1_1_1", "hdwr_large_0_2_1",
        "hdwr_large_1_2_1", "hdwr_large_1_1_2",
    },
    copy_from = "hdwr_large_0_0_1",
    symbol = "H",
    color = "light_cyan",
    name = ccb.content.text("home improvement superstore roof"),
}

content.patch_overmap_terrain {
    ids = { "landscapingsupplyco_1a" },
    copy_from = "landscapingsupplyco_1a",
    symbol = "L",
    color = "light_cyan",
    name = ccb.content.text("landscaping supply co"),
}

content.patch_overmap_terrain {
    ids = { "landscapingsupplyco_1b" },
    copy_from = "landscapingsupplyco_1b",
    symbol = "L",
    color = "light_cyan",
    name = ccb.content.text("landscaping supply co"),
}

content.patch_overmap_terrain {
    ids = { "landscapingsupplyco_1b_roof" },
    copy_from = "landscapingsupplyco_1b_roof",
    symbol = "L",
    color = "light_cyan",
    name = ccb.content.text("landscaping supply co roof"),
}

content.patch_overmap_terrain {
    ids = { "s_electronics", "s_electronics_1", "s_electronicstore" },
    copy_from = "s_electronics",
    symbol = "E",
    color = "light_cyan",
    name = ccb.content.text("electronics store"),
}

content.patch_overmap_terrain {
    ids = { "s_electronics_roof", "s_electronics_roof_1", "s_electronicstore_roof" },
    copy_from = "s_electronics_roof",
    symbol = "E",
    color = "light_cyan",
    name = ccb.content.text("electronics store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_electronicstore_2ndfloor" },
    copy_from = "s_electronicstore_2ndfloor",
    symbol = "E",
    color = "light_cyan",
    name = ccb.content.text("electronics store 2nd floor"),
}

content.patch_overmap_terrain {
    ids = { "public_works_NE", "public_works_NW", "public_works_SE" },
    copy_from = "public_works_NE",
    symbol = "P",
    color = "light_cyan",
    name = ccb.content.text("public works"),
}

content.patch_overmap_terrain {
    ids = { "public_works_SW" },
    copy_from = "public_works_SW",
    symbol = "P",
    color = "light_cyan",
    name = ccb.content.text("public works"),
}

content.patch_overmap_terrain {
    ids = { "public_works_NE_roof", "public_works_NW_roof", "public_works_SE_roof" },
    copy_from = "public_works_NE_roof",
    symbol = "P",
    color = "light_cyan",
    name = ccb.content.text("public works roof"),
}

content.patch_overmap_terrain {
    ids = { "public_works_SW_roof" },
    copy_from = "public_works_SW_roof",
    symbol = "P",
    color = "light_cyan",
    name = ccb.content.text("public works roof"),
}

content.patch_overmap_terrain {
    ids = { "warehouse" },
    copy_from = "warehouse",
    symbol = "W",
    color = "light_cyan",
    name = ccb.content.text("warehouse"),
}

content.patch_overmap_terrain {
    ids = { "warehouse_roof" },
    copy_from = "warehouse_roof",
    symbol = "W",
    color = "light_cyan",
    name = ccb.content.text("warehouse roof"),
}

content.patch_overmap_terrain {
    ids = { "home_improvement" },
    copy_from = "home_improvement",
    symbol = "H",
    color = "light_cyan",
    name = ccb.content.text("home improvement store"),
}

content.patch_overmap_terrain {
    ids = { "home_improvement_roof" },
    copy_from = "home_improvement_roof",
    symbol = "H",
    color = "light_cyan",
    name = ccb.content.text("home improvement store roof"),
}

content.patch_overmap_terrain {
    ids = { "isolated_house_farm_blacksmith", "isolated_house_farm_roof_blacksmith" },
    copy_from = "isolated_house_farm_blacksmith",
    symbol = "B",
    color = "light_cyan",
    name = ccb.content.text("blacksmith's home"),
}

content.patch_overmap_terrain {
    ids = {
        "oil_platform_1a_2", "oil_platform_1b_2", "oil_platform_1c_2", "oil_platform_2a_2",
        "oil_platform_2b_2", "oil_platform_2c_2", "oil_platform_3a_2", "oil_platform_3b_2",
        "oil_platform_3c_2", "oil_platform_4a_2", "oil_platform_4b_2", "oil_platform_4c_2",
        "oil_platform_1a_3", "oil_platform_1b_3", "oil_platform_1c_3", "oil_platform_4a_3",
        "oil_platform_4b_3", "oil_platform_4c_3", "oil_platform_1a_4", "oil_platform_1b_4",
        "oil_platform_1c_4", "oil_platform_4a_4", "oil_platform_4b_4", "oil_platform_4c_4",
        "oil_platform_1a_5", "oil_platform_1b_5", "oil_platform_1c_5", "oil_platform_3a_5",
        "oil_platform_3b_5", "oil_platform_3c_5", "oil_platform_4a_5", "oil_platform_4b_5",
        "oil_platform_4c_5",
    },
    copy_from = "oil_platform_1a_2",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("oil platform"),
    see_cost = "full_high",
}

-- Dorms area
content.patch_overmap_terrain {
    ids = {
        "oil_platform_3a_3", "oil_platform_3b_3", "oil_platform_3c_3", "oil_platform_3a_4",
        "oil_platform_3b_4", "oil_platform_3c_4",
    },
    copy_from = "oil_platform_3a_3",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("oil platform"),
    see_cost = "full_high",
}

-- Open air, lower and underwater levels
content.patch_overmap_terrain {
    ids = {
        "oil_platform_1a_0", "oil_platform_1b_0", "oil_platform_1c_0", "oil_platform_2a_0",
        "oil_platform_2b_0", "oil_platform_2c_0", "oil_platform_3a_0", "oil_platform_3b_0",
        "oil_platform_3c_0", "oil_platform_4a_0", "oil_platform_4b_0", "oil_platform_4c_0",
        "oil_platform_1a_1", "oil_platform_1b_1", "oil_platform_1c_1", "oil_platform_2a_1",
        "oil_platform_2b_1", "oil_platform_2c_1", "oil_platform_3a_1", "oil_platform_3b_1",
        "oil_platform_3c_1", "oil_platform_4a_1", "oil_platform_4b_1", "oil_platform_4c_1",
        "oil_platform_2a_3", "oil_platform_2b_3", "oil_platform_2c_3", "oil_platform_2a_4",
        "oil_platform_2b_4", "oil_platform_2c_4", "oil_platform_2a_5", "oil_platform_2b_5",
        "oil_platform_2c_5", "oil_platform_1a_6", "oil_platform_1b_6", "oil_platform_1c_6",
        "oil_platform_2a_6", "oil_platform_2b_6", "oil_platform_2c_6", "oil_platform_3a_6",
        "oil_platform_3b_6", "oil_platform_3c_6", "oil_platform_4a_6", "oil_platform_4b_6",
        "oil_platform_4c_6", "oil_platform_1a_7", "oil_platform_1b_7", "oil_platform_1c_7",
        "oil_platform_2a_7", "oil_platform_2b_7", "oil_platform_2c_7", "oil_platform_3a_7",
        "oil_platform_3b_7", "oil_platform_3c_7", "oil_platform_4a_7", "oil_platform_4b_7",
        "oil_platform_4c_7", "oil_platform_1a_uw", "oil_platform_1b_uw", "oil_platform_1c_uw",
        "oil_platform_2a_uw", "oil_platform_2b_uw", "oil_platform_2c_uw", "oil_platform_3a_uw",
        "oil_platform_3b_uw", "oil_platform_3c_uw", "oil_platform_4a_uw", "oil_platform_4b_uw",
        "oil_platform_4c_uw", "oil_platform_1a_z-8", "oil_platform_1b_z-8", "oil_platform_1c_z-8",
        "oil_platform_2a_z-8", "oil_platform_2b_z-8", "oil_platform_2c_z-8", "oil_platform_3a_z-8",
        "oil_platform_3b_z-8", "oil_platform_3c_z-8", "oil_platform_4a_z-8", "oil_platform_4b_z-8",
        "oil_platform_4c_z-8", "oil_platform_1a_z-9", "oil_platform_1b_z-9", "oil_platform_1c_z-9",
        "oil_platform_2a_z-9", "oil_platform_2b_z-9", "oil_platform_2c_z-9", "oil_platform_3a_z-9",
        "oil_platform_3b_z-9", "oil_platform_3c_z-9", "oil_platform_4a_z-9", "oil_platform_4b_z-9",
        "oil_platform_4c_z-9",
    },
    copy_from = "oil_platform_1a_0",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("oil platform"),
    see_cost = "full_high",
}

content.patch_overmap_terrain {
    ids = { "mine_entrance", "mine_entrance_loading_zone" },
    copy_from = "mine_entrance",
    symbol = "M",
    color = "light_gray",
    name = ccb.content.text("mine entrance"),
}

content.patch_overmap_terrain {
    ids = { "mine_entrance_roof", "mine_entrance_loading_zone_roof" },
    copy_from = "mine_entrance_roof",
    symbol = "M",
    color = "light_gray",
    name = ccb.content.text("mine entrance roof"),
}

content.patch_overmap_terrain {
    ids = { "mine_shaft_middle", "mine_shaft_middle_east" },
    copy_from = "mine_shaft_middle",
    symbol = "M",
    color = "light_gray",
    name = ccb.content.text("mine shaft"),
}

content.patch_overmap_terrain {
    ids = { "mine_shaft_lower", "mine_shaft_lower_east" },
    copy_from = "mine_shaft_lower",
    symbol = "M",
    color = "light_gray",
    name = ccb.content.text("mine shaft"),
}

content.patch_overmap_terrain {
    ids = {
        "mine_spiral_west", "mine_spiral_central", "mine_spiral_east", "mine_spiral_-1_nw",
        "mine_spiral_-1_n", "mine_spiral_-1_ne", "mine_spiral_-1_sw", "mine_spiral_-1_s",
        "mine_spiral_-1_se", "mine_spiral_finale_nw", "mine_spiral_finale_n", "mine_spiral_finale_ne",
        "mine_spiral_finale_sw", "mine_spiral_finale_s", "mine_spiral_finale_se", "mine_amigara_west",
        "mine_amigara_central", "mine_amigara_east", "mine_amigara_-1_west", "mine_amigara_-1_central",
        "mine_amigara_-1_east", "mine_amigara_finale_west", "mine_amigara_finale_central",
        "mine_amigara_finale_east", "mine_wyrms_west", "mine_wyrms_central", "mine_wyrms_east",
        "mine_wyrms_finale",
    },
    copy_from = "mine_spiral_west",
    symbol = "M",
    color = "light_gray",
    name = ccb.content.text("mine tunnels"),
}

content.patch_overmap_terrain {
    ids = { "mine_finale" },
    copy_from = "mine_finale",
    symbol = "M",
    color = "light_gray",
    name = ccb.content.text("mine"),
}

content.patch_overmap_terrain {
    ids = {
        "steel_mill_0_1", "steel_mill_0_1_2", "steel_mill_0_1_3", "steel_mill_0_2", "steel_mill_0_2_2",
        "steel_mill_0_2_3", "steel_mill_0_3", "steel_mill_0_3_2", "steel_mill_0_3_3", "steel_mill_0_4",
        "steel_mill_0_4_2", "steel_mill_0_4_3", "steel_mill_1_1", "steel_mill_1_1_2", "steel_mill_1_1_3",
        "steel_mill_1_2", "steel_mill_1_2_2", "steel_mill_1_2_3", "steel_mill_1_3", "steel_mill_1_3_2",
        "steel_mill_1_3_3", "steel_mill_1_4", "steel_mill_1_4_2", "steel_mill_1_4_3", "steel_mill_2_1",
        "steel_mill_2_1_2", "steel_mill_2_1_3", "steel_mill_2_2", "steel_mill_2_2_2", "steel_mill_2_2_3",
        "steel_mill_2_3", "steel_mill_2_3_2", "steel_mill_2_3_3", "steel_mill_2_4", "steel_mill_2_4_2",
        "steel_mill_2_4_3", "steel_mill_3_1", "steel_mill_3_1_2", "steel_mill_3_1_3", "steel_mill_3_2",
        "steel_mill_3_2_2", "steel_mill_3_2_3", "steel_mill_3_3", "steel_mill_3_3_2", "steel_mill_3_3_3",
        "steel_mill_4_1", "steel_mill_4_1_2", "steel_mill_4_1_3", "steel_mill_4_2", "steel_mill_4_2_2",
        "steel_mill_4_2_3", "steel_mill_4_3", "steel_mill_4_3_2", "steel_mill_4_3_3",
    },
    copy_from = "steel_mill_0_1",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("steel mill"),
}

content.patch_overmap_terrain {
    ids = {
        "container_yard_inland_base_1", "container_yard_inland_base_2", "container_yard_inland_base_3",
        "container_yard_inland_base_4", "container_yard_inland_base_5", "container_yard_inland_base_6",
        "container_yard_inland_fence", "container_yard_inland_fence_front",
        "container_yard_inland_fence_entry", "container_yard_inland_fence_corner",
        "container_yard_inland_fence_corner_office", "container_yard_inland_fence_corner_garage",
    },
    copy_from = "container_yard_inland_base_1",
    symbol = "I",
    color = "light_gray",
    name = ccb.content.text("inland container depot"),
}

content.patch_overmap_terrain {
    ids = {
        "container_yard_inland_base_1a", "container_yard_inland_base_1b", "container_yard_inland_base_5a",
        "container_yard_inland_fence_corner_office_roof", "container_yard_inland_fence_corner_garage_roof",
        "container_yard_inland_base_1_bandit", "container_yard_inland_base_2_bandit",
        "container_yard_inland_base_3_bandit", "container_yard_inland_base_4_bandit",
        "container_yard_inland_base_5_bandit", "container_yard_inland_base_6_bandit",
        "container_yard_inland_fence_bandit", "container_yard_inland_fence_front_bandit",
        "container_yard_inland_fence_entry_bandit", "container_yard_inland_fence_corner_bandit",
        "container_yard_inland_fence_corner_office_bandit",
        "container_yard_inland_fence_corner_garage_bandit", "container_yard_inland_base_1a_bandit",
        "container_yard_inland_base_1b_bandit", "container_yard_inland_base_5a_bandit",
        "container_yard_inland_fence_corner_office_roof_bandit",
        "container_yard_inland_fence_corner_garage_roof_bandit",
    },
    copy_from = "container_yard_inland_base_1a",
    symbol = "I",
    color = "light_gray",
    name = ccb.content.text("inland container depot"),
}

content.patch_overmap_terrain {
    ids = { "s_lightindustry_00", "s_lightindustry_01", "s_lightindustry_10", "s_lightindustry_11" },
    copy_from = "s_lightindustry_00",
    symbol = "L",
    color = "light_gray",
    name = ccb.content.text("light industry"),
}

content.patch_overmap_terrain {
    ids = {
        "s_lightindustry_00_roof", "s_lightindustry_01_roof", "s_lightindustry_10_roof",
        "s_lightindustry_11_roof",
    },
    copy_from = "s_lightindustry_00_roof",
    symbol = "L",
    color = "light_gray",
    name = ccb.content.text("light industry roof"),
}

content.patch_overmap_terrain {
    ids = { "ruined_tower_highlands_basement" },
    copy_from = "ruined_tower_highlands_basement",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("ruined tower"),
}

content.patch_overmap_terrain {
    ids = { "ruined_tower_highlands_ground" },
    copy_from = "ruined_tower_highlands_ground",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("ruined tower"),
}

content.patch_overmap_terrain {
    ids = {
        "ruined_tower_highlands_z1", "ruined_tower_highlands_z2", "ruined_tower_highlands_z3",
        "ruined_tower_highlands_z4", "ruined_tower_highlands_z5",
    },
    copy_from = "ruined_tower_highlands_z1",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("ruined tower"),
}

content.patch_overmap_terrain {
    ids = { "fema_storage" },
    copy_from = "fema_storage",
    symbol = "F",
    color = "light_gray",
    name = ccb.content.text("FEMA camp storage"),
}

content.patch_overmap_terrain {
    ids = { "office_tower_ne", "office_tower_nw", "office_tower_sw", "office_tower_se" },
    copy_from = "office_tower_ne",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office building"),
}

content.patch_overmap_terrain {
    ids = {
        "office_tower_underground_nw", "office_tower_underground_ne", "office_tower_underground_sw",
        "office_tower_underground_se",
    },
    copy_from = "office_tower_underground_nw",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office building parking"),
}

content.patch_overmap_terrain {
    ids = {
        "office_tower_roof_nw", "office_tower_roof_ne", "office_tower_roof_sw", "office_tower_roof_se",
        "office_tower_roof_ne_roof", "office_tower_roof_se_roof",
    },
    copy_from = "office_tower_roof_nw",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office building roof"),
}

content.patch_overmap_terrain {
    ids = {
        "office_tower_2_a1", "office_tower_2_a2", "office_tower_2_b1", "office_tower_2_b2",
        "office_tower_2_b3", "office_tower_2_a1_1", "office_tower_2_a2_1", "office_tower_2_a3_1",
        "office_tower_2_b1_1", "office_tower_2_b2_1", "office_tower_2_b3_1", "office_tower_2_a1_2",
        "office_tower_2_a2_2", "office_tower_2_b1_2", "office_tower_2_b2_2", "office_tower_2_b3_2",
    },
    copy_from = "office_tower_2_a1",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office tower"),
}

content.patch_overmap_terrain {
    ids = {
        "office_tower_2_a1_roof", "office_tower_2_a2_roof", "office_tower_2_b1_roof",
        "office_tower_2_b2_roof", "office_tower_2_b3_roof",
    },
    copy_from = "office_tower_2_a1_roof",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office tower roof"),
}

content.patch_overmap_terrain {
    ids = { "office_tower_2_a3" },
    copy_from = "office_tower_2_a3",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office courtyard"),
}

content.patch_overmap_terrain {
    ids = {
        "office_tower_collapse_a0", "office_tower_collapse_a1", "office_tower_collapse_a2",
        "office_tower_collapse_b0", "office_tower_collapse_b1", "office_tower_collapse_b2",
        "office_tower_collapse_b_a0", "office_tower_collapse_b_a1", "office_tower_collapse_b_a2",
        "office_tower_collapse_b_b0", "office_tower_collapse_b_b1", "office_tower_collapse_b_b2",
    },
    copy_from = "office_tower_collapse_a0",
    symbol = "C",
    color = "light_gray",
    name = ccb.content.text("collapsed tower"),
}

content.patch_overmap_terrain {
    ids = {
        "loffice_tower_1", "loffice_tower_2", "loffice_tower_3", "loffice_tower_4", "loffice_tower_5",
        "loffice_tower_6", "loffice_tower_7", "loffice_tower_8", "loffice_tower_9", "loffice_tower_9b",
        "loffice_tower_10", "loffice_tower_10b", "loffice_tower_11", "loffice_tower_12", "loffice_tower_13",
        "loffice_tower_14", "loffice_tower_15", "loffice_tower_16",
    },
    copy_from = "loffice_tower_1",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office tower"),
}

content.patch_overmap_terrain {
    ids = {
        "office_skyscraper_1", "office_skyscraper_2", "office_skyscraper_3", "office_skyscraper_4",
        "office_skyscraper_5", "office_skyscraper_6", "office_skyscraper_7", "office_skyscraper_8",
        "office_skyscraper_apartments_111", "office_skyscraper_apartments_011",
        "office_skyscraper_apartments_101", "office_skyscraper_apartments_001",
        "office_skyscraper_apartments_112", "office_skyscraper_apartments_012",
        "office_skyscraper_apartments_102", "office_skyscraper_apartments_002", "office_skyscraper_9",
        "office_skyscraper_9b", "office_skyscraper_10", "office_skyscraper_10b", "office_skyscraper_11",
        "office_skyscraper_12", "office_skyscraper_13", "office_skyscraper_14", "office_skyscraper_15",
        "office_skyscraper_16",
    },
    copy_from = "office_skyscraper_1",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office skyscraper"),
}

content.patch_overmap_terrain {
    ids = { "office_cubical", "office_cubical_1", "small_office" },
    copy_from = "office_cubical",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office"),
}

content.patch_overmap_terrain {
    ids = { "office_cubical_roof", "office_cubical_roof_1", "small_office_roof", "small_office_upper_roof" },
    copy_from = "office_cubical_roof",
    symbol = "O",
    color = "light_gray",
    name = ccb.content.text("office roof"),
}

content.patch_overmap_terrain {
    ids = { "abstorefront", "abstorefront_1", "abstorefront_2" },
    copy_from = "abstorefront",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned storefront"),
}

content.patch_overmap_terrain {
    ids = { "abstorefront_roof", "abstorefront_roof_1", "abstorefront_roof_2" },
    copy_from = "abstorefront_roof",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned storefront roof"),
}

content.patch_overmap_terrain {
    ids = { "subway" },
    copy_from = "subway",
    color = "light_gray",
    name = ccb.content.text("subway"),
}

content.patch_overmap_terrain {
    ids = { "lab_subway" },
    copy_from = "lab_subway",
    color = "light_gray",
    name = ccb.content.text("subway"),
}

content.patch_overmap_terrain {
    ids = { "derelict_property" },
    copy_from = "derelict_property",
    symbol = "D",
    color = "light_gray",
    name = ccb.content.text("derelict property"),
}

content.patch_overmap_terrain {
    ids = { "derelict_property_roof" },
    copy_from = "derelict_property_roof",
    symbol = "D",
    color = "light_gray",
    name = ccb.content.text("derelict property roof"),
}

content.patch_overmap_terrain {
    ids = { "construction_site", "house_vacant", "house_vacant1", "house_vacant2", "house_vacant3" },
    copy_from = "construction_site",
    symbol = "C",
    color = "light_gray",
    name = ccb.content.text("construction site"),
}

content.patch_overmap_terrain {
    ids = { "emptyresidentiallot" },
    copy_from = "emptyresidentiallot",
    symbol = "E",
    color = "light_gray",
    name = ccb.content.text("empty residential lot"),
}

content.patch_overmap_terrain {
    ids = { "cs_city_dump_small" },
    copy_from = "cs_city_dump_small",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("small dump"),
}

content.patch_overmap_terrain {
    ids = { "trailer_public_00", "trailer_public_00_roof" },
    copy_from = "trailer_public_00",
    symbol = "G",
    color = "light_gray",
    name = ccb.content.text("garbage collection point"),
}

content.patch_overmap_terrain {
    ids = { "dumpsite", "dumpsite_edge" },
    copy_from = "dumpsite",
    symbol = "D",
    color = "light_gray",
    name = ccb.content.text("dumpsite"),
}

content.patch_overmap_terrain {
    ids = { "dump" },
    copy_from = "dump",
    symbol = "D",
    color = "light_gray",
    name = ccb.content.text("dump"),
}

content.patch_overmap_terrain {
    ids = { "landfill" },
    copy_from = "landfill",
    symbol = "L",
    color = "light_gray",
    name = ccb.content.text("landfill"),
}

content.patch_overmap_terrain {
    ids = {
        "s_shoppingplaza_a6", "s_shoppingplaza_b1", "s_shoppingplaza_b2", "s_shoppingplaza_b3",
        "s_shoppingplaza_b4", "s_shoppingplaza_b5", "s_shoppingplaza_b6",
    },
    copy_from = "s_shoppingplaza_a6",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned shopping plaza"),
}

content.patch_overmap_terrain {
    ids = {
        "s_shoppingplaza_A6", "s_shoppingplaza_B1", "s_shoppingplaza_B2", "s_shoppingplaza_B3",
        "s_shoppingplaza_B4", "s_shoppingplaza_B5", "s_shoppingplaza_B6",
    },
    copy_from = "s_shoppingplaza_A6",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned shopping plaza roof"),
}

content.patch_overmap_terrain {
    ids = {
        "abandonedwarehouse", "abandonedwarehouse_1", "abandonedwarehouse_2", "abandonedwarehouse_3",
        "abandonedwarehouse_4",
    },
    copy_from = "abandonedwarehouse",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned warehouse"),
}

content.patch_overmap_terrain {
    ids = { "office_warehouse_anduril" },
    copy_from = "office_warehouse_anduril",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("small warehouse"),
}

content.patch_overmap_terrain {
    ids = { "office_warehouse_anduril_roof" },
    copy_from = "office_warehouse_anduril_roof",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("small warehouse roof"),
}

content.patch_overmap_terrain {
    ids = {
        "abandonedwarehouse_roof", "abandonedwarehouse_1_roof", "abandonedwarehouse_2_roof",
        "abandonedwarehouse_3_roof", "abandonedwarehouse_4_roof",
    },
    copy_from = "generic_city_building_roof",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned warehouse roof"),
}

content.patch_overmap_terrain {
    ids = { "emptycommerciallot" },
    copy_from = "emptycommerciallot",
    symbol = "E",
    color = "light_gray",
    name = ccb.content.text("empty commercial lot"),
}

content.patch_overmap_terrain {
    ids = { "junkyard_1a", "junkyard_1b", "junkyard_2a", "junkyard_2b" },
    copy_from = "junkyard_1a",
    symbol = "J",
    color = "light_gray",
    name = ccb.content.text("junkyard"),
}

content.patch_overmap_terrain {
    ids = { "junkyard_roof_1a", "junkyard_roof_1b", "junkyard_roof_2a", "junkyard_roof_2b" },
    copy_from = "junkyard_roof_1a",
    symbol = "J",
    color = "light_gray",
    name = ccb.content.text("junkyard roof"),
}

content.patch_overmap_terrain {
    ids = {
        "ws_regional_dump_0_0", "ws_regional_dump_1_0", "ws_regional_dump_2_0", "ws_regional_dump_3_0",
        "ws_regional_dump_0_1", "ws_regional_dump_1_1", "ws_regional_dump_2_1", "ws_regional_dump_3_1",
        "ws_regional_dump_0_2", "ws_regional_dump_1_2", "ws_regional_dump_2_2", "ws_regional_dump_3_2",
        "ws_regional_dump_0_3", "ws_regional_dump_1_3", "ws_regional_dump_2_3", "ws_regional_dump_3_3",
        "ws_biker_dump_0_0", "ws_biker_dump_1_0", "ws_biker_dump_2_0", "ws_biker_dump_3_0",
        "ws_biker_dump_0_1", "ws_biker_dump_1_1", "ws_biker_dump_2_1", "ws_biker_dump_3_1",
        "ws_biker_dump_0_2", "ws_biker_dump_1_2", "ws_biker_dump_2_2", "ws_biker_dump_3_2",
        "ws_biker_dump_0_3", "ws_biker_dump_1_3", "ws_biker_dump_2_3", "ws_biker_dump_3_3",
    },
    copy_from = "ws_regional_dump_0_0",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("regional dump"),
}

content.patch_overmap_terrain {
    ids = { "ws_regional_dump_3_0_roof", "ws_biker_dump_3_0_roof", "ws_biker_dump_2_2_roof" },
    copy_from = "ws_regional_dump_3_0_roof",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("regional dump roof"),
}

content.patch_overmap_terrain {
    ids = { "recyclecenter", "recyclecenter_1", "recyclecenter_2" },
    copy_from = "recyclecenter",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("recycle center"),
}

content.patch_overmap_terrain {
    ids = { "recyclecenter_roof", "recyclecenter_roof_1", "recyclecenter_roof_2" },
    copy_from = "recyclecenter_roof",
    symbol = "R",
    color = "light_gray",
    name = ccb.content.text("recycle center roof"),
}

content.patch_overmap_terrain {
    ids = { "smallscrapyard" },
    copy_from = "smallscrapyard",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("small scrap yard"),
}

content.patch_overmap_terrain {
    ids = { "smallscrapyard_ocu" },
    copy_from = "smallscrapyard_ocu",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("small scrap yard"),
}

content.patch_overmap_terrain {
    ids = { "smallscrapyard_ocu_roof" },
    copy_from = "smallscrapyard_ocu_roof",
    symbol = "S",
    color = "light_gray",
    name = ccb.content.text("small scrap yard roof"),
}

content.patch_overmap_terrain {
    ids = { "unvitrified_farm_1", "unvitrified_farm_2", "unvitrified_farm_neg_1", "unvitrified_farm_0" },
    copy_from = "unvitrified_farm_1",
    symbol = "Q",
    color = "light_gray",
    name = ccb.content.text("quiet farmstead"),
}

content.patch_overmap_terrain {
    ids = { "unvitrified_orchard" },
    copy_from = "unvitrified_orchard",
    symbol = "Q",
    color = "light_gray",
    name = ccb.content.text("quiet orchard"),
}

content.patch_overmap_terrain {
    ids = {
        "abandoned_textile_mill_0_1", "abandoned_textile_mill_0_2", "abandoned_textile_mill_0_3",
        "abandoned_textile_mill_1_1", "abandoned_textile_mill_1_2", "abandoned_textile_mill_1_3",
        "abandoned_textile_mill_2_1", "abandoned_textile_mill_2_2", "abandoned_textile_mill_2_3",
        "abandoned_textile_mill_3_1", "abandoned_textile_mill_3_2", "abandoned_textile_mill_3_3",
        "abandoned_textile_mill_4_1", "abandoned_textile_mill_4_2", "abandoned_textile_mill_4_3",
        "abandoned_textile_mill_b_0_1", "abandoned_textile_mill_b_0_2", "abandoned_textile_mill_b_1_1",
        "abandoned_textile_mill_b_1_2",
    },
    copy_from = "abandoned_textile_mill_0_1",
    symbol = "A",
    color = "light_gray",
    name = ccb.content.text("abandoned textile mill"),
}

content.patch_overmap_terrain {
    ids = {
        "airliner_2a", "airliner_2a_1", "airliner_2b", "airliner_2b_1", "airliner_2b_-1", "airliner_2c",
        "airliner_2c_1", "airliner_2c_-1",
    },
    copy_from = "airliner_2a",
    symbol = "C",
    color = "light_gray",
    name = ccb.content.text("crashed airliner"),
}

content.patch_overmap_terrain {
    ids = { "airliner_1b", "airliner_3c" },
    copy_from = "airliner_1b",
    symbol = "W",
    color = "light_gray",
    name = ccb.content.text("wreckage"),
}

content.patch_overmap_terrain {
    ids = {
        "airliner_1c", "airliner_2d", "airliner_2e", "airliner_2f", "airliner_2g", "airliner_2h",
        "airliner_2i", "airliner_2j",
    },
    copy_from = "airliner_1c",
    symbol = "*",
    color = "light_gray",
    name = ccb.content.text("crash trail"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_track_1", "farm_horse_track_2" },
    copy_from = "farm_horse_track_1",
    symbol = "-",
    color = "light_gray",
    name = ccb.content.text("track"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_track_large_1" },
    copy_from = "farm_horse_track_large_1",
    symbol = "┌",
    color = "light_gray",
    name = ccb.content.text("track"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_track_large_2" },
    copy_from = "farm_horse_track_large_2",
    symbol = "┐",
    color = "light_gray",
    name = ccb.content.text("track"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_track_large_3" },
    copy_from = "farm_horse_track_large_3",
    symbol = "└",
    color = "light_gray",
    name = ccb.content.text("track"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_track_large_4" },
    copy_from = "farm_horse_track_large_4",
    symbol = "┘",
    color = "light_gray",
    name = ccb.content.text("track"),
}

content.patch_overmap_terrain {
    ids = { "billboard_0", "billboard_1", "billboard_2" },
    copy_from = "billboard_0",
    symbol = "B",
    color = "light_gray",
    name = ccb.content.text("billboard"),
}

content.patch_overmap_terrain {
    ids = { "house_prepper" },
    copy_from = "house_prepper",
    symbol = "^",
    color = "light_green",
    name = ccb.content.text("house"),
}

content.patch_overmap_terrain {
    ids = {
        "2storyModern01_basement", "2storyModern02_basement", "2StoryModern03_basement",
        "2StoryModern04_basement_1", "2StoryModern04_basement_2", "basement_bionic_decoy", "basement_chem",
        "basement_chem2", "basement_messed", "basement_meth", "basement_survival", "basement_weed",
        "multi_unit_basement", "garden_house_1_basement", "house_04_basement", "house_05_basement",
        "house_08_basement", "house_10_basement", "house_11_basement", "house_12_basement",
        "house_13_basement", "house_14_basement", "house_15_basement", "house_16_basement",
        "house_17_basement", "house_19_basement", "house_22_basement", "house_33_basement",
        "house_34_basement", "house_36_basement", "house_37_basement", "house_39_basement",
        "house_2story_basement", "house_crack3_basement", "house_detatched1_basement",
        "house_detatched2_basement", "house_detatched3_basement", "house_detatched4_basement",
        "house_detatched5_basement", "house_detatched6_basement", "house_detatched7_basement",
        "house_detatched8_basement", "house_detatched9_basement", "house_fence01_basement",
        "house_fence03_basement", "house_fence05_basement", "house_fortified_basement",
        "house_garage2_basement", "house_garage3_basement", "house_garage4_basement",
        "house_garage5_basement", "house_garage6_basement", "house_garage7_basement",
        "house_garage8_basement", "house_garage_basement", "house_gardener_basement",
        "house_modern_1_basement", "house_patio_basement", "house_porch_basement", "house_prepper2_basement",
        "house_prepper_basement", "house_rv_basement", "house_toolshed_basement", "house_w_1_basement",
        "house_w_2_basement", "house_w_3_basement", "house_w_4_basement", "house_w_5_basement",
        "house_w_6_basement", "rural_house2_basement",
    },
    copy_from = "generic_city_house_basement",
    symbol = "B",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "urban_13_1", "urban_13_2", "urban_1_1_basement", "urban_1_2_basement", "urban_2_1_basement",
        "urban_2_2_basement", "urban_3_1_basement", "urban_3_2_basement", "urban_4_1", "urban_4_2",
        "urban_5_1_basement", "urban_5_2_basement", "urban_6_1_basement", "urban_6_2_basement",
        "urban_7_1_basement", "urban_7_2_basement", "urban_29_1", "urban_29_2", "urban_10_7", "urban_10_8",
        "urban_18_1", "urban_18_2",
    },
    copy_from = "urban_13_1",
    symbol = "B",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "urban_29_3", "urban_29_4", "urban_8_1", "urban_8_2", "urban_9_1", "urban_9_2", "urban_10_1",
        "urban_10_2", "urban_11_1", "urban_11_2", "urban_12_1", "urban_12_2", "urban_20_1", "urban_20_2",
        "urban_15_1", "urban_15_2", "urban_16_1", "urban_16_2", "urban_17_1", "urban_17_2", "urban_18_3",
        "urban_18_4", "urban_22_1", "urban_22_2",
    },
    copy_from = "urban_29_3",
    symbol = "^",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = { "urban_22_1_roof", "urban_22_2_roof" },
    copy_from = "urban_22_1_roof",
    symbol = "^",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "urban_1_1", "urban_1_2", "urban_1_3", "urban_1_4", "urban_1_6", "urban_2_1", "urban_2_2",
        "urban_dd_1", "urban_dd_2", "urban_3_1", "urban_3_2", "urban_4_3", "urban_4_4", "urban_5_1",
        "urban_5_2", "urban_6_1", "urban_6_2", "urban_7_1", "urban_7_2",
    },
    copy_from = "urban_1_1",
    symbol = "^",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "urban_29_5", "urban_29_6", "urban_29_7", "urban_29_8", "urban_29_9", "urban_29_10", "urban_8_3",
        "urban_8_4", "urban_8_6", "urban_9_3", "urban_9_4", "urban_9_5", "urban_9_6", "urban_10_3",
        "urban_10_4", "urban_10_5", "urban_10_6", "urban_11_3", "urban_11_4", "urban_11_5", "urban_11_6",
        "urban_12_3", "urban_12_4", "urban_12_5", "urban_12_6", "urban_15_3", "urban_15_4", "urban_15_5",
        "urban_15_6", "urban_16_3", "urban_16_4", "urban_17_3", "urban_17_4", "urban_18_5", "urban_18_6",
        "urban_18_7", "urban_18_8", "urban_18_9", "urban_18_10",
    },
    copy_from = "urban_29_5",
    symbol = "^",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "urban_2_3", "urban_2_4", "urban_2_5", "urban_2_6", "urban_dd_3", "urban_dd_4", "urban_dd_5",
        "urban_dd_6", "urban_3_3", "urban_3_4", "urban_3_5", "urban_3_6", "urban_4_5", "urban_4_6",
        "urban_4_7", "urban_4_8", "urban_5_3", "urban_5_4", "urban_5_5", "urban_5_6", "urban_20_2ndfloor_1",
        "urban_20_2ndfloor_2", "urban_6_3", "urban_6_4", "urban_6_5", "urban_6_6", "urban_7_3", "urban_7_4",
        "urban_7_5", "urban_7_6",
    },
    copy_from = "urban_2_3",
    symbol = "^",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = { "urban_20_roof_1", "urban_20_roof_2" },
    copy_from = "urban_20_roof_1",
    symbol = "^",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = {
        "urban_13_3", "urban_13_4", "urban_13_5", "urban_13_6", "urban_13_7", "urban_13_8", "urban_13_9",
        "urban_13_10", "urban_13_11", "urban_13_12",
    },
    copy_from = "urban_13_3",
    symbol = "^",
    color = "light_green",
    name = ccb.content.text("dense urban"),
}

content.patch_overmap_terrain {
    ids = {
        "urban_25_3", "urban_25_4", "urban_25_5", "urban_25_6", "urban_25_7", "urban_25_8", "urban_25_9",
        "urban_25_10", "urban_25_12",
    },
    copy_from = "urban_25_3",
    symbol = "^",
    color = "light_green",
    name = ccb.content.text("urban city block"),
}

content.patch_overmap_terrain {
    ids = { "urban_14_1", "urban_14_2", "urban_25_1", "urban_25_2" },
    copy_from = "urban_14_1",
    symbol = "B",
    color = "light_green",
    name = ccb.content.text("urban city block - basement"),
}

content.patch_overmap_terrain {
    ids = {
        "urban_14_10", "urban_14_11", "urban_14_12", "urban_14_13", "urban_14_14", "urban_14_3",
        "urban_14_4", "urban_14_5", "urban_14_6", "urban_14_7", "urban_14_8", "urban_14_9",
    },
    copy_from = "urban_14_10",
    symbol = "^",
    color = "light_green",
    name = ccb.content.text("dense urban"),
}

content.patch_overmap_terrain {
    ids = { "house_fungus_01" },
    copy_from = "house_fungus_01",
    symbol = "S",
    color = "light_green",
    name = ccb.content.text("strange house"),
}

content.patch_overmap_terrain {
    ids = { "house_fungus_roof_01" },
    copy_from = "house_fungus_roof_01",
    symbol = "S",
    color = "light_green",
    name = ccb.content.text("strange house roof"),
}

content.patch_overmap_terrain {
    ids = {
        "apartments_con_tower_000", "apartments_con_tower_002", "apartments_con_tower_010",
        "apartments_con_tower_011", "apartments_con_tower_012", "apartments_con_tower_013",
        "apartments_con_tower_100", "apartments_con_tower_102", "apartments_con_tower_110",
        "apartments_con_tower_111", "apartments_con_tower_112", "apartments_con_tower_113",
        "apartments_mod_tower_000", "apartments_mod_tower_001", "apartments_mod_tower_010",
        "apartments_mod_tower_011", "apartments_mod_tower_012", "apartments_mod_tower_100",
        "apartments_mod_tower_101", "apartments_mod_tower_110", "apartments_mod_tower_111",
        "apartments_mod_tower_112",
    },
    copy_from = "apartments_con_tower_000",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment tower"),
}

content.patch_overmap_terrain {
    ids = { "s_apt", "s_apt_2ndfloor", "s_apt_2", "s_apt_2_2ndfloor" },
    copy_from = "s_apt",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment tower"),
}

content.patch_overmap_terrain {
    ids = {
        "apartments_con_tower_004", "apartments_con_tower_014", "apartments_con_tower_104",
        "apartments_con_tower_114", "apartments_con_tower_015", "apartments_con_tower_115",
        "apartments_mod_tower_003", "apartments_mod_tower_013", "apartments_mod_tower_103",
        "apartments_mod_tower_113", "apartments_mod_tower_shack_roof",
    },
    copy_from = "apartments_con_tower_004",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment tower roof"),
}

content.patch_overmap_terrain {
    ids = { "s_apt_roof", "s_apt_2_upper_roof", "s_apt_2_roof", "s_apt_upper_roof" },
    copy_from = "s_apt_roof",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment tower roof"),
}

content.patch_overmap_terrain {
    ids = {
        "apartment_complex_entrance", "apartment_complex_corner_ground",
        "apartment_complex_corner_inner_ground", "apartment_complex_straight_ground",
        "apartment_complex_straight_stairs_even_ground", "apartment_complex_center_stairs_even_ground",
        "apartment_complex_corner", "apartment_complex_corner_inner", "apartment_complex_straight",
        "apartment_complex_straight_stairs_even", "apartment_complex_straight_stairs_odd",
        "apartment_complex_center_stairs_even", "apartment_complex_center_stairs_odd",
    },
    copy_from = "apartment_complex_entrance",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment complex"),
}

content.patch_overmap_terrain {
    ids = {
        "apartment_complex_corner_roof", "apartment_complex_corner_inner_roof",
        "apartment_complex_straight_roof", "apartment_complex_straight_stairs_even_roof",
        "apartment_complex_straight_stairs_odd_roof", "apartment_complex_straight_stairs_roof_+1",
        "apartment_complex_center_stairs_even_roof", "apartment_complex_center_stairs_odd_roof",
        "apartment_complex_center_stairs_roof_+1",
    },
    copy_from = "apartment_complex_corner_roof",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment complex roof"),
}

content.patch_overmap_terrain {
    ids = { "apartment_complex_courtyard" },
    copy_from = "apartment_complex_courtyard",
    symbol = "A",
    color = "light_green",
    name = ccb.content.text("apartment complex - courtyard"),
}

-- Ripped the ground floor parking tiles out into light blue, these are empty air in actuality, should PR this
content.patch_overmap_terrain {
    ids = {
        "hotel_tower_flr2_1_4", "hotel_tower_flr3_1_4", "hotel_tower_flr4_1_4", "hotel_tower_roof_1_4",
        "hotel_tower_flr2_1_6", "hotel_tower_flr3_1_6", "hotel_tower_flr4_1_6", "hotel_tower_roof_1_6",
    },
    copy_from = "hotel_tower_flr2_1_4",
    symbol = ".",
    color = "blue",
    name = ccb.content.text("open air"),
}

content.patch_overmap_terrain {
    ids = {
        "hotel_tower_flr2_1_5", "hotel_tower_flr3_1_5", "hotel_tower_flr4_1_5", "hotel_tower_flr2_1_5B",
        "hotel_tower_flr2_1_5C", "hotel_tower_1_7", "hotel_tower_1_8", "hotel_tower_1_9",
        "hotel_tower_flr2_1_7", "hotel_tower_flr2_1_8", "hotel_tower_flr2_1_9", "hotel_tower_flr3_1_7",
        "hotel_tower_flr3_1_8", "hotel_tower_flr3_1_9", "hotel_tower_flr4_1_7", "hotel_tower_flr4_1_8",
        "hotel_tower_flr4_1_9", "hotel_tower_6_1_7", "hotel_tower_6_1_8", "hotel_tower_6_1_9",
    },
    copy_from = "hotel_tower_flr2_1_5",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("hotel"),
}

content.patch_overmap_terrain {
    ids = { "hotel_tower_roof_1_7", "hotel_tower_roof_1_8", "hotel_tower_roof_1_9" },
    copy_from = "hotel_tower_roof_1_7",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("hotel roof"),
}

content.patch_overmap_terrain {
    ids = { "hotel_tower_1_5", "hotel_tower_roof_1_5", "hotel_tower_1_5B", "hotel_tower_1_5C" },
    copy_from = "hotel_tower_1_5",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("hotel entrance"),
}

content.patch_overmap_terrain {
    ids = { "hotel_tower_b_1", "hotel_tower_b_2", "hotel_tower_b_3" },
    copy_from = "hotel_tower_b_1",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("hotel basement"),
}

content.patch_overmap_terrain {
    ids = { "motel_entrance" },
    copy_from = "motel_entrance",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("motel entrance"),
}

content.patch_overmap_terrain {
    ids = { "motel_1", "motel_2", "motel_3" },
    copy_from = "motel_1",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("motel"),
}

content.patch_overmap_terrain {
    ids = { "motel_twd_1", "motel_entrance_no_sidewalk" },
    copy_from = "motel_twd_1",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("motel"),
}

content.patch_overmap_terrain {
    ids = {
        "motel_twd_2", "motel_twd_1_f1", "motel_1_no_sidewalk", "motel_2_no_sidewalk", "motel_3_no_sidewalk",
        "2fmotel_entrance_f2", "2fmotel_1_f2", "2fmotel_2_f2", "2fmotel_3_f2",
    },
    copy_from = "motel_twd_2",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("motel"),
}

content.patch_overmap_terrain {
    ids = {
        "motel_twd_2_f1", "motel_twd_1_f2", "motel_entrance_roof", "motel_1_roof", "motel_2_roof",
        "motel_3_roof", "2fmotel_1_r", "2fmotel_2_r", "2fmotel_3_r",
    },
    copy_from = "motel_twd_2_f1",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("motel roof"),
}

content.patch_overmap_terrain {
    ids = { "mansion_e1", "mansion_boarded_e1", "mansion_e2" },
    copy_from = "mansion_e1",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("mansion"),
}

content.patch_overmap_terrain {
    ids = {
        "mansion_+1", "mansion_+1d", "mansion_+1u", "mansion_+2", "mansion_+2d", "mansion_+2u", "mansion_+3",
        "mansion_+3u", "mansion_+4", "mansion_+4d", "mansion_+4u", "mansion_boarded_c1", "mansion_c1",
        "mansion_c1d", "mansion_boarded_c1u", "mansion_c1u", "mansion_boarded_c2", "mansion_c2",
        "mansion_c2d", "mansion_boarded_c2u", "mansion_c2u", "mansion_boarded_c3", "mansion_c3",
        "mansion_c3d", "mansion_boarded_c3u", "mansion_c3u", "mansion_boarded_c4", "mansion_c4",
        "mansion_c4d", "mansion_boarded_c4u", "mansion_c4u", "mansion_c5", "mansion_c5d", "mansion_c5u",
        "mansion_e1d", "mansion_boarded_e1u", "mansion_e1u", "mansion_e2d", "mansion_e2u", "mansion_t1",
        "mansion_t1d", "mansion_t1u", "mansion_boarded_t2", "mansion_boarded_t2_start", "mansion_t2",
        "mansion_boarded_t2d", "mansion_boarded_t2d_start", "mansion_t2d", "mansion_boarded_t2u",
        "mansion_t2u", "mansion_boarded_t4", "mansion_t4", "mansion_t4d", "mansion_boarded_t4u",
        "mansion_t4u", "mansion_t5", "mansion_t5d", "mansion_t5u", "mansion_t6", "mansion_t6d",
        "mansion_t6u", "mansion_t7", "mansion_t7d", "mansion_t7u",
    },
    copy_from = "mansion_+1",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("mansion"),
}

content.patch_overmap_terrain {
    ids = {
        "mansion_+1_roof", "mansion_+2_roof", "mansion_+3_roof", "mansion_+4_roof", "mansion_c1_roof",
        "mansion_c2_roof", "mansion_c3_roof", "mansion_c4_roof", "mansion_c5_roof", "mansion_e1_roof",
        "mansion_e2_roof", "mansion_t1_roof", "mansion_t2_roof", "mansion_t4_roof", "mansion_t5_roof",
        "mansion_t6_roof", "mansion_t7_roof",
    },
    copy_from = "mansion_+1_roof",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("mansion roof"),
}

content.patch_overmap_terrain {
    ids = { "fema_housing" },
    copy_from = "fema_housing",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("FEMA camp housing"),
}

content.patch_overmap_terrain {
    ids = { "s_daycare" },
    copy_from = "s_daycare",
    symbol = "D",
    color = "light_green",
    name = ccb.content.text("daycare center"),
}

content.patch_overmap_terrain {
    ids = { "s_daycare_roof" },
    copy_from = "s_daycare_roof",
    symbol = "D",
    color = "light_green",
    name = ccb.content.text("daycare center roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_stills_3_basement", "ranch_camp_68_basement" },
    copy_from = "farm_stills_3_basement",
    symbol = "B",
    color = "light_green",
    name = ccb.content.text("basement"),
}

content.patch_overmap_terrain {
    ids = { "farm_isherwood_2_cellar" },
    copy_from = "farm_isherwood_2_cellar",
    symbol = "B",
    color = "light_green",
    name = ccb.content.text("basement"),
}

content.patch_overmap_terrain {
    ids = { "farm_2_roof", "farm_horse_house_1_roof" },
    copy_from = "farm_2_roof",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_isherwood_2_roof", "horse_farm_isherwood_13_roof" },
    copy_from = "farm_isherwood_2_roof",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_horse_house_1_2ndfloor", "farm_dairy_twd_second_floor_3", "farm_dairy_twd_second_floor_4" },
    copy_from = "farm_horse_house_1_2ndfloor",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house 2nd floor"),
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_13_2ndfloor" },
    copy_from = "horse_farm_isherwood_13_2ndfloor",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house 2nd floor"),
}

content.patch_overmap_terrain {
    ids = {
        "farm_2", "farm_horse_house_1", "2farm_11", "farm_stills_3", "farm_stills_3_2nd", "farm_dairy_twd_3",
        "farm_dairy_twd_4",
    },
    copy_from = "farm_2",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house"),
}

content.patch_overmap_terrain {
    ids = { "farm_stills_3_roof", "2farm_roof_11" },
    copy_from = "farm_stills_3_roof",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house roof"),
}

content.patch_overmap_terrain {
    ids = { "farm_dairy_twd_3_roof", "farm_dairy_twd_4_roof" },
    copy_from = "farm_dairy_twd_3_roof",
    symbol = "F",
    color = "light_green",
}

content.patch_overmap_terrain {
    ids = { "horse_farm_isherwood_13", "farm_isherwood_2" },
    copy_from = "horse_farm_isherwood_13",
    symbol = "F",
    color = "light_green",
    name = ccb.content.text("farm house"),
}

content.patch_overmap_terrain {
    ids = { "homeless_0_0_0", "homeless_1_0_0" },
    copy_from = "homeless_0_0_0",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("homeless shelter"),
}

content.patch_overmap_terrain {
    ids = { "homeless_0_0_1", "homeless_1_0_1", "homeless_0_0_2", "homeless_1_0_2", "homeless_0_0_4" },
    copy_from = "homeless_0_0_1",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("homeless shelter"),
}

content.patch_overmap_terrain {
    ids = { "homeless_0_0_roof", "homeless_1_0_roof" },
    copy_from = "homeless_0_0_roof",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("homeless shelter roof"),
}

content.patch_overmap_terrain {
    ids = {
        "nursing_home_sh1", "nursing_home_sh2", "nursing_home_sh3", "nursing_home_sh5", "nursing_home_sh6",
        "nursing_home_sh7",
    },
    copy_from = "nursing_home_sh1",
    symbol = "N",
    color = "light_green",
    name = ccb.content.text("nursing home"),
}

content.patch_overmap_terrain {
    ids = {
        "nursing_home_1", "nursing_home_2", "nursing_home_3", "nursing_home_5", "nursing_home_6",
        "nursing_home_7",
    },
    copy_from = "nursing_home_1",
    symbol = "N",
    color = "light_green",
    name = ccb.content.text("nursing home"),
}

content.patch_overmap_terrain {
    ids = {
        "nursing_home_1_roof", "nursing_home_2_roof", "nursing_home_3_roof", "nursing_home_4_roof",
        "nursing_home_5_roof", "nursing_home_6_roof",
    },
    copy_from = "nursing_home_1_roof",
    symbol = "N",
    color = "light_green",
    name = ccb.content.text("nursing home roof"),
}

content.patch_overmap_terrain {
    ids = {
        "nursing_home_b1", "nursing_home_b2", "nursing_home_b3", "nursing_home_b4", "nursing_home_b5",
        "nursing_home_b6", "nursing_home_b7", "nursing_home_b8", "nursing_home_b9", "nursing_home_b10",
        "nursing_home_b11", "nursing_home_b12",
    },
    copy_from = "nursing_home_b1",
    symbol = "N",
    color = "light_green",
    name = ccb.content.text("nursing home basement"),
}

content.patch_overmap_terrain {
    ids = {
        "nursing_home_bb1", "nursing_home_bb2", "nursing_home_bb3", "nursing_home_bb4", "nursing_home_bb5",
        "nursing_home_bb6", "nursing_home_bb7", "nursing_home_bb8", "nursing_home_bb9", "nursing_home_bb10",
        "nursing_home_bb11", "nursing_home_bb12",
    },
    copy_from = "nursing_home_bb1",
    symbol = "N",
    color = "light_green",
    name = ccb.content.text("nursing home basement"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_68" },
    copy_from = "ranch_camp_68",
    symbol = "R",
    color = "light_green",
    name = ccb.content.text("ranch"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_68_roof" },
    copy_from = "ranch_camp_68_roof",
    symbol = "R",
    color = "light_green",
    name = ccb.content.text("ranch roof"),
}

content.patch_overmap_terrain {
    ids = { "prefab" },
    copy_from = "prefab",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("mobile home"),
}

content.patch_overmap_terrain {
    ids = { "prefab_roof" },
    copy_from = "prefab_roof",
    symbol = "M",
    color = "light_green",
    name = ccb.content.text("mobile home roof"),
}

content.patch_overmap_terrain {
    ids = {
        "retirement_community_b_1", "retirement_community_b_2", "retirement_community_b_3",
        "retirement_community_b_4", "retirement_community_b_5", "retirement_community_b_6",
        "retirement_community_b_7", "retirement_community_b_15", "retirement_community_b_18",
        "retirement_community_b_19", "retirement_community_b_22", "retirement_community_b_23",
        "retirement_community_b_26",
    },
    copy_from = "retirement_community_b_1",
    symbol = "B",
    color = "light_green",
    name = ccb.content.text("basement"),
}

content.patch_overmap_terrain {
    ids = { "homelesscamp", "homelesscamp_npc" },
    copy_from = "homelesscamp",
    symbol = "H",
    color = "light_green",
    name = ccb.content.text("homeless camp"),
}

content.patch_overmap_terrain {
    ids = {
        "hospital_1", "hospital_2", "hospital_3", "hospital_4", "hospital_5", "hospital_6", "hospital_7",
        "hospital_8", "hospital_9", "urban_35_1", "urban_35_2", "urban_35_3", "urban_35_4", "urban_35_5",
        "urban_35_6", "urban_35_7", "urban_35_8", "urban_35_9", "urban_35_10", "urban_35_11", "urban_35_12",
        "urban_35_13", "urban_35_14", "urban_35_15", "urban_35_16", "urban_35_17", "urban_35_18",
        "urban_35_19", "urban_35_20", "urban_35_21", "urban_35_22", "urban_35_23", "urban_35_24",
        "urban_35_25", "urban_35_26", "urban_35_27", "urban_35_28", "urban_35_29", "urban_35_30",
        "urban_35_31", "urban_35_32", "urban_35_33", "urban_35_34", "urban_35_35",
    },
    copy_from = "hospital_1",
    symbol = "H",
    color = "light_red",
    name = ccb.content.text("hospital"),
}

content.patch_overmap_terrain {
    ids = {
        "hospital_1_roof", "hospital_2_roof", "hospital_3_roof", "hospital_4_roof", "hospital_5_roof",
        "hospital_6_roof", "hospital_7_roof", "hospital_8_roof", "hospital_9_roof",
    },
    copy_from = "hospital_1_roof",
    symbol = "H",
    color = "light_red",
    name = ccb.content.text("hospital roof"),
}

content.patch_overmap_terrain {
    ids = { "office_dentist" },
    copy_from = "office_dentist",
    symbol = "D",
    color = "light_red",
    name = ccb.content.text("dentist office"),
}

content.patch_overmap_terrain {
    ids = { "office_dentist_roof" },
    copy_from = "office_dentist_roof",
    symbol = "D",
    color = "light_red",
    name = ccb.content.text("dentist office roof"),
}

content.patch_overmap_terrain {
    ids = { "s_pharm", "s_pharm_1" },
    copy_from = "s_pharm",
    symbol = "P",
    color = "light_red",
    name = ccb.content.text("pharmacy"),
}

content.patch_overmap_terrain {
    ids = { "s_pharm_roof", "s_pharm_roof_1" },
    copy_from = "s_pharm_roof",
    symbol = "P",
    color = "light_red",
    name = ccb.content.text("pharmacy roof"),
}

content.patch_overmap_terrain {
    ids = { "office_doctor", "office_doctor_1", "office_doctor_2" },
    copy_from = "office_doctor",
    symbol = "D",
    color = "light_red",
    name = ccb.content.text("doctor's office"),
}

content.patch_overmap_terrain {
    ids = {
        "office_doctor_roof", "office_doctor_access_roof", "office_doctor_roof_1",
        "office_doctor_access_roof_1", "office_doctor_roof_2", "office_doctor_upper_roof_2",
    },
    copy_from = "office_doctor_roof",
    symbol = "D",
    color = "light_red",
    name = ccb.content.text("doctor's office roof"),
}

content.patch_overmap_terrain {
    ids = { "drug_lab", "bandit_drug_lab" },
    copy_from = "drug_lab",
    symbol = "D",
    color = "light_red",
    name = ccb.content.text("drug lab"),
}

content.patch_overmap_terrain {
    ids = { "drug_lab_roof" },
    copy_from = "drug_lab_roof",
    symbol = "D",
    color = "light_red",
    name = ccb.content.text("drug lab roof"),
}

content.patch_overmap_terrain {
    ids = { "veterinarian" },
    copy_from = "veterinarian",
    symbol = "A",
    color = "light_red",
    name = ccb.content.text("animal clinic"),
}

content.patch_overmap_terrain {
    ids = { "veterinarian_roof" },
    copy_from = "generic_city_building_roof",
    symbol = "A",
    color = "light_red",
    name = ccb.content.text("animal clinic roof"),
}

content.patch_overmap_terrain {
    ids = { "cs_market_small" },
    copy_from = "cs_market_small",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("market, small"),
}

content.patch_overmap_terrain {
    ids = {
        "farm_supply_1", "farm_supply_2", "farm_supply_3", "farm_supply_4", "farm_supply_looted_1",
        "farm_supply_looted_2", "farm_supply_looted_3", "farm_supply_looted_4",
    },
    copy_from = "farm_supply_1",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("farm supply store"),
}

content.patch_overmap_terrain {
    ids = { "farm_supply_roof_1", "farm_supply_roof_2", "farm_supply_roof_3", "farm_supply_roof_4" },
    copy_from = "farm_supply_roof_1",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("farm supply store"),
}

content.patch_overmap_terrain {
    ids = { "s_sports" },
    copy_from = "s_sports",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("sporting goods store"),
}

content.patch_overmap_terrain {
    ids = { "s_sports_roof" },
    copy_from = "s_sports_roof",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("sporting goods store roof"),
}

content.patch_overmap_terrain {
    ids = {
        "s_clothes", "s_clothes_1", "s_clothes_2", "s_clothes_3", "s_clothes_4", "s_clothes_5",
        "s_clothes_6",
    },
    copy_from = "s_clothes",
    symbol = "C",
    color = "magenta",
    name = ccb.content.text("clothing store"),
}

content.patch_overmap_terrain {
    ids = {
        "s_clothes_roof", "s_clothes_roof_1", "s_clothes_roof_2", "s_clothes_roof_3", "s_clothes_roof_4",
        "s_clothes_roof_5", "s_clothes_roof_6", "s_clothes_upper_roof_4",
    },
    copy_from = "s_clothes_roof",
    symbol = "C",
    color = "magenta",
    name = ccb.content.text("clothing store"),
}

content.patch_overmap_terrain {
    ids = { "s_fabricstore" },
    copy_from = "generic_city_building",
    symbol = "F",
    color = "magenta",
    name = ccb.content.text("fabric store"),
}

content.patch_overmap_terrain {
    ids = { "s_fabricstore_roof" },
    copy_from = "generic_city_building_roof",
    symbol = "F",
    color = "magenta",
    name = ccb.content.text("fabric store roof"),
}

content.patch_overmap_terrain {
    ids = { "pawn", "pawn_1", "pawn_pf", "pawn_pf_under" },
    copy_from = "pawn",
    symbol = "P",
    color = "magenta",
    name = ccb.content.text("pawn shop"),
}

content.patch_overmap_terrain {
    ids = { "pawn_roof", "pawn_roof_1", "pawn_pf_roof" },
    copy_from = "pawn_roof",
    symbol = "P",
    color = "magenta",
    name = ccb.content.text("pawn shop roof"),
}

content.patch_overmap_terrain {
    ids = { "cs_sex_shop" },
    copy_from = "cs_sex_shop",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("sex shop"),
}

content.patch_overmap_terrain {
    ids = { "cs_sex_shop_roof" },
    copy_from = "cs_sex_shop_roof",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("sex shop roof"),
}

content.patch_overmap_terrain {
    ids = { "s_camping" },
    copy_from = "s_camping",
    symbol = "O",
    color = "magenta",
    name = ccb.content.text("outdoorsman's store"),
}

content.patch_overmap_terrain {
    ids = { "s_camping_roof" },
    copy_from = "s_camping_roof",
    symbol = "O",
    color = "magenta",
    name = ccb.content.text("outdoorsman's store"),
}

content.patch_overmap_terrain {
    ids = { "s_hunting" },
    copy_from = "s_hunting",
    symbol = "H",
    color = "magenta",
    name = ccb.content.text("hunting supply store"),
}

content.patch_overmap_terrain {
    ids = { "s_hunting_roof" },
    copy_from = "s_hunting_roof",
    symbol = "H",
    color = "magenta",
    name = ccb.content.text("hunting supply store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_games" },
    copy_from = "s_games",
    symbol = "G",
    color = "magenta",
    name = ccb.content.text("gaming store"),
}

content.patch_overmap_terrain {
    ids = { "s_games_roof" },
    copy_from = "s_games_roof",
    symbol = "G",
    color = "magenta",
    name = ccb.content.text("gaming store roof"),
}

content.patch_overmap_terrain {
    ids = {
        "city_block2_1", "city_block2_2", "city_block2_3", "city_block2_4", "city_block2_flr2_1",
        "city_block2_flr2_2", "city_block2_flr2_3", "city_block2_flr2_4", "city_block2_roof_1",
        "city_block2_roof_2", "city_block2_roof_3", "city_block2_roof_4",
    },
    copy_from = "city_block2_1",
    symbol = "U",
    color = "magenta",
    name = ccb.content.text("urban city block"),
}

content.patch_overmap_terrain {
    ids = { "strip_mall_1", "strip_mall_2", "strip_mall_3", "strip_mall_4" },
    copy_from = "strip_mall_1",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("strip mall"),
}

content.patch_overmap_terrain {
    ids = { "strip_mall_roof_1", "strip_mall_roof_2", "strip_mall_roof_3", "strip_mall_roof_4" },
    copy_from = "strip_mall_roof_1",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("strip mall roof"),
}

content.patch_overmap_terrain {
    ids = {
        "robofac_strip_mall_x0y0", "robofac_strip_mall_x1y0", "robofac_strip_mall_x2y0",
        "robofac_strip_mall_x3y0",
    },
    copy_from = "robofac_strip_mall_x0y0",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("strip mall"),
}

content.patch_overmap_terrain {
    ids = {
        "robofac_strip_mall_roof_1", "robofac_strip_mall_roof_2", "robofac_strip_mall_roof_3",
        "robofac_strip_mall_roof_4",
    },
    copy_from = "robofac_strip_mall_roof_1",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("strip mall roof"),
}

content.patch_overmap_terrain {
    ids = { "craft_shop", "craft_shop_1", "craft_shop_2", "craft_shop_3" },
    copy_from = "craft_shop",
    symbol = "C",
    color = "magenta",
    name = ccb.content.text("craft shop"),
}

content.patch_overmap_terrain {
    ids = { "craft_shop_upper_roof" },
    copy_from = "craft_shop_upper_roof",
    symbol = "C",
    color = "magenta",
    name = ccb.content.text("craft shop upper roof"),
}

content.patch_overmap_terrain {
    ids = { "craft_shop_roof", "craft_shop_roof_1", "craft_shop_roof_2", "craft_shop_roof_3" },
    copy_from = "craft_shop_roof",
    symbol = "C",
    color = "magenta",
    name = ccb.content.text("craft shop roof"),
}

content.patch_overmap_terrain {
    ids = { "craft_shop_2ndfloor_2", "craft_shop_2ndfloor_3" },
    copy_from = "craft_shop_2ndfloor_2",
    symbol = "C",
    color = "magenta",
    name = ccb.content.text("craft shop 2nd floor"),
}

-- NOLINT(cata-text-style): not a period
content.patch_overmap_terrain {
    ids = { "mil_surplus", "mil_surplus_1", "mil_surplus_2" },
    copy_from = "mil_surplus",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mil. surplus"),
}

content.patch_overmap_terrain {
    ids = { "s_thrift" },
    copy_from = "s_thrift",
    symbol = "T",
    color = "magenta",
    name = ccb.content.text("thrift store"),
}

content.patch_overmap_terrain {
    ids = { "s_thrift_roof" },
    copy_from = "s_thrift_roof",
    symbol = "T",
    color = "magenta",
    name = ccb.content.text("thrift store roof"),
}

-- NOLINT(cata-text-style): not a period
content.patch_overmap_terrain {
    ids = { "mil_surplus_roof", "mil_surplus_roof_1", "mil_surplus_roof_2" },
    copy_from = "mil_surplus_roof",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mil. surplus roof"),
}

content.patch_overmap_terrain {
    ids = { "s_dive_shop" },
    copy_from = "s_dive_shop",
    symbol = "D",
    color = "magenta",
    name = ccb.content.text("dive shop"),
}

content.patch_overmap_terrain {
    ids = { "s_dive_shop_roof" },
    copy_from = "s_dive_shop_roof",
    symbol = "D",
    color = "magenta",
    name = ccb.content.text("dive shop roof"),
}

content.patch_overmap_terrain {
    ids = { "salon" },
    copy_from = "salon",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("salon"),
}

content.patch_overmap_terrain {
    ids = { "salon_roof" },
    copy_from = "salon_roof",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("salon roof"),
}

content.patch_overmap_terrain {
    ids = { "s_music" },
    copy_from = "s_music",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("music store"),
}

content.patch_overmap_terrain {
    ids = { "s_music_roof" },
    copy_from = "s_music_roof",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("music store roof"),
}

content.patch_overmap_terrain {
    ids = {
        "megastore_0_0_0", "megastore_1_0_0", "megastore_2_0_0", "megastore_0_1_0", "megastore_1_1_0",
        "megastore_2_1_0", "megastore_0_2_0", "megastore_2_2_0",
    },
    copy_from = "megastore_0_0_0",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("megastore"),
}

content.patch_overmap_terrain {
    ids = { "megastore_1_2_0" },
    copy_from = "megastore_1_2_0",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("megastore"),
}

content.patch_overmap_terrain {
    ids = {
        "megastore_0_0_1", "megastore_0_1_1", "megastore_0_2_1", "megastore_1_0_1", "megastore_1_1_1",
        "megastore_1_2_1", "megastore_2_0_1", "megastore_2_1_1", "megastore_2_2_1",
    },
    copy_from = "megastore_0_0_1",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("megastore, second floor"),
}

content.patch_overmap_terrain {
    ids = {
        "megastore_0_0_roof", "megastore_0_1_roof", "megastore_0_2_roof", "megastore_1_0_roof",
        "megastore_1_2_roof", "megastore_2_0_roof", "megastore_2_1_roof", "megastore_2_2_roof",
    },
    copy_from = "megastore_0_0_roof",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("megastore roof"),
}

content.patch_overmap_terrain {
    ids = { "megastore_1_1_roof" },
    copy_from = "megastore_1_1_roof",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("megastore roof"),
}

content.patch_overmap_terrain {
    ids = { "small_storage_units", "small_storage_units_1" },
    copy_from = "small_storage_units",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("small storage units"),
}

content.patch_overmap_terrain {
    ids = { "small_storage_units_roof", "small_storage_units_roof_1" },
    copy_from = "small_storage_units_roof",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("small storage units roof"),
}

content.patch_overmap_terrain {
    ids = { "s_jewelry" },
    copy_from = "s_jewelry",
    symbol = "J",
    color = "magenta",
    name = ccb.content.text("jewelry store"),
}

content.patch_overmap_terrain {
    ids = { "s_jewelry_roof" },
    copy_from = "s_jewelry_roof",
    symbol = "J",
    color = "magenta",
    name = ccb.content.text("jewelry store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_antique" },
    copy_from = "s_antique",
    symbol = "A",
    color = "magenta",
    name = ccb.content.text("antique store"),
}

content.patch_overmap_terrain {
    ids = { "s_antique_roof" },
    copy_from = "s_antique_roof",
    symbol = "A",
    color = "magenta",
    name = ccb.content.text("antique store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_gardening" },
    copy_from = "s_gardening",
    symbol = "G",
    color = "magenta",
    name = ccb.content.text("gardening supply"),
}

content.patch_overmap_terrain {
    ids = { "s_gardening_roof" },
    copy_from = "s_gardening_roof",
    symbol = "G",
    color = "magenta",
    name = ccb.content.text("gardening supply roof"),
}

content.patch_overmap_terrain {
    ids = { "furniture" },
    copy_from = "furniture",
    symbol = "F",
    color = "magenta",
    name = ccb.content.text("furniture store"),
}

content.patch_overmap_terrain {
    ids = { "furniture_roof", "furniture_upper_roof" },
    copy_from = "furniture_roof",
    symbol = "F",
    color = "magenta",
    name = ccb.content.text("furniture store roof"),
}

content.patch_overmap_terrain {
    ids = { "dispensary", "dispensary_1", "dispensary_2" },
    copy_from = "dispensary",
    symbol = "D",
    color = "magenta",
    name = ccb.content.text("dispensary"),
}

content.patch_overmap_terrain {
    ids = { "dispensary_roof", "dispensary_roof_1", "dispensary_roof_2" },
    copy_from = "dispensary_roof",
    symbol = "D",
    color = "magenta",
    name = ccb.content.text("dispensary roof"),
}

content.patch_overmap_terrain {
    ids = { "headshop" },
    copy_from = "headshop",
    symbol = "H",
    color = "magenta",
    name = ccb.content.text("head shop"),
}

content.patch_overmap_terrain {
    ids = { "headshop_roof", "headshop_upper_roof" },
    copy_from = "headshop_roof",
    symbol = "H",
    color = "magenta",
    name = ccb.content.text("head shop roof"),
}

content.patch_overmap_terrain {
    ids = { "dollarstore", "dollarstore_1" },
    copy_from = "dollarstore",
    symbol = "D",
    color = "magenta",
    name = ccb.content.text("dollar store"),
}

content.patch_overmap_terrain {
    ids = { "dollarstore_roof", "dollarstore_roof_1" },
    copy_from = "dollarstore_roof",
    symbol = "D",
    color = "magenta",
    name = ccb.content.text("dollar store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_petstore", "s_petstore_1", "s_petstore_2" },
    copy_from = "s_petstore",
    symbol = "P",
    color = "magenta",
    name = ccb.content.text("pet supply store"),
}

content.patch_overmap_terrain {
    ids = { "s_petstore_roof", "s_petstore_roof_1", "s_petstore_roof_2" },
    copy_from = "s_petstore_roof",
    symbol = "P",
    color = "magenta",
    name = ccb.content.text("pet supply store roof"),
}

content.patch_overmap_terrain {
    ids = {
        "large_storage_units_3", "large_storage_units_2", "large_storage_units_1", "medium_storage_units_1",
        "medium_storage_units_2",
    },
    copy_from = "large_storage_units_3",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("storage units"),
}

content.patch_overmap_terrain {
    ids = {
        "large_storage_units_roof_3", "large_storage_units_roof_2", "large_storage_units_roof_1",
        "medium_storage_units_roof_1", "medium_storage_units_roof_2",
    },
    copy_from = "large_storage_units_roof_3",
    symbol = "S",
    color = "magenta",
    name = ccb.content.text("storage units roof"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_3", "mall_b_3" },
    copy_from = "mall_a_3",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - loading bay"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_3_roof", "mall_upper_roof_3" },
    copy_from = "mall_a_3_roof",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - loading bay roof"),
}

content.patch_overmap_terrain {
    ids = { "mall_upper_roof_4" },
    copy_from = "mall_upper_roof_4",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - loading bay roof"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_4", "mall_b_4", "mall_a_5", "mall_b_5" },
    copy_from = "mall_a_4",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - utilities"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_4_roof", "mall_a_5_roof" },
    copy_from = "mall_a_4_roof",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - utilities roof"),
}

content.patch_overmap_terrain {
    ids = {
        "mall_a_14", "mall_a_14_roof", "mall_a_47", "mall_a_47_roof", "mall_a_53", "mall_a_53_roof",
        "mall_a_68", "mall_a_68_roof", "mall_b_14", "mall_b_47", "mall_b_53", "mall_b_68",
    },
    copy_from = "mall_a_14",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - entrance"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_29", "mall_b_29" },
    copy_from = "mall_a_29",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - food court"),
}

content.patch_overmap_terrain {
    ids = { "mall_a_20", "mall_b_20", "mall_a_20_roof", "mall_a_29_roof" },
    copy_from = "mall_a_20",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - food court roof"),
}

content.patch_overmap_terrain {
    ids = {
        "mall_a_11", "mall_a_11_roof", "mall_a_12", "mall_a_12_roof", "mall_a_13", "mall_a_13_roof",
        "mall_a_21", "mall_a_21_roof", "mall_a_22", "mall_a_22_roof", "mall_a_23", "mall_a_23_roof",
        "mall_a_24", "mall_a_24_roof", "mall_a_25", "mall_a_25_roof", "mall_a_26", "mall_a_26_roof",
        "mall_a_30", "mall_a_30_roof", "mall_a_31", "mall_a_31_roof", "mall_a_32", "mall_a_32_roof",
        "mall_a_33", "mall_a_33_roof", "mall_a_34", "mall_a_34_roof", "mall_a_35", "mall_a_35_roof",
        "mall_a_38", "mall_a_38_roof", "mall_a_39", "mall_a_39_roof", "mall_a_40", "mall_a_40_roof",
        "mall_a_41", "mall_a_41_roof", "mall_a_42", "mall_a_42_roof", "mall_a_43", "mall_a_43_roof",
        "mall_a_44", "mall_a_44_roof", "mall_a_48", "mall_a_48_roof", "mall_a_49", "mall_a_49_roof",
        "mall_a_50", "mall_a_50_roof", "mall_a_51", "mall_a_51_roof", "mall_a_52", "mall_a_52_roof",
        "mall_a_56", "mall_a_56_roof", "mall_a_57", "mall_a_57_roof", "mall_a_58", "mall_a_58_roof",
        "mall_a_59", "mall_a_59_roof", "mall_a_60", "mall_a_60_roof", "mall_a_61", "mall_a_61_roof",
        "mall_a_62", "mall_a_62_roof", "mall_a_65", "mall_a_65_roof", "mall_a_66", "mall_a_66_roof",
        "mall_a_67", "mall_a_67_roof", "mall_a_69", "mall_a_69_roof", "mall_a_70", "mall_a_70_roof",
        "mall_a_71", "mall_a_71_roof", "mall_b_11", "mall_b_12", "mall_b_13", "mall_b_21", "mall_b_22",
        "mall_b_23", "mall_b_24", "mall_b_25", "mall_b_26", "mall_b_30", "mall_b_31", "mall_b_32",
        "mall_b_33", "mall_b_34", "mall_b_35", "mall_b_38", "mall_b_39", "mall_b_40", "mall_b_41",
        "mall_b_42", "mall_b_43", "mall_b_44", "mall_b_48", "mall_b_49", "mall_b_50", "mall_b_51",
        "mall_b_52", "mall_b_56", "mall_b_57", "mall_b_58", "mall_b_59", "mall_b_60", "mall_b_61",
        "mall_b_62", "mall_b_65", "mall_b_66", "mall_b_67", "mall_b_69", "mall_b_70", "mall_b_71",
        "mall_upper_roof_12", "mall_upper_roof_13", "mall_upper_roof_34", "mall_upper_roof_35",
        "mall_upper_roof_48", "mall_upper_roof_49", "mall_upper_roof_50", "mall_upper_roof_51",
    },
    copy_from = "mall_a_11",
    symbol = "M",
    color = "magenta",
}

content.patch_overmap_terrain {
    ids = {
        "mall_a_58_basement", "mall_a_59_basement", "mall_a_60_basement", "mall_a_67_basement",
        "mall_a_68_basement", "mall_a_69_basement", "mall_a_67_sub_basement", "mall_a_68_sub_basement",
        "mall_a_69_sub_basement",
    },
    copy_from = "mall_a_58_basement",
    symbol = "M",
    color = "magenta",
    name = ccb.content.text("mall - subway station"),
}

content.patch_overmap_terrain {
    ids = { "inner_cabins_depths_entrance" },
    copy_from = "inner_cabins_depths_entrance",
    symbol = "C",
    color = "pink",
    name = ccb.content.text("cabin"),
}

content.patch_overmap_terrain {
    ids = { "shipwreck_river_1", "shipwreck_river_2", "shipwreck_river_3", "shipwreck_river_4" },
    copy_from = "shipwreck_river_1",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("shipwreck"),
}

content.patch_overmap_terrain {
    ids = {
        "irradiator_1_1", "irradiator_1_2", "irradiator_1_3", "irradiator_1_4", "irradiator_1_5",
        "irradiator_1_6", "irradiator_1_7", "irradiator_1_9",
    },
    copy_from = "irradiator_1_1",
    symbol = "I",
    color = "pink",
    name = ccb.content.text("irradiation plant"),
}

content.patch_overmap_terrain {
    ids = { "irradiator_1_8" },
    copy_from = "irradiator_1_8",
    symbol = "I",
    color = "pink",
    name = ccb.content.text("irradiation plant"),
}

content.patch_overmap_terrain {
    ids = {
        "irradiator_1_1_roof", "irradiator_1_2_roof", "irradiator_1_3_roof", "irradiator_1_4_roof",
        "irradiator_1_5_roof", "irradiator_1_6_roof", "irradiator_1_7_roof", "irradiator_1_9_roof",
    },
    copy_from = "irradiator_1_1_roof",
    symbol = "I",
    color = "pink",
    name = ccb.content.text("irradiation plant"),
}

content.patch_overmap_terrain {
    ids = { "irradiator_1_8_roof" },
    copy_from = "irradiator_1_8_roof",
    symbol = "I",
    color = "pink",
    name = ccb.content.text("irradiation plant"),
}

content.patch_overmap_terrain {
    ids = { "corpse_surface" },
    copy_from = "corpse_surface",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("monster corpse"),
}

content.patch_overmap_terrain {
    ids = { "corpse_tentacle_surface_entry" },
    copy_from = "corpse_tentacle_surface_entry",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("monster corpse"),
}

content.patch_overmap_terrain {
    ids = { "corpse_tentacle_entry" },
    copy_from = "corpse_bowels_empty_edge",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("monster corpse tentacle"),
}

content.patch_overmap_terrain {
    ids = {
        "corpse_bowels_neck_right", "corpse_bowels_neck_left", "corpse_bowels_neck_edge_center",
        "corpse_bowels_rcorner", "corpse_bowels_lcorner", "corpse_bowels_empty_edge",
    },
    copy_from = "corpse_bowels_neck_right",
    symbol = "B",
    color = "light_red",
    name = ccb.content.text("monster corpse bowels"),
}

content.patch_overmap_terrain {
    ids = { "corpse_bowels_mid" },
    copy_from = "corpse_bowels_mid",
    symbol = "B",
    color = "light_red",
    name = ccb.content.text("monster corpse bowels"),
}

content.patch_overmap_terrain {
    ids = { "corpse_bowels_tentacle_edge" },
    copy_from = "corpse_bowels_tentacle_edge",
    symbol = "E",
    color = "red",
    name = ccb.content.text("monster corpse bowels"),
}

content.patch_overmap_terrain {
    ids = { "corpse_neck", "corpse_neck_center" },
    copy_from = "corpse_neck",
    symbol = "N",
    color = "red",
    name = ccb.content.text("monster corpse neck"),
}

content.patch_overmap_terrain {
    ids = {
        "corpse_head", "corpse_brain", "corpse_under_brain", "corpse_head_edge", "corpse_head_fin",
        "corpse_head_lcorner", "corpse_head_rcorner", "corpse_head_neck_l", "corpse_head_neck_r",
        "corpse_head_neck_center", "corpse_head_neck_l_decap", "corpse_head_neck_r_decap",
        "corpse_head_neck_center_decap",
    },
    copy_from = "corpse_head",
    symbol = "H",
    color = "red",
    name = ccb.content.text("monster corpse head"),
}

content.patch_overmap_terrain {
    ids = {
        "sealab_small_surface", "sealab_small_-1", "sealab_small_-2", "sealab_small_-3", "sealab_small_-4",
        "sealab_small_-5",
    },
    copy_from = "sealab_small_surface",
    symbol = "F",
    color = "pink",
    name = ccb.content.text("freshwater research station"),
}

content.patch_overmap_terrain {
    ids = { "sealab_small_roof" },
    copy_from = "sealab_small_roof",
    symbol = "F",
    color = "pink",
    name = ccb.content.text("freshwater research station roof"),
}

content.patch_overmap_terrain {
    ids = {
        "robofachq_roof_a1", "robofachq_roof_a2", "robofachq_surface_entrance",
        "robofachq_surface_car_entrance", "robofachq_surface_a3", "robofachq_surface_b0",
        "robofachq_surface_b1", "robofachq_surface_b2", "robofachq_surface_b3", "robofachq_foyer1",
        "robofachq_foyer2", "robofachq_foyer4", "robofachq_exe_a0", "robofachq_exe_a1", "robofachq_exe_a2",
        "robofachq_exe_a3", "robofachq_exe_b0", "robofachq_exe_b1", "robofachq_exe_b2", "robofachq_exe_b3",
        "robofachq_hab_a0", "robofachq_hab_a1", "robofachq_hab_a2", "robofachq_hab_a3", "robofachq_hab_b0",
        "robofachq_hab_b1", "robofachq_hab_b2", "robofachq_hab_b3", "robofachq_sub_a0", "robofachq_sub_a1",
        "robofachq_sub_a2", "robofachq_sub_a3", "robofachq_res_a0", "robofachq_res_a1", "robofachq_res_a2",
        "robofachq_res_a3", "robofachq_res_b0", "robofachq_res_b1", "robofachq_res_b2", "robofachq_res_b3",
        "robofachq_ai_a0", "robofachq_ai_a1", "robofachq_ai_a2", "robofachq_ai_a3", "robofachq_ai_b0",
        "robofachq_ai_b1", "robofachq_ai_b2", "robofachq_ai_b3", "robofachq_aiutl_a0", "robofachq_aiutl_a1",
        "robofachq_aiutl_a2", "robofachq_aiutl_a3", "robofachq_aiutl_b0", "robofachq_aiutl_b1",
        "robofachq_aiutl_b2", "robofachq_aiutl_b3",
    },
    copy_from = "robofachq_roof_a1",
    symbol = "H",
    color = "pink",
    name = ccb.content.text("hub 01"),
}

content.patch_overmap_terrain {
    ids = {
        "dls_small_roof", "dls_small_surface", "dls_small_-1", "dls_small_-2", "dls_small_-3",
        "dls_small_-4", "dls_small_-5",
    },
    copy_from = "dls_small_roof",
    symbol = "L",
    color = "pink",
    name = ccb.content.text("limnological station"),
}

content.patch_overmap_terrain {
    ids = {
        "nursing_home_lab1", "nursing_home_lab2", "nursing_home_lab3", "nursing_home_lab4",
        "nursing_home_lab5", "nursing_home_lab6", "nursing_home_lab7", "nursing_home_lab8",
        "nursing_home_lab9", "nursing_home_lab10", "nursing_home_lab11", "nursing_home_lab12",
    },
    copy_from = "nursing_home_lab1",
    symbol = "N",
    color = "pink",
    name = ccb.content.text("nursing home lab"),
}

content.patch_overmap_terrain {
    ids = { "mi-go_camp1", "mi-go_camp1-1" },
    copy_from = "mi-go_camp1",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go encampment"),
}

content.patch_overmap_terrain {
    ids = { "mi-go_camp2" },
    copy_from = "mi-go_camp2",
    symbol = "M",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "mi-go_camp2-1" },
    copy_from = "mi-go_camp2-1",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go spire"),
}

content.patch_overmap_terrain {
    ids = { "mi-go_camp2-2" },
    copy_from = "mi-go_camp2-2",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go landing platform"),
}

content.patch_overmap_terrain {
    ids = { "mi-go_camp2-3" },
    copy_from = "mi-go_camp2-3",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go landing roof"),
}

content.patch_overmap_terrain {
    ids = {
        "barry_mi-go_scout_tower_1", "barry_mi-go_scout_tower_2", "barry_mi-go_scout_tower_3",
        "barry_mi-go_scout_tower_4", "mi-go_scout_tower_1", "mi-go_scout_tower_2", "mi-go_scout_tower_3",
        "mi-go_scout_tower_4",
    },
    copy_from = "barry_mi-go_scout_tower_1",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go scout tower"),
}

content.patch_overmap_terrain {
    ids = { "mi-go_portal" },
    copy_from = "mi-go_portal",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go structure"),
}

content.patch_overmap_terrain {
    ids = { "mi-go_portal_roof" },
    copy_from = "mi-go_portal_roof",
    symbol = "M",
    color = "pink",
    name = ccb.content.text("mi-go structure roof"),
}

content.patch_overmap_terrain {
    ids = {
        "temple_stairs", "temple_underground_1", "temple_underground_2", "temple_underground_3",
        "temple_underground_4",
    },
    copy_from = "temple_stairs",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("strange temple"),
}

content.patch_overmap_terrain {
    ids = { "temple_finale" },
    copy_from = "temple_finale",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("strange temple"),
}

content.patch_overmap_terrain {
    ids = { "toxic_dump", "toxic_dump_roof" },
    copy_from = "toxic_dump",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("toxic waste dump"),
}

content.patch_overmap_terrain {
    ids = {
        "haz_sar_1_1", "haz_sar_1_2", "haz_sar_1_3", "haz_sar_1_4", "haz_sar_1_1_2", "haz_sar_1_2_2",
        "haz_sar_1_3_2", "haz_sar_1_4_2", "haz_sar_b_1", "haz_sar_b_2", "haz_sar_b_3", "haz_sar_b_4",
    },
    copy_from = "haz_sar_1_1",
    symbol = "H",
    color = "pink",
    name = ccb.content.text("hazardous waste sarcophagus"),
}

content.patch_overmap_terrain {
    ids = { "c_cave_entrance" },
    copy_from = "c_cave_entrance",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("river cave entrance"),
}

content.patch_overmap_terrain {
    ids = {
        "hive_edge_00", "hive_edge_10", "hive_edge_20", "hive_edge_01", "hive", "hive_edge_21",
        "hive_edge_02", "hive_edge_12", "hive_edge_22", "hive_edge_00_roof", "hive_edge_10_roof",
        "hive_edge_20_roof", "hive_edge_01_roof", "hive_roof", "hive_edge_21_roof", "hive_edge_02_roof",
        "hive_edge_12_roof", "hive_edge_22_roof",
    },
    copy_from = "hive_edge_00",
    symbol = "B",
    color = "pink",
    name = ccb.content.text("bee hive"),
}

content.patch_overmap_terrain {
    ids = { "fungal_bloom" },
    copy_from = "fungal_bloom",
    symbol = "F",
    color = "pink",
    name = ccb.content.text("fungal bloom"),
}

content.patch_overmap_terrain {
    ids = { "fungal_tower" },
    copy_from = "fungal_tower",
    symbol = "F",
    color = "pink",
    name = ccb.content.text("fungal tower"),
}

content.patch_overmap_terrain {
    ids = { "fungal_flowers" },
    copy_from = "fungal_flowers",
    symbol = "F",
    color = "pink",
    name = ccb.content.text("fungal flowers"),
}

content.patch_overmap_terrain {
    ids = { "anthill" },
    copy_from = "anthill",
    symbol = "A",
    color = "pink",
    name = ccb.content.text("anthill"),
}

content.patch_overmap_terrain {
    ids = { "exo_safehouse_stone_0" },
    copy_from = "exo_safehouse_stone_0",
    symbol = "U",
    color = "pink",
    name = ccb.content.text("unusual stone barn"),
}

content.patch_overmap_terrain {
    ids = { "exo_safehouse_stone_1" },
    copy_from = "exo_safehouse_stone_1",
    symbol = "U",
    color = "pink",
    name = ccb.content.text("unusual stone barn"),
}

content.patch_overmap_terrain {
    ids = { "exo_safehouse_stone_2" },
    copy_from = "exo_safehouse_stone_2",
    symbol = "U",
    color = "pink",
    name = ccb.content.text("unusual stone barn roof"),
}

content.patch_overmap_terrain {
    ids = { "exo_warehouse_1" },
    copy_from = "exo_warehouse_1",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("strange warehouse"),
}

content.patch_overmap_terrain {
    ids = { "exo_warehouse_2" },
    copy_from = "exo_warehouse_2",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("strange warehouse"),
}

content.patch_overmap_terrain {
    ids = {
        "exodii_base_x0y0z0", "exodii_base_x1y0z0", "exodii_base_x2y0z0", "exodii_base_x3y0z0",
        "exodii_base_x0y1z0", "exodii_base_x1y1z0", "exodii_base_x2y1z0", "exodii_base_x3y1z0",
        "exodii_base_x0y2z0", "exodii_base_x1y2z0", "exodii_base_x2y2z0", "exodii_base_x3y2z0",
        "exodii_base_x1y3z0", "exodii_base_x2y3z0", "exodii_base_x3y3z0",
    },
    copy_from = "exodii_base_x0y0z0",
    symbol = "R",
    color = "pink",
    name = ccb.content.text("rocky butte"),
}

content.patch_overmap_terrain {
    ids = { "exodii_base_x0y3z0" },
    copy_from = "exodii_base_x0y3z0",
    symbol = "G",
    color = "pink",
    name = ccb.content.text("ground-level entrance"),
    vision_levels = "large_outcropping",
}

content.patch_overmap_terrain {
    ids = {
        "exodii_base_x0y0z1", "exodii_base_x1y0z1", "exodii_base_x2y0z1", "exodii_base_x3y0z1",
        "exodii_base_x0y1z1", "exodii_base_x1y1z1", "exodii_base_x2y1z1", "exodii_base_x3y1z1",
        "exodii_base_x0y2z1", "exodii_base_x1y2z1", "exodii_base_x2y2z1", "exodii_base_x3y2z1",
        "exodii_base_x0y3z1", "exodii_base_x1y3z1", "exodii_base_x2y3z1", "exodii_base_x3y3z1",
        "exodii_base_x0y0z2", "exodii_base_x1y0z2", "exodii_base_x2y0z2", "exodii_base_x3y0z2",
        "exodii_base_x0y1z2", "exodii_base_x1y1z2", "exodii_base_x2y1z2", "exodii_base_x3y1z2",
        "exodii_base_x0y2z2", "exodii_base_x1y2z2", "exodii_base_x2y2z2", "exodii_base_x3y2z2",
        "exodii_base_x0y3z2", "exodii_base_x1y3z2", "exodii_base_x2y3z2", "exodii_base_x3y3z2",
        "exodii_base_x0y0z3", "exodii_base_x1y0z3", "exodii_base_x2y0z3", "exodii_base_x3y0z3",
        "exodii_base_x0y1z3", "exodii_base_x1y1z3", "exodii_base_x2y1z3", "exodii_base_x3y1z3",
        "exodii_base_x0y2z3", "exodii_base_x1y2z3", "exodii_base_x2y2z3", "exodii_base_x3y2z3",
        "exodii_base_x0y3z3", "exodii_base_x1y3z3", "exodii_base_x2y3z3", "exodii_base_x3y3z3",
        "exodii_base_x0y0z4", "exodii_base_x1y0z4", "exodii_base_x2y0z4", "exodii_base_x3y0z4",
        "exodii_base_x0y1z4", "exodii_base_x1y1z4", "exodii_base_x2y1z4", "exodii_base_x3y1z4",
        "exodii_base_x0y2z4", "exodii_base_x1y2z4", "exodii_base_x2y2z4", "exodii_base_x3y2z4",
        "exodii_base_x0y3z4", "exodii_base_x1y3z4", "exodii_base_x2y3z4", "exodii_base_x3y3z4",
    },
    copy_from = "exodii_base_x0y0z1",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("scrap metal encampment"),
}

content.patch_overmap_terrain {
    ids = { "exo_base_safehouse_stone_0" },
    copy_from = "exo_base_safehouse_stone_0",
    symbol = "U",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "exo_base_safehouse_stone_1" },
    copy_from = "exo_base_safehouse_stone_1",
    symbol = "U",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "exo_base_safehouse_stone_2" },
    copy_from = "exo_base_safehouse_stone_2",
    symbol = "U",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "slimepit_z0" },
    copy_from = "slimepit_z0",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("slime pit"),
}

content.patch_overmap_terrain {
    ids = { "slimepit_z-1" },
    copy_from = "slimepit_z-1",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("slime pit"),
}

content.patch_overmap_terrain {
    ids = { "slimepit_z-2" },
    copy_from = "slimepit_z-2",
    symbol = "S",
    color = "pink",
    name = ccb.content.text("slime pit"),
}

content.patch_overmap_terrain {
    ids = { "triffid_grove" },
    copy_from = "triffid_grove",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("triffid grove"),
}

content.patch_overmap_terrain {
    ids = {
        "triffid_roots", "triffid_rootss", "triffid_rootsn", "triffid_rootse", "triffid_rootsw",
        "triffid_rootsen", "triffid_rootsnw", "triffid_rootssw", "triffid_rootsse",
    },
    copy_from = "triffid_roots",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("triffid roots"),
}

content.patch_overmap_terrain {
    ids = { "triffid_finale" },
    copy_from = "triffid_finale",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("triffid heart"),
}

content.patch_overmap_terrain {
    ids = { "triffid_grove_z3", "triffid_grove_z2" },
    copy_from = "triffid_grove_z3",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("triffid grove trunk"),
}

content.patch_overmap_terrain {
    ids = { "triffid_grove_roof" },
    copy_from = "triffid_grove_roof",
    symbol = "T",
    color = "pink",
    name = ccb.content.text("triffid grove roof"),
}

content.patch_overmap_terrain {
    ids = { "alien_meadow_core" },
    copy_from = "alien_meadow_core",
    symbol = ",",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "alien_meadow_join" },
    copy_from = "alien_meadow_join",
    symbol = ",",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "alien_meadow_end" },
    copy_from = "alien_meadow_end",
    symbol = ",",
    color = "pink",
}

content.patch_overmap_terrain {
    ids = { "s_gun_a" },
    copy_from = "s_gun_a",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gun store"),
}

content.patch_overmap_terrain {
    ids = { "s_gun_a_roof" },
    copy_from = "s_gun_a_roof",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gun store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_gun_b_range", "s_gun_b_store" },
    copy_from = "s_gun_b_range",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gun store"),
}

content.patch_overmap_terrain {
    ids = { "s_gun_b_roof", "s_gun_b_range_roof" },
    copy_from = "s_gun_b_roof",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gun store roof"),
}

content.patch_overmap_terrain {
    ids = { "police", "police_1", "police_2" },
    copy_from = "police",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police station"),
}

content.patch_overmap_terrain {
    ids = { "police_roof", "police_roof_1", "police_roof_2", "police_upper_roof_2" },
    copy_from = "police_roof",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police station roof"),
}

content.patch_overmap_terrain {
    ids = { "police_2ndfloor_1" },
    copy_from = "police_2ndfloor_1",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police station 2nd floor"),
}

content.patch_overmap_terrain {
    ids = {
        "police_dept_u000", "police_dept_u010", "police_dept_u100", "police_dept_u110", "police_dept_u001",
        "police_dept_u011", "police_dept_u101", "police_dept_u111", "police_dept_d000", "police_dept_d010",
        "police_dept_d100", "police_dept_d110", "police_dept_d001", "police_dept_d011", "police_dept_d101",
        "police_dept_d111",
    },
    copy_from = "police_dept_u000",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police department"),
}

content.patch_overmap_terrain {
    ids = {
        "police_dept_u002", "police_dept_u012", "police_dept_u102", "police_dept_u112", "police_dept_d002",
        "police_dept_d012", "police_dept_d102", "police_dept_d112",
    },
    copy_from = "police_dept_u002",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police department roof"),
}

content.patch_overmap_terrain {
    ids = { "police_dept_skyway", "police_dept_skyway_roof" },
    copy_from = "police_dept_skyway",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police department skybridge"),
}

content.patch_overmap_terrain {
    ids = { "police_dept_b00", "police_dept_b10", "police_dept_b01", "police_dept_b11" },
    copy_from = "police_dept_b00",
    symbol = "P",
    color = "red",
    name = ccb.content.text("police department garage"),
}

content.patch_overmap_terrain {
    ids = { "s_airsoft" },
    copy_from = "s_airsoft",
    symbol = "A",
    color = "red",
    name = ccb.content.text("airsoft store"),
}

content.patch_overmap_terrain {
    ids = { "s_airsoft_roof" },
    copy_from = "s_airsoft_roof",
    symbol = "A",
    color = "red",
    name = ccb.content.text("airsoft store roof"),
}

content.patch_overmap_terrain {
    ids = { "s_gas_b11" },
    copy_from = "s_gas_b11",
    symbol = "B",
    color = "red",
    name = ccb.content.text("bunker reception"),
}

content.patch_overmap_terrain {
    ids = { "s_gas_b20", "s_gas_b21" },
    copy_from = "s_gas_b20",
    symbol = "B",
    color = "red",
    name = ccb.content.text("bunker"),
}

content.patch_overmap_terrain {
    ids = {
        "aircraft_carrier_1a", "aircraft_carrier_1b", "aircraft_carrier_1c", "aircraft_carrier_2a",
        "aircraft_carrier_2b", "aircraft_carrier_2c", "aircraft_carrier_3a", "aircraft_carrier_3b",
        "aircraft_carrier_3c", "aircraft_carrier_4a", "aircraft_carrier_4b", "aircraft_carrier_4c",
        "aircraft_carrier_5a", "aircraft_carrier_5b", "aircraft_carrier_5c", "aircraft_carrier_6a",
        "aircraft_carrier_6b", "aircraft_carrier_6c", "aircraft_carrier_7a", "aircraft_carrier_7b",
        "aircraft_carrier_7c", "aircraft_carrier_8a", "aircraft_carrier_8b", "aircraft_carrier_8c",
        "aircraft_carrier_9a", "aircraft_carrier_9b", "aircraft_carrier_9c", "aircraft_carrier_10a",
        "aircraft_carrier_10b", "aircraft_carrier_10c", "aircraft_carrier_11a", "aircraft_carrier_11b",
        "aircraft_carrier_11c", "aircraft_carrier_12a", "aircraft_carrier_12b", "aircraft_carrier_12c",
        "aircraft_carrier_13a", "aircraft_carrier_13b", "aircraft_carrier_13c", "aircraft_carrier_1a_1",
        "aircraft_carrier_1b_1", "aircraft_carrier_1c_1", "aircraft_carrier_2a_1", "aircraft_carrier_2b_1",
        "aircraft_carrier_2c_1", "aircraft_carrier_3a_1", "aircraft_carrier_3b_1", "aircraft_carrier_3c_1",
        "aircraft_carrier_4a_1", "aircraft_carrier_4b_1", "aircraft_carrier_4c_1", "aircraft_carrier_5a_1",
        "aircraft_carrier_5b_1", "aircraft_carrier_5c_1", "aircraft_carrier_6a_1", "aircraft_carrier_6b_1",
        "aircraft_carrier_6c_1", "aircraft_carrier_7a_1", "aircraft_carrier_7b_1", "aircraft_carrier_7c_1",
        "aircraft_carrier_8a_1", "aircraft_carrier_8b_1", "aircraft_carrier_8c_1", "aircraft_carrier_9a_1",
        "aircraft_carrier_9b_1", "aircraft_carrier_9c_1", "aircraft_carrier_10a_1", "aircraft_carrier_10b_1",
        "aircraft_carrier_10c_1", "aircraft_carrier_11a_1", "aircraft_carrier_11b_1",
        "aircraft_carrier_11c_1", "aircraft_carrier_12a_1", "aircraft_carrier_12b_1",
        "aircraft_carrier_12c_1", "aircraft_carrier_13a_1", "aircraft_carrier_13b_1",
        "aircraft_carrier_13c_1", "aircraft_carrier_1a_2", "aircraft_carrier_1b_2", "aircraft_carrier_1c_2",
        "aircraft_carrier_2a_2", "aircraft_carrier_2b_2", "aircraft_carrier_2c_2", "aircraft_carrier_3a_2",
        "aircraft_carrier_3b_2", "aircraft_carrier_3c_2", "aircraft_carrier_4a_2", "aircraft_carrier_4b_2",
        "aircraft_carrier_4c_2", "aircraft_carrier_5a_2", "aircraft_carrier_5b_2", "aircraft_carrier_5c_2",
        "aircraft_carrier_6a_2", "aircraft_carrier_6b_2", "aircraft_carrier_6c_2", "aircraft_carrier_7a_2",
        "aircraft_carrier_7b_2", "aircraft_carrier_7c_2", "aircraft_carrier_8a_2", "aircraft_carrier_8b_2",
        "aircraft_carrier_8c_2", "aircraft_carrier_9a_2", "aircraft_carrier_9b_2", "aircraft_carrier_9c_2",
        "aircraft_carrier_10a_2", "aircraft_carrier_10b_2", "aircraft_carrier_10c_2",
        "aircraft_carrier_11a_2", "aircraft_carrier_11b_2", "aircraft_carrier_11c_2",
        "aircraft_carrier_12a_2", "aircraft_carrier_12b_2", "aircraft_carrier_12c_2",
        "aircraft_carrier_13a_2", "aircraft_carrier_13b_2", "aircraft_carrier_13c_2",
        "aircraft_carrier_1a_3", "aircraft_carrier_2a_3", "aircraft_carrier_1a_4", "aircraft_carrier_2a_4",
    },
    copy_from = "aircraft_carrier_1a",
    symbol = "A",
    color = "red",
    name = ccb.content.text("aircraft carrier"),
}

content.patch_overmap_terrain {
    ids = {
        "aircraft_carrier_1a_-1", "aircraft_carrier_1b_-1", "aircraft_carrier_1c_-1",
        "aircraft_carrier_2a_-1", "aircraft_carrier_2b_-1", "aircraft_carrier_2c_-1",
        "aircraft_carrier_3a_-1", "aircraft_carrier_3b_-1", "aircraft_carrier_3c_-1",
        "aircraft_carrier_4a_-1", "aircraft_carrier_4b_-1", "aircraft_carrier_4c_-1",
        "aircraft_carrier_5a_-1", "aircraft_carrier_5b_-1", "aircraft_carrier_5c_-1",
        "aircraft_carrier_6a_-1", "aircraft_carrier_6b_-1", "aircraft_carrier_6c_-1",
        "aircraft_carrier_7a_-1", "aircraft_carrier_7b_-1", "aircraft_carrier_7c_-1",
        "aircraft_carrier_8a_-1", "aircraft_carrier_8b_-1", "aircraft_carrier_8c_-1",
        "aircraft_carrier_9a_-1", "aircraft_carrier_9b_-1", "aircraft_carrier_9c_-1",
        "aircraft_carrier_10a_-1", "aircraft_carrier_10b_-1", "aircraft_carrier_10c_-1",
        "aircraft_carrier_11a_-1", "aircraft_carrier_11b_-1", "aircraft_carrier_11c_-1",
        "aircraft_carrier_12a_-1", "aircraft_carrier_12b_-1", "aircraft_carrier_12c_-1",
        "aircraft_carrier_13a_-1", "aircraft_carrier_13b_-1", "aircraft_carrier_13c_-1",
    },
    copy_from = "aircraft_carrier_1a_-1",
    symbol = "A",
    color = "red",
    name = ccb.content.text("aircraft carrier"),
}

content.patch_overmap_terrain {
    ids = { "fema_military_building" },
    copy_from = "fema_military_building",
    symbol = "F",
    color = "red",
    name = ccb.content.text("FEMA camp outpost"),
}

content.patch_overmap_terrain {
    ids = { "lmoe" },
    copy_from = "lmoe",
    symbol = "L",
    color = "red",
    name = ccb.content.text("LMOE shelter"),
}

content.patch_overmap_terrain {
    ids = { "lmoe_under" },
    copy_from = "lmoe_under",
    symbol = "L",
    color = "red",
    name = ccb.content.text("LMOE shelter"),
}

content.patch_overmap_terrain {
    ids = { "lmoe_under_empty_prepperquest" },
    copy_from = "lmoe_under_empty_prepperquest",
    symbol = "L",
    color = "red",
    name = ccb.content.text("LMOE shelter"),
}

content.patch_overmap_terrain {
    ids = { "cabin_prepper_shelter" },
    copy_from = "cabin_prepper_shelter",
    symbol = "L",
    color = "red",
    name = ccb.content.text("LMOE shelter"),
}

content.patch_overmap_terrain {
    ids = { "bunker" },
    copy_from = "bunker",
    symbol = "B",
    color = "red",
    name = ccb.content.text("military bunker"),
}

content.patch_overmap_terrain {
    ids = { "bunker_basement_1" },
    copy_from = "bunker_basement_1",
    symbol = "B",
    color = "red",
    name = ccb.content.text("military bunker"),
}

content.patch_overmap_terrain {
    ids = { "bunker_roof" },
    copy_from = "bunker_roof",
    symbol = "B",
    color = "red",
    name = ccb.content.text("military bunker"),
}

content.patch_overmap_terrain {
    ids = { "outpost", "outpost_parking" },
    copy_from = "outpost",
    symbol = "O",
    color = "red",
    name = ccb.content.text("military outpost"),
}

content.patch_overmap_terrain {
    ids = { "outpost_roof" },
    copy_from = "outpost_roof",
    symbol = "O",
    color = "red",
    name = ccb.content.text("military outpost roof"),
}

content.patch_overmap_terrain {
    ids = { "silo_roof", "silo", "silo_1", "silo_2", "silo_3", "silo_4", "silo_finale" },
    copy_from = "silo_roof",
    symbol = "M",
    color = "red",
    name = ccb.content.text("missile silo"),
}

content.patch_overmap_terrain {
    ids = {
        "deserter_city_gate", "deserter_city_park", "deserter_city_office_1f", "deserter_city_office_2f",
        "deserter_city_office_3f", "deserter_city_office_1fb", "deserter_city_office_2fb",
        "deserter_city_office_3fb",
    },
    copy_from = "deserter_city_gate",
    symbol = "D",
    color = "red",
    name = ccb.content.text("deserter outpost"),
}

content.patch_overmap_terrain {
    ids = { "deserter_city_office_roof", "deserter_city_office_roofb" },
    copy_from = "deserter_city_office_roof",
    symbol = "D",
    color = "red",
    name = ccb.content.text("deserter outpost roof"),
}

content.patch_overmap_terrain {
    ids = { "shootingrange_1a", "shootingrange_2a" },
    copy_from = "shootingrange_1a",
    symbol = "S",
    color = "red",
    name = ccb.content.text("shooting range"),
}

content.patch_overmap_terrain {
    ids = { "shootingrange_1a_roof" },
    copy_from = "shootingrange_1a",
    symbol = "S",
    color = "red",
    name = ccb.content.text("shooting range roof"),
}

content.patch_overmap_terrain {
    ids = { "isolated_house_farm_gunsmith", "isolated_house_farm_roof_gunsmith" },
    copy_from = "isolated_house_farm_gunsmith",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gunsmith's home"),
}

content.patch_overmap_terrain {
    ids = { "gunshow_0", "gunshow_1" },
    copy_from = "gunshow_0",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gun show"),
}

content.patch_overmap_terrain {
    ids = { "gunshow_0_roof", "gunshow_1_roof" },
    copy_from = "gunshow_0_roof",
    symbol = "G",
    color = "red",
    name = ccb.content.text("gun show roof"),
}

content.patch_overmap_terrain {
    ids = {
        "fort_1a", "fort_2a", "fort_3a", "fort_4a", "fort_1b", "fort_2b", "fort_3b", "fort_4b", "fort_1c",
        "fort_2c", "fort_3c", "fort_4c",
    },
    copy_from = "fort_1a",
    symbol = "B",
    color = "red",
    name = ccb.content.text("bastion fort"),
}

content.patch_overmap_terrain {
    ids = {
        "fort_1a_1", "fort_2a_1", "fort_3a_1", "fort_4a_1", "fort_1b_1", "fort_2b_1", "fort_3b_1",
        "fort_4b_1", "fort_1c_1", "fort_2c_1", "fort_3c_1", "fort_4c_1",
    },
    copy_from = "fort_1a_1",
    symbol = "B",
    color = "red",
    name = ccb.content.text("bastion fort"),
}

content.patch_overmap_terrain {
    ids = {
        "helipad_nw", "helipad_ne", "helipad_sw", "helipad_se", "helipad2f_nw", "helipad2f_ne",
        "helipad2f_sw", "helipad2f_se",
    },
    copy_from = "helipad_nw",
    symbol = "H",
    color = "red",
    name = ccb.content.text("military helipad"),
}

content.patch_overmap_terrain {
    ids = { "helipad_roof_nw", "helipad_roof_ne", "helipad_roof_sw", "helipad_roof_se" },
    copy_from = "helipad_roof_nw",
    symbol = "H",
    color = "red",
    name = ccb.content.text("military helipad roof"),
}

content.patch_overmap_terrain {
    ids = { "mil_base_7i" },
    copy_from = "helipad_nw",
    symbol = "H",
    color = "red",
    name = ccb.content.text("military helipad"),
}

content.patch_overmap_terrain {
    ids = {
        "mil_base_2d", "mil_base_2e", "mil_base_2f", "mil_base_2g", "mil_base_3d", "mil_base_3e",
        "mil_base_3f", "mil_base_3g", "mil_base_3h", "mil_base_5c", "mil_base_5d", "mil_base_5e",
        "mil_base_5g", "mil_base_5h", "mil_base_5i", "mil_base_6c", "mil_base_6d", "mil_base_6e",
        "mil_base_6i", "mil_base_7c", "mil_base_7d", "mil_base_7e", "mil_base_7f", "mil_base_8e",
    },
    copy_from = "mil_base_2d",
    symbol = "M",
    color = "red",
    name = ccb.content.text("military base"),
}

content.patch_overmap_terrain {
    ids = {
        "mil_base_2d1", "mil_base_2e1", "mil_base_2f1", "mil_base_2g1", "mil_base_3d1", "mil_base_3e1",
        "mil_base_3f1", "mil_base_3g1", "mil_base_3h1", "mil_base_5c1", "mil_base_5d1", "mil_base_5e1",
        "mil_base_5g1", "mil_base_5h1", "mil_base_5i1", "mil_base_6c1", "mil_base_6d1", "mil_base_6e1",
        "mil_base_6i1", "mil_base_7c1", "mil_base_7d1", "mil_base_7e1", "mil_base_7f1", "mil_base_8e1",
        "mil_base_1b2", "mil_base_2b2", "mil_base_3b2", "mil_base_4b2", "mil_base_5b2", "mil_base_6b2",
        "mil_base_7b2", "mil_base_8b2", "mil_base_1g2", "mil_base_2g2", "mil_base_3g2", "mil_base_8g2",
        "mil_base_1k2", "mil_base_2k2", "mil_base_3k2", "mil_base_4k2", "mil_base_8k2",
    },
    copy_from = "mil_base_2d1",
    symbol = "M",
    color = "red",
    name = ccb.content.text("military base roof"),
}

content.patch_overmap_terrain {
    ids = {
        "mil_base_tunnels_a", "mil_base_tunnels_b", "mil_base_tunnels_c", "mil_base_tunnels_d",
        "mil_base_tunnels_e", "mil_base_tunnels_f", "mil_base_tunnels_g", "mil_base_tunnels_h",
        "mil_base_tunnels_i",
    },
    copy_from = "mil_base_tunnels_a",
    symbol = "M",
    color = "red",
    name = ccb.content.text("military base tunnels"),
}

content.patch_overmap_terrain {
    ids = {
        "mil_base_1b", "mil_base_1g", "mil_base_1k", "mil_base_3b", "mil_base_4k", "mil_base_5b",
        "mil_base_8b", "mil_base_8g", "mil_base_8k", "mil_base_1b1", "mil_base_1g1", "mil_base_1k1",
        "mil_base_3b1", "mil_base_4k1", "mil_base_5b1", "mil_base_8b1", "mil_base_8g1", "mil_base_8k1",
    },
    copy_from = "mil_base_1b",
    symbol = "W",
    color = "red",
    name = ccb.content.text("military base watchtower"),
}

content.patch_overmap_terrain {
    ids = { "mil_base_3i", "mil_base_3i1", "mil_base_3i2", "mil_base_3i3", "mil_base_3i4" },
    copy_from = "mil_base_3i",
    symbol = "R",
    color = "red",
    name = ccb.content.text("military base radio tower"),
}

content.patch_overmap_terrain { ids = { "bridge" }, copy_from = "bridge", color = "white" }

content.patch_overmap_terrain {
    ids = { "forest_water" },
    copy_from = "forest_water",
    symbol = "#",
    color = "cyan",
    name = ccb.content.text("swamp"),
}

content.patch_overmap_terrain {
    ids = { "forest" },
    copy_from = "forest",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "forest_thick" },
    copy_from = "forest_thick",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "special_forest", "special_forest_isherwood" },
    copy_from = "special_forest",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "special_forest_thick", "special_forest_thick_isherwood" },
    copy_from = "special_forest_thick",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "island_forest", "island_forest_thick" },
    copy_from = "island_forest",
    symbol = "#",
    color = "green",
    name = ccb.content.text("island"),
}

content.patch_overmap_terrain {
    ids = { "island_forest_water" },
    copy_from = "island_forest_water",
    symbol = "#",
    color = "cyan",
    name = ccb.content.text("island"),
}

content.patch_overmap_terrain {
    ids = { "pond_field" },
    copy_from = "pond_field",
    symbol = "#",
    color = "blue",
    name = ccb.content.text("pond"),
}

content.patch_overmap_terrain {
    ids = { "crater" },
    copy_from = "crater",
    symbol = "*",
    color = "pink",
    name = ccb.content.text("crater"),
}

content.patch_overmap_terrain {
    ids = { "crater_core_large", "crater_core_small" },
    copy_from = "crater_core_large",
    symbol = "*",
    color = "red",
    name = ccb.content.text("crater"),
}

content.patch_overmap_terrain {
    ids = { "ws_giant_sinkhole_1" },
    copy_from = "ws_giant_sinkhole_1",
    symbol = "*",
    color = "brown",
    name = ccb.content.text("giant sinkhole"),
}

content.patch_overmap_terrain {
    ids = { "ws_giant_sinkhole_2" },
    copy_from = "ws_giant_sinkhole_2",
    symbol = "*",
    color = "brown",
    name = ccb.content.text("giant sinkhole base"),
}

content.patch_overmap_terrain {
    ids = { "river_center" },
    copy_from = "river_center",
    symbol = "~",
    color = "blue",
    name = ccb.content.text("river"),
    uniform_terrain = "t_water_moving_dp",
}

content.patch_overmap_terrain {
    ids = { "river" },
    copy_from = "river",
    symbol = "~",
    color = "light_blue",
    name = ccb.content.text("river bank"),
}

content.patch_overmap_terrain {
    ids = { "river_c_not_ne", "river_c_not_nw", "river_c_not_se", "river_c_not_sw" },
    copy_from = "river_c_not_ne",
    symbol = "~",
    color = "light_blue",
    name = ccb.content.text("river bank"),
}

content.patch_overmap_terrain {
    ids = { "river_ne", "river_nw", "river_se", "river_sw" },
    copy_from = "river_ne",
    symbol = "~",
    color = "light_blue",
    name = ccb.content.text("river bank"),
}

content.patch_overmap_terrain {
    ids = { "refctr_field" },
    copy_from = "refctr_field",
    symbol = ".",
    color = "brown",
    name = ccb.content.text("field"),
}

content.patch_overmap_terrain {
    ids = { "ranch_camp_17" },
    copy_from = "ranch_camp_17",
    symbol = "#",
    color = "blue",
    name = ccb.content.text("pond"),
}

content.patch_overmap_terrain {
    ids = { "inner_cabins_void_exit" },
    copy_from = "inner_cabins_void_exit",
    symbol = "#",
    color = "blue",
    name = ccb.content.text("retracting pond"),
}

content.patch_overmap_terrain {
    ids = { "hot_springs" },
    copy_from = "hot_springs",
    symbol = "H",
    color = "blue",
    name = ccb.content.text("hot spring"),
}

content.patch_overmap_terrain {
    ids = { "lumbermill_dforest" },
    copy_from = "lumbermill_dforest",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "dirtroad1_aban1" },
    copy_from = "dirtroad1_aban1",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "forest_aban1", "dirtroad2_aban1", "dirtplaza_aban1" },
    copy_from = "forest_aban1",
    symbol = "#",
    color = "green",
    name = ccb.content.text("forest"),
}

content.patch_overmap_terrain {
    ids = { "cabin_aban1" },
    copy_from = "cabin_aban1",
    symbol = "#",
    color = "green",
    name = ccb.content.text("ruined cabin"),
}

content.patch_overmap_terrain {
    ids = { "cabin_aban1_roof" },
    copy_from = "cabin_aban1_roof",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "barn_aban1" },
    copy_from = "barn_aban1",
    symbol = "#",
    color = "green",
    name = ccb.content.text("barn"),
}

content.patch_overmap_terrain {
    ids = { "barn_aban1_roof" },
    copy_from = "barn_aban1_roof",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "car_corner_aban1" },
    copy_from = "car_corner_aban1",
    symbol = "#",
    color = "green",
    name = ccb.content.text("car corner"),
}

content.patch_overmap_terrain {
    ids = { "car_corner_aban1_roof" },
    copy_from = "car_corner_aban1_roof",
    symbol = "#",
    color = "green",
}

content.patch_overmap_terrain {
    ids = { "church", "church_1" },
    copy_from = "generic_city_building",
    symbol = "C",
    color = "white",
    name = ccb.content.text("church"),
}

content.patch_overmap_terrain {
    ids = { "church_roof", "church_2ndfloor_1", "church_3rdfloor_1", "church_roof_1" },
    copy_from = "generic_city_building_roof",
    symbol = "C",
    color = "white",
    name = ccb.content.text("church roof"),
}

content.patch_overmap_terrain {
    ids = { "church_steeple", "church_steeple_end", "church_steeple_roof" },
    copy_from = "generic_city_building_roof",
    symbol = "C",
    color = "white",
    name = ccb.content.text("church steeple"),
}

content.patch_overmap_terrain {
    ids = { "synagogue" },
    copy_from = "synagogue",
    symbol = "S",
    color = "white",
    name = ccb.content.text("synagogue"),
}

content.patch_overmap_terrain {
    ids = { "synagogue_roof", "synagogue_upper_roof" },
    copy_from = "synagogue_roof",
    symbol = "S",
    color = "white",
    name = ccb.content.text("synagogue roof"),
}

content.patch_overmap_terrain {
    ids = {
        "cathedral_1_NW", "cathedral_1_NE", "cathedral_1_SW", "cathedral_1_SE", "cathedral_2_NW",
        "cathedral_2_NE", "cathedral_2_SW", "cathedral_2_SE", "cathedral_3_NW", "cathedral_3_NE",
        "cathedral_3_SW", "cathedral_3_SE",
    },
    copy_from = "cathedral_1_NW",
    symbol = "C",
    color = "white",
    name = ccb.content.text("cathedral"),
}

content.patch_overmap_terrain {
    ids = { "cathedral_b_NW", "cathedral_b_NE", "cathedral_b_SW", "cathedral_b_SE" },
    copy_from = "cathedral_b_NW",
    symbol = "C",
    color = "white",
    name = ccb.content.text("cathedral basement"),
}

content.patch_overmap_terrain {
    ids = {
        "cathedral_4_NW", "cathedral_4_NE", "cathedral_5_NW", "cathedral_5_NE", "cathedral_6_NW",
        "cathedral_6_NE", "cathedral_7_NW", "cathedral_7_NE",
    },
    copy_from = "cathedral_4_NW",
    symbol = "C",
    color = "white",
    name = ccb.content.text("cathedral tower"),
}

content.patch_overmap_terrain {
    ids = { "s_library", "s_library_1", "s_library_2", "s_library_3" },
    copy_from = "s_library",
    symbol = "L",
    color = "white",
    name = ccb.content.text("library"),
}

content.patch_overmap_terrain {
    ids = { "s_library_roof", "s_library_roof_1", "s_library_roof_2", "s_library_roof_3" },
    copy_from = "s_library_roof",
    symbol = "L",
    color = "white",
    name = ccb.content.text("library roof"),
}

content.patch_overmap_terrain {
    ids = {
        "urban_library_1", "urban_library_2", "urban_library_3", "urban_library_4", "urban_library_5",
        "urban_library_6", "urban_library_7", "urban_library_8",
    },
    copy_from = "s_library",
    symbol = "L",
    color = "white",
    name = ccb.content.text("library"),
}

content.patch_overmap_terrain {
    ids = { "urban_library_roof_1", "urban_library_roof_2", "urban_library_roof_3", "urban_library_roof_4" },
    copy_from = "s_library_roof",
    symbol = "L",
    color = "white",
    name = ccb.content.text("library roof"),
}

content.patch_overmap_terrain {
    ids = { "s_bookstore", "s_bookstore_1", "s_bookstore_2" },
    copy_from = "s_bookstore",
    symbol = "B",
    color = "white",
    name = ccb.content.text("bookstore"),
}

content.patch_overmap_terrain {
    ids = {
        "s_bookstore_roof", "s_bookstore_roof_1", "s_bookstore_roof_2", "s_bookstore_upper_roof",
        "s_bookstore_upper_roof_1",
    },
    copy_from = "s_bookstore_roof",
    symbol = "B",
    color = "white",
    name = ccb.content.text("bookstore roof"),
}

content.patch_overmap_terrain {
    ids = {
        "school_1_1", "school_1_3", "school_1_4", "school_1_5", "school_1_6", "school_1_7", "school_1_8",
        "school_1_9",
    },
    copy_from = "school_1_1",
    symbol = "S",
    color = "white",
    name = ccb.content.text("school"),
}

content.patch_overmap_terrain {
    ids = { "school_1_2" },
    copy_from = "school_1_2",
    symbol = "S",
    color = "white",
    name = ccb.content.text("school"),
}

content.patch_overmap_terrain {
    ids = {
        "school_2_1", "school_2_2", "school_2_4", "school_2_5", "school_2_6", "school_2_7", "school_2_8",
        "school_2_9", "school_3_1", "school_3_2", "school_3_4", "school_3_5", "school_3_6", "school_3_7",
        "school_3_8", "school_3_9", "school_4_1", "school_4_2", "school_4_4", "school_4_5", "school_4_6",
        "school_4_7", "school_4_8", "school_4_9", "school_5_6",
    },
    copy_from = "school_2_1",
    symbol = "S",
    color = "white",
    name = ccb.content.text("school"),
}

content.patch_overmap_terrain {
    ids = {
        "cemetery_4square_00", "cemetery_4square_10", "cemetery_4square_01", "cemetery_4square_11",
        "cemetery_4square_00_lacroix", "cemetery_4square_10_lacroix", "cemetery_4square_01_lacroix",
        "cemetery_4square_11_lacroix", "Cemetery_1a", "Cemetery_1b",
    },
    copy_from = "cemetery_4square_00",
    symbol = "C",
    color = "white",
    name = ccb.content.text("cemetery"),
}

content.patch_overmap_terrain {
    ids = { "cemetery_4square_11_roof", "Cemetery_1a_roof" },
    copy_from = "cemetery_4square_11_roof",
    symbol = "C",
    color = "white",
    name = ccb.content.text("cemetery roof"),
}

content.patch_overmap_terrain {
    ids = { "BotanicalGarden_1a", "BotanicalGarden_1b" },
    copy_from = "BotanicalGarden_1a",
    symbol = "B",
    color = "white",
    name = ccb.content.text("botanical garden"),
}

content.patch_overmap_terrain {
    ids = { "BotanicalGarden_1a_roof", "BotanicalGarden_1b_roof" },
    copy_from = "BotanicalGarden_1a_roof",
    symbol = "B",
    color = "white",
    name = ccb.content.text("botanical garden"),
}

content.patch_overmap_terrain {
    ids = { "NatureTrail_1a", "NatureTrail_1b" },
    copy_from = "NatureTrail_1a",
    symbol = "N",
    color = "white",
    name = ccb.content.text("nature trail"),
}

content.patch_overmap_terrain {
    ids = { "art_gallery" },
    copy_from = "art_gallery",
    symbol = "A",
    color = "white",
    name = ccb.content.text("art gallery"),
}

content.patch_overmap_terrain {
    ids = { "art_gallery_roof" },
    copy_from = "art_gallery_roof",
    symbol = "A",
    color = "white",
    name = ccb.content.text("art gallery roof"),
}

content.patch_overmap_terrain {
    ids = { "small_wooded_trail", "small_wooded_trail_2" },
    copy_from = "small_wooded_trail",
    symbol = "S",
    color = "white",
    name = ccb.content.text("small wooded trail"),
}

content.patch_overmap_terrain {
    ids = { "cs_public_space" },
    copy_from = "cs_public_space",
    symbol = "P",
    color = "white",
    name = ccb.content.text("public space"),
}

content.patch_overmap_terrain {
    ids = { "publicgarden", "publicgarden_2" },
    copy_from = "publicgarden",
    symbol = "P",
    color = "white",
    name = ccb.content.text("public garden"),
}

content.patch_overmap_terrain {
    ids = {
        "textile_mill_museum_0a0", "textile_mill_museum_0a1", "textile_mill_museum_0a2",
        "textile_mill_museum_0b0", "textile_mill_museum_0b1", "textile_mill_museum_0b2",
        "textile_mill_museum_1a0", "textile_mill_museum_1a1", "textile_mill_museum_1a2",
        "textile_mill_museum_1b0", "textile_mill_museum_1b1", "textile_mill_museum_1b2",
        "textile_mill_museum_2a0", "textile_mill_museum_2a1", "textile_mill_museum_2a2",
        "textile_mill_museum_2b0", "textile_mill_museum_2b1", "textile_mill_museum_2b2",
    },
    copy_from = "textile_mill_museum_0a0",
    symbol = "T",
    color = "white",
    name = ccb.content.text("textile mill museum"),
}

content.patch_overmap_terrain {
    ids = { "cs_gardening_allotment" },
    copy_from = "cs_gardening_allotment",
    symbol = "A",
    color = "white",
    name = ccb.content.text("gardening allotment"),
}

content.patch_overmap_terrain {
    ids = { "cs_gardening_allotment_roof" },
    copy_from = "cs_gardening_allotment_roof",
    symbol = "A",
    color = "white",
    name = ccb.content.text("gardening allotment roof"),
}

content.patch_overmap_terrain {
    ids = { "playground", "playground_roof", "playground_1" },
    copy_from = "playground",
    symbol = "P",
    color = "white",
    name = ccb.content.text("playground"),
}

content.patch_overmap_terrain {
    ids = {
        "park", "park_roof", "park_2", "park_3", "park_4", "park_5", "park_5_roof", "park_6", "park_7",
        "park_7_roof",
    },
    copy_from = "park",
    symbol = "P",
    color = "white",
    name = ccb.content.text("park"),
}

content.patch_overmap_terrain {
    ids = { "communitygarden", "communitygarden_2", "communitygarden_3" },
    copy_from = "communitygarden",
    symbol = "C",
    color = "white",
    name = ccb.content.text("community garden"),
}

content.patch_overmap_terrain {
    ids = { "park_maze", "park_maze_2" },
    copy_from = "park_maze",
    symbol = "H",
    color = "white",
    name = ccb.content.text("hedge maze"),
}

content.patch_overmap_terrain {
    ids = { "cs_private_park" },
    copy_from = "cs_private_park",
    symbol = "P",
    color = "white",
    name = ccb.content.text("private park"),
}

content.patch_overmap_terrain {
    ids = { "cs_private_park_roof" },
    copy_from = "cs_private_park_roof",
    symbol = "P",
    color = "white",
    name = ccb.content.text("private park roof"),
}

content.patch_overmap_terrain {
    ids = { "xedra_rural_church", "xedra_rural_church_parking" },
    copy_from = "xedra_rural_church",
    symbol = "R",
    color = "white",
    name = ccb.content.text("barricaded rural church"),
}

content.patch_overmap_terrain {
    ids = { "xedra_rural_church_steeple" },
    copy_from = "xedra_rural_church_steeple",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church steeple"),
}

content.patch_overmap_terrain {
    ids = { "xedra_rural_church_steeple_roof" },
    copy_from = "xedra_rural_church_steeple_roof",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church steeple roof"),
}

content.patch_overmap_terrain {
    ids = { "xedra_rural_church_basement" },
    copy_from = "xedra_rural_church_basement",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church basement"),
}

content.patch_overmap_terrain {
    ids = { "rural_church", "rural_church_parking" },
    copy_from = "rural_church",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church"),
}

content.patch_overmap_terrain {
    ids = { "rural_church_steeple" },
    copy_from = "rural_church_steeple",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church steeple"),
}

content.patch_overmap_terrain {
    ids = { "rural_church_steeple_roof" },
    copy_from = "rural_church_steeple_roof",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church steeple roof"),
}

content.patch_overmap_terrain {
    ids = { "rural_church_basement" },
    copy_from = "rural_church_basement",
    symbol = "R",
    color = "white",
    name = ccb.content.text("rural church basement"),
}

content.patch_overmap_terrain {
    ids = { "dog_park" },
    copy_from = "dog_park",
    symbol = "D",
    color = "white",
    name = ccb.content.text("dog park"),
}

content.patch_overmap_terrain {
    ids = { "cs_public_art_piece" },
    copy_from = "cs_public_art_piece",
    symbol = "P",
    color = "white",
    name = ccb.content.text("public art piece"),
}

content.patch_overmap_terrain {
    ids = { "cemetery_small" },
    copy_from = "cemetery_small",
    symbol = "S",
    color = "white",
    name = ccb.content.text("small cemetery"),
}

content.patch_overmap_terrain {
    ids = { "museum" },
    copy_from = "museum",
    symbol = "M",
    color = "white",
    name = ccb.content.text("museum"),
}

content.patch_overmap_terrain {
    ids = { "museum_roof" },
    copy_from = "museum_roof",
    symbol = "M",
    color = "white",
    name = ccb.content.text("museum roof"),
}

content.patch_overmap_terrain {
    ids = { "retirement_community_34", "retirement_community_35", "retirement_community_36" },
    copy_from = "retirement_community_34",
    symbol = "C",
    color = "white",
    name = ccb.content.text("community building"),
}

content.patch_overmap_terrain {
    ids = { "retirement_community_2f_34", "retirement_community_2f_35", "retirement_community_2f_36" },
    copy_from = "retirement_community_2f_34",
    symbol = "C",
    color = "white",
    name = ccb.content.text("community building roof"),
}

content.patch_overmap_terrain {
    ids = { "small_kindergarten" },
    copy_from = "small_kindergarten",
    symbol = "S",
    color = "white",
    name = ccb.content.text("small kindergarten"),
}

content.patch_overmap_terrain {
    ids = { "small_kindergarten_roof" },
    copy_from = "small_kindergarten_roof",
    symbol = "S",
    color = "white",
    name = ccb.content.text("small kindergarten roof"),
}

content.patch_overmap_terrain {
    ids = { "shelter_under", "shelter_under_unfinished" },
    copy_from = "shelter_under",
    symbol = "E",
    color = "yellow",
}

content.patch_overmap_terrain {
    ids = { "shelter_roof" },
    copy_from = "shelter_roof",
    symbol = "E",
    color = "yellow",
}

content.patch_overmap_terrain {
    ids = { "shelter", "shelter_unfinished" },
    copy_from = "shelter",
    symbol = "E",
    color = "yellow",
}

content.patch_overmap_terrain {
    ids = { "fema_entrance" },
    copy_from = "fema_entrance",
    symbol = "F",
    color = "yellow",
    name = ccb.content.text("FEMA camp entrance checkpoint"),
}

content.patch_overmap_terrain {
    ids = {
        "nuclear_plant_0_0_-1", "nuclear_plant_0_1_-1", "nuclear_plant_0_2_-1", "nuclear_plant_0_3_-1",
        "nuclear_plant_0_4_-1", "nuclear_plant_0_5_-1", "nuclear_plant_0_6_-1", "nuclear_plant_0_7_-1",
        "nuclear_plant_1_0_-1", "nuclear_plant_1_1_-1", "nuclear_plant_1_2_-1", "nuclear_plant_1_3_-1",
        "nuclear_plant_1_4_-1", "nuclear_plant_1_5_-1", "nuclear_plant_1_6_-1", "nuclear_plant_1_7_-1",
        "nuclear_plant_2_0_-1", "nuclear_plant_2_1_-1", "nuclear_plant_2_2_-1", "nuclear_plant_2_3_-1",
        "nuclear_plant_2_4_-1", "nuclear_plant_2_5_-1", "nuclear_plant_2_6_-1", "nuclear_plant_2_7_-1",
        "nuclear_plant_3_0_-1", "nuclear_plant_3_1_-1", "nuclear_plant_3_2_-1", "nuclear_plant_3_3_-1",
        "nuclear_plant_3_4_-1", "nuclear_plant_3_5_-1", "nuclear_plant_3_6_-1", "nuclear_plant_3_7_-1",
        "nuclear_plant_4_0_-1", "nuclear_plant_4_1_-1", "nuclear_plant_4_2_-1", "nuclear_plant_4_3_-1",
        "nuclear_plant_4_4_-1", "nuclear_plant_4_5_-1", "nuclear_plant_4_6_-1", "nuclear_plant_4_7_-1",
        "nuclear_plant_5_0_-1", "nuclear_plant_5_1_-1", "nuclear_plant_5_2_-1", "nuclear_plant_5_3_-1",
        "nuclear_plant_5_4_-1", "nuclear_plant_5_5_-1", "nuclear_plant_5_6_-1", "nuclear_plant_5_7_-1",
        "nuclear_plant_6_0_-1", "nuclear_plant_6_1_-1", "nuclear_plant_6_2_-1", "nuclear_plant_6_3_-1",
        "nuclear_plant_6_4_-1", "nuclear_plant_6_5_-1", "nuclear_plant_6_6_-1", "nuclear_plant_6_7_-1",
        "nuclear_plant_7_0_-1", "nuclear_plant_7_1_-1", "nuclear_plant_7_2_-1", "nuclear_plant_7_3_-1",
        "nuclear_plant_7_4_-1", "nuclear_plant_7_5_-1", "nuclear_plant_7_6_-1", "nuclear_plant_7_7_-1",
        "nuclear_plant_8_0_-1", "nuclear_plant_8_1_-1", "nuclear_plant_8_2_-1", "nuclear_plant_8_3_-1",
        "nuclear_plant_8_4_-1", "nuclear_plant_8_5_-1", "nuclear_plant_8_6_-1", "nuclear_plant_8_7_-1",
        "nuclear_plant_9_0_-1", "nuclear_plant_9_1_-1", "nuclear_plant_9_2_-1", "nuclear_plant_9_3_-1",
        "nuclear_plant_9_4_-1", "nuclear_plant_9_5_-1", "nuclear_plant_9_6_-1", "nuclear_plant_9_7_-1",
        "nuclear_plant_10_0_-1", "nuclear_plant_10_1_-1", "nuclear_plant_10_2_-1", "nuclear_plant_10_3_-1",
        "nuclear_plant_10_4_-1", "nuclear_plant_10_5_-1", "nuclear_plant_10_6_-1", "nuclear_plant_10_7_-1",
        "nuclear_plant_11_0_-1", "nuclear_plant_11_1_-1", "nuclear_plant_11_2_-1", "nuclear_plant_11_3_-1",
        "nuclear_plant_11_4_-1", "nuclear_plant_11_5_-1", "nuclear_plant_11_6_-1", "nuclear_plant_11_7_-1",
        "nuclear_plant_12_0_-1", "nuclear_plant_12_1_-1", "nuclear_plant_12_2_-1", "nuclear_plant_12_3_-1",
        "nuclear_plant_12_4_-1", "nuclear_plant_12_5_-1", "nuclear_plant_12_6_-1", "nuclear_plant_12_7_-1",
        "nuclear_plant_13_0_-1", "nuclear_plant_13_1_-1", "nuclear_plant_13_2_-1", "nuclear_plant_13_3_-1",
        "nuclear_plant_13_4_-1", "nuclear_plant_13_5_-1", "nuclear_plant_13_6_-1", "nuclear_plant_13_7_-1",
        "nuclear_plant_14_0_-1", "nuclear_plant_14_1_-1", "nuclear_plant_14_2_-1", "nuclear_plant_14_3_-1",
        "nuclear_plant_14_4_-1", "nuclear_plant_14_5_-1", "nuclear_plant_14_6_-1", "nuclear_plant_14_7_-1",
        "nuclear_plant_15_0_-1", "nuclear_plant_15_1_-1", "nuclear_plant_15_2_-1", "nuclear_plant_15_3_-1",
        "nuclear_plant_15_4_-1", "nuclear_plant_15_5_-1", "nuclear_plant_15_6_-1", "nuclear_plant_15_7_-1",
        "nuclear_plant_0_0_0", "nuclear_plant_0_1_0", "nuclear_plant_0_2_0", "nuclear_plant_0_3_0",
        "nuclear_plant_0_4_0", "nuclear_plant_0_5_0", "nuclear_plant_0_6_0", "nuclear_plant_0_7_0",
        "nuclear_plant_1_0_0", "nuclear_plant_1_1_0", "nuclear_plant_1_2_0", "nuclear_plant_1_3_0",
        "nuclear_plant_1_4_0", "nuclear_plant_1_5_0", "nuclear_plant_1_6_0", "nuclear_plant_1_7_0",
        "nuclear_plant_2_0_0", "nuclear_plant_2_1_0", "nuclear_plant_2_2_0", "nuclear_plant_2_3_0",
        "nuclear_plant_2_4_0", "nuclear_plant_2_5_0", "nuclear_plant_2_6_0", "nuclear_plant_2_7_0",
        "nuclear_plant_3_0_0", "nuclear_plant_3_1_0", "nuclear_plant_3_2_0", "nuclear_plant_3_3_0",
        "nuclear_plant_3_4_0", "nuclear_plant_3_5_0", "nuclear_plant_3_6_0", "nuclear_plant_3_7_0",
        "nuclear_plant_4_0_0", "nuclear_plant_4_1_0", "nuclear_plant_4_2_0", "nuclear_plant_4_3_0",
        "nuclear_plant_4_4_0", "nuclear_plant_4_5_0", "nuclear_plant_4_6_0", "nuclear_plant_4_7_0",
        "nuclear_plant_5_0_0", "nuclear_plant_5_1_0", "nuclear_plant_5_2_0", "nuclear_plant_5_3_0",
        "nuclear_plant_5_4_0", "nuclear_plant_5_5_0", "nuclear_plant_5_6_0", "nuclear_plant_5_7_0",
        "nuclear_plant_6_0_0", "nuclear_plant_6_1_0", "nuclear_plant_6_2_0", "nuclear_plant_6_3_0",
        "nuclear_plant_6_4_0", "nuclear_plant_6_5_0", "nuclear_plant_6_6_0", "nuclear_plant_6_7_0",
        "nuclear_plant_7_0_0", "nuclear_plant_7_1_0", "nuclear_plant_7_2_0", "nuclear_plant_7_3_0",
        "nuclear_plant_7_4_0", "nuclear_plant_7_5_0", "nuclear_plant_7_6_0", "nuclear_plant_7_7_0",
        "nuclear_plant_8_0_0", "nuclear_plant_8_1_0", "nuclear_plant_8_2_0", "nuclear_plant_8_3_0",
        "nuclear_plant_8_4_0", "nuclear_plant_8_5_0", "nuclear_plant_8_6_0", "nuclear_plant_8_7_0",
        "nuclear_plant_9_0_0", "nuclear_plant_9_1_0", "nuclear_plant_9_2_0", "nuclear_plant_9_3_0",
        "nuclear_plant_9_4_0", "nuclear_plant_9_5_0", "nuclear_plant_9_6_0", "nuclear_plant_9_7_0",
        "nuclear_plant_10_0_0", "nuclear_plant_10_1_0", "nuclear_plant_10_2_0", "nuclear_plant_10_3_0",
        "nuclear_plant_10_4_0", "nuclear_plant_10_5_0", "nuclear_plant_10_6_0", "nuclear_plant_10_7_0",
        "nuclear_plant_11_0_0", "nuclear_plant_11_1_0", "nuclear_plant_11_2_0", "nuclear_plant_11_3_0",
        "nuclear_plant_11_4_0", "nuclear_plant_11_5_0", "nuclear_plant_11_6_0", "nuclear_plant_11_7_0",
        "nuclear_plant_12_0_0", "nuclear_plant_12_1_0", "nuclear_plant_12_2_0", "nuclear_plant_12_3_0",
        "nuclear_plant_12_4_0", "nuclear_plant_12_5_0", "nuclear_plant_12_6_0", "nuclear_plant_12_7_0",
        "nuclear_plant_13_0_0", "nuclear_plant_13_1_0", "nuclear_plant_13_2_0", "nuclear_plant_13_3_0",
        "nuclear_plant_13_4_0", "nuclear_plant_13_5_0", "nuclear_plant_13_6_0", "nuclear_plant_13_7_0",
        "nuclear_plant_14_0_0", "nuclear_plant_14_1_0", "nuclear_plant_14_2_0", "nuclear_plant_14_3_0",
        "nuclear_plant_14_4_0", "nuclear_plant_14_5_0", "nuclear_plant_14_6_0", "nuclear_plant_14_7_0",
        "nuclear_plant_15_0_0", "nuclear_plant_15_1_0", "nuclear_plant_15_2_0", "nuclear_plant_15_3_0",
        "nuclear_plant_15_4_0", "nuclear_plant_15_5_0", "nuclear_plant_15_6_0", "nuclear_plant_15_7_0",
        "nuclear_plant_0_0_1", "nuclear_plant_0_1_1", "nuclear_plant_0_2_1", "nuclear_plant_0_3_1",
        "nuclear_plant_0_4_1", "nuclear_plant_0_5_1", "nuclear_plant_0_6_1", "nuclear_plant_0_7_1",
        "nuclear_plant_1_0_1", "nuclear_plant_1_1_1", "nuclear_plant_1_2_1", "nuclear_plant_1_3_1",
        "nuclear_plant_1_4_1", "nuclear_plant_1_5_1", "nuclear_plant_1_6_1", "nuclear_plant_1_7_1",
        "nuclear_plant_2_0_1", "nuclear_plant_2_1_1", "nuclear_plant_2_2_1", "nuclear_plant_2_3_1",
        "nuclear_plant_2_4_1", "nuclear_plant_2_5_1", "nuclear_plant_2_6_1", "nuclear_plant_2_7_1",
        "nuclear_plant_3_0_1", "nuclear_plant_3_1_1", "nuclear_plant_3_2_1", "nuclear_plant_3_3_1",
        "nuclear_plant_3_4_1", "nuclear_plant_3_5_1", "nuclear_plant_3_6_1", "nuclear_plant_3_7_1",
        "nuclear_plant_4_0_1", "nuclear_plant_4_1_1", "nuclear_plant_4_2_1", "nuclear_plant_4_3_1",
        "nuclear_plant_4_4_1", "nuclear_plant_4_5_1", "nuclear_plant_4_6_1", "nuclear_plant_4_7_1",
        "nuclear_plant_5_0_1", "nuclear_plant_5_1_1", "nuclear_plant_5_2_1", "nuclear_plant_5_3_1",
        "nuclear_plant_5_4_1", "nuclear_plant_5_5_1", "nuclear_plant_5_6_1", "nuclear_plant_5_7_1",
        "nuclear_plant_6_0_1", "nuclear_plant_6_1_1", "nuclear_plant_6_2_1", "nuclear_plant_6_3_1",
        "nuclear_plant_6_4_1", "nuclear_plant_6_5_1", "nuclear_plant_6_6_1", "nuclear_plant_6_7_1",
        "nuclear_plant_7_0_1", "nuclear_plant_7_1_1", "nuclear_plant_7_2_1", "nuclear_plant_7_3_1",
        "nuclear_plant_7_4_1", "nuclear_plant_7_5_1", "nuclear_plant_7_6_1", "nuclear_plant_7_7_1",
        "nuclear_plant_8_0_1", "nuclear_plant_8_1_1", "nuclear_plant_8_2_1", "nuclear_plant_8_3_1",
        "nuclear_plant_8_4_1", "nuclear_plant_8_5_1", "nuclear_plant_8_6_1", "nuclear_plant_8_7_1",
        "nuclear_plant_9_0_1", "nuclear_plant_9_1_1", "nuclear_plant_9_2_1", "nuclear_plant_9_3_1",
        "nuclear_plant_9_4_1", "nuclear_plant_9_5_1", "nuclear_plant_9_6_1", "nuclear_plant_9_7_1",
        "nuclear_plant_10_0_1", "nuclear_plant_10_1_1", "nuclear_plant_10_2_1", "nuclear_plant_10_3_1",
        "nuclear_plant_10_4_1", "nuclear_plant_10_5_1", "nuclear_plant_10_6_1", "nuclear_plant_10_7_1",
        "nuclear_plant_11_0_1", "nuclear_plant_11_1_1", "nuclear_plant_11_2_1", "nuclear_plant_11_3_1",
        "nuclear_plant_11_4_1", "nuclear_plant_11_5_1", "nuclear_plant_11_6_1", "nuclear_plant_11_7_1",
        "nuclear_plant_12_0_1", "nuclear_plant_12_1_1", "nuclear_plant_12_2_1", "nuclear_plant_12_3_1",
        "nuclear_plant_12_4_1", "nuclear_plant_12_5_1", "nuclear_plant_12_6_1", "nuclear_plant_12_7_1",
        "nuclear_plant_13_0_1", "nuclear_plant_13_1_1", "nuclear_plant_13_2_1", "nuclear_plant_13_3_1",
        "nuclear_plant_13_4_1", "nuclear_plant_13_5_1", "nuclear_plant_13_6_1", "nuclear_plant_13_7_1",
        "nuclear_plant_14_0_1", "nuclear_plant_14_1_1", "nuclear_plant_14_2_1", "nuclear_plant_14_3_1",
        "nuclear_plant_14_4_1", "nuclear_plant_14_5_1", "nuclear_plant_14_6_1", "nuclear_plant_14_7_1",
        "nuclear_plant_15_0_1", "nuclear_plant_15_1_1", "nuclear_plant_15_2_1", "nuclear_plant_15_3_1",
        "nuclear_plant_15_4_1", "nuclear_plant_15_5_1", "nuclear_plant_15_6_1", "nuclear_plant_15_7_1",
        "nuclear_plant_0_0_2", "nuclear_plant_0_1_2", "nuclear_plant_0_2_2", "nuclear_plant_0_3_2",
        "nuclear_plant_0_4_2", "nuclear_plant_0_5_2", "nuclear_plant_0_6_2", "nuclear_plant_0_7_2",
        "nuclear_plant_1_0_2", "nuclear_plant_1_1_2", "nuclear_plant_1_2_2", "nuclear_plant_1_3_2",
        "nuclear_plant_1_4_2", "nuclear_plant_1_5_2", "nuclear_plant_1_6_2", "nuclear_plant_1_7_2",
        "nuclear_plant_2_0_2", "nuclear_plant_2_1_2", "nuclear_plant_2_2_2", "nuclear_plant_2_3_2",
        "nuclear_plant_2_4_2", "nuclear_plant_2_5_2", "nuclear_plant_2_6_2", "nuclear_plant_2_7_2",
        "nuclear_plant_3_0_2", "nuclear_plant_3_1_2", "nuclear_plant_3_2_2", "nuclear_plant_3_3_2",
        "nuclear_plant_3_4_2", "nuclear_plant_3_5_2", "nuclear_plant_3_6_2", "nuclear_plant_3_7_2",
        "nuclear_plant_4_0_2", "nuclear_plant_4_1_2", "nuclear_plant_4_2_2", "nuclear_plant_4_3_2",
        "nuclear_plant_4_4_2", "nuclear_plant_4_5_2", "nuclear_plant_4_6_2", "nuclear_plant_4_7_2",
        "nuclear_plant_5_0_2", "nuclear_plant_5_1_2", "nuclear_plant_5_2_2", "nuclear_plant_5_3_2",
        "nuclear_plant_5_4_2", "nuclear_plant_5_5_2", "nuclear_plant_5_6_2", "nuclear_plant_5_7_2",
        "nuclear_plant_6_0_2", "nuclear_plant_6_1_2", "nuclear_plant_6_2_2", "nuclear_plant_6_3_2",
        "nuclear_plant_6_4_2", "nuclear_plant_6_5_2", "nuclear_plant_6_6_2", "nuclear_plant_6_7_2",
        "nuclear_plant_7_0_2", "nuclear_plant_7_1_2", "nuclear_plant_7_2_2", "nuclear_plant_7_3_2",
        "nuclear_plant_7_4_2", "nuclear_plant_7_5_2", "nuclear_plant_7_6_2", "nuclear_plant_7_7_2",
        "nuclear_plant_8_0_2", "nuclear_plant_8_1_2", "nuclear_plant_8_2_2", "nuclear_plant_8_3_2",
        "nuclear_plant_8_4_2", "nuclear_plant_8_5_2", "nuclear_plant_8_6_2", "nuclear_plant_8_7_2",
        "nuclear_plant_9_0_2", "nuclear_plant_9_1_2", "nuclear_plant_9_2_2", "nuclear_plant_9_3_2",
        "nuclear_plant_9_4_2", "nuclear_plant_9_5_2", "nuclear_plant_9_6_2", "nuclear_plant_9_7_2",
        "nuclear_plant_10_0_2", "nuclear_plant_10_1_2", "nuclear_plant_10_2_2", "nuclear_plant_10_3_2",
        "nuclear_plant_10_4_2", "nuclear_plant_10_5_2", "nuclear_plant_10_6_2", "nuclear_plant_10_7_2",
        "nuclear_plant_11_0_2", "nuclear_plant_11_1_2", "nuclear_plant_11_2_2", "nuclear_plant_11_3_2",
        "nuclear_plant_11_4_2", "nuclear_plant_11_5_2", "nuclear_plant_11_6_2", "nuclear_plant_11_7_2",
        "nuclear_plant_12_0_2", "nuclear_plant_12_1_2", "nuclear_plant_12_2_2", "nuclear_plant_12_3_2",
        "nuclear_plant_12_4_2", "nuclear_plant_12_5_2", "nuclear_plant_12_6_2", "nuclear_plant_12_7_2",
        "nuclear_plant_13_0_2", "nuclear_plant_13_1_2", "nuclear_plant_13_2_2", "nuclear_plant_13_3_2",
        "nuclear_plant_13_4_2", "nuclear_plant_13_5_2", "nuclear_plant_13_6_2", "nuclear_plant_13_7_2",
        "nuclear_plant_14_0_2", "nuclear_plant_14_1_2", "nuclear_plant_14_2_2", "nuclear_plant_14_3_2",
        "nuclear_plant_14_4_2", "nuclear_plant_14_5_2", "nuclear_plant_14_6_2", "nuclear_plant_14_7_2",
        "nuclear_plant_15_0_2", "nuclear_plant_15_1_2", "nuclear_plant_15_2_2", "nuclear_plant_15_3_2",
        "nuclear_plant_15_4_2", "nuclear_plant_15_5_2", "nuclear_plant_15_6_2", "nuclear_plant_15_7_2",
        "nuclear_plant_0_0_3", "nuclear_plant_0_1_3", "nuclear_plant_0_2_3", "nuclear_plant_0_3_3",
        "nuclear_plant_0_4_3", "nuclear_plant_0_5_3", "nuclear_plant_1_0_3", "nuclear_plant_1_1_3",
        "nuclear_plant_1_2_3", "nuclear_plant_1_3_3", "nuclear_plant_1_4_3", "nuclear_plant_1_5_3",
        "nuclear_plant_2_0_3", "nuclear_plant_2_1_3", "nuclear_plant_2_2_3", "nuclear_plant_2_3_3",
        "nuclear_plant_2_4_3", "nuclear_plant_2_5_3", "nuclear_plant_3_0_3", "nuclear_plant_3_1_3",
        "nuclear_plant_3_2_3", "nuclear_plant_3_3_3", "nuclear_plant_3_4_3", "nuclear_plant_3_5_3",
        "nuclear_plant_4_0_3", "nuclear_plant_4_1_3", "nuclear_plant_4_2_3", "nuclear_plant_4_3_3",
        "nuclear_plant_4_4_3", "nuclear_plant_4_5_3", "nuclear_plant_5_0_3", "nuclear_plant_5_1_3",
        "nuclear_plant_5_2_3", "nuclear_plant_5_3_3", "nuclear_plant_5_4_3", "nuclear_plant_5_5_3",
        "nuclear_plant_6_0_3", "nuclear_plant_6_1_3", "nuclear_plant_6_2_3", "nuclear_plant_6_3_3",
        "nuclear_plant_6_4_3", "nuclear_plant_6_5_3", "nuclear_plant_7_0_3", "nuclear_plant_7_1_3",
        "nuclear_plant_7_2_3", "nuclear_plant_7_3_3", "nuclear_plant_7_4_3", "nuclear_plant_7_5_3",
        "nuclear_plant_8_0_3", "nuclear_plant_8_1_3", "nuclear_plant_8_2_3", "nuclear_plant_8_3_3",
        "nuclear_plant_8_4_3", "nuclear_plant_8_5_3", "nuclear_plant_9_0_3", "nuclear_plant_9_1_3",
        "nuclear_plant_9_2_3", "nuclear_plant_9_3_3", "nuclear_plant_9_4_3", "nuclear_plant_9_5_3",
        "nuclear_plant_10_0_3", "nuclear_plant_10_1_3", "nuclear_plant_10_2_3", "nuclear_plant_10_3_3",
        "nuclear_plant_10_4_3", "nuclear_plant_10_5_3", "nuclear_plant_11_0_3", "nuclear_plant_11_1_3",
        "nuclear_plant_11_2_3", "nuclear_plant_11_3_3", "nuclear_plant_11_4_3", "nuclear_plant_11_5_3",
        "nuclear_plant_12_0_3", "nuclear_plant_12_1_3", "nuclear_plant_12_2_3", "nuclear_plant_12_3_3",
        "nuclear_plant_12_4_3", "nuclear_plant_12_5_3", "nuclear_plant_13_0_3", "nuclear_plant_13_1_3",
        "nuclear_plant_13_2_3", "nuclear_plant_13_3_3", "nuclear_plant_13_4_3", "nuclear_plant_13_5_3",
        "nuclear_plant_14_0_3", "nuclear_plant_14_1_3", "nuclear_plant_14_2_3", "nuclear_plant_14_3_3",
        "nuclear_plant_14_4_3", "nuclear_plant_14_5_3", "nuclear_plant_15_0_3", "nuclear_plant_15_1_3",
        "nuclear_plant_15_2_3", "nuclear_plant_15_3_3", "nuclear_plant_15_4_3", "nuclear_plant_15_5_3",
        "nuclear_plant_5_2_4", "nuclear_plant_5_3_4", "nuclear_plant_5_4_4", "nuclear_plant_6_2_4",
        "nuclear_plant_6_3_4", "nuclear_plant_6_4_4", "nuclear_plant_7_2_4", "nuclear_plant_7_3_4",
        "nuclear_plant_7_4_4", "nuclear_plant_8_2_4", "nuclear_plant_8_3_4", "nuclear_plant_8_4_4",
        "nuclear_plant_9_2_4", "nuclear_plant_9_3_4", "nuclear_plant_9_4_4", "nuclear_plant_10_2_4",
        "nuclear_plant_10_3_4", "nuclear_plant_10_4_4", "nuclear_plant_11_2_4", "nuclear_plant_11_3_4",
        "nuclear_plant_11_4_4", "nuclear_plant_7_2_5", "nuclear_plant_7_3_5", "nuclear_plant_8_2_5",
        "nuclear_plant_8_3_5", "nuclear_plant_7_3_6", "nuclear_plant_8_3_6", "nuclear_plant_7_3_7",
        "nuclear_plant_8_3_7",
    },
    copy_from = "nuclear_plant_0_0_0",
    symbol = "N",
    color = "yellow",
    name = ccb.content.text("nuclear plant"),
}

content.patch_overmap_terrain {
    ids = {
        "ws_fire_lookout_tower_base", "ws_fire_lookout_tower_f1", "ws_fire_lookout_tower_f2",
        "ws_fire_lookout_tower_f3", "ws_fire_lookout_tower_f4", "ws_fire_lookout_tower_f5",
    },
    copy_from = "ws_fire_lookout_tower_base",
    symbol = "F",
    color = "yellow",
    name = ccb.content.text("fire lookout tower"),
}

content.patch_overmap_terrain {
    ids = { "sub_station" },
    copy_from = "sub_station",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway station"),
}

content.patch_overmap_terrain {
    ids = { "sub_station_roof" },
    copy_from = "sub_station_roof",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway station roof"),
}

content.patch_overmap_terrain {
    ids = { "sewer_sub_station" },
    copy_from = "sewer_sub_station",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway station (sewer level)"),
}

content.patch_overmap_terrain {
    ids = { "underground_sub_station" },
    copy_from = "underground_sub_station",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway station (underground level)"),
}

content.patch_overmap_terrain {
    ids = { "town_hall_0_0_0", "town_hall_1_0_0", "town_hall_0_1_0", "town_hall_1_1_0" },
    copy_from = "town_hall_0_0_0",
    symbol = "T",
    color = "yellow",
    name = ccb.content.text("town hall"),
}

content.patch_overmap_terrain {
    ids = { "town_hall_0_0_1", "town_hall_1_0_1", "town_hall_0_1_1", "town_hall_1_1_1" },
    copy_from = "town_hall_0_0_1",
    symbol = "T",
    color = "yellow",
    name = ccb.content.text("town hall"),
}

content.patch_overmap_terrain {
    ids = {
        "town_hall_0_0_roof", "town_hall_1_0_roof", "town_hall_0_1_roof", "town_hall_1_1_roof",
        "town_hall_1_1_upper_roof",
    },
    copy_from = "town_hall_0_0_roof",
    symbol = "T",
    color = "yellow",
    name = ccb.content.text("town hall roof"),
}

content.patch_overmap_terrain {
    ids = { "retirement_community_38", "retirement_community_39", "retirement_community_40" },
    copy_from = "retirement_community_38",
    symbol = "A",
    color = "yellow",
    name = ccb.content.text("administration building"),
}

content.patch_overmap_terrain {
    ids = { "retirement_community_b_37", "retirement_community_b_38" },
    copy_from = "retirement_community_b_37",
    symbol = "A",
    color = "yellow",
    name = ccb.content.text("administration building basement"),
}

content.patch_overmap_terrain {
    ids = { "retirement_community_2f_38", "retirement_community_2f_39", "retirement_community_2f_40" },
    copy_from = "retirement_community_2f_38",
    symbol = "A",
    color = "yellow",
    name = ccb.content.text("administration building roof"),
}

content.patch_overmap_terrain {
    ids = {
        "evac_center_7", "evac_center_8", "evac_center_9", "evac_center_12", "evac_center_13",
        "evac_center_14", "evac_center_17", "evac_center_18", "evac_center_19",
    },
    copy_from = "evac_center_7",
    symbol = "R",
    color = "yellow",
    name = ccb.content.text("refugee center"),
}

content.patch_overmap_terrain {
    ids = {
        "evac_center_7_z1", "evac_center_8_z1", "evac_center_9_z1", "evac_center_12_z1", "evac_center_13_z1",
        "evac_center_14_z1", "evac_center_17_z1", "evac_center_18_z1", "evac_center_19_z1",
        "evac_center_12_z2", "evac_center_13_z2", "evac_center_14_z2",
    },
    copy_from = "evac_center_7_z1",
    symbol = "R",
    color = "yellow",
    name = ccb.content.text("refugee center roof"),
}

content.patch_overmap_terrain {
    ids = {
        "robofachq_meteorology0", "robofachq_meteorology1", "robofachq_meteorology2",
        "robofachq_meteorology3",
    },
    copy_from = "robofachq_meteorology0",
    symbol = "M",
    color = "yellow",
    name = ccb.content.text("meteorology station"),
}

content.patch_overmap_terrain {
    ids = {
        "robofachq_meteorology_roof0", "robofachq_meteorology_roof1", "robofachq_meteorology_roof2",
        "robofachq_meteorology_roof3",
    },
    copy_from = "robofachq_meteorology_roof0",
    symbol = "M",
    color = "yellow",
    name = ccb.content.text("meteorology station roof"),
}

content.patch_overmap_terrain {
    ids = { "robofachq_subcc_a0", "robofachq_subcc_a1", "robofachq_subcc_a2", "robofachq_subcc_a3" },
    copy_from = "robofachq_subcc_a0",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("subway C&C"),
}

content.patch_overmap_terrain {
    ids = { "robofachq_subline_a0", "robofachq_subline_a1", "robofachq_subline_a2", "robofachq_subline_a3" },
    copy_from = "robofachq_subline_a0",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("hidden terminal"),
}

content.patch_overmap_terrain {
    ids = { "cs_open_sewer", "cs_open_sewer_roof", "cs_open_sewer_undergound" },
    copy_from = "cs_open_sewer",
    symbol = "O",
    color = "yellow",
    name = ccb.content.text("open sewer"),
}

content.patch_overmap_terrain {
    ids = { "post_office", "post_office_1" },
    copy_from = "post_office",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("post office"),
}

content.patch_overmap_terrain {
    ids = { "post_office_roof", "post_office_roof_1" },
    copy_from = "post_office_roof",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("post office roof"),
}

content.patch_overmap_terrain {
    ids = {
        "prison_1_1", "prison_1_2", "prison_1_3", "prison_1_4", "prison_1_5", "prison_1_6", "prison_1_7",
        "prison_1_8", "prison_1_9",
    },
    copy_from = "prison_1_1",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("prison"),
}

content.patch_overmap_terrain {
    ids = {
        "prison_1_b_1", "prison_1_b_2", "prison_1_b_3", "prison_1_b_4", "prison_1_b_5", "prison_1_b_6",
        "prison_1_b_7", "prison_1_b_8", "prison_1_b_9", "prison_1_2f_1", "prison_1_2f_2", "prison_1_2f_3",
        "prison_1_2f_4", "prison_1_2f_5", "prison_1_2f_6", "prison_1_2f_7", "prison_1_2f_8", "prison_1_2f_9",
        "prison_1_3f_1", "prison_1_3f_2", "prison_1_3f_3", "prison_1_3f_4", "prison_1_3f_5", "prison_1_3f_6",
        "prison_1_3f_7", "prison_1_3f_8", "prison_1_3f_9", "prison_alcatraz_1", "prison_alcatraz_2",
        "prison_alcatraz_3", "prison_alcatraz_4", "prison_alcatraz_5", "prison_alcatraz_6",
        "prison_alcatraz_7", "prison_alcatraz_8", "prison_alcatraz_9", "prison_alcatraz_10",
        "prison_alcatraz_11", "prison_alcatraz_12", "prison_alcatraz_13", "prison_alcatraz_14",
        "prison_alcatraz_15", "prison_alcatraz_1_2f", "prison_alcatraz_2_2f", "prison_alcatraz_3_2f",
        "prison_alcatraz_4_2f", "prison_alcatraz_5_2f", "prison_alcatraz_6_2f", "prison_alcatraz_7_2f",
        "prison_alcatraz_8_2f", "prison_alcatraz_9_2f", "prison_alcatraz_10_2f", "prison_alcatraz_11_2f",
        "prison_alcatraz_12_2f", "prison_alcatraz_13_2f", "prison_alcatraz_14_2f", "prison_alcatraz_15_2f",
        "prison_alcatraz_10_3f", "prison_alcatraz_9_3f", "prison_alcatraz_6_3f", "prison_alcatraz_15_3f",
        "prison_alcatraz_14_3f", "prison_alcatraz_11_3f", "prison_island_1_1", "prison_island_1_2",
        "prison_island_1_3", "prison_island_1_4", "prison_island_1_5", "prison_island_1_6",
        "prison_island_1_7", "prison_island_1_8", "prison_island_1_9", "prison_island_1_10",
        "prison_island_1_11", "prison_island_1_12", "prison_island_1_13", "prison_island_1_14",
        "prison_island_1_15", "prison_island_1_2f_1", "prison_island_1_2f_2", "prison_island_1_2f_3",
        "prison_island_1_2f_4", "prison_island_1_2f_5", "prison_island_1_2f_6", "prison_island_1_2f_7",
        "prison_island_1_2f_8", "prison_island_1_2f_9", "prison_island_1_2f_10", "prison_island_1_2f_11",
        "prison_island_1_2f_12", "prison_island_1_2f_13", "prison_island_1_2f_14", "prison_island_1_2f_15",
        "prison_island_1_3f_1", "prison_island_1_3f_4", "prison_island_1_3f_5", "prison_island_1_3f_11",
        "prison_island_1_3f_14", "prison_island_1_ug_1", "prison_island_1_ug_2", "prison_island_1_ug_3",
        "prison_island_1_ug_4", "prison_island_1_ug_5", "prison_island_1_ug_6", "prison_island_1_ug_7",
        "prison_island_1_ug_8", "prison_island_1_ug_9", "prison_island_1_ug_10", "prison_island_1_ug_11",
        "prison_island_1_ug_12", "prison_island_1_ug_13", "prison_island_1_ug_14", "prison_island_1_ug_15",
    },
    copy_from = "prison_1_b_1",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("prison"),
}

content.patch_overmap_terrain {
    ids = {
        "sewage_treatment_0_0_0", "sewage_treatment_1_0_0", "sewage_treatment_0_1_0",
        "sewage_treatment_1_1_0",
    },
    copy_from = "sewage_treatment_0_0_0",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("sewage treatment plant"),
}

content.patch_overmap_terrain {
    ids = {
        "sewage_treatment_1_0_roof", "sewage_treatment_1_1_roof", "sewage_treatment_0_1_roof",
        "sewage_treatment_1_0_upper_roof",
    },
    copy_from = "sewage_treatment_1_0_roof",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("sewage treatment plant roof"),
}

content.patch_overmap_terrain {
    ids = {
        "sewage_treatment_0_0_-1", "sewage_treatment_1_0_-1", "sewage_treatment_2_0_-1",
        "sewage_treatment_0_1_-1", "sewage_treatment_1_1_-1", "sewage_treatment_2_1_-1",
    },
    copy_from = "sewage_treatment_0_0_-1",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("sewage treatment plant - underground"),
}

content.patch_overmap_terrain {
    ids = { "sai" },
    copy_from = "sai",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("serving area interface"),
}

content.patch_overmap_terrain {
    ids = { "solar_farm" },
    copy_from = "solar_farm",
    symbol = "S",
    color = "yellow",
    name = ccb.content.text("solar farm"),
}

content.patch_overmap_terrain {
    ids = { "pwr_sub_s" },
    copy_from = "pwr_sub_s",
    symbol = "E",
    color = "yellow",
    name = ccb.content.text("electric substation"),
}

content.patch_overmap_terrain {
    ids = { "pwr_sub_s_roof" },
    copy_from = "pwr_sub_s_roof",
    symbol = "E",
    color = "yellow",
    name = ccb.content.text("electric substation roof"),
}

content.patch_overmap_terrain {
    ids = { "pwr_large_entrance", "pwr_large_2", "pwr_large_3", "pwr_large_4" },
    copy_from = "pwr_large_entrance",
    symbol = "E",
    color = "yellow",
    name = ccb.content.text("electric substation"),
}

content.patch_overmap_terrain {
    ids = { "pwr_large_entrance_roof", "pwr_large_2_roof" },
    copy_from = "pwr_large_entrance_roof",
    symbol = "E",
    color = "yellow",
    name = ccb.content.text("electric substation roof"),
}

content.patch_overmap_terrain {
    ids = { "pump_station_1" },
    copy_from = "generic_city_building",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("pump station"),
}

content.patch_overmap_terrain {
    ids = { "pump_station_1_roof", "pump_station_2_roof" },
    copy_from = "pump_station_1_roof",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("pump station roof"),
    vision_levels = "roof_or_air",
}

content.patch_overmap_terrain {
    ids = { "pump_station_2" },
    copy_from = "pump_station_2",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("pump station"),
}

content.patch_overmap_terrain {
    ids = { "pump_station_3", "pump_station_4", "pump_station_5" },
    copy_from = "pump_station_3",
    symbol = "P",
    color = "yellow",
    name = ccb.content.text("pump station"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_ground" },
    copy_from = "lighthouse_ground",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_z1", "lighthouse_z2", "lighthouse_z4", "lighthouse_z5" },
    copy_from = "lighthouse_z1",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_roof" },
    copy_from = "lighthouse_roof",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse roof"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_z3" },
    copy_from = "lighthouse_z3",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_small_ground" },
    copy_from = "lighthouse_small_ground",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_small_z1", "lighthouse_small_z2", "lighthouse_small_z3", "lighthouse_small_z4" },
    copy_from = "lighthouse_small_z1",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse"),
}

content.patch_overmap_terrain {
    ids = { "lighthouse_small_roof" },
    copy_from = "lighthouse_small_roof",
    symbol = "L",
    color = "yellow",
    name = ccb.content.text("lighthouse roof"),
}

content.patch_overmap_terrain {
    ids = {
        "wind_turbine_ground", "wind_turbine_pillar", "wind_turbine_pillar_platform", "wind_turbine_roof",
    },
    copy_from = "wind_turbine_ground",
    symbol = "W",
    color = "yellow",
    name = ccb.content.text("wind turbine"),
}

content.patch_overmap_terrain {
    ids = { "wind_turbine_nacelle" },
    copy_from = "wind_turbine_nacelle",
    symbol = "W",
    color = "yellow",
    name = ccb.content.text("wind turbine"),
}

content.patch_overmap_terrain {
    ids = { "fire_station", "fire_station_1" },
    copy_from = "fire_station",
    symbol = "F",
    color = "yellow",
    name = ccb.content.text("fire station"),
}

content.patch_overmap_terrain {
    ids = { "fire_station_roof", "fire_station_roof_1" },
    copy_from = "fire_station_roof",
    symbol = "F",
    color = "yellow",
    name = ccb.content.text("fire station roof"),
}

content.patch_overmap_terrain {
    ids = { "s_vfw" },
    copy_from = "s_vfw",
    symbol = "W",
    color = "yellow",
    name = ccb.content.text("veterans of foreign wars"),
}

content.patch_overmap_terrain {
    ids = { "s_vfw_roof" },
    copy_from = "s_vfw_roof",
    symbol = "W",
    color = "yellow",
    name = ccb.content.text("veterans of foreign wars center roof"),
}
