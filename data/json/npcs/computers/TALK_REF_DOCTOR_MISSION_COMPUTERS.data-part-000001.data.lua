local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "mission_science_rep_2_computer_main",
    line = {
        when = predicates.has_mission("MISSION_SCIENCE_REP_2"),
        yes = ccb.content.text("The computer awaits your input"),
        no = ccb.content.text("You don't see anything useful available on this computer."),
    },
    replies = {
        {
            text = ccb.content.text("Access Lab Data"),
            next_topic = "mission_science_rep_2_computer_download",
            when = predicates.has_mission("MISSION_SCIENCE_REP_2"),
        },
        { text = ccb.content.text("Power off."), next_topic = "TALK_DONE" },
    },
}
