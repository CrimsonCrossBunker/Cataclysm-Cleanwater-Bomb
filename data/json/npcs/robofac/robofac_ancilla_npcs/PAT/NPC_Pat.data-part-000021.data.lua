local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_3",
    line = ccb.content.text("&After a few minutes, Pat disconnects their laptop from the helmet.  \"Hey, look at that.  No sweat.  This thing's fahkin' nuts, pal.  I just pretuned your software radio doohickey to our frequency.  Long as that helmet's powered up, I can link in.  No prob.  Can also give me a shout over the radio, yeah?  I dunno where you keep the fahkin' trigger for the walkie, but if it's in your ass don't go butt dialin' me while you're in the head, yeah?\""),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "robofac_pat_gave_LENS_upgrade", "yes"), actions.handler("dlg_a_dda_01132165fc15") } },
    },
    replies = {
        {
            text = ccb.content.text("Hah, will do, Pat.  Thanks.  I wanted to ask talk about something else, too."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
        {
            text = ccb.content.text("Hah, will do, Pat.  Thanks.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_REMAKE",
    line = ccb.content.text("&Pat boots up their laptop and hooks it to the LENS USB port.  After a few minutes, Pat disconnects their laptop from the helmet.  \"Hey, look at that.  No sweat.\""),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_01132165fc15") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, Pat.  I wanted to ask talk about something else, too."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
        {
            text = ccb.content.text("Thanks, Pat.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}
