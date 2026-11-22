local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_COMPLETE",
    line = ccb.content.text("Great.  I already have a wicked prototype and some software, but I think it'll still take a bit.  Come back heah in two days?"),
    replies = {
        {
            text = ccb.content.text("Sure, see you in two days."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_772d908bcb93"), actions.set_actor_value("speaker", "robofac_waiting_on_pat", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_1_MVAS_HVAH",
    line = ccb.content.text("Great.  This should be easy.  Come back tomorrow, and I'll have somethin' for ya'."),
    replies = { { text = ccb.content.text("Sure, see you tomorrow."), next_topic = "TALK_DONE" } },
}
