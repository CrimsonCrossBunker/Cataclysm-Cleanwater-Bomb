local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_Negotiate",
    line = ccb.content.text("I like what you and Corrie's put together.  I did promise payment for a proof-of-concept, what'll it be?"),
    replies = {
        {
            text = ccb.content.text("I'll have some icons."),
            when = predicates.any_equal({ "in-progress", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
            next_topic = "TALK_GODCO_Helena_machineIcon",
        },
        {
            text = ccb.content.text("I want Corrie to have some extra rations."),
            when = predicates.any_equal({ "in-progress", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
            next_topic = "TALK_GODCO_Helena_machineFood",
        },
        { text = ccb.content.text("Let's negotiate some other time."), next_topic = "TALK_DONE" },
    },
}
