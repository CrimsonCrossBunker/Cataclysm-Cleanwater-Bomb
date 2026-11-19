local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_A1",
    line = ccb.content.text("Sup?  Nice to see a survivor.  If you're here for business, talk to the trader."),
    on_enter = { { actions = { actions.set_first_topic("TALK_CARAVAN_GUARD_A2") } } },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_CARAVAN_GUARD_A_Job",
        },
        { text = ccb.content.text("Thanks for the tip."), next_topic = "TALK_DONE" },
    },
}
