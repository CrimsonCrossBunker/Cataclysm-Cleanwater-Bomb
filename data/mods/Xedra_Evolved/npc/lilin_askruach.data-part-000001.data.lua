local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND" },
    insert_before_standard_exits = true,
    replies = {
        {
            text = ccb.content.text("Can I take a little bit of your energy?  I really need some of it."),
            next_topic = "TALK_FRIEND_FOLLOWER_RUACH_DRAIN_IMPOSSIBLE",
            when = predicates.all({ predicates.has_trait("speaker", "LILIN_TRAITS"), predicates.any({ predicates.has_trait("interlocutor", "LILIN_TRAITS"), predicates.has_trait("interlocutor", "BLOOD_OF_SAINTS") }), predicates.negate(predicates.has_trait("speaker", "TURN_INTO_OWL_TRAITS")), predicates.negate(predicates.has_trait("speaker", "LILIN_WAR_OWL_FORM_TRAITS")) }),
        },
    },
}
