local ccb = require("ccb")
local content = ccb.content

-- data/core/weather.json
do
    local weather = content.WeatherType {
        id = "clear",
        name = content.text("Clear"),
        color = "cyan",
        map_color = "yellow_white",
        symbol = " ",
        sun_symbol = "☼",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = 0,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "clear",
        priority = 0,
    }
    content.upsert(weather)
end

-- data/core/weather.json
do
    local weather = content.WeatherType {
        id = "null",
        name = "NULL Weather - BUG",
        color = "magenta",
        map_color = "magenta_red",
        symbol = "0",
        sun_symbol = "❌",
        ranged_penalty = 0,
        sight_penalty = 0.0,
        light_modifier = 0,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        priority = -1,
    }
    content.upsert(weather)
end
