local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "dimension_sky_island_region",
    extends = "dimension_sky_island_region",
    urbanity_increase = { -1, 0, 0, -1 },
    feature_flag_settings = {
        whitelist = { "CLASSIC" },
        add_blacklist = { "SKY_ISLAND" },
    },
})
