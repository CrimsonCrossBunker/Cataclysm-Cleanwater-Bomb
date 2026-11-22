local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR",
    line = ccb.content.text("No shit?  You also got some kind of internal radio we can use?  If so, I'll plug my computah heah into your USB port, and see what we can do.  Platonically, of course."),
    replies = {
        {
            text = ccb.content.text("Yup, I have an Infolink CBM, too."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_YES",
            when = predicates.handler("dlg_p_dda_80af6556c707"),
        },
        {
            text = ccb.content.text("No, I don't have an internal radio CBM."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_NO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.set_actor_value("speaker", "robofac_pat_said_use_the_earpiece", "yes") },
        },
        {
            text = ccb.content.text("Maybe I should come talk to you in person about this.  I'll swing by sometime."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("Let's talk about this some other time."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_NO",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } }),
        yes = ccb.content.text("Well, I guess an integrated radio'd be nice, but just use the earpiece you have for the headset, yeah?  It should work with that USB port just the same."),
        no = ccb.content.text("&Pat reaches into their pocket and pulls out a small earpiece with some inline electronics.  \"Heah, I've been workin' on this for a while.  You can plug it right into your USB port there, and stick this part here in your ear.  If the earpiece is active, I'll be able to chat and talk with you, yeah?  Turn it off if you need privacy.\""),
    },
    replies = {
        {
            text = ccb.content.text("Great, I'll just use the earpiece for now."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } }),
        },
        {
            text = ccb.content.text("Huh, cool.  Thanks, Pat.  Talk to you soon."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_finished_earpiece" } })),
            actions = { actions.handler("dlg_a_dda_6803713d7a4a"), actions.clear_actor_value("speaker", "robofac_pat_finished_earpiece") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_YES",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        yes = ccb.content.text("Absolutely.  Come by heah sometime and show me, and we'll see what we can do."),
        no = ccb.content.text("&Pat pulls out their laptop, sparks the makeshift car battery they use to power it, then boots it up.  \"Alright, now we're talkin'.  Like I said, I'll have to plug into your USB jack, Jack.  Ready?\""),
    },
    replies = {
        {
            text = ccb.content.text("Sure, I'll come by in person."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } }),
        },
        {
            text = ccb.content.text("[Give Pat access to your USB port] Let's do it."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR_INFOLINK_INSTALLED",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "robofac_pat_chatting_on_radio" } })),
            actions = { actions.set_actor_value("speaker", "robofac_pat_gave_transponder_CBM", "yes"), actions.handler("dlg_a_dda_ea81fc86a3a3") },
        },
        {
            text = ccb.content.text("Actually, let's talk about this some other time."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}
