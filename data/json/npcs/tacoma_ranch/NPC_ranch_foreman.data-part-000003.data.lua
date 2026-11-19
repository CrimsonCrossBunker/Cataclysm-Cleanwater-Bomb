local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_Nunez",
    line = ccb.content.text("We're still in early stages of getting set up, but we're not overly flush for hands, that's for sure.  If they're willing to put in a hard day's work, we can get them busy."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "recruit_general_Nunez_Tacoma", "phase_2") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'll tell them that, but they seemed good for a bit of hard labor."),
            next_topic = "TALK_RANCH_FOREMAN",
        },
    },
}
