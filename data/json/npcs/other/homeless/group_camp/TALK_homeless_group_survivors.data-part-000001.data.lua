local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_INTRO",
    line = ccb.content.text("So, what's up?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text("Where might your friends be?"),
            next_topic = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_FRIENDS",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_told_about_buddies" } }),
        },
        {
            text = ccb.content.text("Can I stay here?"),
            next_topic = "TALK_NPC_HOMELESS_BROKER_STAY",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_told_about_buddies" } }),
        },
        {
            text = ccb.content.text("What's with that guy in the tent?"),
            next_topic = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_BROKER",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_told_about_buddies" } }),
        },
        {
            text = ccb.content.text("Want to trade?"),
            next_topic = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_NOTRADE",
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
