local ccb = require("ccb")
local content = ccb.content

-- data/json/region_settings/region_settings/regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default",
        base_temperature = 11.1,
        climate_station = "bedford_hanscom",
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 3.4,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/dimensions/highland_dimension.json
do
    local generator = content.WeatherGenerator {
        id = "highland_weather",
        base_temperature = 18.5,
        base_humidity = 70.0,
        base_pressure = 995.0,
        base_wind = 2.0,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    generator:whitelisted_weather("clear")
    generator:whitelisted_weather("cloudy")
    generator:whitelisted_weather("light_drizzle")
    generator:whitelisted_weather("rain")
    generator:whitelisted_weather("mist")
    generator:whitelisted_weather("fog")
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/dimensions/highland_imperial_road.json
do
    local generator = content.WeatherGenerator {
        id = "imperial_road",
        base_temperature = 18,
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
    generator:whitelisted_weather("clear")
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/dimensions/portal_storm_dungeon.json
do
    local generator = content.WeatherGenerator {
        id = "default_portal_storm_dungeon",
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

-- data/json/region_settings/region_settings/dimensions/reverberations.json
do
    local generator = content.WeatherGenerator {
        id = "reverberation_rainy_weather",
        base_temperature = 4.5,
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 10.0,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    generator:whitelisted_weather("rainstorm_reverberation")
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/dimensions/reverberations.json
do
    local generator = content.WeatherGenerator {
        id = "inner_cabins_weather",
        base_temperature = 4.5,
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 2.0,
        base_wind_distrib_peaks = 80,
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
    generator:blacklisted_weather("flurries")
    generator:blacklisted_weather("snowing")
    generator:blacklisted_weather("snowstorm")
    generator:blacklisted_weather("light_drizzle")
    generator:blacklisted_weather("sunny")
    generator:blacklisted_weather("drizzle")
    generator:blacklisted_weather("rain")
    generator:blacklisted_weather("rainstorm")
    generator:blacklisted_weather("thunder")
    generator:blacklisted_weather("lightning")
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/dimensions/scarlet_sea_dimension.json
do
    local generator = content.WeatherGenerator {
        id = "scarlet_weather",
        base_temperature = 8.5,
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 0.0,
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
    generator:whitelisted_weather("scarlet_day")
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/dimensions/string_dimension.json
do
    local generator = content.WeatherGenerator {
        id = "string_dimension_weather",
        base_temperature = -20,
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
    generator:whitelisted_weather("clear")
    content.upsert(generator)
end

-- data/json/region_settings/region_settings/test_regional_map_settings.json
do
    local generator = content.WeatherGenerator {
        id = "extreme_weather",
        base_temperature = 60.5,
        base_humidity = 70.0,
        base_pressure = 1015.0,
        base_wind = 90.0,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    content.upsert(generator)
end
