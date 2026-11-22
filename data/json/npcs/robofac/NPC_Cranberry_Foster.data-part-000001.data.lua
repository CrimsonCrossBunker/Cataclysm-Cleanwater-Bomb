local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } }),
            yes = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_robofac_merc_1_temporal_follower" } }),
                yes = {
                    choices = {
                        ccb.content.text("Better keep our eyes on the road."),
                        ccb.content.text("*looks at you expectantly."),
                        ccb.content.text("Better be careful around here."),
                        ccb.content.text("Yeah?"),
                        ccb.content.text("What's up?"),
                    },
                },
                no = {
                    choices = {
                        ccb.content.text("Got something to say?"),
                        ccb.content.text("I charge hourly, y'know."),
                        ccb.content.text("Hey."),
                        ccb.content.text("*looks at you expectantly."),
                        ccb.content.text("Yeah?"),
                        ccb.content.text("What's up?"),
                        ccb.content.text("Good to see you."),
                    },
                },
            },
            no = {
                choices = {
                    ccb.content.text("Did I scare you off the first time?"),
                    ccb.content.text("Hi again, other person."),
                    ccb.content.text("*waves."),
                },
            },
        },
        no = ccb.content.text("&There's a person reclined on the sofa here.  They're very tall, with their legs reaching to the other armrest, and they're wearing a set of Hub 01's modular armor.  An environmental suit in blue-and-brown is crumpled in a misshapen heap on the floor near the table, and leaning against the far armrest is a rifle looking like nothing you've seen before.\n\nThey look up towards you as you come through the door and wave a hand.  \"Placeholder text.\""),
    },
    on_enter = {
        { once = "robofac_merc_1_first_meeting", actions = { actions.set_actor_value("speaker", "general_meeting_u_met_Cranberry", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("…Did you just say \"placeholder text\" out loud?"),
            next_topic = "TALK_ROBOFAC_MERC_1_PLACEHOLDER_TEXT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } })) }),
        },
        {
            text = ccb.content.text("Uh… okay.  Who are you?"),
            next_topic = "TALK_ROBOFAC_MERC_1_WHO",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } })) }),
        },
        {
            text = ccb.content.text("Who are you, exactly?"),
            next_topic = "TALK_ROBOFAC_MERC_1_WHO",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Cranberry" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } })) }),
        },
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About those jobs…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_stay" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_robofac_merc_1_temporal_follower" } })) }),
        },
        {
            text = ccb.content.text("Want help with something else?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_d2342c198178"),
        },
        {
            text = ccb.content.text("Let's set up a combat strategy."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_robofac_merc_1_temporal_follower" } }),
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ROBOFAC_MERC_1_MAIN", "TALK_ROBOFAC_MERC_1_STAY_AWHILE", "TALK_ROBOFAC_MERC_1_GOLD_MISSION_ACCEPTED" },
    line = {
        choices = {
            ccb.content.text("Rough out there, isn't it?"),
            ccb.content.text("Good to have some company."),
            ccb.content.text("Have something to say?"),
            ccb.content.text("Did you want something?"),
            ccb.content.text("*waits expectantly."),
        },
    },
    replies = {
        {
            text = ccb.content.text("So what's going on?"),
            next_topic = "TALK_ROBOFAC_MERC_1_GOING_ON",
        },
        {
            text = ccb.content.text("Anything on your mind?"),
            next_topic = "TALK_ROBOFAC_MERC_1_COINS",
            when = predicates.handler("dlg_p_dda_2c20491e4c6b"),
        },
        {
            text = ccb.content.text("Anything on your mind?"),
            next_topic = "TALK_ROBOFAC_MERC_1_RANDOM_THOUGHTS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_has_gold_deal" } }),
        },
        {
            text = ccb.content.text("What was <the_cataclysm> like for you?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND_NO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_helped_with_missions" } })),
        },
        {
            text = ccb.content.text("What was <the_cataclysm> like for you?"),
            next_topic = "TALK_ROBOFAC_MERC_1_BACKGROUND",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_helped_with_missions" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_heard_backstory" } })) }),
        },
        {
            text = ccb.content.text("Want help with something?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_helped_with_missions" } })),
        },
        {
            text = ccb.content.text("What do you know about our employers?"),
            next_topic = "TALK_ROBOFAC_MERC_1_ASK_HUB",
        },
        {
            text = ccb.content.text("That gun isn't like anything I've ever seen.  What am I looking at?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP",
            when = predicates.handler("dlg_p_dda_507b4950adea"),
        },
        {
            text = ccb.content.text("What's the deal with your gun again?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_EXPLANATION",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_merc_1_robofac_merc_1_HWP" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_hub_rnd_u_can_research_rifle" } })) }),
        },
        {
            text = ccb.content.text("I've helped you out now.  Do you think you could vouch for me with our employers?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_YES",
            when = predicates.handler("dlg_p_dda_11254f2d418d"),
        },
        {
            text = ccb.content.text("How can I get a gun like that?"),
            next_topic = "TALK_ROBOFAC_MERC_1_HWP_NO",
            when = predicates.handler("dlg_p_dda_f782335365a7"),
        },
        {
            text = ccb.content.text("I just realized, we've been in touch for a while now and I don't actually know; are you a man or a woman?"),
            next_topic = "TALK_ROBOFAC_MERC_1_GENDER",
            when = predicates.handler("dlg_p_dda_e9c924b77994"),
        },
        {
            text = ccb.content.text("About the gold you wanted…"),
            next_topic = "TALK_ROBOFAC_MERC_1_GOLD_MISSION_QUERY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_robofac_merc_1_has_gold_deal" } }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_1_GENDER",
    line = ccb.content.text("Yes."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_robofac_merc_1_asked_gender", "yes") },
            once = "robofac_merc_1_asked_gender",
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know what I was expecting."),
            next_topic = "TALK_ROBOFAC_MERC_1_MAIN",
        },
    },
}
