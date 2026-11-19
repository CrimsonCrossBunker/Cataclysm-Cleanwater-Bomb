local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "robofac_strip_mall_x0y0", "robofac_strip_mall_x1y0", "robofac_strip_mall_x2y0",
        "robofac_strip_mall_x3y0",
    },
    name = ccb.content.text("strip mall"),
    symbol = "v",
    color = "light_red",
    copy_from = "generic_city_building",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "robofac_strip_mall_x4y0", "robofac_strip_mall_x0y1", "robofac_strip_mall_x1y1",
        "robofac_strip_mall_x2y1", "robofac_strip_mall_x3y1", "robofac_strip_mall_x4y1",
    },
    name = ccb.content.text("parking lot"),
    copy_from = "s_lot",
}

ccb.content.define_overmap_terrain {
    id = {
        "robofac_strip_mall_roof_1", "robofac_strip_mall_roof_2", "robofac_strip_mall_roof_3",
        "robofac_strip_mall_roof_4",
    },
    name = ccb.content.text("strip mall roof"),
    symbol = "v",
    color = "light_red",
    see_cost = "none",
    vision_levels = "roof_or_air",
}

ccb.content.define_overmap_terrain {
    id = "robofac_strip_mall_roof_5",
    name = ccb.content.text("open air"),
    see_cost = "none",
    vision_levels = "roof_or_air",
    symbol = ".",
    color = "blue",
}
