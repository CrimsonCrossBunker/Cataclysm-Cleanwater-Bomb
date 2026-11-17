local ccb = require("ccb")
local content = ccb.content

-- data/mods/TropiCataclysm/region_settings/tropical_regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default",
        inherits = "default",
        base_temperature = 16.0,
        base_humidity = 83.5,
        base_pressure = 1010.0,
        base_wind = 6.0,
        base_wind_distrib_peaks = 30,
        base_wind_season_variation = 0,
        spring_temp_manual_mod = 5,
        summer_temp_manual_mod = 0,
        autumn_temp_manual_mod = 3,
        winter_temp_manual_mod = 5,
        spring_humidity_manual_mod = 5,
        summer_humidity_manual_mod = 20,
        autumn_humidity_manual_mod = 20,
        winter_humidity_manual_mod = 0,
    }
    generator:blacklisted_weather("flurries")
    generator:blacklisted_weather("snowing")
    generator:blacklisted_weather("snowstorm")
    content.upsert(generator)
end
