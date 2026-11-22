local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ENG_LIGHTHOUSE_2",
    line = ccb.content.text("Hmm, looks shitty.  I'll do my best."),
    replies = {
        {
            text = ccb.content.text("Start working."),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_ENG_LIGHTHOUSE_WORKING"), actions.handler("dlg_a_dda_796e46b31c4a") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ENG_LIGHTHOUSE_WORKING",
    line = {
        when = predicates.handler("dlg_p_dda_efaaa03c052f"),
        yes = {
            when = predicates.has_trait("interlocutor", "Exp_Eng_Electrical1Fake2"),
            yes = ccb.content.gendered_line("Boss, here's the thing… just don't be mad, please.  I lied that I'm good at this… I thought I could figure it out, but it's far beyond my comprehension.  I'm sorry.", { "interlocutor" }),
            no = {
                when = predicates.has_trait("interlocutor", "Exp_Eng_Electrical0Fake2"),
                yes = ccb.content.gendered_line("Boss, here's the thing… just don't be mad, please.  I lied that I know something about this… I thought I could figure it out, but it's far beyond my comprehension.  I'm sorry.", { "interlocutor" }),
                no = ccb.content.text("All done, boss.  Tell that fisherman to try it in action."),
            },
        },
        no = ccb.content.text("I'm still working, boss."),
    },
    on_enter = {
        { when = predicates.handler("dlg_p_dda_cbf4b887e941"), once = "done", actions = { actions.set_actor_value("speaker", "global_safe_space_lighthouse_fixed", "ready") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks for wasting my time, <name_b>.  <end_talking>"),
            false_text = ccb.content.text("We're done here.  <end_talking>"),
            text_when = predicates.has_any_trait("interlocutor", { "Exp_Eng_Electrical1Fake2", "Exp_Eng_Electrical0Fake2" }),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_692f1fbb5052"),
            actions = { "follow" },
        },
        {
            text = ccb.content.text("Good."),
            next_topic = "TALK_DONE",
        },
    },
}
