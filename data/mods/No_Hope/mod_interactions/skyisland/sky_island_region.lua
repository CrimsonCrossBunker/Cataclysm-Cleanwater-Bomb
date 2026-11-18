local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "dimension_sky_island_region",
    extends = "default_nohope",
    feature_flag_settings = {
        add_blacklist = { "SKY_ISLAND" },
    },
})
