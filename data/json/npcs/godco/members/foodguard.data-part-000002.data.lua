local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_bribe_fail",
    line = {
        choices = {
            ccb.content.text("Nope, it couldn't.  Don't try and fuckin' bribe me again."),
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_71e2f9ff2d65") } },
    },
    replies = {
        {
            text = ccb.content.text("Geez, I'm leaving."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_intimidate_success",
    line = {
        choices = {
            ccb.content.text("Alright, alright.  Here's some food and water, <name_b>.  Get out of my sight."),
        },
    },
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_8dfe391a29e6") } },
    },
    replies = {
        {
            text = ccb.content.text("Keep that in mind."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5ebf903ac122") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_bribe_success",
    line = {
        choices = {
            ccb.content.text("Okay, here's some food and water.  Don't tell anyone I gave you that."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I won't.  Pleasure doin' business."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5ebf903ac122") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_about_self",
    line = {
        choices = {
            ccb.content.text("I'm just a regular guy, been with the Church for a while now.  I kept a good, solid job before <the_cataclysm>, lived in a nice apartment on Chestnut Street."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you have any hobbies?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What are you planning on doing in the future?"),
            next_topic = "TALK_GODCO_guard_food_future_plans",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
