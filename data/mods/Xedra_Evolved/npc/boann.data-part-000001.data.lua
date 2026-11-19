local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_QUEST_KNIGHT_OUTWORLD",
    line = ccb.content.text("You won't be a member of my court yet.  After another few quests, you will, and you along with all those that follow you will be brought out of this world whenever you wish so."),
    replies = {
        {
            text = ccb.content.text("Can I see the quest list again?"),
            next_topic = "TALK_QUEST_LIST",
            actions = { actions.set_actor_value("speaker", "told_about_knight_not_coming", "yes") },
        },
        {
            text = ccb.content.text("I'm going to head on now."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "told_about_knight_not_coming", "yes") },
        },
    },
}
