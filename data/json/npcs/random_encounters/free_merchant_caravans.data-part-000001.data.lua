local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_MERCHANT_1",
    line = ccb.content.gendered_line("Well well, another traveler.  Don't try anything, you're outnumbered here and we're well armed.", { "speaker" }),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_MERCHANT_2") } } },
    replies = {
        {
            text = ccb.content.text("Are you threatening me?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Threatening",
        },
        {
            text = ccb.content.text("What's your deal here?"),
            next_topic = "TALK_CARAVAN_MERCHANT_Job",
        },
        {
            text = ccb.content.text("I won't try anything if you don't.  Just passing through."),
            next_topic = "TALK_DONE",
        },
    },
}
