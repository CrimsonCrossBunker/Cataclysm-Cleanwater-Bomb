local content = require("ccb").content

content.replace(content.RegionSettings {
    id = "default",
    extends = "default",
    highways = false,
    cities = "no_cities",
    feature_flag_settings = {
        blacklist = {},
        whitelist = { "DEFENSE_MODE" },
    },
})
