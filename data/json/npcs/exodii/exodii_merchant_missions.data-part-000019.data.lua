local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- &Rubik hands you the device and nods.  "Good luck."
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Accepted",
    line = ccb.content.text("&Rubik hands you the device and nods.  \"Good fortune.\""),
    replies = {
        {
            text = ccb.content.text("[Take the device]"),
            actions = { actions.assign_mission("EXODII_MISSION_STRING_DIMENSION_EXODII") },
            next_topic = "TALK_DONE",
        },
    },
}
