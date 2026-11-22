local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ANCILLA_BARKEEP", "TALK_ANCILLA_BEM_HUMAN_SAMPLE_REWARD" },
    line = {
        when = predicates.handler("dlg_p_dda_2e6ab3005522"),
        yes = {
            choices = {
                ccb.content.text("Ah great to see you around."),
                ccb.content.text("How goes the surface?  All dead and walkey still?"),
                ccb.content.text("Should hang around one of these days, help me out in the bar for a change, what do you say, eh?"),
                ccb.content.text("Oh, what can I do for you today?"),
            },
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_ancilla_barkeep_first_meet" } }),
            yes = ccb.content.text("Feel free to lounge around, and ask if there's anything you need."),
            no = ccb.content.text("Welcome to the Terminal, scavenger, longest standing underground bar in the state.  Feel free to ask if you need something."),
        },
    },
    on_enter = {
        { once = "bar_meet", actions = { actions.set_actor_value("speaker", "dialogue_ancilla_barkeep_first_meet", "yes"), actions.set_actor_value("interlocutor", "bool_ancilla_barkeep", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Let me see what you keep behind the counter."),
            next_topic = "TALK_ANCILLA_BARKEEP",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("What do you have on tap?"),
            next_topic = "TALK_ANCILLA_BARKEEP_TAP",
        },
        {
            text = ccb.content.text("There should be a package for me here."),
            next_topic = "TALK_ANCILLA_BEM_HUMAN_SAMPLE_REWARD",
            when = predicates.handler("dlg_p_dda_57545b08208f"),
        },
        {
            text = ccb.content.text("Any good rumors?"),
            next_topic = "TALK_ANCILLA_BARKEEP_INFORMATION",
        },
        {
            text = ccb.content.text("I'll be going…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ANCILLA_BARKEEP_INFORMATION",
    line = ccb.content.text("If what you want are jobs and opportunities, you'll probably be better off asking to my other patrons.  Have regulars from well across the state, I'm sure some can offer what you want.\"\n\n \"Really, I just tend the bar and don't ask many questions.  Things tend work out better that way."),
    replies = {
        {
            text = ccb.content.text("I'll ask around, thank you."),
            next_topic = "TALK_ANCILLA_BARKEEP",
        },
    },
}
