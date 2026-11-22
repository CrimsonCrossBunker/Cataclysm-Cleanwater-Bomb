local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_1",
    line = {
        choices = {
            ccb.content.text("&You lay beside the shade.  It is comfortable, but also unfamiliar.  You feel like you could stay here forever, though you might not be comfortable."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[Close your eyes]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_2",
            actions = { actions.set_actor_value("speaker", "shade_sent_to_inner_cabins", "yes") },
        },
        {
            text = ccb.content.text("[Stand up]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_NICE_TRY",
            when = predicates.handler("w16b_p_dda_b12e6dcfc828"),
            actions = { actions.set_actor_value("speaker", "shade_sent_to_inner_cabins", "yes") },
        },
        {
            text = ccb.content.text("[Stand up]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_ESCAPE",
            when = predicates.handler("w16b_p_dda_4e415c428af8"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_2",
    line = {
        choices = {
            ccb.content.text("&You close your eyes.  Sleep takes you.  Then, there is light beyond your eyelids, and your mind's eye is flooded with red and gold afterimages."),
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_552b8eb02578") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_NICE_TRY",
    line = {
        choices = {
            ccb.content.text("&As you move to stand, the shade wipes a hand over your eyes.  Sleep takes you.  Then, there is light beyond your eyelids, and your mind's eye is flooded with red and gold afterimages."),
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_552b8eb02578") },
        },
    },
}
