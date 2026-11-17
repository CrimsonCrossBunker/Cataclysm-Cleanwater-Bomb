local ccb = require("ccb")
local content = ccb.content

-- data/mods/Sky_Island/region_settings/region_settings/region_settings.json
do
    local generator = content.WeatherGenerator {
        id = "sky_island_weather",
        inherits = "default",
    }
    generator:blacklisted_weather("early_portal_storm")
    generator:blacklisted_weather("portal_storm")
    generator:blacklisted_weather("distant_portal_storm")
    generator:blacklisted_weather("close_portal_storm")
    content.upsert(generator)
end

-- data/mods/Sky_Island/region_settings/region_settings/region_settings.json
do
    local generator = content.WeatherGenerator {
        id = "sky_island_raid_weather_hot",
        inherits = "default",
        base_temperature = 26,
        spring_temp_manual_mod = 15,
        summer_temp_manual_mod = 0,
        autumn_temp_manual_mod = 15,
        winter_temp_manual_mod = 30,
    }
    content.upsert(generator)
end

-- data/mods/Sky_Island/region_settings/region_settings/region_settings.json
do
    local generator = content.WeatherGenerator {
        id = "sky_island_raid_weather_cold",
        inherits = "default",
        base_temperature = -4,
        spring_temp_manual_mod = -15,
        summer_temp_manual_mod = -30,
        autumn_temp_manual_mod = -15,
        winter_temp_manual_mod = 0,
    }
    content.upsert(generator)
end
