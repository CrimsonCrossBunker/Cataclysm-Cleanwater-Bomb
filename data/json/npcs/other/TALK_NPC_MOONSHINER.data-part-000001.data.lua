local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_MOONSHINER_INTRO",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Could you tell me a bit about yourself?"),
            next_topic = "TALK_NPC_MOONSHINER_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Can I purchase any of your liquor?"),
            next_topic = "TALK_NPC_MOONSHINER_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("It's a bit dangerous to be out here alone.  Why don't you come with me?"),
            trial = { kind = "persuade", difficulty = -15, modifiers = { { score = "value", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow" }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = 0, fear = 0 } },
        },
        {
            text = ccb.content.text("Anything I could do for you?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
