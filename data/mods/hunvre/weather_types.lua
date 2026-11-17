local ccb = require("ccb")
local content = ccb.content

local function world_number(key)
    local result = ccb.services.variables.get_global_number(key)
    if not result.ok then error(result.error.message) end
    return result.value.value or 0
end

local temperatures = {
    { id = "negative_20", degrees = -20, name = content.text("Freezing") },
    { id = "negative_10", degrees = -10, name = content.text("Cold") },
    { id = "0", degrees = 0, name = content.text("Chilly") },
    { id = "positive_10", degrees = 10, name = content.text("Mild") },
    { id = "positive_20", degrees = 20, name = content.text("Warm") },
    { id = "positive_30", degrees = 30, name = content.text("Hot") },
}

for _, temperature in ipairs(temperatures) do
    for _, blackout in ipairs({ 0, 1 }) do
        local id = "weather_" .. temperature.id .. "_light_" .. (blackout == 0 and "on" or "off")
        local handler = id .. "_selected"
        ccb.runtime.handler(handler, function()
            return world_number("blackout") == blackout
                and world_number("current_temperature") == temperature.degrees
        end)
        local weather = content.WeatherType {
            id = id,
            name = temperature.name,
            temperature_delta_kelvin = temperature.degrees,
            light_multiplier = 1 - blackout,
            color = "light_cyan",
            map_color = "yellow_white",
            symbol = "*",
            sun_symbol = "☼",
            ranged_penalty = 0,
            sight_penalty = 1.0,
            light_modifier = 0,
            sound_attenuation = 0,
            dangerous = false,
            precipitation = "none",
            rains = false,
            sound_category = "silent",
            priority = 1,
        }
        weather:condition(handler)
        content.upsert(weather)
    end
end
