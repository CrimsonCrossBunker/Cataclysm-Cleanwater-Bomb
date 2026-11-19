local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_Yoshimi_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } }),
        yes = {
            choices = {
                ccb.content.text("How can I help you, survivor?"),
                ccb.content.text("Seen any interesting specimens?  I mean dinosaurs."),
                ccb.content.text("I was just imagining you transforming into a tyrannosaurus rex.  Of course that's impossible.  Unless…"),
                ccb.content.text("Let's do some science."),
            },
        },
        no = ccb.content.text("Please leave me be, I am but a humble muck farmer in this humble muck."),
    },
    replies = {
        {
            text = ccb.content.text("You are dressed like a scientist.  Are you a scientist?  You look like a dinosaur.  Are you a dinosaur?  Are you a scientist dinosaur?"),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_yoshimi", "yes") },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } })),
            next_topic = "TALK_yoshimi_firstmeet",
        },
        {
            text = ccb.content.text("Die demon mutant!"),
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_yoshimi", "yes"),
                "insult_combat",
            },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } })),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("How did you get here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Yos_chemistry" } }) }),
            next_topic = "TALK_yoshimi_ask_past",
        },
        {
            text = ccb.content.text("How are things here?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } }) }),
            next_topic = "TALK_yoshimi_ask_mood",
        },
        {
            text = ccb.content.text("You look like you need help.  Can I do something for you?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_yoshimi" } }) }),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Goodbye."), next_topic = "TALK_DONE" },
    },
}
