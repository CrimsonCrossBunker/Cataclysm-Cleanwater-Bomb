local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "COMP_REFUGEE_CENTER_MAIN",
    line = ccb.content.text("The computer awaits input…"),
    replies = {
        { text = ccb.content.text("Emergency Message."), next_topic = "COMP_EMERGENCY_MESSAGE" },
        {
            when = predicates.has_mission("MISSION_OLD_GUARD_NEC_COMMO_2"),
            text = ccb.content.text("Disable External Power"),
            next_topic = "COMP_DISABLE_EXTERNAL_POWER",
        },
        { text = ccb.content.text("Contact Us"), next_topic = "COMP_FIND_REFUGEE_CENTER" },
        { text = ccb.content.text("Log off."), next_topic = "TALK_DONE" },
    },
}
