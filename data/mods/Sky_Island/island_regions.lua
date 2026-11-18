local content = require("ccb").content

local open_air_layers = {}
for layer = 1, 21 do
    open_air_layers[layer] = "open_air"
end

content.add(content.RegionSettings {
    id = "default_skyisland",
    default_oter = open_air_layers,
    default_groundcover = {},
    cities = "no_cities",
    forest_composition = "no_forests",
    map_extras = "no_map_extras",
    place_roads = false,
    place_specials = true,
    weather = "sky_island_weather",
    terrain_furniture = "default",
    urbanity_increase = { 0, 10, 5, 0 },
    feature_flag_settings = { whitelist = { "SKY_ISLAND" } },
    connections = {
        intra_city_road_connection = "local_road",
        inter_city_road_connection = "local_road",
        trail_connection = "forest_trail",
        sewer_connection = "sewer_tunnel",
        subway_connection = "subway_tunnel",
        rail_connection = "local_railroad",
    },
})

content.add(content.RegionSettings {
    id = "dimension_sky_island_region",
    extends = "default",
    feature_flag_settings = {
        add_blacklist = { "SKY_ISLAND", "SKY_ISLAND_NO_RAID_SPAWN" },
    },
})

content.add(content.RegionSettings {
    id = "sky_island_raid_region_hot",
    extends = "dimension_sky_island_region",
    weather = "sky_island_raid_weather_hot",
})

content.add(content.RegionSettings {
    id = "sky_island_raid_region_cold",
    extends = "dimension_sky_island_region",
    weather = "sky_island_raid_weather_cold",
})

-- Stop generation of all specials, just city buildings
content.add(content.RegionSettings {
    id = "sky_island_raid_region_mega_city",
    extends = "dimension_sky_island_region",
    place_swamps = false,
    rivers = false,
    ocean = false,
    forests = false,
    lakes = false,
    highways = false,
    cities = "sky_island_raid_region_mega_city_settings",
    feature_flag_settings = {
        add_whitelist = { "MEGACITY_FLAG" },
    },
})

content.add(content.RegionSettingsCity {
    id = "sky_island_raid_region_mega_city_settings",
    extends = "default",
    is_megacity = true,
    city_size = 16,
    city_spacing = 0,
    shop_radius = 200,
    shop_sigma = 0,
    park_radius = 0,
    park_sigma = 0,
})
