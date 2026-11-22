local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Pretty_Action",
    line = {
        joined = {
            {
            when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
            yes = ccb.content.gendered_line("Yo, you're crazy hot!  I'm not stupid!", { "speaker" }),
            no = ccb.content.text("My jewel of the New England, I give to you my biggest prize."),
        },
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("\"\n\nLiam gives you a sly wink, heads to the door, theatrically produces a sock from - somewhere, you're not sure where - slides it on the doorknob, and leaves the room."),
            no = ccb.content.text("\""),
        },
        },
    },
    on_enter = {
        { once = "service_provided", actions = { actions.add_effect("speaker", "al_relaxed", { turns = 400 }), actions.handler("dlg_a_dda_13914f18c2f0") } },
    },
    replies = {
        {
            text = ccb.content.text("Sigh.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("All done.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Normal_Action",
    line = {
        joined = {
            {
            when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
            yes = ccb.content.text("Yeeeeah it's on!"),
            no = ccb.content.text("I give to you what of I got.  And this is Alonso so I mean it's a lot."),
        },
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("\"\n\nLiam gives you a sly wink, heads to the door, theatrically produces a sock from - somewhere, you're not sure where - slides it on the doorknob, and leaves the room."),
            no = ccb.content.text("\""),
        },
        },
    },
    on_enter = {
        { once = "service_provided", actions = { actions.add_effect("speaker", "al_relaxed", { turns = 360 }), actions.handler("dlg_a_dda_4482b3fae01c") } },
    },
    replies = {
        {
            text = ccb.content.text("Sigh.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Yeah.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Ugly_Action",
    line = {
        joined = {
            {
            when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
            yes = ccb.content.gendered_line("Yo, you're crazy hot!  I'm not stupid!", { "speaker" }),
            no = ccb.content.text("My jewel of the New England, I give to you my biggest prize."),
        },
            {
            when = predicates.handler("dlg_p_dda_e9d71f52da0b"),
            yes = ccb.content.text("\"\n\nAfter shooting Alonso a smile of genuine respect, Liam gives you a sly wink, heads to the door, theatrically produces a sock from - somewhere, you're not sure where - slides it on the doorknob, and leaves the room."),
            no = ccb.content.text("\""),
        },
        },
    },
    on_enter = {
        { once = "service_provided", actions = { actions.add_effect("speaker", "al_relaxed", { turns = 300 }), actions.handler("dlg_a_dda_725517b225b5") } },
    },
    replies = {
        {
            text = ccb.content.text("Sigh.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Yeah.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_Too_Young",
    line = {
        when = predicates.any_equal({ "asked", { scope = "interlocutor", key = "general_none_Alonso_accent" } }),
        yes = ccb.content.text("Sorry kid, you're younger than my little sister was.  Seems wrong."),
        no = ccb.content.text("Alonso thinks maybe we should wait a few years?"),
    },
    replies = { { text = ccb.content.text("Sigh."), next_topic = "TALK_DONE" } },
}
