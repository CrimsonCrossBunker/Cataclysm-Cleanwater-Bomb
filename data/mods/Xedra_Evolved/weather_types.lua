local ccb = require("ccb")
local content = ccb.content

local function world_number(key)
    local result = ccb.services.variables.get_global_number(key)
    if not result.ok then error(result.error.message) end
    return result.value.value or 0
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_thick_fog",
        name = content.text("Dense Fog"),
        color = "light_gray",
        map_color = "dark_gray_white",
        symbol = "~",
        sun_symbol = "⛆",
        ranged_penalty = 9,
        sight_penalty = 2.6,
        light_modifier = -60,
        sun_multiplier = 0.2,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 119,
    }
    ccb.runtime.handler("weather_magic_weather_thick_fog_selected", function(sample)
        return world_number("magic_weather_dense_fog") == 1
    end)
    weather:condition("weather_magic_weather_thick_fog_selected")
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_light_drizzle",
        name = content.text("Light Drizzle"),
        color = "light_blue",
        map_color = "h_light_blue",
        symbol = ".",
        sun_symbol = "☂",
        ranged_penalty = 0,
        sight_penalty = 1.01,
        light_modifier = -10,
        sun_multiplier = 0.2,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "very_light",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "drizzle",
        priority = 114,
    }
    ccb.runtime.handler("weather_magic_weather_light_drizzle_selected", function(sample)
        return world_number("magic_weather_light_drizzle") == 1
    end)
    weather:condition("weather_magic_weather_light_drizzle_selected")
    weather:animation {
        factor = 0.01,
        color = "light_blue",
        symbol = ",",
    }
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_drizzle",
        name = content.text("Drizzle"),
        color = "light_blue",
        map_color = "h_light_blue",
        symbol = ".",
        sun_symbol = "☂",
        ranged_penalty = 1,
        sight_penalty = 1.03,
        light_modifier = -20,
        sun_multiplier = 0.1,
        sound_attenuation = 1,
        dangerous = false,
        precipitation = "light",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "drizzle",
        priority = 115,
    }
    ccb.runtime.handler("weather_magic_weather_drizzle_selected", function(sample)
        return world_number("magic_weather_drizzle") == 1
    end)
    weather:condition("weather_magic_weather_drizzle_selected")
    weather:animation {
        factor = 0.01,
        color = "light_blue",
        symbol = ".",
    }
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_rain",
        name = content.text("Rain"),
        color = "blue",
        map_color = "h_blue",
        symbol = "o",
        sun_symbol = "☔",
        ranged_penalty = 3,
        sight_penalty = 1.1,
        light_modifier = -30,
        sun_multiplier = 0.03,
        sound_attenuation = 4,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "rainy",
        priority = 117,
    }
    ccb.runtime.handler("weather_magic_weather_rain_selected", function(sample)
        return world_number("magic_weather_rain") == 1
    end)
    weather:condition("weather_magic_weather_rain_selected")
    weather:animation {
        factor = 0.02,
        color = "light_blue",
        symbol = ",",
    }
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_rainstorm",
        name = content.text("Rain Storm"),
        color = "blue",
        map_color = "i_blue",
        symbol = "%",
        sun_symbol = "☔",
        ranged_penalty = 6,
        sight_penalty = 1.2,
        light_modifier = -35,
        sun_multiplier = 0.01,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "rainstorm",
        priority = 118,
    }
    ccb.runtime.handler("weather_magic_weather_rainstorm_selected", function(sample)
        return world_number("magic_weather_rainstorm") == 1
    end)
    weather:condition("weather_magic_weather_rainstorm_selected")
    weather:animation {
        factor = 0.04,
        color = "blue",
        symbol = ";",
    }
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_thunder",
        name = content.text("Thunder Storm"),
        color = "dark_gray",
        map_color = "i_blue",
        symbol = "%",
        sun_symbol = "⛈",
        ranged_penalty = 4,
        sight_penalty = 1.2,
        light_modifier = -40,
        sun_multiplier = 0.01,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "thunder",
        priority = 70,
    }
    ccb.runtime.handler("weather_magic_weather_thunder_selected", function(sample)
        return world_number("magic_weather_thunder") == 1
    end)
    weather:condition("weather_magic_weather_thunder_selected")
    weather:animation {
        factor = 0.02,
        color = "light_blue",
        symbol = ".",
    }
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "magic_weather_lightning",
        name = content.text("Lightning Storm"),
        color = "yellow",
        map_color = "h_yellow",
        symbol = "%",
        sun_symbol = "⛈",
        ranged_penalty = 4,
        sight_penalty = 1.25,
        light_modifier = -45,
        sun_multiplier = 0.01,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "thunder",
        priority = 119,
    }
    ccb.runtime.handler("weather_magic_weather_lightning_selected", function(sample)
        return world_number("magic_weather_lightning") == 1
    end)
    weather:condition("weather_magic_weather_lightning_selected")
    weather:animation {
        factor = 0.04,
        color = "light_blue",
        symbol = ",",
    }
    content.upsert(weather)
end

-- data/mods/Xedra_Evolved/weather_type.json
do
    local weather = content.WeatherType {
        id = "xe_weather_ominous_fog",
        name = content.text("Ominous Fog"),
        color = "light_gray",
        map_color = "dark_gray_white",
        symbol = "~",
        sun_symbol = "⛆",
        ranged_penalty = 9,
        sight_penalty = 2.6,
        light_modifier = -40,
        sun_multiplier = 0.02,
        light_multiplier = 0.5,
        sound_attenuation = 6,
        dangerous = true,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 121,
    }
    ccb.runtime.handler("weather_xe_weather_ominous_fog_selected", function(sample)
        return (world_number("xe_weather_ominous_fog_scenario") == 1 or world_number("xe_weather_ominous_fog_active") == 1)
    end)
    weather:condition("weather_xe_weather_ominous_fog_selected")
    weather:tint { red = 20, green = 0, blue = 200, strength = 0.4 }
    weather:passive_effect {
        effect = "effect_xe_weather_ominous_fog_monster_buff",
        intensity = 1,
        minimum_duration_turns = 2,
        maximum_duration_turns = 2,
    }
    content.upsert(weather)
end
