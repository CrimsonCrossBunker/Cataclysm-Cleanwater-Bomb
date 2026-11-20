local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_HUB",
    line = ccb.content.text("I'm listening."),
    replies = {
        {
            text = ccb.content.text("Tell me about it."),
            when = predicates.negate(predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER")),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_1",
        },
        {
            text = ccb.content.text("Anything else I should know?"),
            when = predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER"),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_DANGER",
        },
        {
            text = ccb.content.text("Tell me about the cargo."),
            when = predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER"),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_NONE" },
    },
}
