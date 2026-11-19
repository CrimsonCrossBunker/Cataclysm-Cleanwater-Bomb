local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_FEMA_EVACUEE_1_NOTYET",
    line = ccb.content.text("Maybe another time.  I don't really like thinking about it."),
    replies = {
        {
            text = ccb.content.text("Sorry.  Tell me more about that FEMA camp."),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 600 }) },
            next_topic = "BGSS_FEMA_EVACUEE_1_STORY2",
        },
        {
            text = ccb.content.text("Sorry for asking.  <done_conversation_section>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 600 }) },
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("Sorry for asking.  <end_talking>"),
            actions = { actions.add_effect("interlocutor", "player_BGSS_SAIDNO", { turns = 600 }) },
            next_topic = "TALK_DONE",
        },
    },
}
