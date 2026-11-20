local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_XEDRA_FIELD_STATION_1",
    name = ccb.content.text("Go to the address from the notebook"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 1,
    value = 0,
    destination = "xedra_rural_church_parking",
    start = {
        target = {
            special = "xedra_church_rural",
            terrain = "xedra_rural_church_parking",
            reveal_radius = 2,
            random = true,
            search_range = 800,
        },
        handler = "mark_knows_xedra_field_station_1",
    },
}

ccb.content.define_mission {
    id = "MISSION_XEDRA_FIELD_STATION_2",
    name = ccb.content.text("Go to the address from the notebook"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 1,
    value = 0,
    destination = "morgantown_forest_fence_entry",
    start = {
        target = {
            special = "xedra_morgantown",
            terrain = "morgantown_forest_fence_entry",
            reveal_radius = 1,
            random = true,
            search_range = 4000,
        },
        handler = "mark_knows_xedra_field_station_2",
    },
}
