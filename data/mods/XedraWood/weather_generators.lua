local ccb = require("ccb")
local content = ccb.content

-- data/mods/XedraWood/regional_overlay.json
do
    local generator = content.WeatherGenerator {
        id = "default",
        inherits = "default",
        base_temperature = 13,
        base_humidity = 75.0,
        base_pressure = 1012.0,
    }
    content.upsert(generator)
end
