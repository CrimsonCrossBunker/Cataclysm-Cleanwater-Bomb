local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Jane_2", "TALK_GODCO_Jane_Mood", "TALK_GODCO_Jane_Story", "TALK_GODCO_Jane_Firstmeet", "TALK_GODCO_Jane_Kostas_Personal" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Jane_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Jane_Mood",
        },
        {
            text = ccb.content.text("Are the non-joinees treating you fairly?"),
            next_topic = "TALK_GODCO_Jane_Community",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Need any help?"),
            next_topic = "TALK_GODCO_Jane_Help",
        },
        {
            text = ccb.content.text("Could you provide any medical services?"),
            next_topic = "TALK_GODCO_Jane_Heal_You",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Jane_Help", "TALK_GODCO_Jane_Arturo", "TALK_GODCO_Jane_Medicine", "TALK_GODCO_Jane_Kostas" },
    replies = {
        {
            text = ccb.content.text("I might have some medicine for the community.  Anything you're missing?"),
            next_topic = "TALK_GODCO_Jane_Medicine",
        },
        {
            text = ccb.content.text("Are you taking care of Arturo?"),
            next_topic = "TALK_GODCO_Jane_Arturo",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Jane_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Jane_Mood",
        },
        {
            text = ccb.content.text("Are the non-joinees treating you fairly?"),
            next_topic = "TALK_GODCO_Jane_Community",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you want to come with me?"),
            next_topic = "TALK_GODCO_Jane_Follow",
        },
        {
            text = ccb.content.text("Could you provide any medical services?"),
            next_topic = "TALK_GODCO_Jane_Heal_You",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jane_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("&Jane glances at you, scowls, and ignores your presence."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_jane" } }),
            yes = {
                choices = {
                    ccb.content.text("How can I help you?"),
                    ccb.content.text("<u_name>, what can I do for you?"),
                },
            },
            no = ccb.content.text("Oh, I don't think we've met before.  My name's Jane, I'm the local doctor."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you too, Jane."),
            next_topic = "TALK_GODCO_Jane_Firstmeet",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_jane" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_jane", "yes") },
        },
        {
            text = ccb.content.text("Hi, Jane.  Got a minute?"),
            next_topic = "TALK_GODCO_Jane_2",
            when = predicates.handler("dlg_p_dda_07592b4ecdd4"),
        },
        {
            text = ccb.content.text("Hi, Jane.  Got a minute?"),
            next_topic = "TALK_GODCO_Jane_Angry",
            when = predicates.handler("dlg_p_dda_4f8893d03f0a"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
