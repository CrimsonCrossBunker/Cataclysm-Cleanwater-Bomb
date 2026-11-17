local ccb = require("ccb")
local content = ccb.content

-- data/mods/rural_biome/region_settings/region_settings/rural_regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default_ruralbiome",
        inherits = "default",
        base_temperature = 6.5,
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 3.4,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    content.upsert(generator)
end
