local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_3_GAVE_FOOD",
    line = ccb.content.text("Thanks, I really appreciate this."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_3_INTRO",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
