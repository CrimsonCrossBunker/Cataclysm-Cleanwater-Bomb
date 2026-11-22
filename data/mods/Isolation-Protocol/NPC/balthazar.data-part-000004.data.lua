local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "ISO_BALTHAZAR_COMBAT_ASSISTANCE",
    line = {
        when = predicates.handler("w16b_p_isolation_protocol_8150e413f091"),
        yes = ccb.content.text("<BALTHAZAR_COMBAT_ASSISTANCE_GRANTED>"),
        no = ccb.content.text("<BALTHAZAR_COMBAT_ASSISTANCE_DENIED>"),
    },
    replies = {
        {
            text = ccb.content.text("Ask for increased combat abilities."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_isolation_protocol_8150e413f091"),
            actions = { actions.handler("w16b_a_isolation_protocol_e4982d03659d") },
            show_always = true,
            show_reason = "Insufficient power.",
        },
        {
            text = ccb.content.text("Ask for a temporary shield."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_isolation_protocol_e93225d633b1"),
            actions = { actions.handler("w16b_a_isolation_protocol_ea8c65f55cf0") },
            show_always = true,
            show_reason = "Insufficient power.",
        },
        {
            text = ccb.content.text("Make Balthazar kill everything around you."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_isolation_protocol_6a82b760b59a"),
            actions = { actions.handler("w16b_a_isolation_protocol_ad4bd06ae146") },
            show_always = true,
            show_reason = "Insufficient power.",
        },
        {
            text = ccb.content.text("Never mind."),
            next_topic = "TALK_DONE",
        },
    },
}
