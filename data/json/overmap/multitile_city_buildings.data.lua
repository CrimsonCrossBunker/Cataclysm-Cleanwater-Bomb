local ccb = require("ccb")

ccb.content.define_city_building {
    id = "2storyModern01",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "2storyModern01_basement_north" },
        { point = { 0, 0, 0 }, terrain = "2storyModern01_first_north" },
        { point = { 0, 0, 1 }, terrain = "2storyModern01_second_north" },
        { point = { 0, 0, 2 }, terrain = "2storyModern01_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "2storyModern02",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "2storyModern02_basement_north" },
        { point = { 0, 0, 0 }, terrain = "2storyModern02_1_north" },
        { point = { 0, 0, 1 }, terrain = "2storyModern02_2_north" },
        { point = { 0, 0, 2 }, terrain = "2storyModern02_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "2StoryModern03",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "2StoryModern03_basement_north" },
        { point = { 0, 0, 0 }, terrain = "2StoryModern03_1_north" },
        { point = { 0, 0, 1 }, terrain = "2StoryModern03_2_north" },
        { point = { 0, 0, 2 }, terrain = "2StoryModern03_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "2StoryModern04",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "2StoryModern04_basement_1_north" },
        { point = { 1, 0, -1 }, terrain = "2StoryModern04_basement_2_north" },
        { point = { 0, 0, 0 }, terrain = "2StoryModern04_1_1_north" },
        { point = { 1, 0, 0 }, terrain = "2StoryModern04_1_2_north" },
        { point = { 0, 0, 1 }, terrain = "2StoryModern04_2_1_north" },
        { point = { 1, 0, 1 }, terrain = "2StoryModern04_2_2_north" },
        { point = { 0, 0, 2 }, terrain = "2StoryModern04_roof_1_north" },
        { point = { 1, 0, 2 }, terrain = "2StoryModern04_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "deserter_city",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "deserter_city_gate_north" },
        { point = { 1, 0, 0 }, terrain = "deserter_city_park_north" },
        { point = { 0, 1, 0 }, terrain = "deserter_city_office_1f_north" },
        { point = { 0, 1, 1 }, terrain = "deserter_city_office_2f_north" },
        { point = { 0, 1, 2 }, terrain = "deserter_city_office_3f_north" },
        { point = { 0, 1, 3 }, terrain = "deserter_city_office_roof_north" },
        { point = { 1, 1, 0 }, terrain = "deserter_city_office_1fb_north" },
        { point = { 1, 1, 1 }, terrain = "deserter_city_office_2fb_north" },
        { point = { 1, 1, 2 }, terrain = "deserter_city_office_3fb_north" },
        { point = { 1, 1, 3 }, terrain = "deserter_city_office_roofb_north" },
    },
    flags = { "GLOBALLY_UNIQUE", "SAFE_AT_WORLDGEN" },
}

ccb.content.define_city_building {
    id = "bungalow01",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow01_1_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow01_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow02",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow02_1_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow02_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow03",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow03_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow03_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow04",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow04_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow04_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow05",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow05_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow05_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow06",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow06_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow06_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow07",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow07_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow07_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow08",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow08_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow08_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow09",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow09_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow09_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow10",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow10_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow10_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow11",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow11_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow11_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow12",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow12_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow12_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow13",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow13_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow13_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow14",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow14_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow14_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow15",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow15_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow15_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow16",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow16_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow16_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow17",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow17_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow17_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow18",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow18_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow18_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow19",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow19_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow19_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow20",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow20_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow20_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow21",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow21_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow21_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow22",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow22_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow22_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow23",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow23_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow23_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow24",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow24_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow24_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bungalow25",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bungalow25_north" },
        { point = { 0, 0, 1 }, terrain = "bungalow25_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "urban_1_house",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_1_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_1_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_1_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_1_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_1_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_1_4_south" },
        { point = { 0, 0, 2 }, terrain = "urban_1_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_2_house",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_2_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_2_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_2_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_2_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_2_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_2_4_south" },
        { point = { 1, 0, 2 }, terrain = "urban_2_5_south" },
        { point = { 0, 0, 2 }, terrain = "urban_2_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_dd_house",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_dd_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_dd_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_2_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_2_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_dd_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_dd_4_south" },
        { point = { 1, 0, 2 }, terrain = "urban_dd_5_south" },
        { point = { 0, 0, 2 }, terrain = "urban_dd_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_3_house",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_3_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_3_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_3_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_3_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_3_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_3_4_south" },
        { point = { 1, 0, 2 }, terrain = "urban_3_5_south" },
        { point = { 0, 0, 2 }, terrain = "urban_3_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_4_house_basement",
    tiles = {
        { point = { 1, 0, -1 }, terrain = "urban_4_1_south" },
        { point = { 0, 0, -1 }, terrain = "urban_4_2_south" },
        { point = { 1, 0, 0 }, terrain = "urban_4_3_south" },
        { point = { 0, 0, 0 }, terrain = "urban_4_4_south" },
        { point = { 1, 0, 1 }, terrain = "urban_4_5_south" },
        { point = { 0, 0, 1 }, terrain = "urban_4_6_south" },
        { point = { 1, 0, 2 }, terrain = "urban_4_7_south" },
        { point = { 0, 0, 2 }, terrain = "urban_4_8_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_5_house",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_5_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_5_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_5_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_5_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_5_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_5_4_south" },
        { point = { 1, 0, 2 }, terrain = "urban_5_5_south" },
        { point = { 0, 0, 2 }, terrain = "urban_5_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_6_house",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_6_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_6_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_6_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_6_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_6_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_6_4_south" },
        { point = { 1, 0, 2 }, terrain = "urban_6_5_south" },
        { point = { 0, 0, 2 }, terrain = "urban_6_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_7_house_garden",
    tiles = {
        { point = { 1, 0, 0 }, terrain = "urban_7_1_south" },
        { point = { 0, 0, 0 }, terrain = "urban_7_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_7_1_basement_south" },
        { point = { 0, 0, -1 }, terrain = "urban_7_2_basement_south" },
        { point = { 1, 0, 1 }, terrain = "urban_7_3_south" },
        { point = { 0, 0, 1 }, terrain = "urban_7_4_south" },
        { point = { 1, 0, 2 }, terrain = "urban_7_5_south" },
        { point = { 0, 0, 2 }, terrain = "urban_7_6_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_8_house_brick_garden",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_8_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_8_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_8_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_8_4_north" },
        { point = { 1, 0, 2 }, terrain = "urban_8_6_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_9_house_garage_loft",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_9_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_9_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_9_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_9_4_north" },
        { point = { 0, 0, 2 }, terrain = "urban_9_5_north" },
        { point = { 1, 0, 2 }, terrain = "urban_9_6_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_10_house_brick_pool",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_10_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_10_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_10_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_10_4_north" },
        { point = { 0, 0, 2 }, terrain = "urban_10_5_north" },
        { point = { 1, 0, 2 }, terrain = "urban_10_6_north" },
        { point = { 0, 0, -1 }, terrain = "urban_10_7_north" },
        { point = { 1, 0, -1 }, terrain = "urban_10_8_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_11_house_brick",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_11_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_11_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_11_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_11_4_north" },
        { point = { 0, 0, 2 }, terrain = "urban_11_5_north" },
        { point = { 1, 0, 2 }, terrain = "urban_11_6_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_12_house",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_12_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_12_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_12_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_12_4_north" },
        { point = { 0, 0, 2 }, terrain = "urban_12_5_north" },
        { point = { 1, 0, 2 }, terrain = "urban_12_6_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_13_dense_house_apt_house",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "urban_13_1_south" },
        { point = { 1, 0, -1 }, terrain = "urban_13_2_south" },
        { point = { 1, 0, 0 }, terrain = "urban_13_3_south" },
        { point = { 0, 0, 0 }, terrain = "urban_13_4_south" },
        { point = { 1, 0, 1 }, terrain = "urban_13_5_south" },
        { point = { 0, 0, 1 }, terrain = "urban_13_6_south" },
        { point = { 1, 0, 2 }, terrain = "urban_13_7_south" },
        { point = { 0, 0, 2 }, terrain = "urban_13_8_south" },
        { point = { 1, 0, 3 }, terrain = "urban_13_9_south" },
        { point = { 0, 0, 3 }, terrain = "urban_13_10_south" },
        { point = { 1, 0, 4 }, terrain = "urban_13_11_south" },
        { point = { 0, 0, 4 }, terrain = "urban_13_12_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_14_dense_house_mart_food",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "urban_14_1_north" },
        { point = { 1, 0, -1 }, terrain = "urban_14_2_north" },
        { point = { 0, 0, 0 }, terrain = "urban_14_3_north" },
        { point = { 1, 0, 0 }, terrain = "urban_14_4_north" },
        { point = { 0, 0, 1 }, terrain = "urban_14_5_north" },
        { point = { 1, 0, 1 }, terrain = "urban_14_6_north" },
        { point = { 0, 0, 2 }, terrain = "urban_14_7_north" },
        { point = { 1, 0, 2 }, terrain = "urban_14_8_north" },
        { point = { 0, 0, 3 }, terrain = "urban_14_9_north" },
        { point = { 1, 0, 3 }, terrain = "urban_14_10_north" },
        { point = { 0, 0, 4 }, terrain = "urban_14_11_north" },
        { point = { 1, 0, 4 }, terrain = "urban_14_12_north" },
        { point = { 0, 0, 5 }, terrain = "urban_14_13_north" },
        { point = { 1, 0, 5 }, terrain = "urban_14_14_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_15_house",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_15_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_15_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_15_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_15_4_north" },
        { point = { 0, 0, 2 }, terrain = "urban_15_5_north" },
        { point = { 1, 0, 2 }, terrain = "urban_15_6_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_16_house_ranch",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_16_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_16_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_16_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_16_4_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_17_house_ranch",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_17_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_17_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_17_3_north" },
        { point = { 1, 0, 1 }, terrain = "urban_17_4_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_18_victorian",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "urban_18_1_north" },
        { point = { 1, 0, -1 }, terrain = "urban_18_2_north" },
        { point = { 0, 0, 0 }, terrain = "urban_18_3_north" },
        { point = { 1, 0, 0 }, terrain = "urban_18_4_north" },
        { point = { 0, 0, 1 }, terrain = "urban_18_5_north" },
        { point = { 1, 0, 1 }, terrain = "urban_18_6_north" },
        { point = { 0, 0, 2 }, terrain = "urban_18_7_north" },
        { point = { 1, 0, 2 }, terrain = "urban_18_8_north" },
        { point = { 0, 0, 3 }, terrain = "urban_18_9_north" },
        { point = { 1, 0, 3 }, terrain = "urban_18_10_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "urban_29_dense_row",
    tiles = {
        { point = { 0, 0, -1 }, terrain = "urban_29_1_north" },
        { point = { 1, 0, -1 }, terrain = "urban_29_2_north" },
        { point = { 0, 0, 0 }, terrain = "urban_29_3_north" },
        { point = { 1, 0, 0 }, terrain = "urban_29_4_north" },
        { point = { 0, 0, 1 }, terrain = "urban_29_5_north" },
        { point = { 1, 0, 1 }, terrain = "urban_29_6_north" },
        { point = { 0, 0, 2 }, terrain = "urban_29_7_north" },
        { point = { 1, 0, 2 }, terrain = "urban_29_8_north" },
        { point = { 0, 0, 3 }, terrain = "urban_29_9_north" },
        { point = { 1, 0, 3 }, terrain = "urban_29_10_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "house_wooded",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_wooded_north" },
        { point = { 0, 0, 1 }, terrain = "house_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_01",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_01_north" },
        { point = { 0, 0, 1 }, terrain = "house_01_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_02",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_02_north" },
        { point = { 0, 0, 1 }, terrain = "house_02_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_03",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_03_north" },
        { point = { 0, 0, 1 }, terrain = "house_03_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_two_story_basement",
    locations = { "land", "swamp" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_2story_base_north" },
        { point = { 0, 0, 1 }, terrain = "house_2story_second_north" },
        { point = { 0, 0, 2 }, terrain = "house_2story_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_2story_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "multi_unit_two_story_basement",
    locations = { "land", "swamp" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "multi_unit_first_floor_north" },
        { point = { 0, 0, 1 }, terrain = "multi_unit_top_floor_north" },
        { point = { 0, 0, 2 }, terrain = "multi_unit_roof_north" },
        { point = { 0, 0, -1 }, terrain = "multi_unit_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "multi_unit_three_story_basement",
    locations = { "land", "swamp" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "multi_unit_first_floor_north" },
        { point = { 0, 0, 1 }, terrain = "multi_unit_second_floor_of_three_north" },
        { point = { 0, 0, 2 }, terrain = "multi_unit_top_floor_north" },
        { point = { 0, 0, 3 }, terrain = "multi_unit_roof_north" },
        { point = { 0, 0, -1 }, terrain = "multi_unit_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "garden_house_1",
    locations = { "land", "swamp" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "garden_house_1_floor_1_north" },
        { point = { 0, 0, 1 }, terrain = "garden_house_1_floor_2_north" },
        { point = { 0, 0, -1 }, terrain = "garden_house_1_basement_north" },
        { point = { 0, 0, 2 }, terrain = "garden_house_1_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_dogs",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_dogs_north" },
        { point = { 0, 0, 1 }, terrain = "house_dogs_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_08_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_gardener",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_gardener_north" },
        { point = { 0, 0, 1 }, terrain = "house_gardener_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_gardener_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_w_5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_w_5_north" },
        { point = { 0, 0, 1 }, terrain = "house_w_5_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_w_5_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_w_6",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_w_6_north" },
        { point = { 0, 0, 1 }, terrain = "house_w_6_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "house_w_6_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_w_6_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_suicide",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_suicide_north" },
        { point = { 0, 0, 1 }, terrain = "house_suicide_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_10_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_quiverfull",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_quiverfull_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_05_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_toolshed",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_toolshed_north" },
        { point = { 0, 0, 1 }, terrain = "house_toolshed_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_toolshed_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_04",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_04_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_04_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_05",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_05_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_05_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_06",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_06_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_04_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_07",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_07_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_04_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_11",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_11_north" },
        { point = { 0, 0, 1 }, terrain = "house_11_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_11_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_12",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_12_north" },
        { point = { 0, 0, 1 }, terrain = "house_12_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_12_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_13",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_13_north" },
        { point = { 0, 0, 1 }, terrain = "house_13_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_13_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_14",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_14_north" },
        { point = { 0, 0, 1 }, terrain = "house_14_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_14_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_15",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_15_north" },
        { point = { 0, 0, 1 }, terrain = "house_15_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_15_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_16",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_16_north" },
        { point = { 0, 0, 1 }, terrain = "house_16_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_16_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_17",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_17_north" },
        { point = { 0, 0, 1 }, terrain = "house_17_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_17_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_18",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_18_north" },
        { point = { 0, 0, 1 }, terrain = "house_18_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_19",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_19_north" },
        { point = { 0, 0, 1 }, terrain = "house_19_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_19_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_20",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_20_north" },
        { point = { 0, 0, 1 }, terrain = "house_20_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_21",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_21_north" },
        { point = { 0, 0, 1 }, terrain = "house_21_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_22",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_22_north" },
        { point = { 0, 0, 1 }, terrain = "house_22_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_22_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_23",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_23_north" },
        { point = { 0, 0, 1 }, terrain = "house_23_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_24",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_24_north" },
        { point = { 0, 0, 1 }, terrain = "house_24_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_25",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_25_north" },
        { point = { 0, 0, 1 }, terrain = "house_25_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_26",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_26_north" },
        { point = { 0, 0, 1 }, terrain = "house_26_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_survival_north" },
    },
}

ccb.content.define_city_building {
    id = "house_27",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_27_north" },
        { point = { 0, 0, 1 }, terrain = "house_27_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_meth_north" },
    },
}

ccb.content.define_city_building {
    id = "house_28",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_28_north" },
        { point = { 0, 0, 1 }, terrain = "house_28_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_weed_north" },
    },
}

ccb.content.define_city_building {
    id = "house_29",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_29_north" },
        { point = { 0, 0, 1 }, terrain = "house_29_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_chem_north" },
    },
}

ccb.content.define_city_building {
    id = "house_30",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_30_north" },
        { point = { 0, 0, 1 }, terrain = "house_30_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_chem2_north" },
    },
}

ccb.content.define_city_building {
    id = "house_31",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_31_north" },
        { point = { 0, 0, 1 }, terrain = "house_31_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement" },
    },
}

ccb.content.define_city_building {
    id = "house_32",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_32_north" },
        { point = { 0, 0, 1 }, terrain = "house_32_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement" },
    },
}

ccb.content.define_city_building {
    id = "house_33",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_33_north" },
        { point = { 0, 0, -1 }, terrain = "house_33_basement_north" },
        { point = { 0, 0, 1 }, terrain = "house_33_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_34",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_34_north" },
        { point = { 0, 0, -1 }, terrain = "house_34_basement_north" },
        { point = { 0, 0, 1 }, terrain = "house_34_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_35",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_35_north" },
        { point = { 0, 0, 1 }, terrain = "house_35_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_36",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_36_north" },
        { point = { 0, 0, 1 }, terrain = "house_36_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_36_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_37",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_37_north" },
        { point = { 0, 0, 1 }, terrain = "house_37_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_37_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_38",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_38_north" },
        { point = { 0, 0, 1 }, terrain = "house_38_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_39",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_39_north" },
        { point = { 0, 0, 1 }, terrain = "house_39_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_39_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_40",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_40_north" },
        { point = { 0, 0, 1 }, terrain = "house_40_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_41",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_41_north" },
        { point = { 0, 0, 1 }, terrain = "house_41_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_42",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_42_north" },
        { point = { 0, 0, 1 }, terrain = "house_42_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_43",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_43_north" },
        { point = { 0, 0, 1 }, terrain = "house_43_first_floor_north" },
        { point = { 0, 0, 2 }, terrain = "house_43_second_floor_north" },
        { point = { 0, 0, 3 }, terrain = "house_43_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_44",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_44_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "house_44_0_1_north" },
        { point = { 0, 0, 1 }, terrain = "house_44_1_0_north" },
        { point = { 1, 0, 1 }, terrain = "house_44_1_1_north" },
        { point = { 0, 0, 2 }, terrain = "house_44_roof_0_north" },
        { point = { 1, 0, 2 }, terrain = "house_44_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "house_45",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_45_0_north" },
        { point = { 0, 0, 1 }, terrain = "house_45_1_north" },
        { point = { 0, 0, 2 }, terrain = "house_45_2_north" },
        { point = { 0, 0, 3 }, terrain = "house_45_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_46",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_46_north" },
        { point = { 0, 0, 1 }, terrain = "house_46_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "urban_20_house",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_20_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_20_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_20_2ndfloor_1_north" },
        { point = { 1, 0, 1 }, terrain = "urban_20_2ndfloor_2_north" },
        { point = { 0, 0, 2 }, terrain = "urban_20_roof_1_north" },
        { point = { 1, 0, 2 }, terrain = "urban_20_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "urban_22_house_pool",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "urban_22_1_north" },
        { point = { 1, 0, 0 }, terrain = "urban_22_2_north" },
        { point = { 0, 0, 1 }, terrain = "urban_22_1_roof_north" },
        { point = { 1, 0, 1 }, terrain = "urban_22_2_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_08",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_08_north" },
        { point = { 0, 0, 1 }, terrain = "house_08_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_08_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_09",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_09_north" },
        { point = { 0, 0, 1 }, terrain = "house_09_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_bionic_decoy_north" },
    },
}

ccb.content.define_city_building {
    id = "house_10",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_10_north" },
        { point = { 0, 0, 1 }, terrain = "house_10_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_10_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_w_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_w_1_north" },
        { point = { 0, 0, 1 }, terrain = "house_w_1_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_w_1_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_w_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_w_2_north" },
        { point = { 0, 0, 1 }, terrain = "house_w_2_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_w_2_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_w_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_w_3_north" },
        { point = { 0, 0, 1 }, terrain = "house_w_3_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_w_3_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_w_4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_w_4_north" },
        { point = { 0, 0, 1 }, terrain = "house_w_4_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_w_4_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_inner_garden",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_inner_garden_north" },
        { point = { 0, 0, 1 }, terrain = "house_inner_garden_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fence01",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "house_fence01_basement_north" },
        { point = { 0, 0, 0 }, terrain = "house_fence01_north" },
        { point = { 0, 0, 1 }, terrain = "house_fence01_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fence02",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_fence02_1_north" },
        { point = { 0, 0, 1 }, terrain = "house_fence02_2_north" },
        { point = { 0, 0, 2 }, terrain = "house_fence02_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fence03",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "house_fence03_basement_north" },
        { point = { 0, 0, 0 }, terrain = "house_fence03_north" },
        { point = { 0, 0, 1 }, terrain = "house_fence03_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fence04",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_fence04_north" },
        { point = { 0, 0, 1 }, terrain = "house_fence04_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fence05",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "house_fence05_basement_north" },
        { point = { 0, 0, 0 }, terrain = "house_fence05_1_north" },
        { point = { 0, 0, 1 }, terrain = "house_fence05_2_north" },
        { point = { 0, 0, 2 }, terrain = "house_fence05_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_electronics",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_electronics_north" },
        { point = { 0, 0, 1 }, terrain = "s_electronics_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_electronics_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_electronics_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_electronics_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "stripclub",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "stripclub_north" },
        { point = { 0, 0, 1 }, terrain = "stripclub_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "stripclub_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "stripclub_1_north" },
        { point = { 0, 0, 1 }, terrain = "stripclub_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "stripclub_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "stripclub_2_north" },
        { point = { 0, 0, 1 }, terrain = "stripclub_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "post_office",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "post_office_north" },
        { point = { 0, 0, 1 }, terrain = "post_office_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "post_office_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "post_office_1_north" },
        { point = { 0, 0, 1 }, terrain = "post_office_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "paintball_field",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "paintball_field_north" },
        { point = { 0, 0, 1 }, terrain = "paintball_field_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "paintball_field_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "paintball_field_1_north" },
        { point = { 0, 0, 1 }, terrain = "paintball_field_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "mil_surplus",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "mil_surplus_north" },
        { point = { 0, 0, 1 }, terrain = "mil_surplus_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "mil_surplus_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "mil_surplus_1_north" },
        { point = { 0, 0, 1 }, terrain = "mil_surplus_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "sub_station",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "sub_station_north" },
        { point = { 0, 0, 1 }, terrain = "sub_station_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_library",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_library_north" },
        { point = { 0, 0, 1 }, terrain = "s_library_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_library_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_library_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_library_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "mil_surplus_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "mil_surplus_2_north" },
        { point = { 0, 0, 1 }, terrain = "mil_surplus_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_library_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_library_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_library_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_library_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_library_3_north" },
        { point = { 0, 0, 1 }, terrain = "s_library_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "urban_library",
    locations = { "land" },
    tiles = {
        { point = { -1, 0, 0 }, terrain = "urban_library_1_north" },
        { point = { 0, 0, 0 }, terrain = "urban_library_2_north" },
        { point = { -1, 1, 0 }, terrain = "urban_library_3_north" },
        { point = { 0, 1, 0 }, terrain = "urban_library_4_north" },
        { point = { -1, 0, 1 }, terrain = "urban_library_5_north" },
        { point = { 0, 0, 1 }, terrain = "urban_library_6_north" },
        { point = { -1, 1, 1 }, terrain = "urban_library_7_north" },
        { point = { 0, 1, 1 }, terrain = "urban_library_8_north" },
        { point = { -1, 0, 2 }, terrain = "urban_library_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "urban_library_roof_2_north" },
        { point = { -1, 1, 2 }, terrain = "urban_library_roof_3_north" },
        { point = { 0, 1, 2 }, terrain = "urban_library_roof_4_north" },
    },
}

ccb.content.define_city_building {
    id = "furniture",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "furniture_north" },
        { point = { 0, 0, 1 }, terrain = "furniture_roof_north" },
        { point = { 0, 0, 2 }, terrain = "furniture_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_daycare",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_daycare_north" },
        { point = { 0, 0, 1 }, terrain = "s_daycare_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "gym_fitness",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "gym_fitness_north" },
        { point = { 0, 0, 1 }, terrain = "gym_fitness_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "gym_fitness_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "gym_fitness_1_north" },
        { point = { 0, 0, 1 }, terrain = "gym_fitness_2ndFloor_1_north" },
        { point = { 0, 0, 2 }, terrain = "gym_fitness_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_gardening",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_gardening_north" },
        { point = { 0, 0, 1 }, terrain = "s_gardening_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_market_small",
    locations = { "land" },
    tiles = { { point = { 0, 0, 0 }, terrain = "cs_market_small_north" } },
}

ccb.content.define_city_building {
    id = "cs_sex_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_sex_shop_north" },
        { point = { 0, 0, 1 }, terrain = "cs_sex_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_private_park",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_private_park_north" },
        { point = { 0, 0, 1 }, terrain = "cs_private_park_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "church",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "church_north" },
        { point = { 0, 0, 1 }, terrain = "church_roof_north" },
        { point = { 0, 0, 2 }, terrain = "church_steeple_north" },
        { point = { 0, 0, 3 }, terrain = "church_steeple_north" },
        { point = { 0, 0, 4 }, terrain = "church_steeple_north" },
        { point = { 0, 0, 5 }, terrain = "church_steeple_end_north" },
        { point = { 0, 0, 6 }, terrain = "church_steeple_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "church_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "church_1_north" },
        { point = { 0, 0, 1 }, terrain = "church_2ndfloor_1_north" },
        { point = { 0, 0, 2 }, terrain = "church_3rdfloor_1_north" },
        { point = { 0, 0, 3 }, terrain = "church_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "synagogue",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "synagogue_north" },
        { point = { 0, 0, 1 }, terrain = "synagogue_roof_north" },
        { point = { 0, 0, 2 }, terrain = "synagogue_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_tire_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_tire_shop_north" },
        { point = { 0, 0, 1 }, terrain = "cs_tire_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_thrift",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_thrift_north" },
        { point = { 0, 0, 1 }, terrain = "s_thrift_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_gun_a",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_gun_a_north" },
        { point = { 0, 0, 1 }, terrain = "s_gun_a_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_gun_b",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_gun_b_store_north" },
        { point = { 1, 0, 0 }, terrain = "s_gun_b_range_north" },
        { point = { 0, 0, 1 }, terrain = "s_gun_b_roof_north" },
        { point = { 1, 0, 1 }, terrain = "s_gun_b_range_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_weldingstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_weldingstore_north" },
        { point = { 0, 0, 1 }, terrain = "s_weldingstore_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_electronicstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_electronicstore_north" },
        { point = { 0, 0, 1 }, terrain = "s_electronicstore_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "s_electronicstore_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "mortuary",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "mortuary_north" },
        { point = { 0, 0, 1 }, terrain = "mortuary_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_bookstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_bookstore_north" },
        { point = { 0, 0, 1 }, terrain = "s_bookstore_roof_north" },
        { point = { 0, 0, 2 }, terrain = "s_bookstore_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_bookstore_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_bookstore_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_bookstore_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "s_bookstore_upper_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_bookstore_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_bookstore_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_bookstore_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "museum",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "museum_north" },
        { point = { 0, 0, 1 }, terrain = "museum_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_butcher",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_butcher_north" },
        { point = { 0, 0, 1 }, terrain = "s_butcher_roof_north" },
        { point = { 0, 0, 2 }, terrain = "s_butcher_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_butcher_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_butcher_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_butcher_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "s_butcher_upper_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_butcher_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_butcher_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_butcher_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "dojo",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dojo_north" },
        { point = { 0, 0, 1 }, terrain = "dojo_roof_north" },
        { point = { 0, 0, 2 }, terrain = "dojo_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "dojo_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dojo_1_north" },
        { point = { 0, 0, 1 }, terrain = "dojo_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "dojo_upper_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "police",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "police_north" },
        { point = { 0, 0, 1 }, terrain = "police_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "police_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "police_1_north" },
        { point = { 0, 0, 1 }, terrain = "police_2ndfloor_1_north" },
        { point = { 0, 0, 2 }, terrain = "police_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "police_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "police_2_north" },
        { point = { 0, 0, 1 }, terrain = "police_roof_2_north" },
        { point = { 0, 0, 2 }, terrain = "police_upper_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "police_dept",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "police_dept_u000_north" },
        { point = { 1, 0, 0 }, terrain = "police_dept_u100_north" },
        { point = { 0, 1, 0 }, terrain = "police_dept_u010_north" },
        { point = { 1, 1, 0 }, terrain = "police_dept_u110_north" },
        { point = { 0, 0, 1 }, terrain = "police_dept_u001_north" },
        { point = { 1, 0, 1 }, terrain = "police_dept_u101_north" },
        { point = { 0, 1, 1 }, terrain = "police_dept_u011_north" },
        { point = { 1, 1, 1 }, terrain = "police_dept_u111_north" },
        { point = { 0, 0, 2 }, terrain = "police_dept_u002_north" },
        { point = { 1, 0, 2 }, terrain = "police_dept_u102_north" },
        { point = { 0, 1, 2 }, terrain = "police_dept_u012_north" },
        { point = { 1, 1, 2 }, terrain = "police_dept_u112_north" },
        { point = { 1, -1, 1 }, terrain = "police_dept_skyway_north" },
        { point = { 1, -1, 2 }, terrain = "police_dept_skyway_roof_north" },
        { point = { 0, -2, -1 }, terrain = "police_dept_b00_south" },
        { point = { 1, -2, -1 }, terrain = "police_dept_b10_south" },
        { point = { 0, -3, -1 }, terrain = "police_dept_b01_south" },
        { point = { 1, -3, -1 }, terrain = "police_dept_b11_south" },
        { point = { 0, -2, 0 }, terrain = "police_dept_d000_south" },
        { point = { 1, -2, 0 }, terrain = "police_dept_d100_south" },
        { point = { 0, -3, 0 }, terrain = "police_dept_d010_south" },
        { point = { 1, -3, 0 }, terrain = "police_dept_d110_south" },
        { point = { 0, -2, 1 }, terrain = "police_dept_d001_south" },
        { point = { 1, -2, 1 }, terrain = "police_dept_d101_south" },
        { point = { 0, -3, 1 }, terrain = "police_dept_d011_south" },
        { point = { 1, -3, 1 }, terrain = "police_dept_d111_south" },
        { point = { 0, -2, 2 }, terrain = "police_dept_d002_south" },
        { point = { 1, -2, 2 }, terrain = "police_dept_d102_south" },
        { point = { 0, -3, 2 }, terrain = "police_dept_d012_south" },
        { point = { 1, -3, 2 }, terrain = "police_dept_d112_south" },
    },
    city_sizes = { 14, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "bank",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bank_north" },
        { point = { 0, 0, 1 }, terrain = "bank_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bank_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bank_1_north" },
        { point = { 0, 0, 1 }, terrain = "bank_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "office_cubical",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_cubical_north" },
        { point = { 0, 0, 1 }, terrain = "office_cubical_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "office_cubical_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_cubical_1_north" },
        { point = { 0, 0, 1 }, terrain = "office_cubical_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "pavilion",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pavilion_north" },
        { point = { 0, 0, 1 }, terrain = "pavilion_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "pavilion_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pavilion_1_north" },
        { point = { 0, 0, 1 }, terrain = "pavilion_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "bowling_alley",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bowling_alley_north" },
        { point = { 0, 0, 1 }, terrain = "bowling_alley_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "smoke_lounge",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "smoke_lounge_north" },
        { point = { 0, 0, 1 }, terrain = "smoke_lounge_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "smoke_lounge_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "smoke_lounge_1_north" },
        { point = { 0, 0, 1 }, terrain = "smoke_lounge_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_petstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_petstore_north" },
        { point = { 0, 0, 1 }, terrain = "s_petstore_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_petstore_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_petstore_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_petstore_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_petstore_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_petstore_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_petstore_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_coffee",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_coffee_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_coffee_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_coffee_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_coffee_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_coffee_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_coffee_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_coffee_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_coffee_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "recyclecenter",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "recyclecenter_north" },
        { point = { 0, 0, 1 }, terrain = "recyclecenter_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "recyclecenter_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "recyclecenter_1_north" },
        { point = { 0, 0, 1 }, terrain = "recyclecenter_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "recyclecenter_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "recyclecenter_2_north" },
        { point = { 0, 0, 1 }, terrain = "recyclecenter_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_teashop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_teashop_north" },
        { point = { 0, 0, 1 }, terrain = "s_teashop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_teashop_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_teashop_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_teashop_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "s_teashop_upper_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "animalshelter",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "animalshelter_north" },
        { point = { 0, 0, 1 }, terrain = "animalshelter_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_antique",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_antique_north" },
        { point = { 0, 0, 1 }, terrain = "s_antique_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_dive_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_dive_shop_north" },
        { point = { 0, 0, 1 }, terrain = "s_dive_shop_roof_north" },
    },
}

-- All of those overmap specials that spawn also outside of town require a second declare as city_building.
ccb.content.define_city_building {
    id = "motel_city",
    locations = { "land" },
    tiles = {
        { point = { 1, 0, 0 }, terrain = "motel_entrance_north" },
        { point = { 0, 0, 0 }, terrain = "motel_1_north" },
        { point = { 0, 1, 0 }, terrain = "motel_2_north" },
        { point = { 1, 1, 0 }, terrain = "motel_3_north" },
        { point = { 1, 0, 1 }, terrain = "motel_entrance_roof_north" },
        { point = { 0, 0, 1 }, terrain = "motel_1_roof_north" },
        { point = { 0, 1, 1 }, terrain = "motel_2_roof_north" },
        { point = { 1, 1, 1 }, terrain = "motel_3_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "2fmotel_city",
    locations = { "land" },
    tiles = {
        { point = { 1, 0, 0 }, terrain = "motel_entrance_north" },
        { point = { 0, 0, 0 }, terrain = "motel_1_north" },
        { point = { 0, 1, 0 }, terrain = "motel_2_north" },
        { point = { 1, 1, 0 }, terrain = "motel_3_north" },
        { point = { 1, 0, 1 }, terrain = "2fmotel_entrance_f2_north" },
        { point = { 0, 0, 1 }, terrain = "2fmotel_1_f2_north" },
        { point = { 0, 1, 1 }, terrain = "2fmotel_2_f2_north" },
        { point = { 1, 1, 1 }, terrain = "2fmotel_3_f2_north" },
        { point = { 0, 0, 2 }, terrain = "2fmotel_1_r_north" },
        { point = { 0, 1, 2 }, terrain = "2fmotel_2_r_north" },
        { point = { 1, 1, 2 }, terrain = "2fmotel_3_r_north" },
    },
}

ccb.content.define_city_building {
    id = "s_sports",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_sports_north" },
        { point = { 0, 0, 1 }, terrain = "s_sports_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "pawn",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pawn_north" },
        { point = { 0, 0, 1 }, terrain = "pawn_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "pawn_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pawn_1_north" },
        { point = { 0, 0, 1 }, terrain = "pawn_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "dollarstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dollarstore_north" },
        { point = { 0, 0, 1 }, terrain = "dollarstore_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "dollarstore_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dollarstore_1_north" },
        { point = { 0, 0, 1 }, terrain = "dollarstore_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "garage_gas_city",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "garage_gas_1_north" },
        { point = { 0, 0, 1 }, terrain = "garage_gas_roof_1_north" },
        { point = { 1, 0, 0 }, terrain = "garage_gas_2_north" },
        { point = { 1, 0, 1 }, terrain = "garage_gas_roof_2_north" },
        { point = { 2, 0, 0 }, terrain = "garage_gas_3_north" },
        { point = { 2, 0, 1 }, terrain = "garage_gas_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "cemetery_religious_city",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, 0 }, terrain = "cemetery_4square_00_south" },
        { point = { 0, 1, 0 }, terrain = "cemetery_4square_10_south" },
        { point = { 1, 0, 0 }, terrain = "cemetery_4square_01_south" },
        { point = { 0, 0, 0 }, terrain = "cemetery_4square_11_south" },
        { point = { 0, 0, 1 }, terrain = "cemetery_4square_11_roof_south" },
    },
}

ccb.content.define_city_building {
    id = "cemetery_city",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 1 }, terrain = "Cemetery_1a_roof_north" },
        { point = { 0, 0, 0 }, terrain = "Cemetery_1a_north" },
        { point = { 1, 0, 0 }, terrain = "Cemetery_1b_north" },
    },
}

ccb.content.define_city_building {
    id = "station_radio",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "station_radio_north" },
        { point = { 0, 0, 1 }, terrain = "station_radio_roof_north" },
        { point = { 0, 0, 2 }, terrain = "station_radio_tower_even_north" },
        { point = { 0, 0, 3 }, terrain = "station_radio_tower_odd_north" },
        { point = { 0, 0, 4 }, terrain = "station_radio_tower_even_north" },
        { point = { 0, 0, 5 }, terrain = "station_radio_tower_odd_north" },
        { point = { 0, 0, 6 }, terrain = "station_radio_tower_top_north" },
    },
}

ccb.content.define_city_building {
    id = "station_radio_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "station_radio_1_north" },
        { point = { 0, 0, 1 }, terrain = "station_radio_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "station_radio_1_tower_even_north" },
        { point = { 0, 0, 3 }, terrain = "station_radio_1_tower_odd_north" },
        { point = { 0, 0, 4 }, terrain = "station_radio_1_tower_even_north" },
        { point = { 0, 0, 5 }, terrain = "station_radio_1_tower_odd_north" },
        { point = { 0, 0, 6 }, terrain = "station_radio_1_tower_top_north" },
    },
}

ccb.content.define_city_building {
    id = "fishing_pond_city",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "fishing_pond_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "fishing_pond_1_0_north" },
        { point = { 0, 1, 0 }, terrain = "fishing_pond_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "fishing_pond_1_1_north" },
    },
    city_sizes = { 0, 8 },
}

ccb.content.define_city_building {
    id = "public_pond_city",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "PublicPond_1a_north" },
        { point = { 1, 0, 0 }, terrain = "PublicPond_1b_north" },
    },
}

ccb.content.define_city_building {
    id = "small_office",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "small_office_north" },
        { point = { 0, 0, 1 }, terrain = "small_office_roof_north" },
        { point = { 0, 0, 2 }, terrain = "small_office_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "hotel_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hotel_tower_1_3_north" },
        { point = { 1, 0, 0 }, terrain = "hotel_tower_1_2_north" },
        { point = { 2, 0, 0 }, terrain = "hotel_tower_1_1_north" },
        { point = { 0, 1, 0 }, terrain = "hotel_tower_1_6_north" },
        { point = { 0, 1, 1 }, terrain = "hotel_tower_flr2_1_6_north" },
        { point = { 0, 1, 2 }, terrain = "hotel_tower_flr3_1_6_north" },
        { point = { 0, 1, 3 }, terrain = "hotel_tower_flr4_1_6_north" },
        { point = { 0, 1, 4 }, terrain = "hotel_tower_roof_1_6_north" },
        { point = { 1, 1, 0 }, terrain = "hotel_tower_1_5_north" },
        { point = { 1, 1, 1 }, terrain = "hotel_tower_flr2_1_5_north" },
        { point = { 1, 1, 2 }, terrain = "hotel_tower_flr3_1_5_north" },
        { point = { 1, 1, 3 }, terrain = "hotel_tower_flr4_1_5_north" },
        { point = { 1, 1, 4 }, terrain = "hotel_tower_roof_1_5_north" },
        { point = { 2, 1, 0 }, terrain = "hotel_tower_1_4_north" },
        { point = { 2, 1, 1 }, terrain = "hotel_tower_flr2_1_4_north" },
        { point = { 2, 1, 2 }, terrain = "hotel_tower_flr3_1_4_north" },
        { point = { 2, 1, 3 }, terrain = "hotel_tower_flr4_1_4_north" },
        { point = { 2, 1, 4 }, terrain = "hotel_tower_roof_1_4_north" },
        { point = { 0, 2, 0 }, terrain = "hotel_tower_1_9_north" },
        { point = { 0, 2, 1 }, terrain = "hotel_tower_flr2_1_9_north" },
        { point = { 0, 2, 2 }, terrain = "hotel_tower_flr3_1_9_north" },
        { point = { 0, 2, 3 }, terrain = "hotel_tower_flr4_1_9_north" },
        { point = { 0, 2, 4 }, terrain = "hotel_tower_roof_1_9_north" },
        { point = { 0, 2, 5 }, terrain = "hotel_tower_6_1_9_north" },
        { point = { 1, 2, 0 }, terrain = "hotel_tower_1_8_north" },
        { point = { 1, 2, 1 }, terrain = "hotel_tower_flr2_1_8_north" },
        { point = { 1, 2, 2 }, terrain = "hotel_tower_flr3_1_8_north" },
        { point = { 1, 2, 3 }, terrain = "hotel_tower_flr4_1_8_north" },
        { point = { 1, 2, 4 }, terrain = "hotel_tower_roof_1_8_north" },
        { point = { 1, 2, 5 }, terrain = "hotel_tower_6_1_8_north" },
        { point = { 2, 2, 0 }, terrain = "hotel_tower_1_7_north" },
        { point = { 2, 2, 1 }, terrain = "hotel_tower_flr2_1_7_north" },
        { point = { 2, 2, 2 }, terrain = "hotel_tower_flr3_1_7_north" },
        { point = { 2, 2, 3 }, terrain = "hotel_tower_flr4_1_7_north" },
        { point = { 2, 2, 4 }, terrain = "hotel_tower_roof_1_7_north" },
        { point = { 2, 2, 5 }, terrain = "hotel_tower_6_1_7_north" },
        { point = { 0, 2, -1 }, terrain = "hotel_tower_b_3_north" },
        { point = { 1, 2, -1 }, terrain = "hotel_tower_b_2_north" },
        { point = { 2, 2, -1 }, terrain = "hotel_tower_b_1_north" },
    },
    city_sizes = { 12, -1 },
}

ccb.content.define_city_building {
    id = "hotel_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hotel_tower_1_3_north" },
        { point = { 1, 0, 0 }, terrain = "hotel_tower_1_2_north" },
        { point = { 2, 0, 0 }, terrain = "hotel_tower_1_1_north" },
        { point = { 0, 1, 0 }, terrain = "hotel_tower_1_6_north" },
        { point = { 0, 1, 1 }, terrain = "hotel_tower_flr2_1_6_north" },
        { point = { 0, 1, 2 }, terrain = "hotel_tower_flr3_1_6_north" },
        { point = { 0, 1, 3 }, terrain = "hotel_tower_flr4_1_6_north" },
        { point = { 0, 1, 4 }, terrain = "hotel_tower_roof_1_6_north" },
        { point = { 1, 1, 0 }, terrain = "hotel_tower_1_5B_north" },
        { point = { 1, 1, 1 }, terrain = "hotel_tower_flr2_1_5B_north" },
        { point = { 1, 1, 2 }, terrain = "hotel_tower_flr3_1_5_north" },
        { point = { 1, 1, 3 }, terrain = "hotel_tower_flr4_1_5_north" },
        { point = { 1, 1, 4 }, terrain = "hotel_tower_roof_1_5_north" },
        { point = { 2, 1, 0 }, terrain = "hotel_tower_1_4_north" },
        { point = { 2, 1, 1 }, terrain = "hotel_tower_flr2_1_4_north" },
        { point = { 2, 1, 2 }, terrain = "hotel_tower_flr3_1_4_north" },
        { point = { 2, 1, 3 }, terrain = "hotel_tower_flr4_1_4_north" },
        { point = { 2, 1, 4 }, terrain = "hotel_tower_roof_1_4_north" },
        { point = { 0, 2, 0 }, terrain = "hotel_tower_1_9_north" },
        { point = { 0, 2, 1 }, terrain = "hotel_tower_flr2_1_9_north" },
        { point = { 0, 2, 2 }, terrain = "hotel_tower_flr3_1_9_north" },
        { point = { 0, 2, 3 }, terrain = "hotel_tower_flr4_1_9_north" },
        { point = { 0, 2, 4 }, terrain = "hotel_tower_roof_1_9_north" },
        { point = { 0, 2, 5 }, terrain = "hotel_tower_6_1_9_north" },
        { point = { 1, 2, 0 }, terrain = "hotel_tower_1_8_north" },
        { point = { 1, 2, 1 }, terrain = "hotel_tower_flr2_1_8_north" },
        { point = { 1, 2, 2 }, terrain = "hotel_tower_flr3_1_8_north" },
        { point = { 1, 2, 3 }, terrain = "hotel_tower_flr4_1_8_north" },
        { point = { 1, 2, 4 }, terrain = "hotel_tower_roof_1_8_north" },
        { point = { 1, 2, 5 }, terrain = "hotel_tower_6_1_8_north" },
        { point = { 2, 2, 0 }, terrain = "hotel_tower_1_7_north" },
        { point = { 2, 2, 1 }, terrain = "hotel_tower_flr2_1_7_north" },
        { point = { 2, 2, 2 }, terrain = "hotel_tower_flr3_1_7_north" },
        { point = { 2, 2, 3 }, terrain = "hotel_tower_flr4_1_7_north" },
        { point = { 2, 2, 4 }, terrain = "hotel_tower_roof_1_7_north" },
        { point = { 2, 2, 5 }, terrain = "hotel_tower_6_1_7_north" },
        { point = { 0, 2, -1 }, terrain = "hotel_tower_b_3_north" },
        { point = { 1, 2, -1 }, terrain = "hotel_tower_b_2_north" },
        { point = { 2, 2, -1 }, terrain = "hotel_tower_b_1_north" },
    },
    city_sizes = { 12, -1 },
}

ccb.content.define_city_building {
    id = "hotel_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hotel_tower_1_3_north" },
        { point = { 1, 0, 0 }, terrain = "hotel_tower_1_2_north" },
        { point = { 2, 0, 0 }, terrain = "hotel_tower_1_1_north" },
        { point = { 0, 1, 0 }, terrain = "hotel_tower_1_6_north" },
        { point = { 0, 1, 1 }, terrain = "hotel_tower_flr2_1_6_north" },
        { point = { 0, 1, 2 }, terrain = "hotel_tower_flr3_1_6_north" },
        { point = { 0, 1, 3 }, terrain = "hotel_tower_flr4_1_6_north" },
        { point = { 0, 1, 4 }, terrain = "hotel_tower_roof_1_6_north" },
        { point = { 1, 1, 0 }, terrain = "hotel_tower_1_5C_north" },
        { point = { 1, 1, 1 }, terrain = "hotel_tower_flr2_1_5C_north" },
        { point = { 1, 1, 2 }, terrain = "hotel_tower_flr3_1_5_north" },
        { point = { 1, 1, 3 }, terrain = "hotel_tower_flr4_1_5_north" },
        { point = { 1, 1, 4 }, terrain = "hotel_tower_roof_1_5_north" },
        { point = { 2, 1, 0 }, terrain = "hotel_tower_1_4_north" },
        { point = { 2, 1, 1 }, terrain = "hotel_tower_flr2_1_4_north" },
        { point = { 2, 1, 2 }, terrain = "hotel_tower_flr3_1_4_north" },
        { point = { 2, 1, 3 }, terrain = "hotel_tower_flr4_1_4_north" },
        { point = { 2, 1, 4 }, terrain = "hotel_tower_roof_1_4_north" },
        { point = { 0, 2, 0 }, terrain = "hotel_tower_1_9_north" },
        { point = { 0, 2, 1 }, terrain = "hotel_tower_flr2_1_9_north" },
        { point = { 0, 2, 2 }, terrain = "hotel_tower_flr3_1_9_north" },
        { point = { 0, 2, 3 }, terrain = "hotel_tower_flr4_1_9_north" },
        { point = { 0, 2, 4 }, terrain = "hotel_tower_roof_1_9_north" },
        { point = { 0, 2, 5 }, terrain = "hotel_tower_6_1_9_north" },
        { point = { 1, 2, 0 }, terrain = "hotel_tower_1_8_north" },
        { point = { 1, 2, 1 }, terrain = "hotel_tower_flr2_1_8_north" },
        { point = { 1, 2, 2 }, terrain = "hotel_tower_flr3_1_8_north" },
        { point = { 1, 2, 3 }, terrain = "hotel_tower_flr4_1_8_north" },
        { point = { 1, 2, 4 }, terrain = "hotel_tower_roof_1_8_north" },
        { point = { 1, 2, 5 }, terrain = "hotel_tower_6_1_8_north" },
        { point = { 2, 2, 0 }, terrain = "hotel_tower_1_7_north" },
        { point = { 2, 2, 1 }, terrain = "hotel_tower_flr2_1_7_north" },
        { point = { 2, 2, 2 }, terrain = "hotel_tower_flr3_1_7_north" },
        { point = { 2, 2, 3 }, terrain = "hotel_tower_flr4_1_7_north" },
        { point = { 2, 2, 4 }, terrain = "hotel_tower_roof_1_7_north" },
        { point = { 2, 2, 5 }, terrain = "hotel_tower_6_1_7_north" },
        { point = { 0, 2, -1 }, terrain = "hotel_tower_b_3_north" },
        { point = { 1, 2, -1 }, terrain = "hotel_tower_b_2_north" },
        { point = { 2, 2, -1 }, terrain = "hotel_tower_b_1_north" },
    },
    city_sizes = { 12, -1 },
}

ccb.content.define_city_building {
    id = "megastore",
    locations = { "land" },
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
    city_sizes = { 12, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "hospital",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hospital_3_north" },
        { point = { 1, 0, 0 }, terrain = "hospital_2_north" },
        { point = { 2, 0, 0 }, terrain = "hospital_1_north" },
        { point = { 0, 1, 0 }, terrain = "hospital_6_north" },
        { point = { 1, 1, 0 }, terrain = "hospital_5_north" },
        { point = { 2, 1, 0 }, terrain = "hospital_4_north" },
        { point = { 0, 2, 0 }, terrain = "hospital_9_north" },
        { point = { 1, 2, 0 }, terrain = "hospital_8_north" },
        { point = { 2, 2, 0 }, terrain = "hospital_7_north" },
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
    city_sizes = { 12, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "urban_35_hospital",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, -1 }, terrain = "urban_35_1_south" },
        { point = { 0, 1, -1 }, terrain = "urban_35_2_south" },
        { point = { 1, 0, -1 }, terrain = "urban_35_3_south" },
        { point = { 0, 0, -1 }, terrain = "urban_35_4_south" },
        { point = { -1, 1, 0 }, terrain = "urban_35_34_south" },
        { point = { -1, 0, 0 }, terrain = "urban_35_35_south" },
        { point = { 1, 1, 0 }, terrain = "urban_35_5_south" },
        { point = { 0, 1, 0 }, terrain = "urban_35_6_south" },
        { point = { 1, 0, 0 }, terrain = "urban_35_7_south" },
        { point = { 0, 0, 0 }, terrain = "urban_35_8_south" },
        { point = { 1, 1, 1 }, terrain = "urban_35_9_south" },
        { point = { 0, 1, 1 }, terrain = "urban_35_10_south" },
        { point = { 1, 0, 1 }, terrain = "urban_35_11_south" },
        { point = { 0, 0, 1 }, terrain = "urban_35_12_south" },
        { point = { 1, 1, 2 }, terrain = "urban_35_13_south" },
        { point = { 0, 1, 2 }, terrain = "urban_35_14_south" },
        { point = { 1, 0, 2 }, terrain = "urban_35_15_south" },
        { point = { 0, 0, 2 }, terrain = "urban_35_16_south" },
        { point = { 1, 1, 3 }, terrain = "urban_35_17_south" },
        { point = { 0, 1, 3 }, terrain = "urban_35_18_south" },
        { point = { 1, 0, 3 }, terrain = "urban_35_19_south" },
        { point = { 0, 0, 3 }, terrain = "urban_35_20_south" },
        { point = { 1, 1, 4 }, terrain = "urban_35_21_south" },
        { point = { 0, 1, 4 }, terrain = "urban_35_22_south" },
        { point = { 1, 0, 4 }, terrain = "urban_35_23_south" },
        { point = { 0, 0, 4 }, terrain = "urban_35_24_south" },
        { point = { 1, 1, 5 }, terrain = "urban_35_25_south" },
        { point = { 0, 1, 5 }, terrain = "urban_35_26_south" },
        { point = { 1, 0, 5 }, terrain = "urban_35_27_south" },
        { point = { 0, 0, 5 }, terrain = "urban_35_28_south" },
        { point = { 1, 1, 6 }, terrain = "urban_35_29_south" },
        { point = { 0, 1, 6 }, terrain = "urban_35_30_south" },
        { point = { 1, 0, 6 }, terrain = "urban_35_31_south" },
        { point = { 0, 0, 6 }, terrain = "urban_35_32_south" },
        { point = { 1, 0, 7 }, terrain = "urban_35_33_south" },
    },
    city_sizes = { 8, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "public_works",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "public_works_NW_north" },
        { point = { 0, 0, 1 }, terrain = "public_works_NW_roof_north" },
        { point = { 1, 0, 0 }, terrain = "public_works_NE_north" },
        { point = { 1, 0, 1 }, terrain = "public_works_NE_roof_north" },
        { point = { 0, 1, 0 }, terrain = "public_works_SW_north" },
        { point = { 0, 1, 1 }, terrain = "public_works_SW_roof_north" },
        { point = { 1, 1, 0 }, terrain = "public_works_SE_north" },
        { point = { 1, 1, 1 }, terrain = "public_works_SE_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "apartments_mod",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, 1 }, terrain = "apartments_mod_tower_113_south" },
        { point = { 0, 1, 1 }, terrain = "apartments_mod_tower_013_south" },
        { point = { 1, 0, 1 }, terrain = "apartments_mod_tower_103_south" },
        { point = { 0, 0, 1 }, terrain = "apartments_mod_tower_003_south" },
    },
}

ccb.content.define_city_building {
    id = "apartments_con_new",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, 0 }, terrain = "apartments_con_tower_110_south" },
        { point = { 0, 1, 0 }, terrain = "apartments_con_tower_010_south" },
        { point = { 1, 0, 0 }, terrain = "apartments_con_tower_100_south" },
        { point = { 0, 0, 0 }, terrain = "apartments_con_tower_000_south" },
        { point = { 1, 1, 1 }, terrain = "apartments_con_tower_111_south" },
        { point = { 0, 1, 1 }, terrain = "apartments_con_tower_011_south" },
        { point = { 1, 0, 1 }, terrain = "apartments_con_tower_102_south" },
        { point = { 0, 0, 1 }, terrain = "apartments_con_tower_002_south" },
        { point = { 1, 1, 2 }, terrain = "apartments_con_tower_113_south" },
        { point = { 0, 1, 2 }, terrain = "apartments_con_tower_013_south" },
        { point = { 1, 0, 2 }, terrain = "apartments_con_tower_102_south" },
        { point = { 0, 0, 2 }, terrain = "apartments_con_tower_002_south" },
        { point = { 1, 1, 3 }, terrain = "apartments_con_tower_112_south" },
        { point = { 0, 1, 3 }, terrain = "apartments_con_tower_012_south" },
        { point = { 1, 0, 3 }, terrain = "apartments_con_tower_102_south" },
        { point = { 0, 0, 3 }, terrain = "apartments_con_tower_002_south" },
        { point = { 1, 1, 4 }, terrain = "apartments_con_tower_113_south" },
        { point = { 0, 1, 4 }, terrain = "apartments_con_tower_013_south" },
        { point = { 1, 0, 4 }, terrain = "apartments_con_tower_102_south" },
        { point = { 0, 0, 4 }, terrain = "apartments_con_tower_002_south" },
        { point = { 1, 1, 5 }, terrain = "apartments_con_tower_112_south" },
        { point = { 0, 1, 5 }, terrain = "apartments_con_tower_012_south" },
        { point = { 1, 0, 5 }, terrain = "apartments_con_tower_102_south" },
        { point = { 0, 0, 5 }, terrain = "apartments_con_tower_002_south" },
        { point = { 1, 1, 6 }, terrain = "apartments_con_tower_114_south" },
        { point = { 0, 1, 6 }, terrain = "apartments_con_tower_014_south" },
        { point = { 1, 1, 7 }, terrain = "apartments_con_tower_115_south" },
        { point = { 0, 1, 7 }, terrain = "apartments_con_tower_015_south" },
        { point = { 1, 0, 6 }, terrain = "apartments_con_tower_104_south" },
        { point = { 0, 0, 6 }, terrain = "apartments_con_tower_004_south" },
    },
}

ccb.content.define_city_building {
    id = "apartments_mod_new",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, 0 }, terrain = "apartments_mod_tower_110_south" },
        { point = { 0, 1, 0 }, terrain = "apartments_mod_tower_010_south" },
        { point = { 1, 0, 0 }, terrain = "apartments_mod_tower_100_south" },
        { point = { 0, 0, 0 }, terrain = "apartments_mod_tower_000_south" },
        { point = { 1, 1, 1 }, terrain = "apartments_mod_tower_111_south" },
        { point = { 0, 1, 1 }, terrain = "apartments_mod_tower_011_south" },
        { point = { 1, 0, 1 }, terrain = "apartments_mod_tower_101_south" },
        { point = { 0, 0, 1 }, terrain = "apartments_mod_tower_001_south" },
        { point = { 1, 1, 2 }, terrain = "apartments_mod_tower_112_south" },
        { point = { 0, 1, 2 }, terrain = "apartments_mod_tower_012_south" },
        { point = { 1, 0, 2 }, terrain = "apartments_mod_tower_101_south" },
        { point = { 0, 0, 2 }, terrain = "apartments_mod_tower_001_south" },
        { point = { 1, 1, 3 }, terrain = "apartments_mod_tower_111_south" },
        { point = { 0, 1, 3 }, terrain = "apartments_mod_tower_011_south" },
        { point = { 1, 0, 3 }, terrain = "apartments_mod_tower_101_south" },
        { point = { 0, 0, 3 }, terrain = "apartments_mod_tower_001_south" },
        { point = { 1, 1, 4 }, terrain = "apartments_mod_tower_112_south" },
        { point = { 0, 1, 4 }, terrain = "apartments_mod_tower_012_south" },
        { point = { 1, 0, 4 }, terrain = "apartments_mod_tower_101_south" },
        { point = { 0, 0, 4 }, terrain = "apartments_mod_tower_001_south" },
        { point = { 1, 1, 5 }, terrain = "apartments_mod_tower_113_south" },
        { point = { 0, 1, 5 }, terrain = "apartments_mod_tower_013_south" },
        { point = { 1, 0, 5 }, terrain = "apartments_mod_tower_103_south" },
        { point = { 0, 0, 5 }, terrain = "apartments_mod_tower_003_south" },
        { point = { 1, 1, 6 }, terrain = "apartments_mod_tower_shack_roof_south" },
    },
}

ccb.content.define_city_building {
    id = "s_apt",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_apt_north" },
        { point = { 0, 0, 1 }, terrain = "s_apt_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "s_apt_roof_north" },
        { point = { 0, 0, 3 }, terrain = "s_apt_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_apt_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_apt_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_apt_2_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "s_apt_2_roof_north" },
        { point = { 0, 0, 3 }, terrain = "s_apt_2_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "apartment_complex_3x3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "apartment_complex_corner_ground_east" },
        { point = { 1, 0, 0 }, terrain = "apartment_complex_entrance_north" },
        { point = { 2, 0, 0 }, terrain = "apartment_complex_corner_ground_south" },
        { point = { 0, 1, 0 }, terrain = "apartment_complex_straight_ground_east" },
        { point = { 1, 1, 0 }, terrain = "apartment_complex_center_stairs_even_ground_north" },
        { point = { 2, 1, 0 }, terrain = "apartment_complex_straight_ground_west" },
        { point = { 0, 2, 0 }, terrain = "apartment_complex_corner_ground_north" },
        { point = { 1, 2, 0 }, terrain = "apartment_complex_straight_ground_north" },
        { point = { 2, 2, 0 }, terrain = "apartment_complex_corner_ground_west" },
        { point = { 0, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 1 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 1 }, terrain = "apartment_complex_center_stairs_odd_north" },
        { point = { 2, 1, 1 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 2, 1 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 2, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 2, 1 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 2 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 2 }, terrain = "apartment_complex_center_stairs_even_north" },
        { point = { 2, 1, 2 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 2, 2 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 2, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 2, 2 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 3 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 1, 0, 3 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 2, 0, 3 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 0, 1, 3 }, terrain = "apartment_complex_straight_roof_east" },
        { point = { 1, 1, 3 }, terrain = "apartment_complex_center_stairs_even_roof_north" },
        { point = { 1, 1, 4 }, terrain = "apartment_complex_center_stairs_roof_+1_north" },
        { point = { 2, 1, 3 }, terrain = "apartment_complex_straight_roof_west" },
        { point = { 0, 2, 3 }, terrain = "apartment_complex_corner_roof_north" },
        { point = { 1, 2, 3 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 2, 2, 3 }, terrain = "apartment_complex_corner_roof_west" },
    },
}

ccb.content.define_city_building {
    id = "apartment_complex_3x3_alt",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "apartment_complex_corner_ground_east" },
        { point = { 1, 0, 0 }, terrain = "apartment_complex_entrance_north" },
        { point = { 2, 0, 0 }, terrain = "apartment_complex_corner_ground_south" },
        { point = { 3, 0, 0 }, terrain = "parking_2x1_0_north" },
        { point = { 4, 0, 0 }, terrain = "parking_2x1_1_north" },
        { point = { 0, 1, 0 }, terrain = "apartment_complex_straight_ground_east" },
        { point = { 1, 1, 0 }, terrain = "apartment_complex_center_stairs_even_ground_north" },
        { point = { 2, 1, 0 }, terrain = "apartment_complex_corner_inner_ground_north" },
        { point = { 3, 1, 0 }, terrain = "apartment_complex_straight_ground_south" },
        { point = { 4, 1, 0 }, terrain = "apartment_complex_corner_ground_south" },
        { point = { 0, 2, 0 }, terrain = "apartment_complex_corner_ground_north" },
        { point = { 1, 2, 0 }, terrain = "apartment_complex_straight_ground_north" },
        { point = { 2, 2, 0 }, terrain = "apartment_complex_straight_ground_north" },
        { point = { 3, 2, 0 }, terrain = "apartment_complex_straight_stairs_even_ground_north" },
        { point = { 4, 2, 0 }, terrain = "apartment_complex_corner_ground_west" },
        { point = { 0, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 1 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 1 }, terrain = "apartment_complex_center_stairs_odd_north" },
        { point = { 2, 1, 1 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 3, 1, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 1, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 2, 1 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 2, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 2, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 2, 1 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 4, 2, 1 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 2 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 2 }, terrain = "apartment_complex_center_stairs_even_north" },
        { point = { 2, 1, 2 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 3, 1, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 1, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 2, 2 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 2, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 2, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 2, 2 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 4, 2, 2 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 3 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 3 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 3 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 3 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 3 }, terrain = "apartment_complex_center_stairs_odd_north" },
        { point = { 2, 1, 3 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 3, 1, 3 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 1, 3 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 2, 3 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 2, 3 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 2, 3 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 2, 3 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 4, 2, 3 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 4 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 1, 0, 4 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 2, 0, 4 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 0, 1, 4 }, terrain = "apartment_complex_straight_roof_east" },
        { point = { 1, 1, 4 }, terrain = "apartment_complex_center_stairs_odd_roof_north" },
        { point = { 1, 1, 5 }, terrain = "apartment_complex_center_stairs_roof_+1_north" },
        { point = { 2, 1, 4 }, terrain = "apartment_complex_corner_inner_roof_north" },
        { point = { 3, 1, 4 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 4, 1, 4 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 0, 2, 4 }, terrain = "apartment_complex_corner_roof_north" },
        { point = { 1, 2, 4 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 2, 2, 4 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 3, 2, 4 }, terrain = "apartment_complex_straight_stairs_odd_roof_north" },
        { point = { 3, 2, 5 }, terrain = "apartment_complex_straight_stairs_roof_+1_north" },
        { point = { 4, 2, 4 }, terrain = "apartment_complex_corner_roof_west" },
    },
}

ccb.content.define_city_building {
    id = "apartment_complex_line",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "apartment_complex_garage_corner_east" },
        { point = { 1, 0, 0 }, terrain = "apartment_complex_garage_straight_south" },
        { point = { 2, 0, 0 }, terrain = "apartment_complex_garage_straight_gate_wallALT_south" },
        { point = { 3, 0, 0 }, terrain = "apartment_complex_entrance_north" },
        { point = { 4, 0, 0 }, terrain = "apartment_complex_corner_ground_south" },
        { point = { 0, 1, 0 }, terrain = "apartment_complex_garage_corner_north" },
        { point = { 1, 1, 0 }, terrain = "apartment_complex_garage_straight_north" },
        { point = { 2, 1, 0 }, terrain = "apartment_complex_garage_straight_wall_north" },
        { point = { 3, 1, 0 }, terrain = "apartment_complex_straight_stairs_even_ground_north" },
        { point = { 4, 1, 0 }, terrain = "apartment_complex_corner_ground_west" },
        { point = { 0, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 0, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 1 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 1, 1 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 2, 1, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 1, 1 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 4, 1, 1 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 0, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 2 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 1, 2 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 2, 1, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 1, 2 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 4, 1, 2 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 3 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 3 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 3 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 0, 3 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 0, 3 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 3 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 1, 3 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 2, 1, 3 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 1, 3 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 4, 1, 3 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 4 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 4 }, terrain = "apartment_complex_straight_south" },
        { point = { 2, 0, 4 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 0, 4 }, terrain = "apartment_complex_straight_south" },
        { point = { 4, 0, 4 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 4 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 1, 4 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 2, 1, 4 }, terrain = "apartment_complex_straight_north" },
        { point = { 3, 1, 4 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 4, 1, 4 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 5 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 1, 0, 5 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 2, 0, 5 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 3, 0, 5 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 4, 0, 5 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 0, 1, 5 }, terrain = "apartment_complex_corner_roof_north" },
        { point = { 1, 1, 5 }, terrain = "apartment_complex_straight_stairs_even_roof_north" },
        { point = { 1, 1, 6 }, terrain = "apartment_complex_straight_stairs_roof_+1_north" },
        { point = { 2, 1, 5 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 3, 1, 5 }, terrain = "apartment_complex_straight_stairs_even_roof_north" },
        { point = { 3, 1, 6 }, terrain = "apartment_complex_straight_stairs_roof_+1_north" },
        { point = { 4, 1, 5 }, terrain = "apartment_complex_corner_roof_west" },
    },
}

ccb.content.define_city_building {
    id = "apartment_complex_U",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "apartment_complex_garage_corner_gate_L_east" },
        { point = { 1, 0, 0 }, terrain = "apartment_complex_garage_corner_gate_R_south" },
        { point = { 2, 0, 0 }, terrain = "apartment_complex_courtyard_south" },
        { point = { 3, 0, 0 }, terrain = "apartment_complex_corner_ground_east" },
        { point = { 4, 0, 0 }, terrain = "apartment_complex_corner_ground_south" },
        { point = { 0, 1, 0 }, terrain = "apartment_complex_garage_straight_east" },
        { point = { 1, 1, 0 }, terrain = "apartment_complex_garage_straight_west" },
        { point = { 2, 1, 0 }, terrain = "apartment_complex_courtyard_north" },
        { point = { 3, 1, 0 }, terrain = "apartment_complex_straight_stairs_even_ground_east" },
        { point = { 4, 1, 0 }, terrain = "apartment_complex_straight_ground_west" },
        { point = { 0, 2, 0 }, terrain = "apartment_complex_garage_straight_east" },
        { point = { 1, 2, 0 }, terrain = "apartment_complex_garage_corner_inner_wallALT_north" },
        { point = { 2, 2, 0 }, terrain = "apartment_complex_entrance_north" },
        { point = { 3, 2, 0 }, terrain = "apartment_complex_corner_inner_ground_west" },
        { point = { 4, 2, 0 }, terrain = "apartment_complex_straight_ground_west" },
        { point = { 0, 3, 0 }, terrain = "apartment_complex_garage_corner_north" },
        { point = { 1, 3, 0 }, terrain = "apartment_complex_garage_straight_wall_north" },
        { point = { 2, 3, 0 }, terrain = "apartment_complex_straight_stairs_even_ground_north" },
        { point = { 3, 3, 0 }, terrain = "apartment_complex_straight_ground_north" },
        { point = { 4, 3, 0 }, terrain = "apartment_complex_corner_ground_west" },
        { point = { 0, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 3, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 4, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 1 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 1 }, terrain = "apartment_complex_straight_stairs_odd_west" },
        { point = { 3, 1, 1 }, terrain = "apartment_complex_straight_stairs_odd_east" },
        { point = { 4, 1, 1 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 2, 1 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 2, 1 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 2, 2, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 2, 1 }, terrain = "apartment_complex_corner_inner_west" },
        { point = { 4, 2, 1 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 3, 1 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 3, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 3, 1 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 3, 3, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 4, 3, 1 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 3, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 4, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 2 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 2 }, terrain = "apartment_complex_straight_stairs_even_west" },
        { point = { 3, 1, 2 }, terrain = "apartment_complex_straight_stairs_even_east" },
        { point = { 4, 1, 2 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 2, 2 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 2, 2 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 2, 2, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 2, 2 }, terrain = "apartment_complex_corner_inner_west" },
        { point = { 4, 2, 2 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 3, 2 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 3, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 3, 2 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 3, 3, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 4, 3, 2 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 3 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 1, 0, 3 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 3, 0, 3 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 4, 0, 3 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 0, 1, 3 }, terrain = "apartment_complex_straight_roof_east" },
        { point = { 1, 1, 3 }, terrain = "apartment_complex_straight_stairs_even_roof_west" },
        { point = { 1, 1, 4 }, terrain = "apartment_complex_straight_stairs_roof_+1_west" },
        { point = { 3, 1, 3 }, terrain = "apartment_complex_straight_stairs_even_roof_east" },
        { point = { 3, 1, 4 }, terrain = "apartment_complex_straight_stairs_roof_+1_east" },
        { point = { 4, 1, 3 }, terrain = "apartment_complex_straight_roof_west" },
        { point = { 0, 2, 3 }, terrain = "apartment_complex_straight_roof_east" },
        { point = { 1, 2, 3 }, terrain = "apartment_complex_corner_inner_roof_north" },
        { point = { 2, 2, 3 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 3, 2, 3 }, terrain = "apartment_complex_corner_inner_roof_west" },
        { point = { 4, 2, 3 }, terrain = "apartment_complex_straight_roof_west" },
        { point = { 0, 3, 3 }, terrain = "apartment_complex_corner_roof_north" },
        { point = { 1, 3, 3 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 2, 3, 3 }, terrain = "apartment_complex_straight_stairs_even_roof_north" },
        { point = { 2, 3, 4 }, terrain = "apartment_complex_straight_stairs_roof_+1_north" },
        { point = { 3, 3, 3 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 4, 3, 3 }, terrain = "apartment_complex_corner_roof_west" },
    },
}

ccb.content.define_city_building {
    id = "apartment_complex_U_alt",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "apartment_complex_corner_ground_east" },
        { point = { 1, 0, 0 }, terrain = "apartment_complex_corner_ground_south" },
        { point = { 2, 0, 0 }, terrain = "apartment_complex_courtyard_south" },
        { point = { 3, 0, 0 }, terrain = "apartment_complex_garage_corner_gate_L_east" },
        { point = { 4, 0, 0 }, terrain = "apartment_complex_garage_corner_gate_R_south" },
        { point = { 0, 1, 0 }, terrain = "apartment_complex_straight_ground_east" },
        { point = { 1, 1, 0 }, terrain = "apartment_complex_straight_stairs_even_ground_west" },
        { point = { 2, 1, 0 }, terrain = "apartment_complex_courtyard_north" },
        { point = { 3, 1, 0 }, terrain = "apartment_complex_garage_straight_east" },
        { point = { 4, 1, 0 }, terrain = "apartment_complex_garage_straight_west" },
        { point = { 0, 2, 0 }, terrain = "apartment_complex_straight_ground_east" },
        { point = { 1, 2, 0 }, terrain = "apartment_complex_corner_inner_ground_north" },
        { point = { 2, 2, 0 }, terrain = "apartment_complex_entrance_north" },
        { point = { 3, 2, 0 }, terrain = "apartment_complex_garage_corner_inner_wall_west" },
        { point = { 4, 2, 0 }, terrain = "apartment_complex_garage_straight_west" },
        { point = { 0, 3, 0 }, terrain = "apartment_complex_corner_ground_north" },
        { point = { 1, 3, 0 }, terrain = "apartment_complex_straight_ground_north" },
        { point = { 2, 3, 0 }, terrain = "apartment_complex_straight_stairs_even_ground_north" },
        { point = { 3, 3, 0 }, terrain = "apartment_complex_garage_straight_wallALT_north" },
        { point = { 4, 3, 0 }, terrain = "apartment_complex_garage_corner_west" },
        { point = { 0, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 3, 0, 1 }, terrain = "apartment_complex_corner_east" },
        { point = { 4, 0, 1 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 1 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 1 }, terrain = "apartment_complex_straight_stairs_odd_west" },
        { point = { 3, 1, 1 }, terrain = "apartment_complex_straight_stairs_odd_east" },
        { point = { 4, 1, 1 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 2, 1 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 2, 1 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 2, 2, 1 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 2, 1 }, terrain = "apartment_complex_corner_inner_west" },
        { point = { 4, 2, 1 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 3, 1 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 3, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 3, 1 }, terrain = "apartment_complex_straight_stairs_odd_north" },
        { point = { 3, 3, 1 }, terrain = "apartment_complex_straight_north" },
        { point = { 4, 3, 1 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 1, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 3, 0, 2 }, terrain = "apartment_complex_corner_east" },
        { point = { 4, 0, 2 }, terrain = "apartment_complex_corner_south" },
        { point = { 0, 1, 2 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 1, 2 }, terrain = "apartment_complex_straight_stairs_even_west" },
        { point = { 3, 1, 2 }, terrain = "apartment_complex_straight_stairs_even_east" },
        { point = { 4, 1, 2 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 2, 2 }, terrain = "apartment_complex_straight_east" },
        { point = { 1, 2, 2 }, terrain = "apartment_complex_corner_inner_north" },
        { point = { 2, 2, 2 }, terrain = "apartment_complex_straight_south" },
        { point = { 3, 2, 2 }, terrain = "apartment_complex_corner_inner_west" },
        { point = { 4, 2, 2 }, terrain = "apartment_complex_straight_west" },
        { point = { 0, 3, 2 }, terrain = "apartment_complex_corner_north" },
        { point = { 1, 3, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 2, 3, 2 }, terrain = "apartment_complex_straight_stairs_even_north" },
        { point = { 3, 3, 2 }, terrain = "apartment_complex_straight_north" },
        { point = { 4, 3, 2 }, terrain = "apartment_complex_corner_west" },
        { point = { 0, 0, 3 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 1, 0, 3 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 3, 0, 3 }, terrain = "apartment_complex_corner_roof_east" },
        { point = { 4, 0, 3 }, terrain = "apartment_complex_corner_roof_south" },
        { point = { 0, 1, 3 }, terrain = "apartment_complex_straight_roof_east" },
        { point = { 1, 1, 3 }, terrain = "apartment_complex_straight_stairs_even_roof_west" },
        { point = { 1, 1, 4 }, terrain = "apartment_complex_straight_stairs_roof_+1_west" },
        { point = { 3, 1, 3 }, terrain = "apartment_complex_straight_stairs_even_roof_east" },
        { point = { 3, 1, 4 }, terrain = "apartment_complex_straight_stairs_roof_+1_east" },
        { point = { 4, 1, 3 }, terrain = "apartment_complex_straight_roof_west" },
        { point = { 0, 2, 3 }, terrain = "apartment_complex_straight_roof_east" },
        { point = { 1, 2, 3 }, terrain = "apartment_complex_corner_inner_roof_north" },
        { point = { 2, 2, 3 }, terrain = "apartment_complex_straight_roof_south" },
        { point = { 3, 2, 3 }, terrain = "apartment_complex_corner_inner_roof_west" },
        { point = { 4, 2, 3 }, terrain = "apartment_complex_straight_roof_west" },
        { point = { 0, 3, 3 }, terrain = "apartment_complex_corner_roof_north" },
        { point = { 1, 3, 3 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 2, 3, 3 }, terrain = "apartment_complex_straight_stairs_even_roof_north" },
        { point = { 2, 3, 4 }, terrain = "apartment_complex_straight_stairs_roof_+1_north" },
        { point = { 3, 3, 3 }, terrain = "apartment_complex_straight_roof_north" },
        { point = { 4, 3, 3 }, terrain = "apartment_complex_corner_roof_west" },
    },
}

ccb.content.define_city_building {
    id = "office_tower_large",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, 0 }, terrain = "loffice_tower_5_south" },
        { point = { 0, 1, 0 }, terrain = "loffice_tower_6_south" },
        { point = { 1, 0, 0 }, terrain = "loffice_tower_7_south" },
        { point = { 0, 0, 0 }, terrain = "loffice_tower_8_south" },
        { point = { 1, 1, -1 }, terrain = "loffice_tower_1_south" },
        { point = { 0, 1, -1 }, terrain = "loffice_tower_2_south" },
        { point = { 1, 0, -1 }, terrain = "loffice_tower_3_south" },
        { point = { 0, 0, -1 }, terrain = "loffice_tower_4_south" },
        { point = { 1, 1, 1 }, terrain = "loffice_tower_9_south" },
        { point = { 0, 1, 1 }, terrain = "loffice_tower_10_south" },
        { point = { 1, 0, 1 }, terrain = "loffice_tower_11_south" },
        { point = { 0, 0, 1 }, terrain = "loffice_tower_12_south" },
        { point = { 1, 1, 2 }, terrain = "loffice_tower_9b_south" },
        { point = { 0, 1, 2 }, terrain = "loffice_tower_10b_south" },
        { point = { 1, 0, 2 }, terrain = "loffice_tower_11_south" },
        { point = { 0, 0, 2 }, terrain = "loffice_tower_12_south" },
        { point = { 1, 1, 3 }, terrain = "loffice_tower_9_south" },
        { point = { 0, 1, 3 }, terrain = "loffice_tower_10_south" },
        { point = { 1, 0, 3 }, terrain = "loffice_tower_11_south" },
        { point = { 0, 0, 3 }, terrain = "loffice_tower_12_south" },
        { point = { 1, 1, 4 }, terrain = "loffice_tower_9b_south" },
        { point = { 0, 1, 4 }, terrain = "loffice_tower_10b_south" },
        { point = { 1, 0, 4 }, terrain = "loffice_tower_11_south" },
        { point = { 0, 0, 4 }, terrain = "loffice_tower_12_south" },
        { point = { 1, 1, 5 }, terrain = "loffice_tower_13_south" },
        { point = { 0, 1, 5 }, terrain = "loffice_tower_14_south" },
        { point = { 1, 0, 5 }, terrain = "loffice_tower_15_south" },
        { point = { 0, 0, 5 }, terrain = "loffice_tower_16_south" },
        { point = { 1, 1, 6 }, terrain = "loffice_tower_17_south" },
        { point = { 0, 1, 6 }, terrain = "loffice_tower_18_south" },
        { point = { 1, 0, 6 }, terrain = "loffice_tower_19_south" },
        { point = { 0, 0, 6 }, terrain = "loffice_tower_20_south" },
    },
    city_sizes = { 12, -1 },
}

ccb.content.define_city_building {
    id = "office_tower",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_tower_nw_north" },
        { point = { 1, 0, 0 }, terrain = "office_tower_ne_north" },
        { point = { 0, 1, 0 }, terrain = "office_tower_sw_north" },
        { point = { 1, 1, 0 }, terrain = "office_tower_se_north" },
        { point = { 0, 0, -1 }, terrain = "office_tower_underground_nw_north" },
        { point = { 1, 0, -1 }, terrain = "office_tower_underground_ne_north" },
        { point = { 0, 1, -1 }, terrain = "office_tower_underground_sw_north" },
        { point = { 1, 1, -1 }, terrain = "office_tower_underground_se_north" },
        { point = { 0, 0, 1 }, terrain = "office_tower_roof_nw_north" },
        { point = { 1, 0, 1 }, terrain = "office_tower_roof_ne_north" },
        { point = { 0, 1, 1 }, terrain = "office_tower_roof_sw_north" },
        { point = { 1, 1, 1 }, terrain = "office_tower_roof_se_north" },
        { point = { 1, 0, 2 }, terrain = "office_tower_roof_ne_roof_north" },
        { point = { 1, 1, 2 }, terrain = "office_tower_roof_se_roof_north" },
    },
    city_sizes = { 8, -1 },
}

ccb.content.define_city_building {
    id = "office_tower_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_tower_2_a1_north" },
        { point = { 1, 0, 0 }, terrain = "office_tower_2_a2_north" },
        { point = { 2, 0, 0 }, terrain = "office_tower_2_a3_north" },
        { point = { 0, 1, 0 }, terrain = "office_tower_2_b1_north" },
        { point = { 1, 1, 0 }, terrain = "office_tower_2_b2_north" },
        { point = { 2, 1, 0 }, terrain = "office_tower_2_b3_north" },
        { point = { 0, 0, 1 }, terrain = "office_tower_2_a1_1_north" },
        { point = { 1, 0, 1 }, terrain = "office_tower_2_a2_1_north" },
        { point = { 2, 0, 1 }, terrain = "office_tower_2_a3_1_north" },
        { point = { 0, 1, 1 }, terrain = "office_tower_2_b1_1_north" },
        { point = { 1, 1, 1 }, terrain = "office_tower_2_b2_1_north" },
        { point = { 2, 1, 1 }, terrain = "office_tower_2_b3_1_north" },
        { point = { 0, 0, 2 }, terrain = "office_tower_2_a1_2_north" },
        { point = { 1, 0, 2 }, terrain = "office_tower_2_a2_2_north" },
        { point = { 0, 1, 2 }, terrain = "office_tower_2_b1_2_north" },
        { point = { 1, 1, 2 }, terrain = "office_tower_2_b2_2_north" },
        { point = { 2, 1, 2 }, terrain = "office_tower_2_b3_2_north" },
        { point = { 0, 0, 3 }, terrain = "office_tower_2_a1_roof_north" },
        { point = { 1, 0, 3 }, terrain = "office_tower_2_a2_roof_north" },
        { point = { 0, 1, 3 }, terrain = "office_tower_2_b1_roof_north" },
        { point = { 1, 1, 3 }, terrain = "office_tower_2_b2_roof_north" },
        { point = { 2, 1, 3 }, terrain = "office_tower_2_b3_roof_north" },
    },
    city_sizes = { 10, -1 },
}

ccb.content.define_city_building {
    id = "cathedral",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 6 }, terrain = "cathedral_7_NW_north" },
        { point = { 1, 0, 6 }, terrain = "cathedral_7_NE_north" },
        { point = { 0, 0, 5 }, terrain = "cathedral_6_NW_north" },
        { point = { 1, 0, 5 }, terrain = "cathedral_6_NE_north" },
        { point = { 0, 0, 4 }, terrain = "cathedral_5_NW_north" },
        { point = { 1, 0, 4 }, terrain = "cathedral_5_NE_north" },
        { point = { 0, 0, 3 }, terrain = "cathedral_4_NW_north" },
        { point = { 1, 0, 3 }, terrain = "cathedral_4_NE_north" },
        { point = { 0, 0, 2 }, terrain = "cathedral_3_NW_north" },
        { point = { 1, 0, 2 }, terrain = "cathedral_3_NE_north" },
        { point = { 0, 1, 2 }, terrain = "cathedral_3_SW_north" },
        { point = { 1, 1, 2 }, terrain = "cathedral_3_SE_north" },
        { point = { 0, 0, 1 }, terrain = "cathedral_2_NW_north" },
        { point = { 1, 0, 1 }, terrain = "cathedral_2_NE_north" },
        { point = { 0, 1, 1 }, terrain = "cathedral_2_SW_north" },
        { point = { 1, 1, 1 }, terrain = "cathedral_2_SE_north" },
        { point = { 0, 0, 0 }, terrain = "cathedral_1_NW_north" },
        { point = { 1, 0, 0 }, terrain = "cathedral_1_NE_north" },
        { point = { 0, 1, 0 }, terrain = "cathedral_1_SW_north" },
        { point = { 1, 1, 0 }, terrain = "cathedral_1_SE_north" },
        { point = { 0, 0, -1 }, terrain = "cathedral_b_NW_north" },
        { point = { 1, 0, -1 }, terrain = "cathedral_b_NE_north" },
        { point = { 0, 1, -1 }, terrain = "cathedral_b_SW_north" },
        { point = { 1, 1, -1 }, terrain = "cathedral_b_SE_north" },
    },
    city_sizes = { 14, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "school",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "school_1_3_north" },
        { point = { 1, 0, 0 }, terrain = "school_1_2_north" },
        { point = { 2, 0, 0 }, terrain = "school_1_1_north" },
        { point = { 0, 1, 0 }, terrain = "school_1_6_north" },
        { point = { 1, 1, 0 }, terrain = "school_1_5_north" },
        { point = { 2, 1, 0 }, terrain = "school_1_4_north" },
        { point = { 0, 2, 0 }, terrain = "school_1_9_north" },
        { point = { 1, 2, 0 }, terrain = "school_1_8_north" },
        { point = { 2, 2, 0 }, terrain = "school_1_7_north" },
        { point = { 1, 0, 1 }, terrain = "school_2_2_north" },
        { point = { 2, 0, 1 }, terrain = "school_2_1_north" },
        { point = { 0, 1, 1 }, terrain = "school_2_6_north" },
        { point = { 1, 1, 1 }, terrain = "school_2_5_north" },
        { point = { 2, 1, 1 }, terrain = "school_2_4_north" },
        { point = { 0, 2, 1 }, terrain = "school_2_9_north" },
        { point = { 1, 2, 1 }, terrain = "school_2_8_north" },
        { point = { 2, 2, 1 }, terrain = "school_2_7_north" },
        { point = { 1, 0, 2 }, terrain = "school_3_2_north" },
        { point = { 2, 0, 2 }, terrain = "school_3_1_north" },
        { point = { 0, 1, 2 }, terrain = "school_3_6_north" },
        { point = { 1, 1, 2 }, terrain = "school_3_5_north" },
        { point = { 2, 1, 2 }, terrain = "school_3_4_north" },
        { point = { 0, 2, 2 }, terrain = "school_3_9_north" },
        { point = { 1, 2, 2 }, terrain = "school_3_8_north" },
        { point = { 2, 2, 2 }, terrain = "school_3_7_north" },
        { point = { 1, 0, 3 }, terrain = "school_4_2_north" },
        { point = { 2, 0, 3 }, terrain = "school_4_1_north" },
        { point = { 0, 1, 3 }, terrain = "school_4_6_north" },
        { point = { 1, 1, 3 }, terrain = "school_4_5_north" },
        { point = { 2, 1, 3 }, terrain = "school_4_4_north" },
        { point = { 0, 2, 3 }, terrain = "school_4_9_north" },
        { point = { 1, 2, 3 }, terrain = "school_4_8_north" },
        { point = { 2, 2, 3 }, terrain = "school_4_7_north" },
        { point = { 0, 1, 4 }, terrain = "school_5_6_north" },
    },
}

ccb.content.define_city_building {
    id = "mall",
    locations = { "land" },
    tiles = {
        { point = { 8, 9, 0 }, terrain = "mall_a_1_south" },
        { point = { 7, 9, 0 }, terrain = "mall_a_2_south" },
        { point = { 6, 9, 0 }, terrain = "mall_a_3_south" },
        { point = { 6, 9, 1 }, terrain = "mall_b_3_south" },
        { point = { 6, 9, 2 }, terrain = "mall_a_3_roof_south" },
        { point = { 6, 9, 3 }, terrain = "mall_upper_roof_3_south" },
        { point = { 5, 9, 0 }, terrain = "mall_a_4_south" },
        { point = { 5, 9, 1 }, terrain = "mall_b_4_south" },
        { point = { 5, 9, 2 }, terrain = "mall_a_4_roof_south" },
        { point = { 5, 9, 3 }, terrain = "mall_upper_roof_4_south" },
        { point = { 4, 9, 0 }, terrain = "mall_a_5_south" },
        { point = { 4, 9, 1 }, terrain = "mall_b_5_south" },
        { point = { 4, 9, 2 }, terrain = "mall_a_5_roof_south" },
        { point = { 3, 9, 0 }, terrain = "mall_a_6_south" },
        { point = { 2, 9, 0 }, terrain = "mall_a_7_south" },
        { point = { 1, 9, 0 }, terrain = "mall_a_8_south" },
        { point = { 0, 9, 0 }, terrain = "mall_a_9_south" },
        { point = { 8, 8, 0 }, terrain = "mall_a_10_south" },
        { point = { 8, 8, 1 }, terrain = "mall_b_10_south" },
        { point = { 8, 8, 2 }, terrain = "mall_a_10_roof_south" },
        { point = { 7, 8, 0 }, terrain = "mall_a_11_south" },
        { point = { 7, 8, 1 }, terrain = "mall_b_11_south" },
        { point = { 7, 8, 2 }, terrain = "mall_a_11_roof_south" },
        { point = { 6, 8, 0 }, terrain = "mall_a_12_south" },
        { point = { 6, 8, 1 }, terrain = "mall_b_12_south" },
        { point = { 6, 8, 2 }, terrain = "mall_a_12_roof_south" },
        { point = { 6, 8, 3 }, terrain = "mall_upper_roof_12_south" },
        { point = { 5, 8, 0 }, terrain = "mall_a_13_south" },
        { point = { 5, 8, 1 }, terrain = "mall_b_13_south" },
        { point = { 5, 8, 2 }, terrain = "mall_a_13_roof_south" },
        { point = { 5, 8, 3 }, terrain = "mall_upper_roof_13_south" },
        { point = { 4, 8, 0 }, terrain = "mall_a_14_south" },
        { point = { 4, 8, 1 }, terrain = "mall_b_14_south" },
        { point = { 4, 8, 2 }, terrain = "mall_a_14_roof_south" },
        { point = { 3, 8, 0 }, terrain = "mall_a_15_south" },
        { point = { 2, 8, 0 }, terrain = "mall_a_16_south" },
        { point = { 1, 8, 0 }, terrain = "mall_a_17_south" },
        { point = { 0, 8, 0 }, terrain = "mall_a_18_south" },
        { point = { 8, 7, 0 }, terrain = "mall_a_19_south" },
        { point = { 8, 7, 1 }, terrain = "mall_b_19_south" },
        { point = { 8, 7, 2 }, terrain = "mall_a_19_roof_south" },
        { point = { 7, 7, 0 }, terrain = "mall_a_20_south" },
        { point = { 7, 7, 1 }, terrain = "mall_b_20_south" },
        { point = { 7, 7, 2 }, terrain = "mall_a_20_roof_south" },
        { point = { 6, 7, 0 }, terrain = "mall_a_21_south" },
        { point = { 6, 7, 1 }, terrain = "mall_b_21_south" },
        { point = { 6, 7, 2 }, terrain = "mall_a_21_roof_south" },
        { point = { 5, 7, 0 }, terrain = "mall_a_22_south" },
        { point = { 5, 7, 1 }, terrain = "mall_b_22_south" },
        { point = { 5, 7, 2 }, terrain = "mall_a_22_roof_south" },
        { point = { 4, 7, 0 }, terrain = "mall_a_23_south" },
        { point = { 4, 7, 1 }, terrain = "mall_b_23_south" },
        { point = { 4, 7, 2 }, terrain = "mall_a_23_roof_south" },
        { point = { 3, 7, 0 }, terrain = "mall_a_24_south" },
        { point = { 3, 7, 1 }, terrain = "mall_b_24_south" },
        { point = { 3, 7, 2 }, terrain = "mall_a_24_roof_south" },
        { point = { 2, 7, 0 }, terrain = "mall_a_25_south" },
        { point = { 2, 7, 1 }, terrain = "mall_b_25_south" },
        { point = { 2, 7, 2 }, terrain = "mall_a_25_roof_south" },
        { point = { 1, 7, 0 }, terrain = "mall_a_26_south" },
        { point = { 1, 7, 1 }, terrain = "mall_b_26_south" },
        { point = { 1, 7, 2 }, terrain = "mall_a_26_roof_south" },
        { point = { 0, 7, 0 }, terrain = "mall_a_27_south" },
        { point = { 8, 6, 0 }, terrain = "mall_a_28_south" },
        { point = { 7, 6, 0 }, terrain = "mall_a_29_south" },
        { point = { 7, 6, 1 }, terrain = "mall_b_29_south" },
        { point = { 7, 6, 2 }, terrain = "mall_a_29_roof_south" },
        { point = { 6, 6, 0 }, terrain = "mall_a_30_south" },
        { point = { 6, 6, 1 }, terrain = "mall_b_30_south" },
        { point = { 6, 6, 2 }, terrain = "mall_a_30_roof_south" },
        { point = { 5, 6, 0 }, terrain = "mall_a_31_south" },
        { point = { 5, 6, 1 }, terrain = "mall_b_31_south" },
        { point = { 5, 6, 2 }, terrain = "mall_a_31_roof_south" },
        { point = { 4, 6, 0 }, terrain = "mall_a_32_south" },
        { point = { 4, 6, 1 }, terrain = "mall_b_32_south" },
        { point = { 4, 6, 2 }, terrain = "mall_a_32_roof_south" },
        { point = { 3, 6, 0 }, terrain = "mall_a_33_south" },
        { point = { 3, 6, 1 }, terrain = "mall_b_33_south" },
        { point = { 3, 6, 2 }, terrain = "mall_a_33_roof_south" },
        { point = { 2, 6, 0 }, terrain = "mall_a_34_south" },
        { point = { 2, 6, 1 }, terrain = "mall_b_34_south" },
        { point = { 2, 6, 2 }, terrain = "mall_a_34_roof_south" },
        { point = { 2, 6, 3 }, terrain = "mall_upper_roof_34_south" },
        { point = { 1, 6, 0 }, terrain = "mall_a_35_south" },
        { point = { 1, 6, 1 }, terrain = "mall_b_35_south" },
        { point = { 1, 6, 2 }, terrain = "mall_a_35_roof_south" },
        { point = { 1, 6, 3 }, terrain = "mall_upper_roof_35_south" },
        { point = { 0, 6, 0 }, terrain = "mall_a_36_south" },
        { point = { 8, 5, 0 }, terrain = "mall_a_37_south" },
        { point = { 7, 5, 0 }, terrain = "mall_a_38_south" },
        { point = { 7, 5, 1 }, terrain = "mall_b_38_south" },
        { point = { 7, 5, 2 }, terrain = "mall_a_38_roof_south" },
        { point = { 6, 5, 0 }, terrain = "mall_a_39_south" },
        { point = { 6, 5, 1 }, terrain = "mall_b_39_south" },
        { point = { 6, 5, 2 }, terrain = "mall_a_39_roof_south" },
        { point = { 5, 5, 0 }, terrain = "mall_a_40_south" },
        { point = { 5, 5, 1 }, terrain = "mall_b_40_south" },
        { point = { 5, 5, 2 }, terrain = "mall_a_40_roof_south" },
        { point = { 4, 5, 0 }, terrain = "mall_a_41_south" },
        { point = { 4, 5, 1 }, terrain = "mall_b_41_south" },
        { point = { 4, 5, 2 }, terrain = "mall_a_41_roof_south" },
        { point = { 3, 5, 0 }, terrain = "mall_a_42_south" },
        { point = { 3, 5, 1 }, terrain = "mall_b_42_south" },
        { point = { 3, 5, 2 }, terrain = "mall_a_42_roof_south" },
        { point = { 2, 5, 0 }, terrain = "mall_a_43_south" },
        { point = { 2, 5, 1 }, terrain = "mall_b_43_south" },
        { point = { 2, 5, 2 }, terrain = "mall_a_43_roof_south" },
        { point = { 1, 5, 0 }, terrain = "mall_a_44_south" },
        { point = { 1, 5, 1 }, terrain = "mall_b_44_south" },
        { point = { 1, 5, 2 }, terrain = "mall_a_44_roof_south" },
        { point = { 0, 5, 0 }, terrain = "mall_a_45_south" },
        { point = { 8, 4, 0 }, terrain = "mall_a_46_south" },
        { point = { 7, 4, 0 }, terrain = "mall_a_47_south" },
        { point = { 7, 4, 1 }, terrain = "mall_b_47_south" },
        { point = { 7, 4, 2 }, terrain = "mall_a_47_roof_south" },
        { point = { 6, 4, 0 }, terrain = "mall_a_48_south" },
        { point = { 6, 4, 1 }, terrain = "mall_b_48_south" },
        { point = { 6, 4, 2 }, terrain = "mall_a_48_roof_south" },
        { point = { 6, 4, 3 }, terrain = "mall_upper_roof_48_south" },
        { point = { 5, 4, 0 }, terrain = "mall_a_49_south" },
        { point = { 5, 4, 1 }, terrain = "mall_b_49_south" },
        { point = { 5, 4, 2 }, terrain = "mall_a_49_roof_south" },
        { point = { 5, 4, 3 }, terrain = "mall_upper_roof_49_south" },
        { point = { 4, 4, 0 }, terrain = "mall_a_50_south" },
        { point = { 4, 4, 1 }, terrain = "mall_b_50_south" },
        { point = { 4, 4, 2 }, terrain = "mall_a_50_roof_south" },
        { point = { 4, 4, 3 }, terrain = "mall_upper_roof_50_south" },
        { point = { 3, 4, 0 }, terrain = "mall_a_51_south" },
        { point = { 3, 4, 1 }, terrain = "mall_b_51_south" },
        { point = { 3, 4, 2 }, terrain = "mall_a_51_roof_south" },
        { point = { 3, 4, 3 }, terrain = "mall_upper_roof_51_south" },
        { point = { 2, 4, 0 }, terrain = "mall_a_52_south" },
        { point = { 2, 4, 1 }, terrain = "mall_b_52_south" },
        { point = { 2, 4, 2 }, terrain = "mall_a_52_roof_south" },
        { point = { 1, 4, 0 }, terrain = "mall_a_53_south" },
        { point = { 1, 4, 1 }, terrain = "mall_b_53_south" },
        { point = { 1, 4, 2 }, terrain = "mall_a_53_roof_south" },
        { point = { 0, 4, 0 }, terrain = "mall_a_54_south" },
        { point = { 8, 3, 0 }, terrain = "mall_a_55_south" },
        { point = { 7, 3, 0 }, terrain = "mall_a_56_south" },
        { point = { 7, 3, 1 }, terrain = "mall_b_56_south" },
        { point = { 7, 3, 2 }, terrain = "mall_a_56_roof_south" },
        { point = { 7, 3, -1 }, terrain = "mall_a_56_basement_south" },
        { point = { 6, 3, 0 }, terrain = "mall_a_57_south" },
        { point = { 6, 3, 1 }, terrain = "mall_b_57_south" },
        { point = { 6, 3, 2 }, terrain = "mall_a_57_roof_south" },
        { point = { 6, 3, -1 }, terrain = "mall_a_57_basement_south" },
        { point = { 5, 3, 0 }, terrain = "mall_a_58_south" },
        { point = { 5, 3, 1 }, terrain = "mall_b_58_south" },
        { point = { 5, 3, 2 }, terrain = "mall_a_58_roof_south" },
        { point = { 5, 3, -1 }, terrain = "mall_a_58_basement_south" },
        { point = { 4, 3, 0 }, terrain = "mall_a_59_south" },
        { point = { 4, 3, 1 }, terrain = "mall_b_59_south" },
        { point = { 4, 3, 2 }, terrain = "mall_a_59_roof_south" },
        { point = { 4, 3, -1 }, terrain = "mall_a_59_basement_south" },
        { point = { 3, 3, 0 }, terrain = "mall_a_60_south" },
        { point = { 3, 3, 1 }, terrain = "mall_b_60_south" },
        { point = { 3, 3, 2 }, terrain = "mall_a_60_roof_south" },
        { point = { 3, 3, -1 }, terrain = "mall_a_60_basement_south" },
        { point = { 2, 3, 0 }, terrain = "mall_a_61_south" },
        { point = { 2, 3, 1 }, terrain = "mall_b_61_south" },
        { point = { 2, 3, 2 }, terrain = "mall_a_61_roof_south" },
        { point = { 2, 3, -1 }, terrain = "mall_a_61_basement_south" },
        { point = { 1, 3, 0 }, terrain = "mall_a_62_south" },
        { point = { 1, 3, 1 }, terrain = "mall_b_62_south" },
        { point = { 1, 3, 2 }, terrain = "mall_a_62_roof_south" },
        { point = { 1, 3, -1 }, terrain = "mall_a_62_basement_south" },
        { point = { 0, 3, 0 }, terrain = "mall_a_63_south" },
        { point = { 8, 2, 0 }, terrain = "mall_a_64_south" },
        { point = { 7, 2, 0 }, terrain = "mall_a_65_south" },
        { point = { 7, 2, 1 }, terrain = "mall_b_65_south" },
        { point = { 7, 2, 2 }, terrain = "mall_a_65_roof_south" },
        { point = { 7, 2, -1 }, terrain = "mall_a_65_basement_south" },
        { point = { 6, 2, 0 }, terrain = "mall_a_66_south" },
        { point = { 6, 2, 1 }, terrain = "mall_b_66_south" },
        { point = { 6, 2, 2 }, terrain = "mall_a_66_roof_south" },
        { point = { 6, 2, -1 }, terrain = "mall_a_66_basement_south" },
        { point = { 5, 2, 0 }, terrain = "mall_a_67_south" },
        { point = { 5, 2, 1 }, terrain = "mall_b_67_south" },
        { point = { 5, 2, 2 }, terrain = "mall_a_67_roof_south" },
        { point = { 5, 2, -1 }, terrain = "mall_a_67_basement_south" },
        { point = { 5, 2, -2 }, terrain = "mall_a_67_sub_basement_south" },
        { point = { 4, 2, 0 }, terrain = "mall_a_68_south" },
        { point = { 4, 2, 1 }, terrain = "mall_b_68_south" },
        { point = { 4, 2, 2 }, terrain = "mall_a_68_roof_south" },
        { point = { 4, 2, -1 }, terrain = "mall_a_68_basement_south" },
        { point = { 4, 2, -2 }, terrain = "mall_a_68_sub_basement_south" },
        { point = { 3, 2, 0 }, terrain = "mall_a_69_south" },
        { point = { 3, 2, 1 }, terrain = "mall_b_69_south" },
        { point = { 3, 2, 2 }, terrain = "mall_a_69_roof_south" },
        { point = { 3, 2, -1 }, terrain = "mall_a_69_basement_south" },
        { point = { 3, 2, -2 }, terrain = "mall_a_69_sub_basement_south" },
        { point = { 2, 2, 0 }, terrain = "mall_a_70_south" },
        { point = { 2, 2, 1 }, terrain = "mall_b_70_south" },
        { point = { 2, 2, 2 }, terrain = "mall_a_70_roof_south" },
        { point = { 2, 2, -1 }, terrain = "mall_a_70_basement_south" },
        { point = { 1, 2, 0 }, terrain = "mall_a_71_south" },
        { point = { 1, 2, 1 }, terrain = "mall_b_71_south" },
        { point = { 1, 2, 2 }, terrain = "mall_a_71_roof_south" },
        { point = { 1, 2, -1 }, terrain = "mall_a_71_basement_south" },
        { point = { 0, 2, 0 }, terrain = "mall_a_72_south" },
        { point = { 8, 1, 0 }, terrain = "mall_a_73_south" },
        { point = { 7, 1, 0 }, terrain = "mall_a_74_south" },
        { point = { 6, 1, 0 }, terrain = "mall_a_75_south" },
        { point = { 5, 1, 0 }, terrain = "mall_a_76_south" },
        { point = { 4, 1, 0 }, terrain = "mall_a_77_south" },
        { point = { 4, 1, -2 }, terrain = "microlab_sub_connector_north" },
        { point = { 3, 1, 0 }, terrain = "mall_a_78_south" },
        { point = { 2, 1, 0 }, terrain = "mall_a_79_south" },
        { point = { 1, 1, 0 }, terrain = "mall_a_80_south" },
        { point = { 0, 1, 0 }, terrain = "mall_a_81_south" },
    },
    city_sizes = { 16, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "home_improvement_superstore_new",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "hdwr_large_0_0_0_south" },
        { point = { 1, 0, 0 }, terrain = "hdwr_large_1_0_0_south" },
        { point = { 1, 1, 0 }, terrain = "hdwr_large_1_1_0_south" },
        { point = { 0, 1, 0 }, terrain = "hdwr_large_0_1_0_south" },
        { point = { 1, 2, 0 }, terrain = "hdwr_large_1_2_0_south" },
        { point = { 0, 2, 0 }, terrain = "hdwr_large_0_2_0_south" },
        { point = { 0, 0, 1 }, terrain = "hdwr_large_0_0_1_south" },
        { point = { 1, 0, 1 }, terrain = "hdwr_large_1_0_1_south" },
        { point = { 1, 1, 1 }, terrain = "hdwr_large_1_1_1_south" },
        { point = { 0, 1, 1 }, terrain = "hdwr_large_0_1_1_south" },
        { point = { 1, 2, 1 }, terrain = "hdwr_large_1_2_1_south" },
        { point = { 0, 2, 1 }, terrain = "hdwr_large_0_2_1_south" },
        { point = { 1, 1, 2 }, terrain = "hdwr_large_1_1_2_south" },
    },
    city_sizes = { 8, -1 },
}

ccb.content.define_city_building {
    id = "football_field",
    locations = { "land" },
    tiles = {
        { point = { 0, 2, 0 }, terrain = "football_field_c1_north" },
        { point = { 1, 2, 0 }, terrain = "football_field_c2_north" },
        { point = { 2, 2, 0 }, terrain = "football_field_c3_north" },
        { point = { 3, 2, 0 }, terrain = "football_field_c4_north" },
        { point = { 4, 2, 0 }, terrain = "football_field_c5_north" },
        { point = { 0, 1, 0 }, terrain = "football_field_b1_north" },
        { point = { 1, 1, 0 }, terrain = "football_field_b2_north" },
        { point = { 2, 1, 0 }, terrain = "football_field_b3_north" },
        { point = { 3, 1, 0 }, terrain = "football_field_b4_north" },
        { point = { 4, 1, 0 }, terrain = "football_field_b5_north" },
        { point = { 0, 0, 0 }, terrain = "football_field_a1_north" },
        { point = { 1, 0, 0 }, terrain = "football_field_a2_north" },
        { point = { 2, 0, 0 }, terrain = "football_field_a3_north" },
        { point = { 3, 0, 0 }, terrain = "football_field_a4_north" },
        { point = { 4, 0, 0 }, terrain = "football_field_a5_north" },
        { point = { 4, 2, 1 }, terrain = "football_field_C5_north" },
        { point = { 0, 1, 1 }, terrain = "football_field_B1_north" },
        { point = { 4, 1, 1 }, terrain = "football_field_B5_north" },
    },
    city_sizes = { 6, -1 },
}

ccb.content.define_city_building {
    id = "lumberyard",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "lumberyard_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "lumberyard_1_0_north" },
        { point = { 0, 1, 0 }, terrain = "lumberyard_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "lumberyard_1_1_north" },
        { point = { 0, 0, 1 }, terrain = "lumberyard_0_0_roof_north" },
        { point = { 1, 0, 1 }, terrain = "lumberyard_1_0_roof_north" },
        { point = { 0, 1, 1 }, terrain = "lumberyard_0_1_roof_north" },
        { point = { 1, 1, 1 }, terrain = "lumberyard_1_1_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "botanical_garden",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "BotanicalGarden_1a_north" },
        { point = { 0, 0, 1 }, terrain = "BotanicalGarden_1a_roof_north" },
        { point = { 1, 0, 0 }, terrain = "BotanicalGarden_1b_north" },
        { point = { 1, 0, 1 }, terrain = "BotanicalGarden_1b_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "landscaping_supply_co",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "landscapingsupplyco_1a_north" },
        { point = { 1, 0, 0 }, terrain = "landscapingsupplyco_1b_north" },
        { point = { 1, 0, 1 }, terrain = "landscapingsupplyco_1b_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "storage_units_large",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "large_storage_units_3_north" },
        { point = { 0, 0, 1 }, terrain = "large_storage_units_roof_3_north" },
        { point = { 1, 0, 0 }, terrain = "large_storage_units_2_north" },
        { point = { 1, 0, 1 }, terrain = "large_storage_units_roof_2_north" },
        { point = { 2, 0, 0 }, terrain = "large_storage_units_1_north" },
        { point = { 2, 0, 1 }, terrain = "large_storage_units_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "storage_units_medium",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "medium_storage_units_2_north" },
        { point = { 0, 0, 1 }, terrain = "medium_storage_units_roof_2_north" },
        { point = { 1, 0, 0 }, terrain = "medium_storage_units_1_north" },
        { point = { 1, 0, 1 }, terrain = "medium_storage_units_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "baseball_field",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_baseballfield_a1_north" },
        { point = { 1, 0, 0 }, terrain = "s_baseballfield_a2_north" },
        { point = { 1, 0, 1 }, terrain = "s_baseballfield_a2_2_north" },
        { point = { 0, 1, 0 }, terrain = "s_baseballfield_b1_north" },
        { point = { 1, 1, 0 }, terrain = "s_baseballfield_b2_north" },
    },
}

ccb.content.define_city_building {
    id = "shopping_plaza",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_shoppingplaza_a1_north" },
        { point = { 1, 0, 0 }, terrain = "s_shoppingplaza_a2_north" },
        { point = { 2, 0, 0 }, terrain = "s_shoppingplaza_a3_north" },
        { point = { 3, 0, 0 }, terrain = "s_shoppingplaza_a4_north" },
        { point = { 4, 0, 0 }, terrain = "s_shoppingplaza_a5_north" },
        { point = { 5, 0, 0 }, terrain = "s_shoppingplaza_a6_north" },
        { point = { 0, 1, 0 }, terrain = "s_shoppingplaza_b1_north" },
        { point = { 1, 1, 0 }, terrain = "s_shoppingplaza_b2_north" },
        { point = { 2, 1, 0 }, terrain = "s_shoppingplaza_b3_north" },
        { point = { 3, 1, 0 }, terrain = "s_shoppingplaza_b4_north" },
        { point = { 4, 1, 0 }, terrain = "s_shoppingplaza_b5_north" },
        { point = { 5, 1, 0 }, terrain = "s_shoppingplaza_b6_north" },
        { point = { 5, 0, 1 }, terrain = "s_shoppingplaza_A6_north" },
        { point = { 0, 1, 1 }, terrain = "s_shoppingplaza_B1_north" },
        { point = { 1, 1, 1 }, terrain = "s_shoppingplaza_B2_north" },
        { point = { 2, 1, 1 }, terrain = "s_shoppingplaza_B3_north" },
        { point = { 3, 1, 1 }, terrain = "s_shoppingplaza_B4_north" },
        { point = { 4, 1, 1 }, terrain = "s_shoppingplaza_B5_north" },
        { point = { 5, 1, 1 }, terrain = "s_shoppingplaza_B6_north" },
    },
    city_sizes = { 6, -1 },
}

ccb.content.define_city_building {
    id = "zoo",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "zoo_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "zoo_1_0_north" },
        { point = { 2, 0, 0 }, terrain = "zoo_2_0_north" },
        { point = { 3, 0, 0 }, terrain = "zoo_3_0_north" },
        { point = { 0, 1, 0 }, terrain = "zoo_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "zoo_1_1_north" },
        { point = { 2, 1, 0 }, terrain = "zoo_2_1_north" },
        { point = { 3, 1, 0 }, terrain = "zoo_3_1_north" },
        { point = { 0, 2, 0 }, terrain = "zoo_0_2_north" },
        { point = { 1, 2, 0 }, terrain = "zoo_1_2_north" },
        { point = { 2, 2, 0 }, terrain = "zoo_2_2_north" },
        { point = { 3, 2, 0 }, terrain = "zoo_3_2_north" },
        { point = { 0, 3, 0 }, terrain = "zoo_0_3_north" },
        { point = { 1, 3, 0 }, terrain = "zoo_1_3_north" },
        { point = { 2, 3, 0 }, terrain = "zoo_2_3_north" },
        { point = { 3, 3, 0 }, terrain = "zoo_3_3_north" },
        { point = { 0, 0, 1 }, terrain = "zoo_0_0_roof_north" },
        { point = { 1, 0, 1 }, terrain = "zoo_1_0_roof_north" },
        { point = { 2, 0, 1 }, terrain = "zoo_2_0_roof_north" },
        { point = { 3, 0, 1 }, terrain = "zoo_3_0_roof_north" },
        { point = { 0, 1, 1 }, terrain = "zoo_0_1_roof_north" },
        { point = { 1, 1, 1 }, terrain = "zoo_1_1_roof_north" },
        { point = { 2, 1, 1 }, terrain = "zoo_2_1_roof_north" },
        { point = { 3, 1, 1 }, terrain = "zoo_3_1_roof_north" },
        { point = { 0, 2, 1 }, terrain = "zoo_0_2_roof_north" },
        { point = { 1, 2, 1 }, terrain = "zoo_1_2_roof_north" },
        { point = { 2, 2, 1 }, terrain = "zoo_2_2_roof_north" },
        { point = { 3, 2, 1 }, terrain = "zoo_3_2_roof_north" },
        { point = { 0, 3, 1 }, terrain = "zoo_0_3_roof_north" },
        { point = { 1, 3, 1 }, terrain = "zoo_1_3_roof_north" },
        { point = { 2, 3, 1 }, terrain = "zoo_2_3_roof_north" },
        { point = { 3, 3, 1 }, terrain = "zoo_3_3_roof_north" },
        { point = { 3, 2, -1 }, terrain = "zoo_3_2_basement_north" },
        { point = { 3, 3, -1 }, terrain = "zoo_3_3_basement_north" },
    },
    city_sizes = { 6, -1 },
}

ccb.content.define_city_building {
    id = "stadium",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "stadium_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "stadium_1_0_north" },
        { point = { 2, 0, 0 }, terrain = "stadium_2_0_north" },
        { point = { 3, 0, 0 }, terrain = "stadium_3_0_north" },
        { point = { 0, 1, 0 }, terrain = "stadium_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "stadium_1_1_north" },
        { point = { 2, 1, 0 }, terrain = "stadium_2_1_north" },
        { point = { 3, 1, 0 }, terrain = "stadium_3_1_north" },
        { point = { 0, 2, 0 }, terrain = "stadium_0_2_north" },
        { point = { 1, 2, 0 }, terrain = "stadium_1_2_north" },
        { point = { 2, 2, 0 }, terrain = "stadium_2_2_north" },
        { point = { 3, 2, 0 }, terrain = "stadium_3_2_north" },
        { point = { 0, 3, 0 }, terrain = "stadium_0_3_north" },
        { point = { 1, 3, 0 }, terrain = "stadium_1_3_north" },
        { point = { 2, 3, 0 }, terrain = "stadium_2_3_north" },
        { point = { 3, 3, 0 }, terrain = "stadium_3_3_north" },
        { point = { 0, 4, 0 }, terrain = "stadium_0_4_north" },
        { point = { 1, 4, 0 }, terrain = "stadium_1_4_north" },
        { point = { 2, 4, 0 }, terrain = "stadium_2_4_north" },
        { point = { 3, 4, 0 }, terrain = "stadium_3_4_north" },
        { point = { 0, 1, 1 }, terrain = "stadium_0_1_1_north" },
        { point = { 1, 1, 1 }, terrain = "stadium_1_1_1_north" },
        { point = { 2, 1, 1 }, terrain = "stadium_2_1_1_north" },
        { point = { 3, 1, 1 }, terrain = "stadium_3_1_1_north" },
        { point = { 0, 2, 1 }, terrain = "stadium_0_2_1_north" },
        { point = { 1, 2, 1 }, terrain = "stadium_1_2_1_north" },
        { point = { 2, 2, 1 }, terrain = "stadium_2_2_1_north" },
        { point = { 3, 2, 1 }, terrain = "stadium_3_2_1_north" },
        { point = { 0, 3, 1 }, terrain = "stadium_0_3_1_north" },
        { point = { 1, 3, 1 }, terrain = "stadium_1_3_1_north" },
        { point = { 2, 3, 1 }, terrain = "stadium_2_3_1_north" },
        { point = { 3, 3, 1 }, terrain = "stadium_3_3_1_north" },
        { point = { 0, 4, 1 }, terrain = "stadium_0_4_1_north" },
        { point = { 1, 4, 1 }, terrain = "stadium_1_4_1_north" },
        { point = { 2, 4, 1 }, terrain = "stadium_2_4_1_north" },
        { point = { 3, 4, 1 }, terrain = "stadium_3_4_1_north" },
        { point = { 0, 1, 2 }, terrain = "stadium_0_1_2_north" },
        { point = { 1, 1, 2 }, terrain = "stadium_1_1_2_north" },
        { point = { 2, 1, 2 }, terrain = "stadium_2_1_2_north" },
        { point = { 3, 1, 2 }, terrain = "stadium_3_1_2_north" },
        { point = { 0, 2, 2 }, terrain = "stadium_0_2_2_north" },
        { point = { 1, 2, 2 }, terrain = "stadium_1_2_2_north" },
        { point = { 2, 2, 2 }, terrain = "stadium_2_2_2_north" },
        { point = { 3, 2, 2 }, terrain = "stadium_3_2_2_north" },
        { point = { 0, 3, 2 }, terrain = "stadium_0_3_2_north" },
        { point = { 1, 3, 2 }, terrain = "stadium_1_3_2_north" },
        { point = { 2, 3, 2 }, terrain = "stadium_2_3_2_north" },
        { point = { 3, 3, 2 }, terrain = "stadium_3_3_2_north" },
        { point = { 0, 4, 2 }, terrain = "stadium_0_4_2_north" },
        { point = { 1, 4, 2 }, terrain = "stadium_1_4_2_north" },
        { point = { 2, 4, 2 }, terrain = "stadium_2_4_2_north" },
        { point = { 3, 4, 2 }, terrain = "stadium_3_4_2_north" },
        { point = { 1, 1, 3 }, terrain = "stadium_1_1_3_north" },
        { point = { 2, 1, 3 }, terrain = "stadium_2_1_3_north" },
        { point = { 0, 3, 3 }, terrain = "stadium_0_3_3_north" },
    },
    city_sizes = { 16, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "stadium_football",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "stadium_football_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "stadium_football_1_0_north" },
        { point = { 2, 0, 0 }, terrain = "stadium_football_2_0_north" },
        { point = { 3, 0, 0 }, terrain = "stadium_football_3_0_north" },
        { point = { 4, 0, 0 }, terrain = "stadium_football_4_0_north" },
        { point = { 5, 0, 0 }, terrain = "stadium_football_5_0_north" },
        { point = { 6, 0, 0 }, terrain = "stadium_football_6_0_north" },
        { point = { 7, 0, 0 }, terrain = "stadium_football_7_0_north" },
        { point = { 8, 0, 0 }, terrain = "stadium_football_8_0_north" },
        { point = { 0, 1, 0 }, terrain = "stadium_football_0_1_north" },
        { point = { 0, 2, 0 }, terrain = "stadium_football_0_2_north" },
        { point = { 0, 3, 0 }, terrain = "stadium_football_0_3_north" },
        { point = { 0, 4, 0 }, terrain = "stadium_football_0_4_north" },
        { point = { 0, 5, 0 }, terrain = "stadium_football_0_5_north" },
        { point = { 0, 6, 0 }, terrain = "stadium_football_0_6_north" },
        { point = { 8, 1, 0 }, terrain = "stadium_football_8_1_north" },
        { point = { 8, 2, 0 }, terrain = "stadium_football_8_2_north" },
        { point = { 8, 3, 0 }, terrain = "stadium_football_8_3_north" },
        { point = { 8, 4, 0 }, terrain = "stadium_football_8_4_north" },
        { point = { 8, 5, 0 }, terrain = "stadium_football_8_5_north" },
        { point = { 8, 6, 0 }, terrain = "stadium_football_8_6_north" },
        { point = { 1, 6, 0 }, terrain = "stadium_football_1_6_north" },
        { point = { 2, 6, 0 }, terrain = "stadium_football_2_6_north" },
        { point = { 3, 6, 0 }, terrain = "stadium_football_3_6_north" },
        { point = { 4, 6, 0 }, terrain = "stadium_football_4_6_north" },
        { point = { 5, 6, 0 }, terrain = "stadium_football_5_6_north" },
        { point = { 6, 6, 0 }, terrain = "stadium_football_6_6_north" },
        { point = { 7, 6, 0 }, terrain = "stadium_football_7_6_north" },
        { point = { 1, 1, 0 }, terrain = "stadium_football_1_1_north" },
        { point = { 2, 1, 0 }, terrain = "stadium_football_2_1_north" },
        { point = { 3, 1, 0 }, terrain = "stadium_football_3_1_north" },
        { point = { 4, 1, 0 }, terrain = "stadium_football_4_1_north" },
        { point = { 5, 1, 0 }, terrain = "stadium_football_5_1_north" },
        { point = { 6, 1, 0 }, terrain = "stadium_football_6_1_north" },
        { point = { 7, 1, 0 }, terrain = "stadium_football_7_1_north" },
        { point = { 1, 5, 0 }, terrain = "stadium_football_1_5_north" },
        { point = { 2, 5, 0 }, terrain = "stadium_football_2_5_north" },
        { point = { 3, 5, 0 }, terrain = "stadium_football_3_5_north" },
        { point = { 4, 5, 0 }, terrain = "stadium_football_4_5_north" },
        { point = { 5, 5, 0 }, terrain = "stadium_football_5_5_north" },
        { point = { 6, 5, 0 }, terrain = "stadium_football_6_5_north" },
        { point = { 7, 5, 0 }, terrain = "stadium_football_7_5_north" },
        { point = { 1, 2, 0 }, terrain = "stadium_football_1_2_north" },
        { point = { 1, 3, 0 }, terrain = "stadium_football_1_3_north" },
        { point = { 1, 4, 0 }, terrain = "stadium_football_1_4_north" },
        { point = { 7, 2, 0 }, terrain = "stadium_football_7_2_north" },
        { point = { 7, 3, 0 }, terrain = "stadium_football_7_3_north" },
        { point = { 7, 4, 0 }, terrain = "stadium_football_7_4_north" },
        { point = { 2, 2, 0 }, terrain = "stadium_football_2_2_north" },
        { point = { 3, 2, 0 }, terrain = "stadium_football_3_2_north" },
        { point = { 4, 2, 0 }, terrain = "stadium_football_4_2_north" },
        { point = { 5, 2, 0 }, terrain = "stadium_football_5_2_north" },
        { point = { 6, 2, 0 }, terrain = "stadium_football_6_2_north" },
        { point = { 2, 3, 0 }, terrain = "stadium_football_2_3_north" },
        { point = { 3, 3, 0 }, terrain = "stadium_football_3_3_north" },
        { point = { 4, 3, 0 }, terrain = "stadium_football_4_3_north" },
        { point = { 5, 3, 0 }, terrain = "stadium_football_5_3_north" },
        { point = { 6, 3, 0 }, terrain = "stadium_football_6_3_north" },
        { point = { 2, 4, 0 }, terrain = "stadium_football_2_4_north" },
        { point = { 3, 4, 0 }, terrain = "stadium_football_3_4_north" },
        { point = { 4, 4, 0 }, terrain = "stadium_football_4_4_north" },
        { point = { 5, 4, 0 }, terrain = "stadium_football_5_4_north" },
        { point = { 6, 4, 0 }, terrain = "stadium_football_6_4_north" },
        { point = { 1, 1, 1 }, terrain = "stadium_football_1_1_1_north" },
        { point = { 2, 1, 1 }, terrain = "stadium_football_2_1_1_north" },
        { point = { 3, 1, 1 }, terrain = "stadium_football_3_1_1_north" },
        { point = { 4, 1, 1 }, terrain = "stadium_football_4_1_1_north" },
        { point = { 5, 1, 1 }, terrain = "stadium_football_5_1_1_north" },
        { point = { 6, 1, 1 }, terrain = "stadium_football_6_1_1_north" },
        { point = { 7, 1, 1 }, terrain = "stadium_football_7_1_1_north" },
        { point = { 1, 5, 1 }, terrain = "stadium_football_1_5_1_north" },
        { point = { 2, 5, 1 }, terrain = "stadium_football_2_5_1_north" },
        { point = { 3, 5, 1 }, terrain = "stadium_football_3_5_1_north" },
        { point = { 4, 5, 1 }, terrain = "stadium_football_4_5_1_north" },
        { point = { 5, 5, 1 }, terrain = "stadium_football_5_5_1_north" },
        { point = { 6, 5, 1 }, terrain = "stadium_football_6_5_1_north" },
        { point = { 7, 5, 1 }, terrain = "stadium_football_7_5_1_north" },
        { point = { 1, 2, 1 }, terrain = "stadium_football_1_2_1_north" },
        { point = { 1, 3, 1 }, terrain = "stadium_football_1_3_1_north" },
        { point = { 1, 4, 1 }, terrain = "stadium_football_1_4_1_north" },
        { point = { 7, 2, 1 }, terrain = "stadium_football_7_2_1_north" },
        { point = { 7, 3, 1 }, terrain = "stadium_football_7_3_1_north" },
        { point = { 7, 4, 1 }, terrain = "stadium_football_7_4_1_north" },
        { point = { 2, 3, 1 }, terrain = "stadium_football_2_3_1_north" },
        { point = { 6, 3, 1 }, terrain = "stadium_football_6_3_1_north" },
        { point = { 1, 1, 2 }, terrain = "stadium_football_1_1_2_north" },
        { point = { 2, 1, 2 }, terrain = "stadium_football_2_1_2_north" },
        { point = { 3, 1, 2 }, terrain = "stadium_football_3_1_2_north" },
        { point = { 4, 1, 2 }, terrain = "stadium_football_4_1_2_north" },
        { point = { 5, 1, 2 }, terrain = "stadium_football_5_1_2_north" },
        { point = { 6, 1, 2 }, terrain = "stadium_football_6_1_2_north" },
        { point = { 7, 1, 2 }, terrain = "stadium_football_7_1_2_north" },
        { point = { 1, 5, 2 }, terrain = "stadium_football_1_5_2_north" },
        { point = { 2, 5, 2 }, terrain = "stadium_football_2_5_2_north" },
        { point = { 3, 5, 2 }, terrain = "stadium_football_3_5_2_north" },
        { point = { 4, 5, 2 }, terrain = "stadium_football_4_5_2_north" },
        { point = { 5, 5, 2 }, terrain = "stadium_football_5_5_2_north" },
        { point = { 6, 5, 2 }, terrain = "stadium_football_6_5_2_north" },
        { point = { 7, 5, 2 }, terrain = "stadium_football_7_5_2_north" },
        { point = { 1, 2, 2 }, terrain = "stadium_football_1_2_2_north" },
        { point = { 1, 3, 2 }, terrain = "stadium_football_1_3_2_north" },
        { point = { 1, 4, 2 }, terrain = "stadium_football_1_4_2_north" },
        { point = { 7, 2, 2 }, terrain = "stadium_football_7_2_2_north" },
        { point = { 7, 3, 2 }, terrain = "stadium_football_7_3_2_north" },
        { point = { 7, 4, 2 }, terrain = "stadium_football_7_4_2_north" },
        { point = { 1, 1, 3 }, terrain = "stadium_football_1_1_3_north" },
        { point = { 2, 1, 3 }, terrain = "stadium_football_2_1_3_north" },
        { point = { 3, 1, 3 }, terrain = "stadium_football_3_1_3_north" },
        { point = { 4, 1, 3 }, terrain = "stadium_football_4_1_3_north" },
        { point = { 5, 1, 3 }, terrain = "stadium_football_5_1_3_north" },
        { point = { 6, 1, 3 }, terrain = "stadium_football_6_1_3_north" },
        { point = { 7, 1, 3 }, terrain = "stadium_football_7_1_3_north" },
        { point = { 1, 5, 3 }, terrain = "stadium_football_1_5_3_north" },
        { point = { 2, 5, 3 }, terrain = "stadium_football_2_5_3_north" },
        { point = { 3, 5, 3 }, terrain = "stadium_football_3_5_3_north" },
        { point = { 4, 5, 3 }, terrain = "stadium_football_4_5_3_north" },
        { point = { 5, 5, 3 }, terrain = "stadium_football_5_5_3_north" },
        { point = { 6, 5, 3 }, terrain = "stadium_football_6_5_3_north" },
        { point = { 7, 5, 3 }, terrain = "stadium_football_7_5_3_north" },
        { point = { 1, 2, 3 }, terrain = "stadium_football_1_2_3_north" },
        { point = { 1, 3, 3 }, terrain = "stadium_football_1_3_3_north" },
        { point = { 1, 4, 3 }, terrain = "stadium_football_1_4_3_north" },
        { point = { 7, 2, 3 }, terrain = "stadium_football_7_2_3_north" },
        { point = { 7, 3, 3 }, terrain = "stadium_football_7_3_3_north" },
        { point = { 7, 4, 3 }, terrain = "stadium_football_7_4_3_north" },
        { point = { 2, 1, 4 }, terrain = "stadium_football_2_1_4_north" },
        { point = { 3, 1, 4 }, terrain = "stadium_football_3_1_4_north" },
        { point = { 4, 1, 4 }, terrain = "stadium_football_4_1_4_north" },
        { point = { 5, 1, 4 }, terrain = "stadium_football_5_1_4_north" },
        { point = { 6, 1, 4 }, terrain = "stadium_football_6_1_4_north" },
        { point = { 2, 5, 4 }, terrain = "stadium_football_2_5_4_north" },
        { point = { 3, 5, 4 }, terrain = "stadium_football_3_5_4_north" },
        { point = { 4, 5, 4 }, terrain = "stadium_football_4_5_4_north" },
        { point = { 5, 5, 4 }, terrain = "stadium_football_5_5_4_north" },
        { point = { 6, 5, 4 }, terrain = "stadium_football_6_5_4_north" },
        { point = { 2, 1, 5 }, terrain = "stadium_football_2_1_5_north" },
        { point = { 3, 1, 5 }, terrain = "stadium_football_3_1_5_north" },
        { point = { 4, 1, 5 }, terrain = "stadium_football_4_1_5_north" },
        { point = { 5, 1, 5 }, terrain = "stadium_football_5_1_5_north" },
        { point = { 6, 1, 5 }, terrain = "stadium_football_6_1_5_north" },
        { point = { 2, 5, 5 }, terrain = "stadium_football_2_5_5_north" },
        { point = { 3, 5, 5 }, terrain = "stadium_football_3_5_5_north" },
        { point = { 4, 5, 5 }, terrain = "stadium_football_4_5_5_north" },
        { point = { 5, 5, 5 }, terrain = "stadium_football_5_5_5_north" },
        { point = { 6, 5, 5 }, terrain = "stadium_football_6_5_5_north" },
    },
    city_sizes = { 16, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "movie_theater",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "movietheater_0_0_north" },
        { point = { 0, 0, 1 }, terrain = "movietheater_roof_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "movietheater_1_0_north" },
        { point = { 1, 0, 1 }, terrain = "movietheater_roof_1_0_north" },
        { point = { 2, 0, 0 }, terrain = "movietheater_2_0_north" },
        { point = { 2, 0, 1 }, terrain = "movietheater_roof_2_0_north" },
        { point = { 2, 0, 2 }, terrain = "movietheater_2_2_0_north" },
        { point = { 0, 1, 0 }, terrain = "movietheater_0_1_north" },
        { point = { 0, 1, 1 }, terrain = "movietheater_roof_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "movietheater_1_1_north" },
        { point = { 1, 1, 1 }, terrain = "movietheater_roof_1_1_north" },
        { point = { 2, 1, 0 }, terrain = "movietheater_2_1_north" },
        { point = { 2, 1, 1 }, terrain = "movietheater_roof_2_1_north" },
        { point = { 2, 1, 2 }, terrain = "movietheater_2_2_1_north" },
        { point = { 0, 2, 0 }, terrain = "movietheater_0_2_north" },
        { point = { 0, 2, 1 }, terrain = "movietheater_roof_0_2_north" },
        { point = { 1, 2, 0 }, terrain = "movietheater_1_2_north" },
        { point = { 1, 2, 1 }, terrain = "movietheater_roof_1_2_north" },
        { point = { 2, 2, 0 }, terrain = "movietheater_2_2_north" },
        { point = { 2, 2, 1 }, terrain = "movietheater_roof_2_2_north" },
    },
}

ccb.content.define_city_building {
    id = "office_skyscraper",
    locations = { "land" },
    tiles = {
        { point = { 1, 1, 0 }, terrain = "office_skyscraper_5_south" },
        { point = { 0, 1, 0 }, terrain = "office_skyscraper_6_south" },
        { point = { 1, 0, 0 }, terrain = "office_skyscraper_7_south" },
        { point = { 0, 0, 0 }, terrain = "office_skyscraper_8_south" },
        { point = { 1, 1, -1 }, terrain = "office_skyscraper_1_south" },
        { point = { 0, 1, -1 }, terrain = "office_skyscraper_2_south" },
        { point = { 1, 0, -1 }, terrain = "office_skyscraper_3_south" },
        { point = { 0, 0, -1 }, terrain = "office_skyscraper_4_south" },
        { point = { 1, 1, 1 }, terrain = "office_skyscraper_apartments_111_south" },
        { point = { 0, 1, 1 }, terrain = "office_skyscraper_apartments_011_south" },
        { point = { 1, 0, 1 }, terrain = "office_skyscraper_apartments_101_south" },
        { point = { 0, 0, 1 }, terrain = "office_skyscraper_apartments_001_south" },
        { point = { 1, 1, 2 }, terrain = "office_skyscraper_apartments_112_south" },
        { point = { 0, 1, 2 }, terrain = "office_skyscraper_apartments_012_south" },
        { point = { 1, 0, 2 }, terrain = "office_skyscraper_apartments_102_south" },
        { point = { 0, 0, 2 }, terrain = "office_skyscraper_apartments_002_south" },
        { point = { 1, 1, 3 }, terrain = "office_skyscraper_9_south" },
        { point = { 0, 1, 3 }, terrain = "office_skyscraper_10_south" },
        { point = { 1, 0, 3 }, terrain = "office_skyscraper_11_south" },
        { point = { 0, 0, 3 }, terrain = "office_skyscraper_12_south" },
        { point = { 1, 1, 4 }, terrain = "office_skyscraper_9b_south" },
        { point = { 0, 1, 4 }, terrain = "office_skyscraper_10b_south" },
        { point = { 1, 0, 4 }, terrain = "office_skyscraper_11_south" },
        { point = { 0, 0, 4 }, terrain = "office_skyscraper_12_south" },
        { point = { 1, 1, 5 }, terrain = "office_skyscraper_9_south" },
        { point = { 0, 1, 5 }, terrain = "office_skyscraper_10_south" },
        { point = { 1, 0, 5 }, terrain = "office_skyscraper_11_south" },
        { point = { 0, 0, 5 }, terrain = "office_skyscraper_12_south" },
        { point = { 1, 1, 6 }, terrain = "office_skyscraper_9b_south" },
        { point = { 0, 1, 6 }, terrain = "office_skyscraper_10b_south" },
        { point = { 1, 0, 6 }, terrain = "office_skyscraper_11_south" },
        { point = { 0, 0, 6 }, terrain = "office_skyscraper_12_south" },
        { point = { 1, 1, 7 }, terrain = "office_skyscraper_9_south" },
        { point = { 0, 1, 7 }, terrain = "office_skyscraper_10_south" },
        { point = { 1, 0, 7 }, terrain = "office_skyscraper_11_south" },
        { point = { 0, 0, 7 }, terrain = "office_skyscraper_12_south" },
        { point = { 1, 1, 8 }, terrain = "office_skyscraper_13_south" },
        { point = { 0, 1, 8 }, terrain = "office_skyscraper_14_south" },
        { point = { 1, 0, 8 }, terrain = "office_skyscraper_15_south" },
        { point = { 0, 0, 8 }, terrain = "office_skyscraper_16_south" },
        { point = { 1, 1, 9 }, terrain = "office_skyscraper_17_south" },
        { point = { 0, 1, 9 }, terrain = "office_skyscraper_18_south" },
        { point = { 1, 0, 9 }, terrain = "office_skyscraper_19_south" },
        { point = { 0, 0, 9 }, terrain = "office_skyscraper_20_south" },
    },
    city_sizes = { 16, -1 },
}

ccb.content.define_city_building {
    id = "town_hall",
    locations = { "land", "swamp" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "town_hall_0_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "town_hall_1_0_0_north" },
        { point = { 0, 1, 0 }, terrain = "town_hall_0_1_0_north" },
        { point = { 1, 1, 0 }, terrain = "town_hall_1_1_0_north" },
        { point = { 0, 0, 1 }, terrain = "town_hall_0_0_1_north" },
        { point = { 1, 0, 1 }, terrain = "town_hall_1_0_1_north" },
        { point = { 0, 1, 1 }, terrain = "town_hall_0_1_1_north" },
        { point = { 1, 1, 1 }, terrain = "town_hall_1_1_1_north" },
        { point = { 0, 0, 2 }, terrain = "town_hall_0_0_roof_north" },
        { point = { 1, 0, 2 }, terrain = "town_hall_1_0_roof_north" },
        { point = { 0, 1, 2 }, terrain = "town_hall_0_1_roof_north" },
        { point = { 1, 1, 2 }, terrain = "town_hall_1_1_roof_north" },
        { point = { 1, 1, 3 }, terrain = "town_hall_1_1_upper_roof_north" },
    },
    city_sizes = { 10, -1 },
    flags = { "CITY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "veterinarian",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "veterinarian_north" },
        { point = { 0, 0, 1 }, terrain = "veterinarian_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abstorefront",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abstorefront_north" },
        { point = { 0, 0, 1 }, terrain = "abstorefront_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abstorefront_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abstorefront_1_north" },
        { point = { 0, 0, 1 }, terrain = "abstorefront_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "abstorefront_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abstorefront_2_north" },
        { point = { 0, 0, 1 }, terrain = "abstorefront_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_fast",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_fast_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_fast_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_fast_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_fast_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_fast_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_fast_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "drive_through_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "drive_through_1_0_north" },
        { point = { 2, 0, 0 }, terrain = "drive_through_2_0_north" },
        { point = { 0, 1, 0 }, terrain = "drive_through_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "drive_through_1_1_north" },
        { point = { 2, 1, 0 }, terrain = "drive_through_2_1_north" },
        { point = { 0, 0, 1 }, terrain = "drive_through_roof_0_0_north" },
        { point = { 1, 0, 1 }, terrain = "drive_through_roof_1_0_north" },
        { point = { 2, 0, 1 }, terrain = "drive_through_roof_2_0_north" },
        { point = { 0, 1, 1 }, terrain = "drive_through_roof_0_1_north" },
        { point = { 1, 1, 1 }, terrain = "drive_through_roof_1_1_north" },
        { point = { 2, 1, 1 }, terrain = "drive_through_roof_2_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_vfw",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_vfw_north" },
        { point = { 0, 0, 1 }, terrain = "s_vfw_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "dispensary",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dispensary_north" },
        { point = { 0, 0, 1 }, terrain = "dispensary_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "dispensary_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dispensary_1_north" },
        { point = { 0, 0, 1 }, terrain = "dispensary_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "dispensary_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dispensary_2_north" },
        { point = { 0, 0, 1 }, terrain = "dispensary_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "headshop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "headshop_north" },
        { point = { 0, 0, 1 }, terrain = "headshop_roof_north" },
        { point = { 0, 0, 2 }, terrain = "headshop_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abandonedwarehouse",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abandonedwarehouse_north" },
        { point = { 0, 0, 1 }, terrain = "abandonedwarehouse_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abandonedwarehouse_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abandonedwarehouse_1_north" },
        { point = { 0, 0, 1 }, terrain = "abandonedwarehouse_1_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abandonedwarehouse_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abandonedwarehouse_2_north" },
        { point = { 0, 0, 1 }, terrain = "abandonedwarehouse_2_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abandonedwarehouse_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abandonedwarehouse_3_north" },
        { point = { 0, 0, 1 }, terrain = "abandonedwarehouse_3_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "abandonedwarehouse_4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abandonedwarehouse_4_north" },
        { point = { 0, 0, 1 }, terrain = "abandonedwarehouse_4_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "art_gallery",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "art_gallery_north" },
        { point = { 0, 0, 1 }, terrain = "art_gallery_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "fire_station",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "fire_station_north" },
        { point = { 0, 0, 1 }, terrain = "fire_station_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "fire_station_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "fire_station_1_north" },
        { point = { 0, 0, 1 }, terrain = "fire_station_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "animalpound",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "animalpound_north" },
        { point = { 0, 0, 1 }, terrain = "animalpound_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "small_storage_units",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "small_storage_units_north" },
        { point = { 0, 0, 1 }, terrain = "small_storage_units_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "small_storage_units_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "small_storage_units_1_north" },
        { point = { 0, 0, 1 }, terrain = "small_storage_units_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_arcade",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_arcade_north" },
        { point = { 0, 0, 1 }, terrain = "s_arcade_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_games",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_games_north" },
        { point = { 0, 0, 1 }, terrain = "s_games_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_car_dealership",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_car_dealership_north" },
        { point = { 0, 0, 1 }, terrain = "cs_car_dealership_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_foodplace",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_foodplace_roof_north" },
        { point = { 0, 0, 2 }, terrain = "s_restaurant_foodplace_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_roof_2_north" },
        { point = { 0, 0, 2 }, terrain = "s_restaurant_upper_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_restaurant_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_restaurant_3_north" },
        { point = { 0, 0, 1 }, terrain = "s_restaurant_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "s_pizza_parlor",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_pizza_parlor_north" },
        { point = { 0, 0, 1 }, terrain = "s_pizza_parlor_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_pizza_parlor_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_pizza_parlor_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_pizza_parlor_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_grocery",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_grocery_north" },
        { point = { 0, 0, 1 }, terrain = "s_grocery_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_cosmetic",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_cosmetic_north" },
        { point = { 0, 0, 1 }, terrain = "s_cosmetic_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_grocery_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_grocery_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_grocery_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "gambling_hall",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "gambling_hall_north" },
        { point = { 0, 0, 1 }, terrain = "gambling_hall_roof_north" },
        { point = { 0, 0, 2 }, terrain = "gambling_hall_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "gambling_hall_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "gambling_hall_1_north" },
        { point = { 0, 0, 1 }, terrain = "gambling_hall_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "bakery",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bakery_north" },
        { point = { 0, 0, 1 }, terrain = "bakery_roof_north" },
        { point = { 0, 0, 2 }, terrain = "bakery_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_jewelry_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_jewelry_north" },
        { point = { 0, 0, 1 }, terrain = "s_jewelry_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_gardening_allotment",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_gardening_allotment_north" },
        { point = { 0, 0, 1 }, terrain = "cs_gardening_allotment_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "icecream_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "icecream_shop_north" },
        { point = { 0, 0, 1 }, terrain = "icecream_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_liquor",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_liquor_north" },
        { point = { 0, 0, 1 }, terrain = "s_liquor_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bar",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bar_north" },
        { point = { 0, 0, 1 }, terrain = "bar_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "bar_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bar_1_north" },
        { point = { 0, 0, 1 }, terrain = "bar_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "lancenter",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "lancenter_north" },
        { point = { 0, 0, 1 }, terrain = "lancenter_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "lancenter_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "lancenter_1_north" },
        { point = { 0, 0, 1 }, terrain = "lancenter_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "office_doctor",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_doctor_north" },
        { point = { 0, 0, 1 }, terrain = "office_doctor_roof_north" },
        { point = { 0, 0, 2 }, terrain = "office_doctor_access_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "office_doctor_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_doctor_1_north" },
        { point = { 0, 0, 1 }, terrain = "office_doctor_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "office_doctor_access_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "office_doctor_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_doctor_2_north" },
        { point = { 0, 0, 1 }, terrain = "office_doctor_roof_2_north" },
        { point = { 0, 0, 2 }, terrain = "office_doctor_upper_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_gas_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_gas_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_gas_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_garage",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_garage_north" },
        { point = { 0, 0, 1 }, terrain = "s_garage_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_garage_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_garage_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_garage_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_garage_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_garage_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_garage_roof_2_north" },
        { point = { 0, 0, 2 }, terrain = "s_garage_upper_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_internet_cafe",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_internet_cafe_north" },
        { point = { 0, 0, 1 }, terrain = "cs_internet_cafe_roof_north" },
        { point = { 0, 0, 2 }, terrain = "cs_internet_cafe_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "candy_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "candy_shop_north" },
        { point = { 0, 0, 1 }, terrain = "candy_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "candy_shop_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "candy_shop_1_north" },
        { point = { 0, 0, 1 }, terrain = "candy_shop_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_hardware",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_hardware_north" },
        { point = { 0, 0, 1 }, terrain = "s_hardware_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_hardware_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_hardware_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_hardware_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_hardware_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_hardware_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_hardware_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_hardware_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_hardware_3_north" },
        { point = { 0, 0, 1 }, terrain = "s_hardware_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_2_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_3_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes_4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_4_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_4_north" },
        { point = { 0, 0, 2 }, terrain = "s_clothes_upper_roof_4_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes_5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_5_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_5_north" },
    },
}

ccb.content.define_city_building {
    id = "s_clothes_6",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_clothes_6_north" },
        { point = { 0, 0, 1 }, terrain = "s_clothes_roof_6_north" },
    },
}

ccb.content.define_city_building {
    id = "s_bike_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_bike_shop_north" },
        { point = { 0, 0, 1 }, terrain = "s_bike_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_bike_shop_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_bike_shop_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_bike_shop_roof_1_north" },
        { point = { 0, 0, 2 }, terrain = "s_bike_shop_roof_1_shack_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "home_improvement",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "home_improvement_north" },
        { point = { 0, 0, 1 }, terrain = "home_improvement_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "cs_car_showroom",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_car_showroom_north" },
        { point = { 0, 0, 1 }, terrain = "cs_car_showroom_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "cs_car_showroom_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "gym",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "gym_north" },
        { point = { 0, 0, 1 }, terrain = "gym_roof_north" },
        { point = { 0, 0, 2 }, terrain = "gym_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_pharm",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_pharm_north" },
        { point = { 0, 0, 1 }, terrain = "s_pharm_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_pharm_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_pharm_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_pharm_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "homeless_shelter",
    locations = { "land", "swamp" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "homeless_0_0_0_north" },
        { point = { 0, 1, 0 }, terrain = "homeless_1_0_0_north" },
        { point = { 0, 0, 1 }, terrain = "homeless_0_0_1_north" },
        { point = { 0, 1, 1 }, terrain = "homeless_1_0_1_north" },
        { point = { 0, 0, 2 }, terrain = "homeless_0_0_2_north" },
        { point = { 0, 1, 2 }, terrain = "homeless_1_0_2_north" },
        { point = { 0, 0, 3 }, terrain = "homeless_0_0_roof_north" },
        { point = { 0, 1, 3 }, terrain = "homeless_1_0_roof_north" },
        { point = { 0, 0, 4 }, terrain = "homeless_0_0_4_north" },
    },
}

ccb.content.define_city_building {
    id = "city_block_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "city_block2_1_north" },
        { point = { 0, 0, 1 }, terrain = "city_block2_flr2_1_north" },
        { point = { 0, 0, 2 }, terrain = "city_block2_roof_1_north" },
        { point = { 1, 0, 0 }, terrain = "city_block2_2_north" },
        { point = { 1, 0, 1 }, terrain = "city_block2_flr2_2_north" },
        { point = { 1, 0, 2 }, terrain = "city_block2_roof_2_north" },
        { point = { 2, 0, 0 }, terrain = "city_block2_3_north" },
        { point = { 2, 0, 1 }, terrain = "city_block2_flr2_3_north" },
        { point = { 2, 0, 2 }, terrain = "city_block2_roof_3_north" },
        { point = { 3, 0, 0 }, terrain = "city_block2_4_north" },
        { point = { 3, 0, 1 }, terrain = "city_block2_flr2_4_north" },
        { point = { 3, 0, 2 }, terrain = "city_block2_roof_4_north" },
    },
}

ccb.content.define_city_building {
    id = "textile_mill_museum",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "textile_mill_museum_0a0_north" },
        { point = { 1, 0, 0 }, terrain = "textile_mill_museum_0a1_north" },
        { point = { 2, 0, 0 }, terrain = "textile_mill_museum_0a2_north" },
        { point = { 0, 1, 0 }, terrain = "textile_mill_museum_0b0_north" },
        { point = { 1, 1, 0 }, terrain = "textile_mill_museum_0b1_north" },
        { point = { 2, 1, 0 }, terrain = "textile_mill_museum_0b2_north" },
        { point = { 0, 0, 1 }, terrain = "textile_mill_museum_1a0_north" },
        { point = { 1, 0, 1 }, terrain = "textile_mill_museum_1a1_north" },
        { point = { 2, 0, 1 }, terrain = "textile_mill_museum_1a2_north" },
        { point = { 0, 1, 1 }, terrain = "textile_mill_museum_1b0_north" },
        { point = { 1, 1, 1 }, terrain = "textile_mill_museum_1b1_north" },
        { point = { 2, 1, 1 }, terrain = "textile_mill_museum_1b2_north" },
        { point = { 0, 0, 2 }, terrain = "textile_mill_museum_2a0_north" },
        { point = { 1, 0, 2 }, terrain = "textile_mill_museum_2a1_north" },
        { point = { 2, 0, 2 }, terrain = "textile_mill_museum_2a2_north" },
        { point = { 0, 1, 2 }, terrain = "textile_mill_museum_2b0_north" },
        { point = { 1, 1, 2 }, terrain = "textile_mill_museum_2b1_north" },
        { point = { 2, 1, 2 }, terrain = "textile_mill_museum_2b2_north" },
    },
}

ccb.content.define_city_building {
    id = "abandoned_textile_mill",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "abandoned_textile_mill_0_3_west" },
        { point = { 0, 1, 0 }, terrain = "abandoned_textile_mill_0_2_west" },
        { point = { 0, 2, 0 }, terrain = "abandoned_textile_mill_0_1_west" },
        { point = { 1, 2, 0 }, terrain = "abandoned_textile_mill_b_0_1_north" },
        { point = { 2, 2, 0 }, terrain = "abandoned_textile_mill_b_0_2_north" },
        { point = { 0, 3, 0 }, terrain = "abandoned_textile_mill_0_1_north" },
        { point = { 1, 3, 0 }, terrain = "abandoned_textile_mill_0_2_north" },
        { point = { 2, 3, 0 }, terrain = "abandoned_textile_mill_0_3_north" },
        { point = { 0, 0, 1 }, terrain = "abandoned_textile_mill_1_3_west" },
        { point = { 0, 1, 1 }, terrain = "abandoned_textile_mill_1_2_west" },
        { point = { 0, 2, 1 }, terrain = "abandoned_textile_mill_1_1_west" },
        { point = { 1, 2, 1 }, terrain = "abandoned_textile_mill_b_1_1_north" },
        { point = { 2, 2, 1 }, terrain = "abandoned_textile_mill_b_1_2_north" },
        { point = { 0, 3, 1 }, terrain = "abandoned_textile_mill_1_1_north" },
        { point = { 1, 3, 1 }, terrain = "abandoned_textile_mill_1_2_north" },
        { point = { 2, 3, 1 }, terrain = "abandoned_textile_mill_1_3_north" },
        { point = { 0, 0, 2 }, terrain = "abandoned_textile_mill_2_3_west" },
        { point = { 0, 1, 2 }, terrain = "abandoned_textile_mill_2_2_west" },
        { point = { 0, 2, 2 }, terrain = "abandoned_textile_mill_2_1_west" },
        { point = { 0, 3, 2 }, terrain = "abandoned_textile_mill_2_1_north" },
        { point = { 1, 3, 2 }, terrain = "abandoned_textile_mill_2_2_north" },
        { point = { 2, 3, 2 }, terrain = "abandoned_textile_mill_2_3_north" },
        { point = { 0, 0, 3 }, terrain = "abandoned_textile_mill_3_3_west" },
        { point = { 0, 1, 3 }, terrain = "abandoned_textile_mill_3_2_west" },
        { point = { 0, 2, 3 }, terrain = "abandoned_textile_mill_3_1_west" },
        { point = { 0, 3, 3 }, terrain = "abandoned_textile_mill_3_1_north" },
        { point = { 1, 3, 3 }, terrain = "abandoned_textile_mill_3_2_north" },
        { point = { 2, 3, 3 }, terrain = "abandoned_textile_mill_3_3_north" },
        { point = { 0, 0, 4 }, terrain = "abandoned_textile_mill_4_3_west" },
        { point = { 0, 1, 4 }, terrain = "abandoned_textile_mill_4_2_west" },
        { point = { 0, 2, 4 }, terrain = "abandoned_textile_mill_4_1_west" },
        { point = { 0, 3, 4 }, terrain = "abandoned_textile_mill_4_1_north" },
        { point = { 1, 3, 4 }, terrain = "abandoned_textile_mill_4_2_north" },
        { point = { 2, 3, 4 }, terrain = "abandoned_textile_mill_4_3_north" },
    },
}

ccb.content.define_city_building {
    id = "craft_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "craft_shop_north" },
        { point = { 0, 0, 1 }, terrain = "craft_shop_roof_north" },
        { point = { 0, 0, 2 }, terrain = "craft_shop_upper_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "craft_shop_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "craft_shop_1_north" },
        { point = { 0, 0, 1 }, terrain = "craft_shop_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "craft_shop_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "craft_shop_2_north" },
        { point = { 0, 0, 1 }, terrain = "craft_shop_2ndfloor_2_north" },
        { point = { 0, 0, 2 }, terrain = "craft_shop_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "craft_shop_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "craft_shop_3_north" },
        { point = { 0, 0, 1 }, terrain = "craft_shop_2ndfloor_3_north" },
        { point = { 0, 0, 2 }, terrain = "craft_shop_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "pool",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pool_north" },
        { point = { 0, 0, 1 }, terrain = "pool_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "pool_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pool_1_north" },
        { point = { 0, 0, 1 }, terrain = "pool_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "pool_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pool_2_north" },
        { point = { 0, 0, 1 }, terrain = "pool_roof_2_north" },
    },
}

ccb.content.define_city_building {
    id = "pool_3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pool_3_north" },
        { point = { 0, 0, 1 }, terrain = "pool_roof_3_north" },
    },
}

ccb.content.define_city_building {
    id = "pool_4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pool_4_north" },
        { point = { 0, 0, 1 }, terrain = "pool_roof_4_north" },
    },
}

ccb.content.define_city_building {
    id = "bus_station",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "bus_stat_0_north" },
        { point = { 0, 0, 1 }, terrain = "bus_stat_0_roof_north" },
        { point = { 1, 0, 0 }, terrain = "bus_stat_1_north" },
        { point = { 1, 0, 1 }, terrain = "bus_stat_1_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "parking_lot_2x1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "parking_2x1_0_north" },
        { point = { 1, 0, 0 }, terrain = "parking_2x1_1_north" },
    },
}

ccb.content.define_city_building {
    id = "parking_lot_2x2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "parking_2x2_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "parking_2x2_1_0_north" },
        { point = { 0, 1, 0 }, terrain = "parking_2x2_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "parking_2x2_1_1_north" },
    },
}

ccb.content.define_city_building {
    id = "parking_lot_3x1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "parking_3x1_0_north" },
        { point = { 1, 0, 0 }, terrain = "parking_3x1_1_north" },
        { point = { 2, 0, 0 }, terrain = "parking_3x1_2_north" },
    },
}

ccb.content.define_city_building {
    id = "parking_garage",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "parking_garage_down_0_north" },
        { point = { 1, 0, -1 }, terrain = "parking_garage_down_1_north" },
        { point = { 0, 0, 0 }, terrain = "parking_garage_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "parking_garage_0_1_north" },
        { point = { 0, 0, 1 }, terrain = "parking_garage_1_0_north" },
        { point = { 1, 0, 1 }, terrain = "parking_garage_1_1_north" },
        { point = { 0, 0, 2 }, terrain = "parking_garage_2_0_north" },
        { point = { 1, 0, 2 }, terrain = "parking_garage_2_1_north" },
        { point = { 0, 0, 3 }, terrain = "parking_garage_roof_0_north" },
        { point = { 1, 0, 3 }, terrain = "parking_garage_roof_1_north" },
        { point = { 0, 0, 4 }, terrain = "parking_garage_roof_top_north" },
    },
    city_sizes = { 6, -1 },
}

ccb.content.define_city_building {
    id = "parking_garage2x2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, -1 }, terrain = "parking_garage2x2_down_0_north" },
        { point = { 1, 0, -1 }, terrain = "parking_garage2x2_down_1_north" },
        { point = { 0, 1, -1 }, terrain = "parking_garage2x2_down_2_north" },
        { point = { 1, 1, -1 }, terrain = "parking_garage2x2_down_3_north" },
        { point = { 0, 0, 0 }, terrain = "parking_garage2x2_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "parking_garage2x2_0_1_north" },
        { point = { 0, 1, 0 }, terrain = "parking_garage2x2_0_2_north" },
        { point = { 1, 1, 0 }, terrain = "parking_garage2x2_0_3_north" },
        { point = { 0, 0, 1 }, terrain = "parking_garage2x2_1_0_north" },
        { point = { 1, 0, 1 }, terrain = "parking_garage2x2_1_1_north" },
        { point = { 0, 1, 1 }, terrain = "parking_garage2x2_1_2_north" },
        { point = { 1, 1, 1 }, terrain = "parking_garage2x2_1_3_north" },
        { point = { 0, 0, 2 }, terrain = "parking_garage2x2_2_0_north" },
        { point = { 1, 0, 2 }, terrain = "parking_garage2x2_2_1_north" },
        { point = { 0, 1, 2 }, terrain = "parking_garage2x2_2_2_north" },
        { point = { 1, 1, 2 }, terrain = "parking_garage2x2_2_3_north" },
        { point = { 0, 0, 3 }, terrain = "parking_garage2x2_3_0_north" },
        { point = { 1, 0, 3 }, terrain = "parking_garage2x2_3_1_north" },
        { point = { 0, 1, 3 }, terrain = "parking_garage2x2_3_2_north" },
        { point = { 1, 1, 3 }, terrain = "parking_garage2x2_3_3_north" },
        { point = { 0, 1, 4 }, terrain = "parking_garage2x2_4_2_north" },
        { point = { 1, 1, 4 }, terrain = "parking_garage2x2_4_3_north" },
    },
    city_sizes = { 10, -1 },
}

ccb.content.define_city_building {
    id = "s_music",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_music_north" },
        { point = { 0, 0, 1 }, terrain = "s_music_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "music_venue",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "music_venue_north" },
        { point = { 0, 0, 1 }, terrain = "music_venue_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "music_venue_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "music_venue_1_north" },
        { point = { 0, 0, 1 }, terrain = "music_venue_1_roof_north" },
        { point = { 0, 0, 2 }, terrain = "music_venue_1_roof_top_north" },
    },
}

ccb.content.define_city_building {
    id = "pawn_pf",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "pawn_pf_north" },
        { point = { 0, 0, -1 }, terrain = "pawn_pf_under_north" },
        { point = { 0, 0, 1 }, terrain = "pawn_pf_roof_north" },
    },
    flags = { "GLOBALLY_UNIQUE" },
}

ccb.content.define_city_building {
    id = "s_hunting",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_hunting_north" },
        { point = { 0, 0, 1 }, terrain = "s_hunting_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_rv",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_rv_north" },
        { point = { 0, 0, 1 }, terrain = "house_rv_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_rv_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_porch",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_porch_north" },
        { point = { 0, 0, 1 }, terrain = "house_porch_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_porch_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_patio",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_patio_north" },
        { point = { 0, 0, 1 }, terrain = "house_patio_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_patio_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_modern_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_modern_1_north" },
        { point = { 0, 0, 1 }, terrain = "house_modern_1_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_modern_1_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_library",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_library_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_04_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage2_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage2_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage2_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage3_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage3_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage3_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage4_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage4_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage4_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage5_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage5_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage5_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage6",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage6_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage6_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage6_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage7",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage7_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage7_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage7_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_garage8",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_garage8_north" },
        { point = { 0, 0, 1 }, terrain = "house_garage8_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_garage8_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "rural_house1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "rural_house1_north" },
        { point = { 0, 0, 1 }, terrain = "rural_house1_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "rural_house2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "rural_house2_north" },
        { point = { 0, 0, 1 }, terrain = "rural_house2_roof_north" },
        { point = { 0, 0, -1 }, terrain = "rural_house2_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched1_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched1_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched1_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched2_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched2_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched2_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched3_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched3_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched3_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched4_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched4_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched4_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched5_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched5_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched5_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched6",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched6_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched6_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched6_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched7",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched7_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched7_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched7_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched8",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched8_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched8_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched8_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched9",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched9_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched9_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_detatched9_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched10",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched10_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched10_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "duplex",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "duplex_north" },
        { point = { 0, 0, 1 }, terrain = "duplex_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex2_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex2_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex3_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex3_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex4",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex4_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex4_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex5_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex5_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex6",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex6_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex6_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex7",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex7_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex7_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex8",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex8_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex8_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex9",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex9_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex9_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex10",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex10_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex10_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_duplex11",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_duplex11_north" },
        { point = { 0, 0, 1 }, terrain = "house_duplex11_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_prepper",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_prepper_north" },
        { point = { 0, 0, 1 }, terrain = "house_04_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_prepper_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_prepper2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_prepper2_north" },
        { point = { 0, 0, 1 }, terrain = "house_prepper2_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_prepper2_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fortified",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_fortified_north" },
        { point = { 0, 0, 1 }, terrain = "house_fortified_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_fortified_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_crack1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_crack1_north" },
        { point = { 0, 0, 1 }, terrain = "house_crack1_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_messed_north" },
    },
}

ccb.content.define_city_building {
    id = "house_crack2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_crack2_north" },
        { point = { 0, 0, 1 }, terrain = "house_crack1_roof_north" },
        { point = { 0, 0, -1 }, terrain = "basement_messed_north" },
    },
}

ccb.content.define_city_building {
    id = "house_crack3",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_crack3_north" },
        { point = { 0, 0, 1 }, terrain = "house_crack3_roof_north" },
        { point = { 0, 0, -1 }, terrain = "house_crack3_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "s_laundromat",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_laundromat_north" },
        { point = { 0, 0, 1 }, terrain = "s_laundromat_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_laundromat_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_laundromat_1_north" },
        { point = { 0, 0, 1 }, terrain = "s_laundromat_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "s_camping",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_camping_north" },
        { point = { 0, 0, 1 }, terrain = "s_camping_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_cardealer",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_cardealer_north" },
        { point = { 0, 0, 1 }, terrain = "s_cardealer_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_diner",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_diner_north" },
        { point = { 0, 0, 1 }, terrain = "s_diner_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "s_diner_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_lot",
    locations = { "land" },
    tiles = { { point = { 0, 0, 0 }, terrain = "s_lot_north" } },
}

ccb.content.define_city_building {
    id = "urban_25_dense_diner_apt",
    tiles = {
        { point = { 1, 1, -1 }, terrain = "sewer_connector_east" },
        { point = { 0, 1, -1 }, terrain = "urban_25_sewer_connector_south" },
        { point = { 1, 0, -1 }, terrain = "urban_25_1_south" },
        { point = { 0, 0, -1 }, terrain = "urban_25_2_south" },
        { point = { 1, 0, 0 }, terrain = "urban_25_3_south" },
        { point = { 0, 0, 0 }, terrain = "urban_25_4_south" },
        { point = { 1, 0, 1 }, terrain = "urban_25_5_south" },
        { point = { 0, 0, 1 }, terrain = "urban_25_6_south" },
        { point = { 1, 0, 2 }, terrain = "urban_25_7_south" },
        { point = { 0, 0, 2 }, terrain = "urban_25_8_south" },
        { point = { 1, 0, 3 }, terrain = "urban_25_9_south" },
        { point = { 0, 0, 3 }, terrain = "urban_25_10_south" },
        { point = { 0, 0, 4 }, terrain = "urban_25_12_south" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
}

ccb.content.define_city_building {
    id = "skate_park_ramp",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "skate_park_up_north" },
        { point = { 0, 0, -1 }, terrain = "skate_park_down_north" },
    },
}

ccb.content.define_city_building {
    id = "playground",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "playground_north" },
        { point = { 0, 0, 1 }, terrain = "playground_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "park",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "park_north" },
        { point = { 0, 0, 1 }, terrain = "park_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "park_5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "park_5_north" },
        { point = { 0, 0, 1 }, terrain = "park_5_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "park_7",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "park_7_north" },
        { point = { 0, 0, 1 }, terrain = "park_7_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "nature_trail_city",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "NatureTrail_1a_north" },
        { point = { 1, 0, 0 }, terrain = "NatureTrail_1b_north" },
    },
}

ccb.content.define_city_building {
    id = "salon",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "salon_south" },
        { point = { 0, 0, 1 }, terrain = "salon_roof_south" },
    },
}

ccb.content.define_city_building {
    id = "strip_mall",
    locations = { "land" },
    tiles = {
        { point = { 4, 0, 0 }, terrain = "strip_mall_1_south" },
        { point = { 3, 0, 0 }, terrain = "strip_mall_2_south" },
        { point = { 2, 0, 0 }, terrain = "strip_mall_3_south" },
        { point = { 1, 0, 0 }, terrain = "strip_mall_4_south" },
        { point = { 0, 0, 0 }, terrain = "strip_mall_5_south" },
        { point = { 4, 0, 1 }, terrain = "strip_mall_roof_1_south" },
        { point = { 3, 0, 1 }, terrain = "strip_mall_roof_2_south" },
        { point = { 2, 0, 1 }, terrain = "strip_mall_roof_3_south" },
        { point = { 1, 0, 1 }, terrain = "strip_mall_roof_4_south" },
        { point = { 0, 0, 1 }, terrain = "strip_mall_roof_5_south" },
    },
    city_sizes = { 6, -1 },
}

ccb.content.define_city_building {
    id = "cs_open_sewer",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "cs_open_sewer_north" },
        { point = { 0, 0, 1 }, terrain = "cs_open_sewer_roof_north" },
        { point = { 0, 0, -1 }, terrain = "cs_open_sewer_undergound_north" },
        { point = { 0, -1, -1 }, terrain = "sewer_connector_north" },
    },
}

ccb.content.define_city_building {
    id = "orchard",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "orchard_north" },
        { point = { 0, 0, 1 }, terrain = "orchard_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "orchard_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "orchard_1_north" },
        { point = { 0, 0, 1 }, terrain = "orchard_roof_1_north" },
    },
}

ccb.content.define_city_building {
    id = "warehouse",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "warehouse_north" },
        { point = { 0, 0, 1 }, terrain = "warehouse_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "convention_center",
    tiles = {
        { point = { 0, 0, 0 }, terrain = "convention_0_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "convention_1_0_0_north" },
        { point = { 2, 0, 0 }, terrain = "convention_2_0_0_north" },
        { point = { 3, 0, 0 }, terrain = "convention_3_0_0_north" },
        { point = { 4, 0, 0 }, terrain = "convention_4_0_0_north" },
        { point = { 0, 1, 0 }, terrain = "convention_0_1_0_north" },
        { point = { 1, 1, 0 }, terrain = "convention_1_1_0_north" },
        { point = { 2, 1, 0 }, terrain = "convention_2_1_0_north" },
        { point = { 3, 1, 0 }, terrain = "convention_3_1_0_north" },
        { point = { 4, 1, 0 }, terrain = "convention_4_1_0_north" },
        { point = { 0, 2, 0 }, terrain = "convention_0_2_0_north" },
        { point = { 1, 2, 0 }, terrain = "convention_1_2_0_north" },
        { point = { 2, 2, 0 }, terrain = "convention_2_2_0_north" },
        { point = { 3, 2, 0 }, terrain = "convention_3_2_0_north" },
        { point = { 4, 2, 0 }, terrain = "convention_4_2_0_north" },
        { point = { 0, 0, 1 }, terrain = "convention_0_0_1_north" },
        { point = { 1, 0, 1 }, terrain = "convention_1_0_1_north" },
        { point = { 2, 0, 1 }, terrain = "convention_2_0_1_north" },
        { point = { 3, 0, 1 }, terrain = "convention_3_0_1_north" },
        { point = { 4, 0, 1 }, terrain = "convention_4_0_1_north" },
        { point = { 0, 1, 1 }, terrain = "convention_0_1_1_north" },
        { point = { 1, 1, 1 }, terrain = "convention_1_1_1_north" },
        { point = { 2, 1, 1 }, terrain = "convention_2_1_1_north" },
        { point = { 3, 1, 1 }, terrain = "convention_3_1_1_north" },
        { point = { 4, 1, 1 }, terrain = "convention_4_1_1_north" },
        { point = { 0, 2, 1 }, terrain = "convention_0_2_1_north" },
        { point = { 1, 2, 1 }, terrain = "convention_1_2_1_north" },
        { point = { 2, 2, 1 }, terrain = "convention_2_2_1_north" },
        { point = { 3, 2, 1 }, terrain = "convention_3_2_1_north" },
        { point = { 4, 2, 1 }, terrain = "convention_4_2_1_north" },
        { point = { 0, 0, 2 }, terrain = "convention_0_0_2_north" },
        { point = { 1, 0, 2 }, terrain = "convention_1_0_2_north" },
        { point = { 2, 0, 2 }, terrain = "convention_2_0_2_north" },
        { point = { 3, 0, 2 }, terrain = "convention_3_0_2_north" },
        { point = { 4, 0, 2 }, terrain = "convention_4_0_2_north" },
        { point = { 0, 1, 2 }, terrain = "convention_0_1_2_north" },
        { point = { 1, 1, 2 }, terrain = "convention_1_1_2_north" },
        { point = { 2, 1, 2 }, terrain = "convention_2_1_2_north" },
        { point = { 3, 1, 2 }, terrain = "convention_3_1_2_north" },
        { point = { 4, 1, 2 }, terrain = "convention_4_1_2_north" },
        { point = { 0, 2, 2 }, terrain = "convention_0_2_2_north" },
        { point = { 1, 2, 2 }, terrain = "convention_1_2_2_north" },
        { point = { 2, 2, 2 }, terrain = "convention_2_2_2_north" },
        { point = { 3, 2, 2 }, terrain = "convention_3_2_2_north" },
        { point = { 4, 2, 2 }, terrain = "convention_4_2_2_north" },
    },
    locations = { "land" },
    flags = { "CLASSIC" },
    city_sizes = { 12, -1 },
}

ccb.content.define_city_building {
    id = "barber_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "barber_shop_north" },
        { point = { 0, 0, 1 }, terrain = "barber_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_fabricstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_fabricstore_north" },
        { point = { 0, 0, 1 }, terrain = "s_fabricstore_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_fungus_01",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_fungus_01_north" },
        { point = { 0, 0, 1 }, terrain = "house_fungus_roof_01_north" },
    },
}

ccb.content.define_city_building {
    id = "small_kindergarten",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "small_kindergarten_north" },
        { point = { 0, 0, 1 }, terrain = "small_kindergarten_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "office_dentist",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_dentist_north" },
        { point = { 0, 0, 1 }, terrain = "office_dentist_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "s_airsoft",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "s_airsoft_north" },
        { point = { 0, 0, 1 }, terrain = "s_airsoft_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "office_warehouse_anduril",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "office_warehouse_anduril_north" },
        { point = { 0, 0, 1 }, terrain = "office_warehouse_anduril_roof_north" },
    },
    flags = { "GLOBALLY_UNIQUE" },
}
