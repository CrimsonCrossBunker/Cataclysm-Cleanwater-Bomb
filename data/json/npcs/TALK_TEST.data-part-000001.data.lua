local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_FAIL_RESPONSE",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        {
            text = ccb.content.text("Never See this."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c51cb610e41e"),
            failure_topic = "TALK_TEST_START",
            failure_explanation = ccb.content.text("Impossible Test"),
        },
    },
}
