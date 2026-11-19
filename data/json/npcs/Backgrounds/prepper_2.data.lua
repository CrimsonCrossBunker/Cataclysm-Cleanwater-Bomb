local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_2_NOSALE",
    line = ccb.content.text("Nice try.  You want the maps, you pay up."),
    replies = {
        {
            text = ccb.content.text("Fine.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { permanent = true }) },
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { permanent = true }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { permanent = true }) },
            next_topic = "TALK_DONE",
        },
    },
}
