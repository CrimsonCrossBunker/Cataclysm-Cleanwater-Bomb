local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_MOONSHINER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text("Hey <name_g>."),
        no = ccb.content.gendered_line("Haven't seen someone new in a while.  What brings you around here?", { "interlocutor" }),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Just wandering, <name_g>."),
            next_topic = "TALK_NPC_MOONSHINER_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
        {
            text = ccb.content.text("I'll make this real simple for you.  Hand over your stuff, and no one gets hurt, capiche?"),
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
            text = ccb.content.text_without_extraction("<greet>"),
            next_topic = "TALK_NPC_MOONSHINER_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_MOONSHINER_STORY",
    line = ccb.content.gendered_line("I run this distillery you're standing in, before <the_cataclysm> it wasn't so legal with the law.  I was in <city> making a deal on my product when a horde of rioters busted in, so I ran for it.  I thought my business would be a nice place to stay, so I came out here.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Huh."), next_topic = "TALK_NONE" } },
}
