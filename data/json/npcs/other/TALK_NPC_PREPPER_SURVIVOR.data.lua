local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_PREPPER_SURVIVOR",
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
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_CALM",
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
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_PREPPER_SURVIVOR_CALM",
    line = ccb.content.gendered_line("Oh, you're not one of the <zombies>.  Come on in, just don't cause any trouble.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Alright, let's chat."),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_PREPPER_SURVIVOR_INTRO",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_2c514690302b"),
        },
        {
            text = ccb.content.text("Would you be interested in bartering?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO",
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
    id = "TALK_NPC_PREPPER_SURVIVOR_STORY",
    line = ccb.content.gendered_line("They all said I was crazy for preparing for <the_cataclysm>.  Now, they're all dead, and I'm still kickin'.  When the riots turned to hordes, I was ready; all I had to do was dodge a few <zombies> to get back to my bastion.  I've been living safely here ever since.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Interesting."), next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO" },
        {
            text = ccb.content.text("Can I stay here for a while?"),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_STAY",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_PREPPER_SURVIVOR_STAY",
    line = ccb.content.text("Well, I guess you could borrow one of the spare beds, just don't hog it.  I kept a few in case someone else joined me, but no one I knew came here."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_NPC_PREPPER_SURVIVOR_INTRO",
            actions = { actions.handler("dlg_a_dda_cda1365f4ecb") },
        },
    },
}
