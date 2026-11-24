local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_GUN_STORE_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text_without_extraction("<greet>"),
        no = ccb.content.gendered_line("Hey stranger.  How's life treatin' ya these days?", { "speaker" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hand over your stuff!  Don't make any sudden moves, or you die!"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("Hey, nice to meet you."),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text_without_extraction("<greet>"),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
    line = ccb.content.text("What brings you around here?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_WHO",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Would you be interested in trading at all?"),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can I stay here for a while?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_STAY",
        },
        {
            text = ccb.content.text("Why don't you come with me?"),
            trial = { kind = "persuade", difficulty = -15, modifiers = { { score = "value", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow" }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = 0, fear = 0 } },
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_GUN_STORE_SURVIVOR_WHO",
    line = ccb.content.gendered_line("I'm just an average person, really.  When a horde of those <freaking> <zombies> came knockin' on my door, I ran for it.  Good for me that someone left this store open in the chaos, I ran inside and locked the place down.  There isn't a thing in all of <city> that can bust through these walls and barred windows, I'd reckon I'm the luckiest <name_b> in town.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Why would someone leave a gun store open in all this chaos?"),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_WHY_HERE",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Would you be interested in trading at all?"),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can I stay here for a while?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_STAY",
        },
        {
            text = ccb.content.text("Why don't you come with me?"),
            trial = { kind = "persuade", difficulty = -15, modifiers = { { score = "value", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow" }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = 0, fear = 0 } },
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_GUN_STORE_SURVIVOR_WHY_HERE",
    line = ccb.content.text("Well, they weren't really around to lock it up.  Whoever got here first blew their head off with a 12-gauge, but they were up and movin', tried to kill me too.  They're out in the dumpster now."),
    replies = {
        {
            text = ccb.content.text("I'm sorry to hear that.  Maybe we should change the subject."),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Would you be interested in trading at all?"),
            next_topic = "TALK_NPC_GUN_STORE_SURVIVOR_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("Can I stay here for a while?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_STAY",
        },
        {
            text = ccb.content.text("Why don't you come with me?"),
            trial = { kind = "persuade", difficulty = -15, modifiers = { { score = "value", scale = 2 } } },
            success = { next_topic = "TALK_AGREE_FOLLOW", actions = { "follow" }, opinion = { trust = 1, value = 1 } },
            failure = { next_topic = "TALK_DENY_FOLLOW", actions = { "deny_follow" }, opinion = { trust = 0, fear = 0 } },
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
