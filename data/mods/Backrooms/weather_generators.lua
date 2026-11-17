local ccb = require("ccb")
local content = ccb.content

-- data/mods/Backrooms/region_settings/region_settings/regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default_backrooms",
        inherits = "default",
        base_temperature = 6.5,
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 3.4,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    generator:blacklisted_weather("early_portal_storm")
    generator:blacklisted_weather("portal_storm")
    content.upsert(generator)
end
