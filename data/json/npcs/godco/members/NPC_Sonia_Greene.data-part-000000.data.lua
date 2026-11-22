local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Sonia_Tunes", "TALK_GODCO_Sonia_Instrument", "TALK_GODCO_Sonia_Chloe", "TALK_GODCO_Sonia_Band", "TALK_GODCO_Sonia_Feeling", "TALK_GODCO_Sonia_Greet", "TALK_GODCO_Sonia_Godco" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Sonia_Chloe",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Sonia_Feeling",
        },
        {
            text = ccb.content.text("Is everyone treating you fairly?"),
            next_topic = "TALK_GODCO_Sonia_Godco",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Now that your guitar is fixed, could you play something for me?"),
            next_topic = "TALK_GODCO_Sonia_Play_For_U",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_completed_sonia_guitar_fixed" } }), predicates.has_item("interlocutor", "acoustic_guitar") }),
        },
        {
            text = ccb.content.text("That's a nice guitar you have."),
            next_topic = "TALK_GODCO_Sonia_Instrument",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Sonia",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("&Sonia glances at you harshly, then turns away.  \"Come back later, I'm busy right now.\""),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_sonia" } }),
            yes = {
                choices = {
                    ccb.content.gendered_line("Well now, good to see you again, friend.", { "speaker" }),
                    ccb.content.text("Nice of you to come around <u_name>."),
                },
            },
            no = ccb.content.text("Good to see people like you in the world.  I'm Sonia, Sonia Greene.  I entertain the people."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Sonia?  Nice to meet you, I'm <u_name>.  How are things here?"),
            next_topic = "TALK_GODCO_Sonia_Feeling",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_sonia" } })),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_sonia", "yes") },
        },
        {
            text = ccb.content.text("Hey Sonia.  What's up?"),
            next_topic = "TALK_GODCO_Sonia_Tunes",
            when = predicates.handler("dlg_p_dda_1885ec9fcf06"),
        },
        {
            text = ccb.content.text("Hey Sonia.  What's up?"),
            next_topic = "TALK_GODCO_Sonia_Angry",
            when = predicates.handler("dlg_p_dda_50d7905c11f8"),
        },
        {
            text = ccb.content.text("Hey Sonia.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_17ef1b259c2c"),
        },
        {
            text = ccb.content.text("Alright, see you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        },
    },
}
