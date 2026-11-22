local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE_SELL_EXODII",
    line = ccb.content.text("Is that so?  What do you have?"),
    replies = {
        {
            text = ccb.content.text("[1 HGC] I've brought you one of those workers."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d5a685558a07"),
            actions = { actions.handler("dlg_a_dda_4c91eb166453") },
        },
        {
            text = ccb.content.text("[2 HGC] I've brought you one of those quadrupeds."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_4c42079ffa99"),
            actions = { actions.handler("dlg_a_dda_f7a1fbc5f069") },
        },
        {
            text = ccb.content.text("[2 HGC] I've brought you one of those turrets."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c7eeecf43eb7"),
            actions = { actions.handler("dlg_a_dda_6d2f64f6260e") },
        },
        {
            text = ccb.content.text("[4 HGC] I found this strange balloon robot."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_4004e2d04b14"),
            actions = { actions.handler("dlg_a_dda_49ea36d673a8") },
        },
        {
            text = ccb.content.text("Nevermind.  Let's talk about something else."),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE",
        },
        {
            text = ccb.content.text("Actually, I'd better be going."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE_RESEARCH_PROGRESS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } }),
            yes = {
                when = predicates.handler("dlg_p_dda_a5d50abe7c2d"),
                yes = ccb.content.text("R&D is going well.  Maybe we'll have new products ready sometime soon."),
                no = ccb.content.text("Research is ongoing.  Nothing new to report."),
            },
            no = ccb.content.text("We've made some progress.  If you're keen to use our newest prototypes, I'd encourage you to see the Doc across the street.  Now we're looking for some cool military tech to synergize with the circuits I'm slapping together.  The intercom will have a relevant open contract, if they don't already."),
        },
        no = ccb.content.text("Honestly?  I'm able to reverse engineer a lot of this tech, but I can't recreate it.  Our top engineers know what we need to fix the problem, and are looking for mercs to help us solve the problem.  Ask about contracts at the intercom."),
    },
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE",
        },
        {
            text = ccb.content.text("I'd better be going."),
            next_topic = "TALK_DONE",
        },
    },
}
