local ccb = require("ccb")

ccb.content.define_city_building {
    id = "dinozoo",
    locations = { "land" },
    tiles = {
        { point = { 0, 0, 0 }, terrain = "dinozoo_0_0_north" },
        { point = { 1, 0, 0 }, terrain = "dinozoo_1_0_north" },
        { point = { 2, 0, 0 }, terrain = "dinozoo_2_0_north" },
        { point = { 3, 0, 0 }, terrain = "dinozoo_3_0_north" },
        { point = { 0, 1, 0 }, terrain = "dinozoo_0_1_north" },
        { point = { 1, 1, 0 }, terrain = "dinozoo_1_1_north" },
        { point = { 2, 1, 0 }, terrain = "dinozoo_2_1_north" },
        { point = { 3, 1, 0 }, terrain = "dinozoo_3_1_north" },
        { point = { 0, 2, 0 }, terrain = "dinozoo_0_2_north" },
        { point = { 1, 2, 0 }, terrain = "dinozoo_1_2_north" },
        { point = { 2, 2, 0 }, terrain = "dinozoo_2_2_north" },
        { point = { 3, 2, 0 }, terrain = "dinozoo_3_2_north" },
        { point = { 0, 3, 0 }, terrain = "dinozoo_0_3_north" },
        { point = { 1, 3, 0 }, terrain = "dinozoo_1_3_north" },
        { point = { 2, 3, 0 }, terrain = "dinozoo_2_3_north" },
        { point = { 3, 3, 0 }, terrain = "dinozoo_3_3_north" },
        { point = { 0, 0, 1 }, terrain = "dinozoo_0_0_roof_north" },
        { point = { 1, 0, 1 }, terrain = "dinozoo_1_0_roof_north" },
        { point = { 2, 0, 1 }, terrain = "dinozoo_2_0_roof_north" },
        { point = { 3, 0, 1 }, terrain = "dinozoo_3_0_roof_north" },
        { point = { 0, 1, 1 }, terrain = "dinozoo_0_1_roof_north" },
        { point = { 1, 1, 1 }, terrain = "dinozoo_1_1_roof_north" },
        { point = { 2, 1, 1 }, terrain = "dinozoo_2_1_roof_north" },
        { point = { 3, 1, 1 }, terrain = "dinozoo_3_1_roof_north" },
        { point = { 0, 2, 1 }, terrain = "dinozoo_0_2_roof_north" },
        { point = { 1, 2, 1 }, terrain = "dinozoo_1_2_roof_north" },
        { point = { 2, 2, 1 }, terrain = "dinozoo_2_2_roof_north" },
        { point = { 3, 2, 1 }, terrain = "dinozoo_3_2_roof_north" },
        { point = { 0, 3, 1 }, terrain = "dinozoo_0_3_roof_north" },
        { point = { 1, 3, 1 }, terrain = "dinozoo_1_3_roof_north" },
        { point = { 2, 3, 1 }, terrain = "dinozoo_2_3_roof_north" },
        { point = { 3, 3, 1 }, terrain = "dinozoo_3_3_roof_north" },
        { point = { 3, 2, -1 }, terrain = "dinozoo_3_2_basement_north" },
        { point = { 3, 3, -1 }, terrain = "dinozoo_3_3_basement_north" },
    },
}

ccb.content.define_overmap_terrain {
    id = { "dinozoo_0_0", "dinozoo_1_0" },
    copy_from = "generic_city_building",
    name = ccb.content.text("DinoZoo parking"),
    symbol = "P",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = { "dinozoo_2_0", "dinozoo_3_0" },
    copy_from = "generic_city_building",
    name = ccb.content.text("DinoZoo entrance"),
    symbol = "P",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = {
        "dinozoo_0_1", "dinozoo_1_1", "dinozoo_2_1", "dinozoo_3_1", "dinozoo_0_2", "dinozoo_1_2",
        "dinozoo_2_2", "dinozoo_3_2", "dinozoo_0_3", "dinozoo_1_3", "dinozoo_2_3", "dinozoo_3_3",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("DinoZoo"),
    symbol = "Z",
    color = "i_green",
}

ccb.content.define_overmap_terrain {
    id = { "dinozoo_3_2_basement", "dinozoo_3_3_basement" },
    copy_from = "generic_city_building",
    name = ccb.content.text("DinoZoo cave"),
    symbol = "Z",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "dinozoo_0_0_roof", "dinozoo_1_0_roof", "dinozoo_2_0_roof", "dinozoo_3_0_roof",
        "dinozoo_0_1_roof", "dinozoo_1_1_roof", "dinozoo_2_1_roof", "dinozoo_3_1_roof",
        "dinozoo_0_2_roof", "dinozoo_1_2_roof", "dinozoo_2_2_roof", "dinozoo_3_2_roof",
        "dinozoo_0_3_roof", "dinozoo_1_3_roof", "dinozoo_2_3_roof", "dinozoo_3_3_roof",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("DinoZoo roof"),
    symbol = "Z",
    color = "i_green",
}
