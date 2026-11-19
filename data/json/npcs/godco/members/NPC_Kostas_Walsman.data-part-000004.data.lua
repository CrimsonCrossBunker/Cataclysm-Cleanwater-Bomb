local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah_Persuade",
    line = ccb.content.gendered_line("Alright, you've convinced me.  I'll take Jeremiah on and show him the ropes.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Thank you.  See you around, Kostas."),
            actions = {
                actions.set_actor_value("speaker", "general_mission_kostas_teach_jeremiah", "yes"),
                actions.clear_actor_value("speaker", "general_mission_convince_kostas"),
            },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah_FailPersuade",
    line = ccb.content.text("No, I'm still certain about this.  Jeremiah just isn't a good fit."),
    replies = {
        {
            text = ccb.content.text("Alright.  See you around, Kostas."),
            actions = { actions.add_effect("interlocutor", "failed_persuade", { turns = 86400 }) },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Jeremiah_FailPersuade_Violent",
    line = ccb.content.text("You think you're so tough <name_b>?  I'm not taking Jeremiah on, certainly not when his representitive is so barbaric.  I don't know how he got such a violent individual like yourself to do this, but I hope he can find someone else in the future."),
    replies = {
        {
            text = ccb.content.text("Fuck you then, you judgmental <name_b>."),
            actions = { actions.add_effect("interlocutor", "failed_persuade", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
