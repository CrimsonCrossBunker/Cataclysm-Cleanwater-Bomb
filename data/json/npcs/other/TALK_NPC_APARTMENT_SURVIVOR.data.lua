local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_APARTMENT_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        yes = ccb.content.text_without_extraction("<greet>"),
        no = ccb.content.text("Freeze you <freaking> <zombies>!"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "dialogue_first_meeting_knows_u", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("&Hold up your hands.  \"Don't worry, I'm not going to hurt you\""),
            next_topic = "TALK_NPC_APARTMENT_SURVIVOR_CALM",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } })),
        },
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
            text = ccb.content.text_without_extraction("<greet>"),
            next_topic = "TALK_NPC_APARTMENT_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_APARTMENT_SURVIVOR_CALM",
    line = ccb.content.gendered_line("Oh, you're not one of the <zombies>.  Come on in, just don't cause any trouble.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Alright, let's chat."),
            next_topic = "TALK_NPC_APARTMENT_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_APARTMENT_SURVIVOR_INTRO",
    line = ccb.content.text("So, what's up?"),
    replies = {
        {
            text = ccb.content.text("What are you doing in this deathtrap?"),
            next_topic = "TALK_NPC_APARTMENT_SURVIVOR_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Care to trade?"),
            next_topic = "TALK_NPC_APARTMENT_SURVIVOR_INTRO",
            actions = { "start_trade" },
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
    id = "TALK_NPC_APARTMENT_SURVIVOR_STORY",
    line = ccb.content.gendered_line("I used to live here before <the_cataclysm>.  I was asleep when a horde of <zombies> busted through the front, and in the chaos I wound up here.  When the screaming stopped, I peaked out the door to find my neighbor stumbling about with his face half-eaten, and I haven't left since.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Wow."), next_topic = "TALK_NONE" } },
}
