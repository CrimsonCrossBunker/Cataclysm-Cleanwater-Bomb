local ccb = require("ccb")
local content = ccb.content

local function world_number(key)
    local result = ccb.services.variables.get_global_number(key)
    if not result.ok then error(result.error.message) end
    return result.value.value or 0
end

-- Native 33 F threshold; units::temperature stores a float.
local rain_snow_threshold_kelvin = 273.70556640625

-- Temperature minus dew point, using the sampled native Celsius conversion.
local function dew_point_factor(sample)
    local celsius = sample.temperature_celsius
    local humidity_factor = math.log(sample.humidity / 100)
        + 17.625 * celsius / (243.04 + celsius)
    local dew_point = 243.04 * humidity_factor / (17.625 - humidity_factor)
    return math.abs(celsius - dew_point)
end

local sunny_options = {
    id = "sunny",
    name = content.text("Sunny"),
    color = "light_cyan",
    map_color = "yellow_white",
    symbol = "*",
    sun_symbol = "☼",
    ranged_penalty = 0,
    sight_penalty = 1.0,
    light_modifier = 2,
    sound_attenuation = 0,
    dangerous = false,
    precipitation = "none",
    rains = false,
    sound_category = "sunny",
    priority = 10,
}

-- data/json/weather_type.json
do
    local weather = content.WeatherType(sunny_options)
    ccb.runtime.handler("weather_sunny_selected", function(sample)
        return (sample.daylight and sample.pressure >= 1020 and sample.humidity < 70)
    end)
    weather:condition("weather_sunny_selected")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "cloudy",
        name = content.text("Cloudy"),
        color = "light_gray",
        map_color = "dark_gray_white",
        symbol = "~",
        sun_symbol = "⛅",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = -20,
        sun_multiplier = 0.3,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "cloudy",
        priority = 20,
    }
    ccb.runtime.handler("weather_cloudy_selected", function(sample)
        return (sample.humidity >= 40 and sample.pressure < 1010)
    end)
    weather:condition("weather_cloudy_selected")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "light_drizzle",
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
        priority = 30,
    }
    ccb.runtime.handler("weather_light_drizzle_selected", function(sample)
        if sample.climate_match ~= nil then return sample.climate_match end
        return (sample.humidity >= 96 or sample.pressure < 1003)
    end)
    weather:condition("weather_light_drizzle_selected")
    weather:animation {
        factor = 0.01,
        color = "light_blue",
        symbol = ",",
    }
    weather:requires("cloudy")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "drizzle",
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
        priority = 40,
    }
    ccb.runtime.handler("weather_drizzle_selected", function(sample)
        if sample.climate_match ~= nil then return sample.climate_match end
        return (sample.humidity >= 97 or sample.pressure < 1000)
    end)
    weather:condition("weather_drizzle_selected")
    weather:animation {
        factor = 0.01,
        color = "light_blue",
        symbol = ".",
    }
    weather:requires("light_drizzle")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "rain",
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
        priority = 50,
    }
    ccb.runtime.handler("weather_rain_selected", function(sample)
        if sample.climate_match ~= nil then return sample.climate_match end
        return (sample.humidity >= 98 or sample.pressure < 993)
    end)
    weather:condition("weather_rain_selected")
    weather:animation {
        factor = 0.02,
        color = "light_blue",
        symbol = ",",
    }
    weather:requires("light_drizzle")
    weather:requires("drizzle")
    weather:requires("scarlet_storm_1")
    weather:requires("scarlet_storm_2")
    weather:requires("scarlet_storm_3")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "rainstorm",
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
        priority = 60,
    }
    ccb.runtime.handler("weather_rainstorm_selected", function(sample)
        return (sample.temperature_kelvin >= rain_snow_threshold_kelvin and sample.windpower >= 15)
    end)
    weather:condition("weather_rainstorm_selected")
    weather:animation {
        factor = 0.04,
        color = "blue",
        symbol = ";",
    }
    weather:requires("rain")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "thunder",
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
    ccb.runtime.handler("weather_thunder_selected", function(sample)
        return sample.pressure < 996
    end)
    weather:condition("weather_thunder_selected")
    weather:animation {
        factor = 0.02,
        color = "light_blue",
        symbol = ".",
    }
    weather:requires("rain")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "lightning",
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
        priority = 80,
    }
    ccb.runtime.handler("weather_lightning_selected", function(sample)
        return sample.pressure < 990
    end)
    weather:condition("weather_lightning_selected")
    weather:animation {
        factor = 0.04,
        color = "light_blue",
        symbol = ",",
    }
    weather:requires("thunder")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "flurries",
        name = content.text("Flurries"),
        color = "white",
        map_color = "dark_gray_cyan",
        symbol = ".",
        sun_symbol = "⛄",
        ranged_penalty = 2,
        sight_penalty = 1.12,
        light_modifier = -15,
        sun_multiplier = 0.3,
        sound_attenuation = 2,
        dangerous = false,
        precipitation = "light",
        rains = false,
        tiles_animation = "weather_snowflake",
        sound_category = "flurries",
        priority = 90,
    }
    ccb.runtime.handler("weather_flurries_selected", function(sample)
        if sample.climate_match ~= nil then return sample.climate_match end
        return sample.temperature_kelvin < rain_snow_threshold_kelvin
    end)
    weather:condition("weather_flurries_selected")
    weather:animation {
        factor = 0.01,
        color = "white",
        symbol = ".",
    }
    weather:requires("drizzle")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "snowing",
        name = content.text("Snowing"),
        color = "white",
        map_color = "dark_gray_cyan",
        symbol = "*",
        sun_symbol = "☃",
        ranged_penalty = 4,
        sight_penalty = 1.3,
        light_modifier = -20,
        sun_multiplier = 0.15,
        sound_attenuation = 4,
        dangerous = false,
        precipitation = "heavy",
        rains = false,
        tiles_animation = "weather_snowflake",
        sound_category = "snow",
        priority = 100,
    }
    ccb.runtime.handler("weather_snowing_selected", function(sample)
        if sample.climate_match ~= nil then return sample.climate_match end
        return sample.temperature_kelvin < rain_snow_threshold_kelvin
    end)
    weather:condition("weather_snowing_selected")
    weather:animation {
        factor = 0.02,
        color = "white",
        symbol = ",",
    }
    weather:requires("rain")
    weather:requires("thunder")
    weather:requires("lightning")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "snowstorm",
        name = content.text("Snowstorm"),
        color = "white",
        map_color = "white_cyan",
        symbol = "%",
        sun_symbol = "⛇",
        ranged_penalty = 6,
        sight_penalty = 1.2,
        light_modifier = -30,
        sun_multiplier = 0.01,
        sound_attenuation = 6,
        dangerous = false,
        precipitation = "heavy",
        rains = false,
        tiles_animation = "weather_snowflake",
        sound_category = "snowstorm",
        priority = 110,
    }
    ccb.runtime.handler("weather_snowstorm_selected", function(sample)
        return (sample.temperature_kelvin < rain_snow_threshold_kelvin and sample.windpower >= 15)
    end)
    weather:condition("weather_snowstorm_selected")
    weather:animation {
        factor = 0.04,
        color = "white",
        symbol = "*",
    }
    weather:requires("thunder")
    weather:requires("lightning")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "mist",
        name = content.text("Mist"),
        color = "light_gray",
        map_color = "dark_gray_white",
        symbol = "~",
        sun_symbol = "⛆",
        ranged_penalty = 3,
        sight_penalty = 1.3,
        light_modifier = -20,
        sun_multiplier = 0.3,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 15,
    }
    ccb.runtime.handler("weather_mist_selected", function(sample)
        return (sample.windpower < 12 and sample.windpower > 0 and dew_point_factor(sample) <= 2.5 and sample.humidity < 90)
    end)
    weather:condition("weather_mist_selected")
    weather:requires("clear")
    weather:requires("sunny")
    weather:requires("fog")
    weather:requires("scarlet_storm_1")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "fog",
        name = content.text("Fog"),
        color = "light_gray",
        map_color = "dark_gray_white",
        symbol = "~",
        sun_symbol = "⛆",
        ranged_penalty = 7,
        sight_penalty = 1.7,
        light_modifier = -40,
        sun_multiplier = 0.3,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "silent",
        priority = 15,
    }
    ccb.runtime.handler("weather_fog_selected", function(sample)
        return (sample.windpower < 12 and sample.windpower > 0 and dew_point_factor(sample) <= 2.5)
    end)
    weather:condition("weather_fog_selected")
    weather:requires("clear")
    weather:requires("sunny")
    weather:requires("mist")
    weather:requires("scarlet_storm_1")
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "rainstorm_reverberation",
        name = content.text("Rain Storm"),
        color = "blue",
        map_color = "i_blue",
        symbol = "%",
        sun_symbol = "☔",
        ranged_penalty = 6,
        sight_penalty = 1.2,
        light_modifier = -100,
        sun_multiplier = 0.01,
        sound_attenuation = 8,
        dangerous = false,
        precipitation = "heavy",
        rains = true,
        tiles_animation = "weather_rain_drop",
        sound_category = "rainstorm",
        priority = 5,
    }
    ccb.runtime.handler("weather_rainstorm_reverberation_selected", function(sample)
        return sample.dimension == "radiosphere"
    end)
    weather:condition("weather_rainstorm_reverberation_selected")
    weather:animation {
        factor = 0.04,
        color = "blue",
        symbol = ";",
    }
    content.upsert(weather)
