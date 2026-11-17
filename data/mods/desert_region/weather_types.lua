local ccb = require("ccb")
local content = ccb.content

local function world_number(key)
    local result = ccb.services.variables.get_global_number(key)
    if not result.ok then error(result.error.message) end
    return result.value.value or 0
end

-- data/mods/desert_region/weather/desert_weather_type.json
do
    local weather = content.WeatherType {
        id = "early_dust_storm",
        name = content.text("Early Dust Storm"),
        color = "yellow",
        map_color = "yellow",
        symbol = "*",
        sun_symbol = "⛆",
        ranged_penalty = 0,
        sight_penalty = 1,
        light_modifier = -33,
        sound_attenuation = 3,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "flurries",
        sun_multiplier = 0.2,
        priority = 115,
    }
    ccb.runtime.handler("weather_early_dust_storm_selected", function(sample)
        return world_number("cause_early_dust_storm") == 1
    end)
    weather:condition("weather_early_dust_storm_selected")
    content.upsert(weather)
end

-- data/mods/desert_region/weather/desert_weather_type.json
do
    local weather = content.WeatherType {
        id = "dust_storm",
        name = content.text("Dust Storm"),
        color = "yellow",
        map_color = "yellow",
        symbol = "%",
        sun_symbol = "⛆",
        ranged_penalty = 6,
        sight_penalty = 1.5,
        light_modifier = -110,
        sound_attenuation = 10,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "snow",
        sun_multiplier = 0.01,
        priority = 116,
    }
    ccb.runtime.handler("weather_dust_storm_selected", function(sample)
        return world_number("cause_dust_storm") == 1
    end)
    weather:condition("weather_dust_storm_selected")
    weather:animation {
        factor = 0.04,
        color = "yellow",
        symbol = "-",
    }
    content.upsert(weather)
end
