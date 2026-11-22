local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_ANCILLA_HQ_GUARD", "TALK_ANCILLA_HQ_GUARD_AskJob", "TALK_ANCILLA_HQ_GUARD_AskJoin" },
    line = {
        when = predicates.has_any_trait("speaker", { "PROF_FED" }),
        yes = {
            choices = {
                ccb.content.text("We'll protect our own, marshal."),
                ccb.content.text("Make sure you don't get in trouble, officer."),
                ccb.content.text("Don't let me see you snooping around."),
                ccb.content.text("Stay out of trouble, right?"),
                ccb.content.text("How do you like that boot, huh?"),
            },
        },
        no = {
            when = predicates.has_trait("speaker", "PROF_HUB01_ANCILLIARY"),
            yes = {
                choices = {
                    ccb.content.text("Hey, oh, umm.  Yes, Sir?"),
                    ccb.content.gendered_line("&The mercenary looks noticeably tense as you approach.", { "interlocutor" }),
                    ccb.content.text("Nothing to report, Sir!"),
                    ccb.content.text("Hey boss."),
                },
            },
            no = {
                when = predicates.handler("dlg_p_dda_f684f7d3a2ec"),
                yes = {
                    choices = {
                        ccb.content.text("Great to see you back in base."),
                        ccb.content.text("Here's hoping I get out of guard duty soon."),
                        ccb.content.text("Got anything good?"),
                        ccb.content.text("On an errand from the box?"),
                        ccb.content.text("Up and at them again?"),
                        ccb.content.text("Up for a drink when my shift ends?"),
                        ccb.content.text("Well I can't complain much, money and free food for standing around with a gun?\n\nSure looks like a steal nowadays."),
                    },
                },
                no = {
                    when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_ancilla_hq_guard_first_meet" } }),
                    yes = {
                        choices = {
                            ccb.content.text("If you don't have any business here, you better get going."),
                            ccb.content.text("Terminal is down there, please move along."),
                            ccb.content.text("Please head right down, scavenger."),
                            ccb.content.text("Are you here to do anything?"),
                        },
                    },
                    no = ccb.content.text("If you are looking for the Terminal, it's in the first basement, right down the stairs and to the left."),
                },
            },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "bool_ancilla_barkeep", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_ANCILLA_HQ_GUARD_AskJob",
            when = predicates.negate(predicates.has_any_trait("speaker", { "PROF_FED" })),
        },
        {
            text = ccb.content.text("Is there any way I can join your team?"),
            next_topic = "TALK_ANCILLA_HQ_GUARD_AskJoin",
            when = predicates.handler("dlg_p_dda_b67aadf18b30"),
        },
        {
            text = ccb.content.text("See you around."),
            false_text = ccb.content.text("Don't mind me…"),
            text_when = predicates.handler("dlg_p_dda_f684f7d3a2ec"),
            next_topic = "TALK_DONE",
        },
    },
}
