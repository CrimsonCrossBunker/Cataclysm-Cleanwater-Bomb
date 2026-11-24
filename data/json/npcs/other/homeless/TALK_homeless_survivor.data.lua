local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_homeless" } }),
        yes = ccb.content.text("Hello there.  Nice to see you again."),
        no = ccb.content.text("Who are you?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_first_meeting_talked_to_homeless", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_NPC_HOMELESS_SURVIVOR_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_HOMELESS_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_SURVIVOR_STORY",
    line = {
        choices = {
            ccb.content.gendered_line("I was homeless before everything went down, just camping out here for a while.  Stuck up <name_b>s shunned me for my condition, but they're all dead now.  I guess I'm better off than they are.", { "interlocutor" }),
            ccb.content.gendered_line("I guess you probably wouldn't have noticed this place before shit hit the fan, but I've been down here for quite a while.", { "speaker" }),
            ccb.content.text("Nothing to it.  Before <the_cataclysm>, it didn't take much to find yourself here.  And I guess it just made sense to stay.  We seem to be doing better than most, anyway."),
            ccb.content.text("Surviving, as I always have.  Is that what you mean?"),
            ccb.content.gendered_line("It's hard to say exactly what I'm doing out here, but I guess one thing just leads to another and… well, you're just being nice when you ask, aren't you?  It doesn't matter now anyway.  I'm here and I'm still alive.", { "interlocutor" }),
        },
    },
    replies = { { text = ccb.content.text("Hm."), next_topic = "TALK_NONE" } },
}