end

-- data/json/weather_type.json
do
    local weather = content.WeatherType {
        id = "scarlet_day",
        name = content.text("Scarlet Day"),
        color = "light_gray",
        map_color = "dark_gray_white",
        symbol = "~",
        sun_symbol = "⛅",
        ranged_penalty = 0,
        sight_penalty = 1.0,
        light_modifier = -100,
        sun_multiplier = 0.01,
        sound_attenuation = 0,
        dangerous = false,
        precipitation = "none",
        rains = false,
        sound_category = "cloudy",
        priority = 1,
    }
    ccb.runtime.handler("weather_scarlet_day_selected", function(sample)
        return sample.dimension == "scarlet"
    end)
    weather:condition("weather_scarlet_day_selected")
    weather:tint { red = 110, green = 0, blue = 0, strength = 1.0 }
    content.upsert(weather)
end

-- data/json/effects_on_condition/scenario_specific_eocs.json
do
    local options = {}
    for key, value in pairs(sunny_options) do options[key] = value end
    options.id = "moonlit_scenario_weather"
    options.name = content.text("Moonlit")
    options.priority = 999
    local weather = content.WeatherType(options)
    ccb.runtime.handler("weather_moonlit_scenario_weather_selected", function(sample)
        return world_number("is_moonlit_scenario") == 1
    end)
    weather:condition("weather_moonlit_scenario_weather_selected")
    content.upsert(weather)
end
