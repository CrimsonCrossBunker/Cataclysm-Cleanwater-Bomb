local ccb = require("ccb")
local content = ccb.content

-- data/mods/hunvre/json/mod_settings/region_settings/regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default_hunvre",
        base_temperature = 0,
        base_humidity = 0,
        base_pressure = 1015.0,
        base_wind = 0,
        base_wind_distrib_peaks = 0,
        base_wind_season_variation = 0,
        spring_temp_manual_mod = 0,
        summer_temp_manual_mod = 0,
        autumn_temp_manual_mod = 0,
        winter_temp_manual_mod = 0,
        spring_humidity_manual_mod = 0,
        summer_humidity_manual_mod = 0,
        autumn_humidity_manual_mod = 0,
        winter_humidity_manual_mod = 0,
    }
    generator:whitelisted_weather("weather_negative_20_light_on")
    generator:whitelisted_weather("weather_negative_20_light_off")
    generator:whitelisted_weather("weather_negative_10_light_on")
    generator:whitelisted_weather("weather_negative_10_light_off")
    generator:whitelisted_weather("weather_0_light_on")
    generator:whitelisted_weather("weather_0_light_off")
    generator:whitelisted_weather("weather_positive_10_light_on")
    generator:whitelisted_weather("weather_positive_10_light_off")
    generator:whitelisted_weather("weather_positive_20_light_on")
    generator:whitelisted_weather("weather_positive_20_light_off")
    generator:whitelisted_weather("weather_positive_30_light_on")
    generator:whitelisted_weather("weather_positive_30_light_off")
    content.upsert(generator)
end
