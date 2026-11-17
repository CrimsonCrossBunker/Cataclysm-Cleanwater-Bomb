local ccb = require("ccb")
local content = ccb.content

-- data/mods/classic_zombies/region_settings/region_settings/region_overlay.json
do
    local generator = content.WeatherGenerator {
        id = "default",
        inherits = "default",
        base_temperature = 5.5,
        base_humidity = 50.0,
        base_pressure = 1015,
        base_wind = 4.4,
    }
    generator:blacklisted_weather("early_portal_storm")
    generator:blacklisted_weather("portal_storm")
    content.upsert(generator)
end
