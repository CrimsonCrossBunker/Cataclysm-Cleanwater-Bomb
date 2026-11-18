local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "default",
    extends = "default",
    rivers = false,
    lakes = false,
    ravines = false,
    forests = false,
    forest_trails = false,
    cities = "no_cities",
    neighbor_connections = false,
    place_roads = false,
    feature_flag_settings = {
        blacklist = {},
        whitelist = { "TUTORIAL" },
    },
})
