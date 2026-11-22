local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MAKE_EARPIECE_MVAS",
    line = ccb.content.text("Well hole-lee shit, look at that heah.  I read about these online before it all happened, eh?  Real assholes, Anduril, with that Tolkien reference.  Betcha he woulda' hated that.  Anyways.  Tell ya' what - ya' let that stay with me for a day, and I betcha I can work something out.  I may have to do a factory reset, so make sure ya' back up any data you need."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll see you in a day or so."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_bf1fc7827640"), actions.set_actor_value("speaker", "robofac_pat_started_earpiece", "yes"), actions.set_actor_value("speaker", "robofac_pat_is_holding", "military_vis_aug_system") },
        },
        {
            text = ccb.content.text("Maybe some other time.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MAKE_EARPIECE_HVAH",
    line = ccb.content.text("Well hole-lee shit, look at that heah.  Wicked.  Attached to the helmet and everything!  Tell ya' what - ya' let that stay with me for a day, and I betcha I can work something out.  I may have to do a factory reset, so make sure ya' back up any data you need."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll see you in a day or so."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_333a45f80cf4"), actions.set_actor_value("speaker", "robofac_pat_started_earpiece", "yes"), actions.set_actor_value("speaker", "robofac_pat_is_holding", "robofac_head_rig_ar") },
        },
        {
            text = ccb.content.text("Maybe some other time.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}
