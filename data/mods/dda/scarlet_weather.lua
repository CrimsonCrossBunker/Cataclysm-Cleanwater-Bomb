local ccb = require("ccb")
local content = ccb.content
local variables = ccb.services.variables
local coords = ccb.services.coords

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function active_here(sample)
    return sample.dimension == "default"
        and (checked(variables.get_global_number("scarlet_storm_active")).value or 0) == 1
end

local function focus_distance(sample, focus)
    local location = sample.location
    local origin = coords.tripoint_abs_ms(location.x, location.y, location.z)
    local center = checked(variables.get_global_tripoint(focus)).value
        or coords.tripoint_abs_ms(0, 0, 0)
    return origin:game_distance(center)
end

local function within_fog(sample, limit)
    return active_here(sample)
        and (focus_distance(sample, "scarlet_storm_focus_a1")
                + focus_distance(sample, "scarlet_storm_focus_a2") < limit
            or focus_distance(sample, "scarlet_storm_focus_b1")
                + focus_distance(sample, "scarlet_storm_focus_b2") < limit)
        and focus_distance(sample, "scarlet_storm_focus_a1") > 0
        and focus_distance(sample, "scarlet_storm_focus_a2") > 0
        and focus_distance(sample, "scarlet_storm_focus_b1") > 0
        and focus_distance(sample, "scarlet_storm_focus_b2") > 0
end

-- Yellowish Haze
ccb.runtime.handler("scarlet_storm_1_selected", function(sample)
    return within_fog(sample, 7680)
end)

do
    local weather = content.WeatherType {
        id = "scarlet_storm_1",
        name = content.text("Yellowish Haze"),
        color = "yellow",
        map_color = "yellow",
        symbol = "~",
        sun_symbol = "🌫",
        ranged_penalty = 7,
        sight_penalty = 1.7,
        light_modifier = -40,
        sun_multiplier = 0.3,
        temperature_delta_kelvin = -2,
        sound_attenuation = 8,
        dangerous = true,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 13,
    }
    weather:condition("scarlet_storm_1_selected")
    weather:tint { red = 125, green = 100, blue = 30, strength = 0.7 }
    content.upsert(weather)
end

-- Amber Mist
ccb.runtime.handler("scarlet_storm_2_selected", function(sample)
    return within_fog(sample, 6912)
end)

do
    local weather = content.WeatherType {
        id = "scarlet_storm_2",
        name = content.text("Amber Mist"),
        color = "light_red",
        map_color = "light_red",
        symbol = "~",
        sun_symbol = "🌫",
        ranged_penalty = 7,
        sight_penalty = 2.0,
        light_modifier = -60,
        sun_multiplier = 0.01,
        temperature_delta_kelvin = -5,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 14,
    }
    weather:condition("scarlet_storm_2_selected")
    weather:tint { red = 125, green = 100, blue = 30, strength = 0.8 }
    weather:passive_effect {
        effect = "scarlet_storm_lungs",
        intensity = 1,
        minimum_duration_turns = 1,
        maximum_duration_turns = 1,
        environmental = false,
        environmental_resistance = { ["mouth"] = 1 },
    }
    content.upsert(weather)
end

-- Crimson Fog
ccb.runtime.handler("scarlet_storm_3_selected", function(sample)
    return within_fog(sample, 6144)
end)

do
    local weather = content.WeatherType {
        id = "scarlet_storm_3",
        name = content.text("Crimson Fog"),
        color = "red",
        map_color = "red",
        symbol = "~",
        sun_symbol = "🌫",
        ranged_penalty = 7,
        sight_penalty = 2.0,
        light_modifier = -65,
        sun_multiplier = 0.01,
        temperature_delta_kelvin = -10,
        sound_attenuation = 8,
        dangerous = true,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 45,
    }
    weather:condition("scarlet_storm_3_selected")
    weather:tint { red = 100, green = 15, blue = 30, strength = 1.0 }
    weather:passive_effect {
        effect = "scarlet_storm_lungs",
        intensity = 1,
        minimum_duration_turns = 1,
        maximum_duration_turns = 1,
        environmental = false,
        environmental_resistance = { ["mouth"] = 3 },
    }
    content.upsert(weather)
end

-- Scarlet Storm
ccb.runtime.handler("scarlet_storm_4_selected", function(sample)
    return within_fog(sample, 3840)
end)

do
    local weather = content.WeatherType {
        id = "scarlet_storm_4",
        name = content.text("Scarlet Storm"),
        color = "red",
        map_color = "red",
        symbol = "%",
        sun_symbol = "🌫",
        ranged_penalty = 7,
        sight_penalty = 2.0,
        light_modifier = -75,
        sun_multiplier = 0.01,
        temperature_delta_kelvin = -20,
        sound_attenuation = 8,
        dangerous = true,
        precipitation = "none",
        rains = false,
        sound_category = "thunder",
        priority = 120,
    }
    weather:condition("scarlet_storm_4_selected")
    weather:tint { red = 140, green = 15, blue = 25, strength = 1.0 }
    weather:passive_effect {
        effect = "scarlet_storm_lungs",
        intensity = 1,
        minimum_duration_turns = 1,
        maximum_duration_turns = 1,
        environmental = false,
        environmental_resistance = { ["mouth"] = 7 },
    }
    content.upsert(weather)
end

-- rainstorm that supresses the effects of the fog
ccb.runtime.handler("scarlet_storm_5_selected", function(sample)
    return active_here(sample)
        and focus_distance(sample, "scarlet_storm_focus_a1") < 1920
        and focus_distance(sample, "scarlet_storm_focus_a1") > 0
        and (sample.humidity >= 97 or sample.pressure < 1000)
end)

do
    local weather = content.WeatherType {
        id = "scarlet_storm_5",
        name = content.text("Scarlet Cloudburst"),
        color = "magenta",
        map_color = "magenta",
        symbol = "%",
        sun_symbol = "⛈",
        ranged_penalty = 7,
        sight_penalty = 2.0,
        light_modifier = -85,
        sun_multiplier = 0.01,
        temperature_delta_kelvin = -20,
        sound_attenuation = 8,
        dangerous = true,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "thunder",
        priority = 125,
    }
    weather:condition("scarlet_storm_5_selected")
    weather:tint { red = 175, green = 25, blue = 0, strength = 1.0 }
    weather:animation {
        factor = 0.04,
        color = "blue",
        symbol = ";",
    }
    content.upsert(weather)
end
