local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CABIN_TUNNEL_SHADOW",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } }),
        yes = ccb.content.text("&The creature doesn't pay you any attention."),
        no = ccb.content.text("&The creature rolls slowly onto its back, staring up at you with stark, white eyes.  \"Lay.  Sleep in the earth.  You can leave this place.  You will be safe.\""),
    },
    replies = {
        {
            text = ccb.content.text("Who are you?"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_WHO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } })),
        },
        {
            text = ccb.content.text("[Lay beside the creature]"),
            next_topic = "TALK_CABIN_TUNNEL_SHADOW_SLEEP_1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } })),
        },
        {
            text = ccb.content.text("[Move away]"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } })),
        },
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "shade_sent_to_inner_cabins" } }),
        },
    },
}
