local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_ADVICE_EXODII_MISSION_WAREHOUSE",
    line = ccb.content.text("Now THIS is what I'm good at.  Tell ya' what, I can take this one, if you want.  No guarantees on time, but check in once a week, and I'll let ya' know if I find it.  But listen, you should talk to our employah 'bout this, yeah?  I'm tellin' ya, they'd probably cough up a wicked pile'a coins for the tech in that thing.  Think about it."),
    replies = {
        {
            text = ccb.content.text("Absolutely.  I'll check in next week.  And I'll think about telling the intercom."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
            actions = { actions.assign_mission("MISSION_ROBOFAC_PAT_EXODII_WAREHOUSE"), actions.set_actor_value("speaker", "robofac_pat_looking_for_exodii_warehouse", "yes"), actions.handler("dlg_a_dda_0a0865d35a87") },
        },
        {
            text = ccb.content.text("No, I've got this for now.  If I change my mind, I'll let you know."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_ADVICE",
        },
    },
}
