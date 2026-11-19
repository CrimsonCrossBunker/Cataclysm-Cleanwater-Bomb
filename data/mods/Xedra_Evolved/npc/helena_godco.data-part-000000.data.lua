local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Helena_1",
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Are you looking at me funny?"),
            when = predicates.has_effect("speaker", "effect_weird_equipment"),
            next_topic = "TALK_GODCO_Helena_INVENTOR",
        },
    },
}
