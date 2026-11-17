local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function blot(value)
    checked(services.variables.set_global("blotted_sun", value, { include_before = false }))
    checked(services.weather.refresh())
end

ccb.runtime.handler("blotted_sun_selected", function()
    return (checked(services.variables.get_global_number("blotted_sun")).value or 0) == 1
end)
ccb.runtime.handler("blotted_sun_debug_enter", function()
    blot(1)
end)
ccb.runtime.handler("blotted_sun_debug_leave", function()
    blot(0)
    services.messages.add(services.translate("The darkness you summoned fades away, clearing the sky."), "bad")
end)

local weather = content.WeatherType {
    id = "blotted_sun",
    name = content.text("Blotted Sun"),
    color = "dark_gray",
    map_color = "i_blue",
    symbol = "%",
    sun_symbol = "☉",
    ranged_penalty = 0,
    sight_penalty = 1.0,
    light_modifier = -145,
    sun_multiplier = 0.01,
    sound_attenuation = 0,
    dangerous = false,
    precipitation = "none",
    rains = false,
    priority = 119,
}
weather:condition("blotted_sun_selected")
weather:debug_actions {
    enter_handler = "blotted_sun_debug_enter",
    leave_handler = "blotted_sun_debug_leave",
}
content.upsert(weather)
