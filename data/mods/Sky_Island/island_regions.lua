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
