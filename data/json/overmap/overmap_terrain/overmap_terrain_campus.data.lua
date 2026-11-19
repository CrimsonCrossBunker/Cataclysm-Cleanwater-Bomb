local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "campus_admin_0_0_0", "campus_admin_0_1_0", "campus_admin_0_2_0", "campus_admin_0_0_1",
        "campus_admin_0_1_1", "campus_admin_0_2_1", "campus_admin_0_0_2", "campus_admin_0_1_2",
        "campus_admin_0_2_2", "campus_admin_0_0_3", "campus_admin_0_1_3", "campus_admin_0_2_3",
    },
    vision_levels = "large_building",
    name = ccb.content.text("campus admin building"),
    symbol = "A",
    color = "red",
    see_cost = "full_high",
    flags = { "SOURCE_CHEMISTRY", "RISK_HIGH", "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = {
        "campus_commons_0_0_0", "campus_commons_1_0_0", "campus_commons_0_1_0", "campus_commons_1_1_0",
        "campus_commons_0_2_0", "campus_commons_1_2_0", "campus_commons_0_3_0", "campus_commons_1_3_0",
        "campus_commons_0_0_1", "campus_commons_1_0_1", "campus_commons_0_1_1", "campus_commons_1_1_1",
        "campus_commons_0_2_1", "campus_commons_1_2_1", "campus_commons_0_3_1", "campus_commons_1_3_1",
        "campus_commons_0_0_2", "campus_commons_1_0_2", "campus_commons_0_1_2", "campus_commons_1_1_2",
        "campus_commons_0_2_2", "campus_commons_1_2_2", "campus_commons_0_3_2", "campus_commons_1_3_2",
    },
    vision_levels = "large_building",
    name = ccb.content.text("campus commons building"),
    symbol = "C",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = {
        "campus_commons_0_0_3", "campus_commons_1_0_3", "campus_commons_0_1_3", "campus_commons_1_1_3",
        "campus_commons_0_2_3", "campus_commons_1_2_3", "campus_commons_0_3_3", "campus_commons_1_3_3",
    },
    vision_levels = "roof_or_air",
    name = ccb.content.text("campus commons roof"),
    color = "blue",
    copy_from = "campus_commons_0_0_0",
}

ccb.content.define_overmap_terrain {
    id = {
        "campus_media_0_0_0", "campus_media_0_1_0", "campus_media_1_0_0", "campus_media_1_1_0",
        "campus_media_0_0_1", "campus_media_0_1_1", "campus_media_1_0_1", "campus_media_1_1_1",
        "campus_media_0_0_2", "campus_media_0_1_2", "campus_media_1_0_2", "campus_media_1_1_2",
        "campus_media_0_0_3", "campus_media_0_1_3", "campus_media_1_0_3", "campus_media_1_1_3",
    },
    vision_levels = "large_building",
    name = ccb.content.text("campus media building"),
    symbol = "C",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = { "campus_media_0_0_4", "campus_media_0_1_4", "campus_media_1_0_4", "campus_media_1_1_4" },
    name = ccb.content.text("campus media building roof"),
    vision_levels = "roof_or_air",
    color = "blue",
    copy_from = "campus_media_0_0_0",
}

ccb.content.define_overmap_terrain {
    id = {
        "campus_health_0_0_0", "campus_health_0_1_0", "campus_health_0_2_0", "campus_health_0_0_1",
        "campus_health_0_1_1", "campus_health_0_2_1", "campus_health_0_0_2", "campus_health_0_1_2",
        "campus_health_0_2_2",
    },
    vision_levels = "large_building",
    name = ccb.content.text("campus health building"),
    symbol = "C",
    color = "red",
    see_cost = "full_high",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = { "campus_health_0_0_3", "campus_health_0_1_3", "campus_health_0_2_3" },
    vision_levels = "roof_or_air",
    name = ccb.content.text("campus health building roof"),
    copy_from = "campus_health_0_0_0",
}

ccb.content.define_overmap_terrain {
    id = {
        "campus_lecture_0_0_0", "campus_lecture_0_1_0", "campus_lecture_0_2_0", "campus_lecture_0_3_0",
        "campus_lecture_0_0_1", "campus_lecture_0_1_1", "campus_lecture_0_2_1", "campus_lecture_0_3_1",
        "campus_lecture_0_0_2", "campus_lecture_0_1_2", "campus_lecture_0_2_2", "campus_lecture_0_3_2",
    },
    name = ccb.content.text("campus lecture hall"),
    vision_levels = "large_building",
    symbol = "C",
    color = "light_blue",
    see_cost = "full_high",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = { "campus_lecture_0_0_3", "campus_lecture_0_1_3", "campus_lecture_0_2_3", "campus_lecture_0_3_3" },
    name = ccb.content.text("campus lecture hall roof"),
    vision_levels = "roof_or_air",
    color = "blue",
    copy_from = "campus_lecture_0_0_0",
}

ccb.content.define_overmap_terrain {
    id = {
        "pedestrian_9_8", "pedestrian_10_8", "pedestrian_9_11", "pedestrian_10_11",
        "pedestrian_11_5_0", "pedestrian_12_5_0", "pedestrian_13_5_0", "pedestrian_14_5_0",
        "pedestrian_11_6_0", "pedestrian_12_6_0", "pedestrian_13_6_0", "pedestrian_14_6_0",
        "pedestrian_11_7_0", "pedestrian_12_7_0", "pedestrian_13_7_0", "pedestrian_11_8_0",
        "pedestrian_12_8_0", "pedestrian_13_8_0", "pedestrian_12_9_0", "pedestrian_13_9_0",
    },
    vision_levels = "blends_till_details",
    name = ccb.content.text("campus pedestrian area"),
    symbol = ".",
    color = "light_green",
    see_cost = "full_high",
    flags = { "SHOULD_NOT_SPAWN" },
}
