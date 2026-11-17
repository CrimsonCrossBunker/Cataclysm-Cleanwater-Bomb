local ccb = require("ccb")
local content = ccb.content

-- data/mods/aftershock_exoplanet/region_settings/region_settings/region_settings.json
do
    local generator = content.WeatherGenerator {
        id = "default_aftershock",
        inherits = "default",
        base_temperature = -50.0,
        base_humidity = 80.0,
        base_pressure = 1015.0,
        base_wind = 9.0,
        base_wind_distrib_peaks = 80,
        base_wind_season_variation = 0,
    }
    generator:whitelisted_weather("clear")
    generator:whitelisted_weather("sunny")
    generator:whitelisted_weather("cloudy")
    generator:whitelisted_weather("afs_whiteout")
    generator:whitelisted_weather("afs_thunder")
    generator:whitelisted_weather("afs_lightning")
    generator:whitelisted_weather("afs_flurries")
    generator:whitelisted_weather("afs_snowing")
    content.upsert(generator)
end
