local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "overmap",
    id = "fema_road_straight",
    layout = {
        fill_terrain = "t_railroad_rubble",
        vehicle_placements = { { id = "industrial_transport", x = 11, y = 13, chance = 10, rotation = { 90, 270 } } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "fema_road_end",
    layout = {
        fill_terrain = "t_region_groundcover",
        vehicle_placements = { { id = "industrial_transport", x = 11, y = 13, chance = 10, rotation = { 90, 270 } } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "fema_road_curved",
    layout = {
        fill_terrain = "t_railroad_rubble",
        vehicle_placements = { { id = "industrial_transport", x = 11, y = 13, chance = 10, rotation = { 90, 270 } } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "fema_road_tee",
    layout = {
        fill_terrain = "t_railroad_rubble",
        vehicle_placements = { { id = "industrial_transport", x = 11, y = 13, chance = 10, rotation = { 90, 270 } } },
    },
}

ccb.content.define_mapgen {
    kind = "overmap",
    id = "fema_road_four_way",
    layout = {
        fill_terrain = "t_railroad_rubble",
        vehicle_placements = { { id = "industrial_transport", x = 11, y = 13, chance = 10, rotation = { 90, 270 } } },
    },
}
