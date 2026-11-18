local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "default",
    extends = "default",
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
        },
        whitelist = {},
    },
})
