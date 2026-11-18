local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "dimension_sky_island_region",
    extends = "dimension_sky_island_region",
    cities = "no_cities",
    highways = false,
    place_roads = false,
    feature_flag_settings = {
        blacklist = {
            "LAB",
            "MAN_MADE",
            "MILITARY",
            "URBAN",
            "FARM",
            "EXODII",
            "EXTRADIMENSIONAL",
            "SKY_ISLAND",
        },
        whitelist = {},
    },
})
