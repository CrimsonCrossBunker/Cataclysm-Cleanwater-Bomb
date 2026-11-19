local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = { "isolated_road_field_0", "isolated_road_field_1", "isolated_road_field_1_roof" },
    vision_levels = "open_land",
    see_cost = "none",
    name = ccb.content.text("yard"),
    symbol = ".",
    color = "green",
    flags = { "NO_ROTATE" },
}

ccb.content.define_overmap_terrain {
    id = { "isolated_house_farm_gunsmith", "isolated_house_farm_roof_gunsmith" },
    vision_levels = "isolated_building",
    name = ccb.content.text("gunsmith's home"),
    symbol = "v",
    color = "red",
    flags = { "NO_ROTATE" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "isolated_house_farm_blacksmith", "isolated_house_farm_roof_blacksmith" },
    vision_levels = "isolated_building",
    name = ccb.content.text("blacksmith's home"),
    symbol = "^",
    color = "cyan",
    flags = { "NO_ROTATE" },
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = { "gunshow_0", "gunshow_1", "gunshow_0_roof", "gunshow_1_roof" },
    vision_levels = "blends_till_details",
    name = ccb.content.text("gun show"),
    symbol = "G",
    color = "red",
    see_cost = "high",
}
