local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD2",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("Hello marshal."),
        no = ccb.content.text("Hello."),
    },
    replies = {
        { text = ccb.content.text("I am actually new."), next_topic = "TALK_EVAC_GUARD2_NEW" },
        {
            text = ccb.content.text("Are there any rules I should follow while inside?"),
            next_topic = "TALK_EVAC_GUARD2_RULES",
        },
        {
            text = ccb.content.text("So who is everyone around here?"),
            next_topic = "TALK_EVAC_GUARD2_WHO",
        },
        { text = ccb.content.text("Let's trade!"), next_topic = "TALK_EVAC_GUARD2_TRADE" },
        {
            text = ccb.content.text("Is there anything I can do to help?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Thanks!  I will be on my way."), next_topic = "TALK_DONE" },
    },
}
