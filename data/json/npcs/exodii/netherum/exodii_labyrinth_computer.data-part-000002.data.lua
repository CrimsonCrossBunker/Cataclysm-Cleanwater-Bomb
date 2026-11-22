local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "COMP_LS_Entrance_Controls2",
    line = ccb.content.text("& Truly?  Aye/Nay"),
    replies = {
        {
            text = ccb.content.text("[Select \"Aye\"]"),
            next_topic = "TALK_DONE",
            actions = { actions.finish_mission("MISSION_EXODII_LABYRINTHS_INTRO", { success = true }), actions.handler("w16b_a_dda_183f08bf4e45") },
        },
        {
            text = ccb.content.text("[Select \"Nay\"]"),
            next_topic = "COMP_LS_Entrance_Controls",
        },
    },
}
