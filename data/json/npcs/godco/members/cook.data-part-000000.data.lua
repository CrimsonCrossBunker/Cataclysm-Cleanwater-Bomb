local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Could you be on your way, please?  We don't take kindly to sinners like you."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Could you be on your way, please?  I'm rather busy."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } }),
                yes = {
                    choices = {
                        ccb.content.text("Welcome back."),
                        ccb.content.text("Hello again.  What do you need?"),
                        ccb.content.text("*waves you over.  \"Hey <u_name>.  How's it going for you?\""),
                    },
                },
                no = ccb.content.gendered_line("Hello stranger, I don't think we've met before.  Its nice to meet you, name's Simon.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Who are you?  Where am I right now?"),
            next_topic = "TALK_GODCO_chef_intro",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_chef", "yes") },
        },
        {
            text = ccb.content.text("Just passing through, don't mind me."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_chef", "yes") },
        },
        {
            text = ccb.content.text("I wanted to talk."),
            next_topic = "TALK_GODCO_chef_idle_chat",
            when = predicates.handler("dlg_p_dda_9aeef99033a0"),
        },
        {
            text = ccb.content.text("Could I have some food?"),
            next_topic = "TALK_GODCO_chef_get_food",
            when = predicates.handler("dlg_p_dda_b9e1e88d4a2b"),
        },
        {
            text = ccb.content.text("I heard the joinees could get some food here."),
            next_topic = "TALK_GODCO_chef_get_food_joinee",
            when = predicates.handler("dlg_p_dda_0a0c74d1dca5"),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_4cb2c3f2db3c"),
        },
        {
            text = ccb.content.text("Just saying hello.  Keep safe."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_chef" } }),
        },
        {
            text = ccb.content.text("Okay, man.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_idle_chat",
    line = {
        choices = {
            ccb.content.text("Okay, shoot."),
            ccb.content.text("Sure, what's up?"),
            ccb.content.text("Alright, let's chat."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_chef_past",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are you holding up?"),
            next_topic = "TALK_GODCO_chef_mood",
        },
        {
            text = ccb.content.text("Is there any way I could join the community?"),
            next_topic = "TALK_GODCO_chef_join",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about Katherine?"),
            next_topic = "TALK_GODCO_chef_katherine",
            when = predicates.handler("dlg_p_dda_1e018699ec48"),
        },
        {
            text = ccb.content.text("Could you tell me about Jeremiah?"),
            next_topic = "TALK_GODCO_chef_jeremiah",
            when = predicates.handler("dlg_p_dda_1e018699ec48"),
        },
        {
            text = ccb.content.text("I've changed my mind, forget about it."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See ya, <name_g>."),
            next_topic = "TALK_DONE",
        },
    },
}
