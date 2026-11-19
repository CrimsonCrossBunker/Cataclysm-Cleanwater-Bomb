local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_sewer",
    vision_levels = "underground_dirt",
    name = ccb.content.text("sewer"),
    color = "green",
    see_cost = "full_high",
}

ccb.content.define_overmap_terrain {
    id = "sewer",
    copy_from = "generic_sewer",
    flags = { "LINEAR" },
}

ccb.content.define_overmap_terrain {
    id = "urban_25_sewer_connector",
    copy_from = "generic_sewer",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = "sewer_connector",
    copy_from = "generic_sewer",
    symbol = "X",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = { "sewage_treatment_0_0_0", "sewage_treatment_1_0_0", "sewage_treatment_1_1_0" },
    name = ccb.content.text("sewage treatment plant"),
    vision_levels = "isolated_building",
    symbol = "P",
    color = "red",
    see_cost = "high",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = "sewage_treatment_0_0_roof",
    vision_levels = "always_full",
    name = ccb.content.text("open air"),
    symbol = ".",
    color = "blue",
    see_cost = "all_clear",
}

ccb.content.define_overmap_terrain {
    id = { "sewage_treatment_1_0_roof", "sewage_treatment_1_1_roof", "sewage_treatment_1_0_upper_roof" },
    name = ccb.content.text("sewage treatment plant roof"),
    vision_levels = "isolated_building",
    symbol = "P",
    color = "red",
    see_cost = "high",
}

ccb.content.define_overmap_terrain {
    id = "sewage_treatment_0_1_0",
    name = ccb.content.text("sewage treatment plant"),
    symbol = "O",
    color = "blue",
    vision_levels = "single_water",
    see_cost = "none",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = "sewage_treatment_0_1_roof",
    name = ccb.content.text("sewage treatment plant roof"),
    symbol = "O",
    color = "blue",
    vision_levels = "roof_or_air",
    see_cost = "none",
}

ccb.content.define_overmap_terrain {
    id = {
        "sewage_treatment_0_0_-1", "sewage_treatment_1_0_-1", "sewage_treatment_2_0_-1",
        "sewage_treatment_0_1_-1", "sewage_treatment_1_1_-1", "sewage_treatment_2_1_-1",
    },
    name = ccb.content.text("sewage treatment plant - underground"),
    symbol = "P",
    color = "green",
    vision_levels = "underground_dirt",
    see_cost = "full_high",
    extras = "build",
    flags = { "KNOWN_UP" },
}

ccb.content.define_overmap_terrain {
    id = { "toxic_dump", "toxic_dump_roof" },
    name = ccb.content.text("toxic waste dump"),
    symbol = "D",
    color = "pink",
    vision_levels = "isolated_building",
    see_cost = "spaced_high",
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = {
        "haz_sar_1_1", "haz_sar_1_2", "haz_sar_1_3", "haz_sar_1_4", "haz_sar_1_1_2", "haz_sar_1_2_2",
        "haz_sar_1_3_2", "haz_sar_1_4_2", "haz_sar_b_1", "haz_sar_b_2", "haz_sar_b_3", "haz_sar_b_4",
    },
    name = ccb.content.text("hazardous waste sarcophagus"),
    symbol = "X",
    color = "pink",
    vision_levels = "isolated_building",
    see_cost = "high",
    flags = { "RISK_HIGH" },
}

ccb.content.define_overmap_terrain {
    id = "pump_station_1",
    copy_from = "generic_city_building",
    vision_levels = "isolated_building",
    name = ccb.content.text("pump station"),
    symbol = "P",
    color = "red",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = { "pump_station_1_roof", "pump_station_2_roof" },
    copy_from = "generic_city_building",
    vision_levels = "roof_or_air",
    name = ccb.content.text("pump station roof"),
    symbol = "P",
    color = "red",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = "pump_station_2",
    copy_from = "generic_city_building",
    vision_levels = "isolated_building",
    name = ccb.content.text("pump station"),
    symbol = "P",
    color = "red",
    flags = { "KNOWN_DOWN" },
}

ccb.content.define_overmap_terrain {
    id = { "pump_station_3", "pump_station_4", "pump_station_5" },
    name = ccb.content.text("pump station"),
    vision_levels = "isolated_building",
    symbol = "P",
    color = "green",
    see_cost = "high",
    monster_density = 2,
}

ccb.content.define_overmap_terrain {
    id = { "dumpsite", "dumpsite_edge" },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("dumpsite"),
    symbol = "D",
    color = "brown",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "dump",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("dump"),
    symbol = "D",
    color = "i_brown",
    flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION" },
}

