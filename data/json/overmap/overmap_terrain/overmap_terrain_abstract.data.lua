local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_cropland",
    vision_levels = "open_land",
    travel_cost = "field",
    see_cost = "low",
    name = ccb.content.text("generic_cropland"),
    land_use_code = "cropland",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_pasture",
    vision_levels = "open_land",
    travel_cost = "field",
    see_cost = "none",
    name = ccb.content.text("generic_pasture"),
    land_use_code = "pasture",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_forest",
    name = ccb.content.text("generic_forest"),
    vision_levels = "forested",
    travel_cost = "forest",
    see_cost = "spaced_high",
    land_use_code = "forest",
    connect_group = "forest",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_wetland",
    vision_levels = "forested_swampy",
    travel_cost = "swamp",
    see_cost = "spaced_high",
    name = ccb.content.text("generic_wetland"),
    land_use_code = "wetland",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_mining",
    travel_cost = "other",
    see_cost = "high",
    name = ccb.content.text("generic_mining"),
    land_use_code = "mining",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_open_land",
    see_cost = "none",
    vision_levels = "open_land",
    travel_cost = "field",
    name = ccb.content.text("generic_open_land"),
    land_use_code = "open_land",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_recreation_participation",
    see_cost = "low",
    travel_cost = "field",
    name = ccb.content.text("generic_recreation_participation"),
    land_use_code = "recreation_participation",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_recreation_spectator",
    see_cost = "low",
    travel_cost = "field",
    name = ccb.content.text("generic_recreation_spectator"),
    land_use_code = "recreation_spectator",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_recreation_water",
    see_cost = "none",
    travel_cost = "water",
    name = ccb.content.text("generic_recreation_water"),
    land_use_code = "recreation_water",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_residential_multi",
    see_cost = "high",
    travel_cost = "structure",
    name = ccb.content.text("generic_residential_multi"),
    land_use_code = "residential_multi",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_residential_high",
    see_cost = "high",
    travel_cost = "structure",
    name = ccb.content.text("generic_residential_high"),
    land_use_code = "residential_high",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_residential_medium",
    see_cost = "high",
    travel_cost = "structure",
    name = ccb.content.text("generic_residential_medium"),
    land_use_code = "residential_medium",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_residential_low",
    see_cost = "high",
    travel_cost = "structure",
    name = ccb.content.text("generic_residential_low"),
    land_use_code = "residential_low",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_wetland_saltwater",
    see_cost = "spaced_high",
    travel_cost = "swamp",
    name = ccb.content.text("generic_wetland_saltwater"),
    land_use_code = "wetland_saltwater",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_commercial",
    see_cost = "high",
    travel_cost = "structure",
    name = ccb.content.text("generic_commercial"),
    land_use_code = "commercial",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_industrial",
    see_cost = "high",
    travel_cost = "structure",
    name = ccb.content.text("generic_industrial"),
    land_use_code = "industrial",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_transitional",
    see_cost = "high",
    vision_levels = "blends_till_details",
    travel_cost = "field",
    name = ccb.content.text("generic_transitional"),
    land_use_code = "transitional",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_transportation",
    see_cost = "none",
    vision_levels = "blends_till_outlines",
    travel_cost = "road",
    name = ccb.content.text("generic_transportation"),
    land_use_code = "transportation",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_waste_disposal",
    see_cost = "medium",
    name = ccb.content.text("generic_waste_disposal"),
    travel_cost = "structure",
    land_use_code = "waste_disposal",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_water",
    see_cost = "none",
    name = ccb.content.text("generic_water"),
    travel_cost = "water",
    land_use_code = "water",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_cranberry_bog",
    see_cost = "none",
    name = ccb.content.text("generic_cranberry_bog"),
    travel_cost = "swamp",
    land_use_code = "cranberry_bog",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_powerline_utility",
    see_cost = "low",
    name = ccb.content.text("generic_powerline_utility"),
    travel_cost = "dirt_road",
    land_use_code = "powerline_utility",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_saltwater_sandy_beach",
    see_cost = "none",
    name = ccb.content.text("generic_saltwater_sandy_beach"),
    travel_cost = "shore",
    land_use_code = "saltwater_sandy_beach",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_golf_course",
    see_cost = "none",
    name = ccb.content.text("generic_golf_course"),
    travel_cost = "field",
    land_use_code = "golf_course",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_marina",
    see_cost = "high",
    name = ccb.content.text("generic_marina"),
    travel_cost = "structure",
    land_use_code = "marina",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_urban_public_institutional",
    see_cost = "high",
    name = ccb.content.text("generic_urban_public_institutional"),
    travel_cost = "structure",
    land_use_code = "urban_public_institutional",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_cemetery",
    see_cost = "medium",
    copy_from = "generic_city_building",
    name = ccb.content.text("cemetery"),
    land_use_code = "cemetery",
    symbol = "n",
    color = "white",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_orchard",
    see_cost = "spaced_high",
    name = ccb.content.text("generic_orchard"),
    travel_cost = "forest",
    land_use_code = "orchard",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_nursery",
    see_cost = "spaced_high",
    name = ccb.content.text("generic_nursery"),
    travel_cost = "forest",
    land_use_code = "nursery",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_wetland_forest",
    see_cost = "spaced_high",
    name = ccb.content.text("generic_wetland_forest"),
    travel_cost = "swamp",
    land_use_code = "wetland_forest",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_residential_very_low",
    see_cost = "high",
    name = ccb.content.text("generic_residential_very_low"),
    travel_cost = "structure",
    land_use_code = "residential_very_low",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_junkyard",
    see_cost = "high",
    name = ccb.content.text("generic_junkyard"),
    travel_cost = "structure",
    land_use_code = "junkyard",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_brushland",
    see_cost = "low",
    name = ccb.content.text("generic_brushland"),
    travel_cost = "field",
    land_use_code = "brushland",
}
