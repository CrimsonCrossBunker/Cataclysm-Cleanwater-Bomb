local ccb = require("ccb")
local content = ccb.content

-- data/mods/desert_region/region_settings/region_settings/desert_regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default",
        inherits = "default",
        base_temperature = 11.0,
        base_humidity = 20.0,
        base_pressure = 1025.0,
        base_wind = 5.7,
        base_wind_distrib_peaks = 20,
        base_wind_season_variation = 0,
        summer_temp_manual_mod = 25,
        spring_temp_manual_mod = 15,
        autumn_temp_manual_mod = 15,
        winter_temp_manual_mod = 7,
        spring_humidity_manual_mod = 10,
        summer_humidity_manual_mod = 0,
        autumn_humidity_manual_mod = 10,
        winter_humidity_manual_mod = 15,
    }
    generator:blacklisted_weather("flurries")
    generator:blacklisted_weather("snowing")
    generator:blacklisted_weather("snowstorm")
    content.upsert(generator)
end