ccb.content.define_overmap_terrain {
    id = { "trailer_public_00", "trailer_public_00_roof" },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("garbage collection point"),
    symbol = "D",
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = { "recyclecenter", "recyclecenter_1", "recyclecenter_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("recycle center"),
    symbol = "R",
    color = "i_green",
    extend = { flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = { "recyclecenter_roof", "recyclecenter_roof_1", "recyclecenter_roof_2" },
    copy_from = "generic_city_building",
    name = ccb.content.text("recycle center roof"),
    symbol = "R",
    color = "i_green",
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = "landfill",
    copy_from = "generic_city_building",
    name = ccb.content.text("landfill"),
    symbol = "L",
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = {
        "junkyard_1a", "junkyard_roof_1a", "junkyard_1b", "junkyard_roof_1b", "junkyard_2a",
        "junkyard_roof_2a", "junkyard_2b", "junkyard_roof_2b",
    },
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("junkyard"),
    symbol = "J",
    color = "i_brown",
    extend = { flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION", "SOURCE_VEHICLES" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    abstract = "generic_regional_dump",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("regional dump"),
    symbol = "d",
    color = "i_brown",
    flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION", "SOURCE_VEHICLES" },
}

ccb.content.define_overmap_terrain {
    id = {
        "ws_regional_dump_2_0", "ws_regional_dump_3_0", "ws_regional_dump_3_0_roof",
        "ws_regional_dump_0_1", "ws_regional_dump_1_1", "ws_regional_dump_2_1", "ws_regional_dump_3_1",
        "ws_regional_dump_0_2", "ws_regional_dump_1_2", "ws_regional_dump_2_2", "ws_regional_dump_3_2",
        "ws_regional_dump_0_3", "ws_regional_dump_1_3", "ws_regional_dump_2_3", "ws_regional_dump_3_3",
        "ws_biker_dump_0_0", "ws_biker_dump_1_0", "ws_biker_dump_2_0", "ws_biker_dump_3_0",
        "ws_biker_dump_3_0_roof", "ws_biker_dump_0_1", "ws_biker_dump_1_1", "ws_biker_dump_2_1",
        "ws_biker_dump_3_1", "ws_biker_dump_0_2", "ws_biker_dump_1_2", "ws_biker_dump_2_2",
        "ws_biker_dump_2_2_roof", "ws_biker_dump_3_2", "ws_biker_dump_0_3", "ws_biker_dump_1_3",
        "ws_biker_dump_2_3", "ws_biker_dump_3_3",
    },
    copy_from = "generic_regional_dump",
}

ccb.content.define_overmap_terrain {
    id = { "ws_regional_dump_0_0", "ws_regional_dump_1_0" },
    copy_from = "generic_regional_dump",
    looks_like = "s_lot",
    vision_levels = "large_pavement",
}

ccb.content.define_overmap_terrain {
    id = "smallscrapyard",
    copy_from = "generic_city_building_no_sidewalk",
    name = ccb.content.text("small scrap yard"),
    symbol = "s",
    color = "red",
    flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION", "SOURCE_VEHICLES" },
}

ccb.content.define_overmap_terrain {
    id = { "cs_open_sewer", "cs_open_sewer_roof", "cs_open_sewer_undergound" },
    copy_from = "generic_city_building",
    name = ccb.content.text("open sewer"),
    symbol = "s",
    color = "i_light_blue",
}

ccb.content.define_overmap_terrain {
    id = "cs_city_dump_small",
    copy_from = "generic_city_building",
    name = ccb.content.text("small dump"),
    symbol = "d",
    color = "i_brown",
    extend = { flags = { "SOURCE_FABRICATION", "SOURCE_CONSTRUCTION", "SOURCE_VEHICLES" } },
    delete = { post_process_generators = { "riot_damage" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "abandoned_textile_mill_0_1", "abandoned_textile_mill_0_2", "abandoned_textile_mill_0_3",
        "abandoned_textile_mill_1_1", "abandoned_textile_mill_1_2", "abandoned_textile_mill_1_3",
        "abandoned_textile_mill_2_1", "abandoned_textile_mill_2_2", "abandoned_textile_mill_2_3",
        "abandoned_textile_mill_3_1", "abandoned_textile_mill_3_2", "abandoned_textile_mill_3_3",
        "abandoned_textile_mill_4_1", "abandoned_textile_mill_4_2", "abandoned_textile_mill_4_3",
        "abandoned_textile_mill_b_0_1", "abandoned_textile_mill_b_0_2", "abandoned_textile_mill_b_1_1",
        "abandoned_textile_mill_b_1_2",
    },
    copy_from = "generic_city_building",
    name = ccb.content.text("abandoned textile mill"),
    color = "light_blue",
    extend = { flags = { "SOURCE_CONSTRUCTION" } },
    delete = { post_process_generators = { "riot_damage" } },
}
