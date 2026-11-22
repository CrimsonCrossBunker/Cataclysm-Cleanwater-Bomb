local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_1",
    line = ccb.content.text("As we discussed during acceptance of the contract, we were aware of hazardous ground conditions, but we were unable to deduce further information other than what was available through long-range sensing.  If you would like to provide a description of the hazards present, we are willing to document them."),
    replies = {
        {
            text = ccb.content.text("[Detail the conditions at the collapsed tower and its basement.  This will advance time by ten minutes.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_Explainer",
            actions = { actions.handler("dlg_a_dda_d05d0c5b676b") },
        },
        {
            text = ccb.content.text("[Let them know how bad that mission REALLY was.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_3_COMPLETE_ChewingOut",
        },
        {
            text = ccb.content.text("…Just forget it.  Let's never speak of this again."),
            next_topic = "TALK_ROBOFAC_INTERCOM_SERVICES",
        },
    },
}
