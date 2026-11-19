local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_2_NOTYET",
    line = ccb.content.text("What do you think happened?  You see them around anywhere?"),
    on_enter = {
        {
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 14000 }) },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
