local ccb = require("ccb")

ccb.content.define_city_building {
    id = "magic_shop",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "magic_shop_north" },
        { point = { 0, 0, 1 }, terrain = "magic_shop_2ndfloor_north" },
        { point = { 0, 0, 2 }, terrain = "magic_shop_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "used_bookstore",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "used_bookstore_north" },
        { point = { 0, 0, 1 }, terrain = "used_bookstore_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "wizard_tower_1",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "wizardtower1_ground_south" },
        { point = { 0, 0, 1 }, terrain = "wizardtower1_living_south" },
        { point = { 0, 0, 2 }, terrain = "wizardtower1_golems_south" },
        { point = { 0, 0, 3 }, terrain = "wizardtower1_study_south" },
        { point = { 0, 0, 4 }, terrain = "wizardtower1_roof_south" },
    },
}

ccb.content.define_city_building {
    id = "wizard_tower_2",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "wizardtower2_ground_north" },
        { point = { 0, 0, 1 }, terrain = "wizardtower2_stairs1_north" },
        { point = { 0, 0, 2 }, terrain = "wizardtower2_stairs2_north" },
        { point = { 0, 0, 3 }, terrain = "wizardtower2_study_north" },
        { point = { 0, 0, 4 }, terrain = "wizardtower2_roof_north" },
    },
}

ccb.content.define_city_building {
    id = "house_detatched5",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_detatched5_north" },
        { point = { 0, 0, 1 }, terrain = "house_detatched5_roof_north" },
        { point = { 0, 0, -1 }, terrain = "magic_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "magic_academy",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "magic_academy_ground_north" },
        { point = { 0, 0, 1 }, terrain = "magic_academy_2nd_north" },
        { point = { 0, 0, 2 }, terrain = "magic_academy_3rd_north" },
        { point = { 0, 0, 3 }, terrain = "magic_academy_4th_north" },
        { point = { 0, 0, 4 }, terrain = "magic_academy_5th_north" },
        { point = { 0, 0, 5 }, terrain = "magic_academy_6th_north" },
        { point = { 0, 0, 6 }, terrain = "magic_academy_7th_north" },
        { point = { 0, 0, 7 }, terrain = "magic_academy_8th_north" },
        { point = { 0, 0, 8 }, terrain = "magic_academy_roof_north" },
        { point = { 0, 0, -1 }, terrain = "magic_academy_basement_north" },
    },
}

ccb.content.define_city_building {
    id = "house_technomancer",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_technomancer_1_north" },
        { point = { 1, 0, 0 }, terrain = "house_technomancer_2_north" },
        { point = { 0, 0, 1 }, terrain = "house_technomancer_3_north" },
        { point = { 1, 0, 1 }, terrain = "house_technomancer_4_north" },
        { point = { 0, 0, 2 }, terrain = "house_technomancer_5_north" },
        { point = { 1, 0, 2 }, terrain = "house_technomancer_6_north" },
        { point = { 0, 0, -1 }, terrain = "house_technomancer_7_north" },
        { point = { 1, 0, -1 }, terrain = "house_technomancer_8_north" },
    },
}

ccb.content.define_city_building {
    id = "house_elf_01",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "house_elf_01_north" },
        { point = { 0, 0, 1 }, terrain = "house_elf_01_roof_north" },
    },
}
