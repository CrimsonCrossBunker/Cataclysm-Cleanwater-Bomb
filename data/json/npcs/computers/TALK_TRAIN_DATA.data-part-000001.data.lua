local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "COMP_TRAIN_DATA_MAIN",
    line = ccb.content.text("The computer awaits input…"),
    replies = {
        {
            text = ccb.content.text("Request Monorail"),
            next_topic = "COMP_TRAIN_DATA_MONRAIL_REQUEST",
        },
        {
            text = ccb.content.text("Download Train Data"),
            next_topic = "COMP_TRAIN_DATA_DOWNLOAD",
            when = predicates.has_mission("MISSION_SCIENCE_REP_5"),
        },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}
