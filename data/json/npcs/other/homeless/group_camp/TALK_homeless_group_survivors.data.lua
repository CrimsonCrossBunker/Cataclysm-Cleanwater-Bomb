local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        yes = ccb.content.text("Hello there.  Nice to see you again."),
        no = ccb.content.text("Who are you, and what are you doing here?"),
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
            text = ccb.content.text("Nice to meet you.  I mean no harm."),
            next_topic = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Hand over your stuff!  Don't make any sudden moves, or you die!"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = 4, fear = -3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_FRIENDS",
    line = ccb.content.text("Oh, they're right over there, and one of us is in that tent over there.  They handle any stuff we manage to scavenge, so feel free to trade for what you want."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_NOTRADE",
    line = ccb.content.text("Thanks for the offer, but I don't have anything to spare right now.  One of my buddies over in that tent handles stuff like this, though.  You might find something."),
    replies = { { text = ccb.content.text("Alright."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_GROUP_SURVIVOR_BROKER",
    line = ccb.content.text("Well, they were the brightest of us when all hell broke loose.  They managed to get us some food and weapons early on.  I guess that just kinda made them the leader."),
    replies = { { text = ccb.content.text("Hmm."), next_topic = "TALK_NONE" } },
}
