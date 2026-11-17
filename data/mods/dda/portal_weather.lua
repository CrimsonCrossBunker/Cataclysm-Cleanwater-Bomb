local ccb = require("ccb")
local content = ccb.content
local state = require("portal_storm_state")
require("portal_storm")

local function within_storm(sample, active, radius_key, default_radius)
    local location = sample.location
    local position = ccb.services.coords.tripoint_abs_ms(location.x, location.y, location.z)
    return state.number(active) == 1
        and position:game_distance(state.point("portal_storm_center"))
            <= state.number(radius_key, default_radius)
end

ccb.runtime.handler("weather_early_portal_storm_selected", function(sample)
    return within_storm(sample, "cause_early_portal_storm",
        "portal_storm_distant_distance", 200)
end)

do
    local weather = content.WeatherType {
        id = "early_portal_storm",
        name = content.text("Early Portal Storm"),
        color = "light_red",
        map_color = "light_red",
        symbol = "o",
        sun_symbol = "✹",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = -5,
        sun_multiplier = 0.8,
        sound_attenuation = 0,
        dangerous = true,
        precipitation = "none",
        rains = false,
        tiles_animation = "weather_portal_storm",
        sound_category = "portal_storm",
        priority = 120,
    }
    weather:condition("weather_early_portal_storm_selected")
    weather:debug_actions {
        enter_handler = "portal_storm_debug_early",
        leave_handler = "portal_storm_debug_stop",
    }
    weather:animation {
        factor = 0.01,
        color = "red",
        symbol = "*",
    }
    content.upsert(weather)
end

ccb.runtime.handler("weather_distant_portal_storm_selected", function(sample)
    return within_storm(sample, "cause_portal_storm",
        "portal_storm_distant_distance", 200)
end)

do
    local weather = content.WeatherType {
        id = "distant_portal_storm",
        name = content.text("Distant Portal Storm"),
        color = "red",
        map_color = "red",
        symbol = "O",
        sun_symbol = "✶",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = -8,
        sun_multiplier = 0.7,
        sound_attenuation = 0,
        dangerous = true,
        precipitation = "none",
        rains = false,
        tiles_animation = "weather_portal_storm",
        sound_category = "portal_storm",
        priority = 130,
    }
    weather:condition("weather_distant_portal_storm_selected")
    weather:debug_actions {
        enter_handler = "portal_storm_debug_start",
        leave_handler = "portal_storm_debug_stop",
    }
    weather:animation {
        factor = 0.01,
        color = "red",
        symbol = "*",
    }
    content.upsert(weather)
end

ccb.runtime.handler("weather_close_portal_storm_selected", function(sample)
    return within_storm(sample, "cause_portal_storm",
        "portal_storm_close_distance", 100)
end)

do
    local weather = content.WeatherType {
        id = "close_portal_storm",
        name = content.text("Close Portal Storm"),
        color = "red",
        map_color = "red",
        symbol = "O",
        sun_symbol = "✷",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = -10,
        sun_multiplier = 0.6,
        sound_attenuation = 0,
        dangerous = true,
        precipitation = "none",
        rains = false,
        tiles_animation = "weather_portal_storm",
        sound_category = "portal_storm",
        priority = 131,
    }
    weather:condition("weather_close_portal_storm_selected")
    weather:debug_actions {
        enter_handler = "portal_storm_debug_start",
        leave_handler = "portal_storm_debug_stop",
    }
    weather:animation {
        factor = 0.02,
        color = "red",
        symbol = "*",
    }
    content.upsert(weather)
end

ccb.runtime.handler("weather_portal_storm_selected", function(sample)
    return within_storm(sample, "cause_portal_storm",
        "portal_storm_distance", 50)
end)

do
    local weather = content.WeatherType {
        id = "portal_storm",
        name = content.text("Portal Storm"),
        color = "red",
        map_color = "red",
        symbol = "O",
        sun_symbol = "✺",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = -14,
        sun_multiplier = 0.5,
        sound_attenuation = 0,
        dangerous = true,
        precipitation = "none",
        rains = false,
        tiles_animation = "weather_portal_storm",
        sound_category = "portal_storm",
        priority = 132,
    }
    weather:condition("weather_portal_storm_selected")
    weather:debug_actions {
        enter_handler = "portal_storm_debug_start",
        leave_handler = "portal_storm_debug_stop",
    }
    weather:animation {
        factor = 0.03,
        color = "red",
        symbol = "*",
    }
    content.upsert(weather)
end
