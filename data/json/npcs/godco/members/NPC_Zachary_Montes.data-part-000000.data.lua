local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Zachary_Intro_2", "TALK_GODCO_Zachary_Story0", "TALK_GODCO_Zachary_Feeling", "TALK_GODCO_Zachary_Result_rewardIcon", "TALK_GODCO_Zachary_Result_rewardRation", "TALK_GODCO_Zachary_Godco", "TALK_GODCO_Zachary_Intro", "TALK_GODCO_Zachary_Background" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Zachary_Story0",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Why don't you blow this joint and come with me?"),
            next_topic = "TALK_GODCO_Zachary_Follow",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Zachary_Feeling",
        },
        {
            text = ccb.content.text("Is everyone treating you fairly?"),
            next_topic = "TALK_GODCO_Zachary_Godco",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Zachary",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("You're back?  Shove off <name_b>!"),
        no = ccb.content.gendered_line("I got my rights to be here, chum.  Squatter's rights!", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text("Don't worry, I'm not going to hurt you."),
            next_topic = "TALK_GODCO_Zachary_Intro",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_zachary" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_zachary", "yes") },
        },
        {
            text = ccb.content.text("Hey, good to see you're still around."),
            next_topic = "TALK_GODCO_Zachary_Intro_2",
            when = predicates.handler("dlg_p_dda_e044ff8b2e0f"),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
        },
    },
}
