local ccb = require("ccb")

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
