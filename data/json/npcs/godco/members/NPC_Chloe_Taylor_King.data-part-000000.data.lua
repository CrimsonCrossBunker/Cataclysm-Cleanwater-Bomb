local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("What are you doing here, go away!  I don't want to talk to you…"),
        no = {
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
            yes = {
                choices = {
                    ccb.content.text("Aw hey, it's you again, <u_name>.  How have you been?"),
                    ccb.content.text("Aw hey, it's you again, <name_g>.  How have you been?"),
                },
            },
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_chloe" } }),
                yes = {
                    choices = {
                        ccb.content.text("Hey <u_name>, what's up?"),
                        ccb.content.text("Hey <name_g>, what's up?"),
                    },
                },
                no = ccb.content.text("Oh… hi.  I don't know you.  My name's Chloe."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Chloe.  What's up?"),
            next_topic = "TALK_GODCO_chloe_2",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_chloe" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_chloe", "yes") },
        },
        {
            text = ccb.content.text("Hi.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_8213427bad25"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_chloe", "yes") },
        },
        {
            text = ccb.content.text("Do you wanna shoot the breeze?"),
            next_topic = "TALK_GODCO_chloe_idle_chat",
            when = predicates.handler("dlg_p_dda_948fd1983114"),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_GODCO_chloe_help",
            when = predicates.handler("dlg_p_dda_948fd1983114"),
        },
        {
            text = ccb.content.text("Do you wanna shoot the breeze?"),
            next_topic = "TALK_GODCO_chloe_angry",
            when = predicates.handler("dlg_p_dda_65e116ddf480"),
        },
        {
            text = ccb.content.text("Do you need any help?"),
            next_topic = "TALK_GODCO_chloe_angry",
            when = predicates.handler("dlg_p_dda_65e116ddf480"),
        },
        {
            text = ccb.content.text("Just saying hello.  Keep safe."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_948fd1983114"),
        },
        {
            text = ccb.content.text("Okay <name_b>, I'll leave."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_65e116ddf480"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_idle_chat",
    line = ccb.content.text("Shoot."),
    replies = {
        {
            text = ccb.content.text("Really, what's your story?"),
            when = predicates.handler("dlg_p_dda_bcd6b4e1bd5b"),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "TALK_GODCO_chloe_past_2" },
            failure = { next_topic = "TALK_GODCO_chloe_nochat" },
        },
        {
            text = ccb.content.text("How'd you and Sonia come to meet?"),
            next_topic = "TALK_GODCO_chloe_sonia",
            when = predicates.handler("dlg_p_dda_737f2e47701d"),
        },
        {
            text = ccb.content.text("How'd you and Sonia come to meet again?"),
            next_topic = "TALK_GODCO_chloe_sonia",
            when = predicates.handler("dlg_p_dda_386abab4facf"),
        },
        {
            text = ccb.content.text("Aren't you a bit young to be carrying a knife?"),
            next_topic = "TALK_GODCO_chloe_knife",
        },
        {
            text = ccb.content.text("On second though, let's talk about something else."),
            next_topic = "TALK_GODCO_chloe",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
