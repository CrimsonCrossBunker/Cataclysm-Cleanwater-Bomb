local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_GIVECARDBOARD",
    line = ccb.content.text("Kind of a question's that?  Yeah man, you got cardboard, I got a whole… a whole shopping list.  Got it here."),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "mission_dinodave_cardboard_donor", "yes") },
        },
    },
    replies = {
        { text = ccb.content.text("What's next on the list?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
