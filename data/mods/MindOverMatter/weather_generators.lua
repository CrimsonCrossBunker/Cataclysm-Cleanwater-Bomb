local ccb = require("ccb")
local content = ccb.content

-- data/mods/MindOverMatter/dimensions/innawood_rainy_mom.json
do
    local generator = content.WeatherGenerator {
        id = "mom_innawood_rainy",
        inherits = "default",
        base_temperature = 8.5,
        base_humidity = 80.0,
        base_pressure = 999,
        base_wind = 4.4,
    }
    content.upsert(generator)
end
