local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_SURVIVOR_INTRO",
    line = ccb.content.text("So, what's up?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_HOMELESS_SURVIVOR_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_NPC_HOMELESS_SURVIVOR_INTRO",
            native_actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Why don't you come with me?"),
            trial = { kind = "persuade", difficulty = -15, modifiers = { { score = "value", scale = 2 } } },
            success = {
                next_topic = "TALK_AGREE_FOLLOW",
                native_actions = { "follow" },
                opinion = { trust = 1, value = 1 },
            },
            failure = {
                next_topic = "TALK_DENY_FOLLOW",
                native_actions = { "deny_follow" },
                opinion = { trust = 0, fear = 0 },
            },
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
