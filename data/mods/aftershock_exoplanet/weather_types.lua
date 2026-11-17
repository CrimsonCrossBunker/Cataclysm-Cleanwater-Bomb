local ccb = require("ccb")
local content = ccb.content

-- data/mods/aftershock_exoplanet/weather_type.json
do
    local weather = content.WeatherType {
        id = "afs_flurries",
        name = content.text("Flurries"),
        color = "white",
        map_color = "h_white",
        symbol = ".",
        sun_symbol = "⛄",
        ranged_penalty = 1,
        sight_penalty = 1.03,
        light_modifier = -20,
        sound_attenuation = 1,
        dangerous = false,
        precipitation = "light",
        rains = true,
        tiles_animation = "weather_snowflake",
        sound_category = "flurries",
        sun_multiplier = 0.3,
        priority = 30,
    }
    ccb.runtime.handler("weather_afs_flurries_selected", function(sample)
        return (sample.humidity >= 97 or sample.pressure < 1000)
    end)
    weather:condition("weather_afs_flurries_selected")
    weather:animation {
        factor = 0.01,
        color = "white",
        symbol = ".",
    }
    weather:requires("cloudy")
    content.upsert(weather)
end

-- data/mods/aftershock_exoplanet/weather_type.json
do
    local weather = content.WeatherType {
        id = "afs_whiteout",
        name = content.text("Whiteout"),
        color = "i_black",
        map_color = "i_black",
        symbol = "o",
        sun_symbol = "⛆",
        ranged_penalty = 1,
        sight_penalty = 1.03,
        light_modifier = -40,
        sound_attenuation = 1,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_snowflake",
        sound_category = "snowstorm",
        sun_multiplier = 0.15,
        priority = 40,
    }
    ccb.runtime.handler("weather_afs_whiteout_selected", function(sample)
        return (sample.daylight and sample.windpower >= 20)
    end)
    weather:condition("weather_afs_whiteout_selected")
    weather:animation {
        factor = 0.01,
        color = "white",
        symbol = "*",
    }
    weather:requires("cloudy")
    weather:requires("afs_flurries")
    content.upsert(weather)
end

-- data/mods/aftershock_exoplanet/weather_type.json
do
    local weather = content.WeatherType {
        id = "afs_snowing",
        name = content.text("Snowing"),
        color = "blue",
        map_color = "h_blue",
        symbol = "o",
        sun_symbol = "☃",
        ranged_penalty = 3,
        sight_penalty = 1.1,
        light_modifier = -30,
        sound_attenuation = 4,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_snowflake",
        sound_category = "snow",
        sun_multiplier = 0.2,
        priority = 50,
    }
    ccb.runtime.handler("weather_afs_snowing_selected", function(sample)
        return (sample.humidity >= 98 or sample.pressure < 993)
    end)
    weather:condition("weather_afs_snowing_selected")
    weather:animation {
        factor = 0.02,
        color = "white",
        symbol = "*",
    }
    weather:requires("afs_flurries")
    weather:requires("afs_whiteout")
    content.upsert(weather)
end

-- data/mods/aftershock_exoplanet/weather_type.json
do
    local weather = content.WeatherType {
        id = "afs_thunder",
        name = content.text("Thunder Storm"),
        color = "dark_gray",
        map_color = "i_blue",
        symbol = "%",
        sun_symbol = "⛈",
        ranged_penalty = 4,
        sight_penalty = 1.2,
        light_modifier = -40,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_snowflake",
        sound_category = "snowstorm",
        sun_multiplier = 0.01,
        priority = 60,
    }
    ccb.runtime.handler("weather_afs_thunder_selected", function(sample)
        return sample.pressure < 990
    end)
    weather:condition("weather_afs_thunder_selected")
    weather:animation {
        factor = 0.02,
        color = "white",
        symbol = "*",
    }
    weather:requires("afs_snowing")
    content.upsert(weather)
end

-- data/mods/aftershock_exoplanet/weather_type.json
do
    local weather = content.WeatherType {
        id = "afs_lightning",
        name = content.text("Lightning Storm"),
        color = "yellow",
        map_color = "h_yellow",
        symbol = "%",
        sun_symbol = "⛈",
        ranged_penalty = 4,
        sight_penalty = 1.25,
        light_modifier = -45,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_snowflake",
        sound_category = "snowstorm",
        sun_multiplier = 0.01,
        priority = 70,
    }
    ccb.runtime.handler("weather_afs_lightning_selected", function(sample)
        return sample.pressure < 980
    end)
    weather:condition("weather_afs_lightning_selected")
    weather:animation {
        factor = 0.04,
        color = "white",
        symbol = "*",
    }
    weather:requires("afs_thunder")
    content.upsert(weather)
end
