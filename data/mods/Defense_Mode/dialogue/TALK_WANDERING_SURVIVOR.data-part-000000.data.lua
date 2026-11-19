local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_DEFENSE_WANDERER",
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
            next_topic = "TALK_NPC_DEFENSE_WANDERER_CALM",
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
            text = ccb.content.text("Nice to see you."),
            next_topic = "TALK_NPC_DEFENSE_WANDERER_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_knows_u" } }),
        },
        { text = ccb.content.text("Bye."), next_topic = "TALK_DONE" },
    },
}
