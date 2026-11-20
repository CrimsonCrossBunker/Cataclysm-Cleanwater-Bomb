local ccb = require("ccb")

ccb.content.define_mission {
    id = "EXODII_MISSION_STRING_DIMENSION_EXODII",
    name = ccb.content.text("Download data from the other-dimension Exodii node"),
    goal = "MGOAL_NULL",
    start = { item_rewards = { { item = "exodii_usb_stick" } } },
    finish = { handler = "mark_mission_completed_u_returned_string_dimension_data" },
    difficulty = 5,
    value = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}
