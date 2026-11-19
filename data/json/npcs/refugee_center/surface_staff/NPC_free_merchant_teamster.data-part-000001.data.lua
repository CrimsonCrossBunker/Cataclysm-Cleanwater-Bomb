local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- initial greeting
ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_teamster" } }),
        yes = ccb.content.text("What can I help you with?"),
        no = ccb.content.text("Well now, a new face.  Nice ta meet ya.  I'm the one sendin' out these here caravans far and wide.  What can I do ya for?"),
    },
    replies = {
        {
            text = ccb.content.text("Can I ask you some questions?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_teamster", "yes") },
        },
        {
            text = ccb.content.text("I've gotta run, nice talking to you."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_teamster", "yes") },
        },
    },
}
