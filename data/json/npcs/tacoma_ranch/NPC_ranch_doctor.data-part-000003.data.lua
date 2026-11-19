local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_DOCTOR_SUPPLIES",
    line = ccb.content.text("I'm running out of office supplies.  I know… of all the things to need at a time like this!  I just need to be able to keep track of and organize medical records so that I can focus on helping people.  Ten binders and a ream of paper should tide me over until some shipments come in."),
    replies = {
        {
            text = ccb.content.text("I'll see what I can find."),
            next_topic = "TALK_DONE",
            actions = {
                actions.set_actor_value("interlocutor", "mission_tacoma_ranch_doctor_completed_supplies", "no"),
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
