local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_XEDRA_FIELD_STATION_3",
    name = ccb.content.text("Go to the address from the notebook"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 1,
    value = 0,
    destination = "xedra_fishing_shack_0",
    start = {
        target = {
            special = "xedra_fishing_shack",
            terrain = "xedra_fishing_shack_0",
            reveal_radius = 1,
            random = true,
            search_range = 4000,
        },
        handler = { "mark_knows_xedra_field_station_3", "mark_knows_xedra_field_station_3_passcode" },
    },
}
