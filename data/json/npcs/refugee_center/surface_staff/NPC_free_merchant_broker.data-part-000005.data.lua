local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_STOCKS_SEALED1wrong",
    line = ccb.content.text("We didn't have great organization when we first arrived.  A few of the earliest arrivals set up a triage and sorting system, with the sick and infirm getting set aside to wait.  It's cruel, but we could see there was only space for so many, and we didn't know what was causing people to turn into zombies at the time, so we were trying to quarantine out infection.  A couple folks died in there, and it escalated.  One of the first people here, Jacob, had taken charge of the whole thing.  When the triage area had to be evacuated he stayed behind to make sure everyone who could get out got out.  It was a hell of a loss."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_conversation_told_about_FM_evacuation", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, can I ask you something else?"),
            next_topic = "TALK_FREE_MERCHANT_STOCKS",
        },
    },
}
