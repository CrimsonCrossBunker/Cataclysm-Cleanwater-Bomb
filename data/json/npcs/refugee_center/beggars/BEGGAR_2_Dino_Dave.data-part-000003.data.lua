local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_GAVE_FOOD",
    line = ccb.content.text("I can tell when it has stuff in it, it's got a sandy texture.  But this doesn't.  Thanks again."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
