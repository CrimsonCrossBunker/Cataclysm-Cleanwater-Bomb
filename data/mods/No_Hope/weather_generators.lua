local ccb = require("ccb")
local content = ccb.content

-- data/mods/No_Hope/region_settings/region_settings/region_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default_nohope",
        inherits = "default",
        base_humidity = 90.0,
    }
    content.upsert(generator)
end
