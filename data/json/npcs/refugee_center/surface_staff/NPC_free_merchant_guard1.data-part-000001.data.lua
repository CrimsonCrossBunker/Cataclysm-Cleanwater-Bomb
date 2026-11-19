local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Hello marshal."),
        no = ccb.content.text("Hello there."),
    },
    replies = {
        { text = ccb.content.text("What is this place?"), next_topic = "TALK_EVAC_GUARD1_PLACE" },
        { text = ccb.content.text("Can I join you guys?"), next_topic = "TALK_EVAC_GUARD1_JOIN" },
        {
            text = ccb.content.text("Anything I can do for you?"),
            next_topic = "TALK_EVAC_GUARD1_JOB",
        },
        { text = ccb.content.text("See you later."), next_topic = "TALK_EVAC_GUARD1_BYE" },
    },
}
